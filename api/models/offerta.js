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
        o.id_cliente,
        c.ragione_sociale as cliente,
        o.id_progetto,
        o.luogo,
        o.impianto,
        o.id_tipo_progetto,
        tp.name as tipo_progetto,
        o.data_offerta,
        o.data_accettazione,
        o.importo_offerto,
        o.importo_contrattato,
        o.kw,
        o.id_stato,
        s.name as stato, 
        sum(if(f.path is null, 0, 1)) has_pdf
        FROM offerte o 
        JOIN stati s on o.id_stato = s.id and s.entita = 'offerta'
        LEFT JOIN clienti c ON o.id_cliente = c.id
        LEFT JOIN tipi_progetto tp ON o.id_tipo_progetto = tp.id
        LEFT JOIN files f on f.id_progetto = o.id_progetto and f.tipo = 'offerta'
        where ${condition}
        group by o.id
        `
        const result = await this.dbService.query(stmt, values)
        return result.length ? result : []
    }

    async descTable () {
        return [
            'id',
            'id_cliente',
            'cliente',
            'id_progetto',
            'luogo',
            'impianto',
            'id_tipo_progetto',
            'tipo_progetto',
            'data_offerta',
            'data_accettazione',
            'importo_offerto',
            'importo_contrattato',
            'kw',
            'id_stato',
            'stato'
        ]
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