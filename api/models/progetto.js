const Model = require('./model')
class Progetto extends Model {
    constructor () {
        super()
        this.table = 'progetti'
    }

    async getRunningProjects () {
        try {
            const stmt = `select count(*) as running_projects from progetti where stato = ?`
            return (await this.dbService.query(stmt, ['lavorazione']))[0] || 0
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }


    async getProjectsProgress () {
        try {
            const stmt = `
            SELECT 
            p.id,
            c.ragione_sociale,
            impianto,
            completamento 
            FROM progetti p JOIN clienti c ON p.cliente = c.id 
            WHERE stato = 'lavorazione' and completamento < 100
            `
            return await this.dbService.query(stmt, ['lavorazione'])
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }
}
module.exports = Progetto