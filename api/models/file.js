const Model = require('./model')
const Helper = require('../helper')
class File extends Model {
    constructor () {
        super()
        this.table = 'files'
    }

    async saveFile ( file, data ) {
        try {
            const stmt = `
                INSERT INTO ${this.table} (id_cliente,id_progetto,id_riferimento,tipo,path) 
                SELECT progetti.id_cliente, progetti.id, ?, ?, ?
                FROM ordini JOIN progetti ON ordini.id_progetto = progetti.id 
                WHERE ordini.id = ?
                ON DUPLICATE KEY UPDATE path = VALUES(path)
            ` 
            await this.dbService.query(stmt, [data.id_riferimento, data.type, file.path.replace('/app/',''), data.id])

        }
        catch ( error ) {
            console.log( error )
            switch (error.code) {
                default: 
                    return {error: true, code: null, message: "Unknown error"}
            }
        }
    } 

    async deleteFile ( id ) {
        try {
            const pathStmt = `select path from ${this.table} where id = ?`
            const res = await this.dbService.query(pathStmt, [id])
            const path = res[0].path
            
            const stmt = `DELETE FROM ${this.table} WHERE id = ?` 
            await this.dbService.query(stmt, [id])

            Helper.deleteFile(path)

        }
        catch ( error ) {
            console.log( error )
            switch (error.code) {
                default: 
                    return {error: true, code: null, message: "Unknown error"}
            }
        }
    } 
}
module.exports = File