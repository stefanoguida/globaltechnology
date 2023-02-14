const Model = require('./model')
class RigaOfferta extends Model {
    constructor () {
        super()
        this.table = 'righe_offerta'
    }

    async get (cond = []) {
        const {condition, values} = this.dbService.evaluateConditions(cond)
        const stmt = `
        SELECT 
        o.id,
        o.id_offerta,
        o.id_servizio,
        s.code as codice_fornitura,
        s.name as fornitura,
        o.descrizione,
        o.brand,
        o.importo_offerto,
        o.importo_contrattato,
        o.pagamento,
        date(o.data_arrivo_merce) data_arrivo_merce
        FROM righe_offerta o 
        JOIN servizi s on o.id_servizio = s.id
        where ${condition}
        `
        const result = await this.dbService.query(stmt, values)
        return result.length ? result : []
    }

    async descTable () {
        return [
            'id',
            'id_offerta',
            'id_servizio',
            'codice_fornitura',
            'fornitura',
            'descrizione',
            'brand',
            'importo_offerto',
            'importo_contrattato',
            'pagamento',
            'data_arrivo_merce'
        ]
    }
}
module.exports = RigaOfferta