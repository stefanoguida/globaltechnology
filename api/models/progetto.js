const Model = require('./model')
class Progetto extends Model {
    constructor () {
        super()
        this.table = 'progetti'
    }

    async get (cond = []) {
        const {condition, values} = this.dbService.evaluateConditions(cond)
        const stmt = `
        SELECT 
        p.id,
        p.id_cliente,
        c.ragione_sociale as cliente,
        p.luogo,
        p.impianto,
        p.data_inizio,
        p.data_fine,
        p.id_stato,
        s.name as stato,
        p.completamento,
        p.commenti
        FROM ${this.table} p 
        JOIN clienti c ON p.id_cliente = c.id 
        JOIN stati s ON p.id_stato = s.id AND s.entita = 'progetto'
        where ${condition}
        `
        const result = await this.dbService.query(stmt, values)
        return result.length ? result : []
    }

    async descTable () {
        return [
            'id',
            'id_cliente',
            'cliente',
            'luogo',
            'impianto',
            'data_inizio',
            'data_fine',
            'id_stato',
            'stato',
            'completamento',
            'commenti'
        ]
    }

    async getRunningProjects () {
        try {
            const stmt = `select count(*) as running_projects from progetti where id_stato = 5` // stato in lavorazione
            return (await this.dbService.query(stmt))[0] || 0
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