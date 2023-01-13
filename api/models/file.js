const Model = require('./model')
class File extends Model {
    constructor () {
        super()
        this.table = 'files'
    }

    async saveFile ( file, data ) {
        try {
            const stmt = `
                INSERT INTO ${this.table} (cliente,progetto,tipo,path) 
                SELECT progetti.cliente, progetti.id, ?, ?
                FROM ordini JOIN progetti ON ordini.progetto = progetti.id 
                WHERE ordini.id = ?
                ON DUPLICATE KEY UPDATE path = VALUES(path)
            ` 
            await this.dbService.query(stmt, [data.type, file.path.replace('/app/',''), data.id])

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
            const stmt = `DELETE FROM ${this.table} WHERE id = ?` 
            await this.dbService.query(stmt, [id])

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