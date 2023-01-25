const Model = require('./model')
class Offerta extends Model {
    constructor () {
        super()
        this.table = 'offerte'
    }

    async get (cond = []) {
        const {condition, values} = this.dbService.evaluateConditions(cond)
        const stmt = `
        SELECT 
        o.id,
        c.ragione_sociale as cliente,
        o.id_progetto,
        p.impianto as progetto,
        o.data_offerta,
        o.importo,
        o.kw,
        o.id_stato,
        s.name as stato
        FROM offerte o 
        JOIN progetti p ON o.id_progetto = p.id
        JOIN stati s on o.id_stato = s.id and s.entita = 'offerta'
        JOIN clienti c ON p.id_cliente = c.id
        where ${condition}
        `
        const result = await this.dbService.query(stmt, values)
        return result.length ? result : []
    }

    async getRunningOffers () {
        try {
            const stmt = `select count(*) as running_offers from ${this.table}`
            return (await this.dbService.query(stmt))[0] || 0
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }
}
module.exports = Offerta