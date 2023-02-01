const Model = require('./model')
class Milestone extends Model {
    constructor () {
        super()
        this.table = 'milestones'
    }

    async get (cond = []) {
        const {condition, values} = this.dbService.evaluateConditions(cond)
        const stmt = `
        SELECT 
        m.*,
        s.name as stato
        FROM ${this.table} m
        JOIN stati s ON m.id_stato = s.id and s.entita = 'milestone'
        where ${condition}
        `
        const result = await this.dbService.query(stmt, values)
        return result.length ? result : []
    }

    async insert (data = {}) {
        try {
            if ( !this.helper.dependencies.lodash.isObject(data) ) throw new Error("Data seems not to be an Object")
            if ( !Object.keys(data).length ) throw new Error("Missing data!")
            
            const stmt = `replace into ${this.table} (${Object.keys(data).join(',')}) values (${Object.values(data).map( v => '?').join(',')})`
            const result = await this.dbService.query(stmt, Object.values(data))
            return {error: false, code: null, message: "Insert succede", data: result}
        }
        catch ( error ) {
            console.log(error)
            switch (error.code) {
                case "ER_DUP_ENTRY":
                    return {error: true, code: error.code, message: "Record already exist."}
                default: 
                    return {error: true, code: null, message: "Unknown error"}
            }
        }
    }

}
module.exports = Milestone