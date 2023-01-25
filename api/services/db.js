const util = require('util')
const mysql = require('mysql2')
const config = require('../config')
const helper = require('../helper')

class Db {

    constructor () {
        if ( Db.instance ) return Db.instance
        this.initDb()
        Db.instance = this
    }

    initDb() {
      this.connection = mysql.createPool(config.db)
      this.connection.on('connection', function(connection) {
        setInterval( () => {
          try {
            console.log("ping db")
            connection.ping()
          }
          catch ( error ) {
            console.log("ping error", error)
          }
        }, 60000); // ping to DB every minute
      })
      this.connection.on('error', function(err) {
        if(err.code === 'PROTOCOL_CONNECTION_LOST'){
          this.initDb()
        }
        else {
          throw err
        }

      } )
      this.query = util.promisify(this.connection.query).bind(this.connection)
      this.acceptedOperators = ['=','<','>','<=','>=','!=','like','rlike','llike','between','regexp']
    }

    async executeQuery(stmt, data = []) {
        try {
          if (!stmt) throw new Error('Missing statement')
          return await this.query(stmt, data)
        }
        catch ( err ) {
          console.log(err)
          throw err
        }
    }

    evaluateConditions(conditions = [], level = 1, preparedStatement = true) {
        if (conditions.length === 0) return { condition: ' 1 > 0 ', values: [] }
      
        const cond = conditions.reduce((acc, curr) => {
          let str, data
          if (helper.dependencies.lodash.isArray(curr)) {
            const { condition, values } = evaluateConditions(curr, level + 1, preparedStatement)
            str = `(${condition})`
            data = [...values]
          }
          else {
            str = curr.field
            data = [curr.value]
            switch (curr.op.toLowerCase()) {
              case 'between':
                str += preparedStatement ? ` between ? AND ? ` : ` between '${curr.value[0]}' and '${curr.value[1]}' `
                data = [...curr.value]
                break;
              case 'like':
                str += preparedStatement ? ` like '%?%' ` : ` like '%${curr.value}%' `
                break;
              case 'llike':
                str += preparedStatement ? ` like '%?' ` : ` like '%${curr.value}' `
                break;
              case 'rlike':
                str += preparedStatement ? ` like '?%' ` : ` like '${curr.value}%' `
                break;
              default:
                str += preparedStatement ? ` ${curr.op} ? ` : ` ${curr.op} '${curr.value}'`
                break;
            }
          }
      
          acc.str.push(str)
          acc.values.push(...data)
          return acc
        }, { str: [], values: [] })
        cond.str = cond.str.join(level % 2 === 0 ? ' OR ' : ' AND ')
        return { condition: cond.str, values: cond.values }
    }
}

module.exports = new Db()