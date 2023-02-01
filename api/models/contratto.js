const Model = require('./model')
class Contratto extends Model {
    constructor () {
        super()
        this.table = 'contratti'
    }

    async get (cond = []) {
        const {condition, values} = this.dbService.evaluateConditions(cond)
        const stmt = `
        SELECT 
        o.id,
        c.ragione_sociale as cliente,
        o.id_progetto,
        p.impianto as progetto,
        p.luogo,
        p.impianto,
        o.kw,
        o.data_accettazione,
        o.importo_contrattato
        FROM contratti o 
        JOIN progetti p ON o.id_progetto = p.id
        JOIN clienti c ON p.id_cliente = c.id
        where ${condition}
        `
        const result = await this.dbService.query(stmt, values)
        return result.length ? result : []
    }

    async getAcceptedOffers () {
        try {
            const stmt = `select count(*) as accepted_offers from ${this.table}`
            return (await this.dbService.query(stmt))[0] || 0
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }
    async getTotalKW () {
        try {
            const stmt = `select IFNULL(sum(kw),0) as total_kw from ${this.table}`
            return (await this.dbService.query(stmt))[0] || 0
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }
    async getTotalInvoiced () {
        try {
            const stmt = `select IFNULL(sum(importo_contrattato),0) as total_invoiced from ${this.table}`
            return (await this.dbService.query(stmt))[0] || 0
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }
}
module.exports = Contratto