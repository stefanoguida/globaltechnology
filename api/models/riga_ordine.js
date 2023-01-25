const Model = require('./model')
class RigaOrdine extends Model {
    constructor () {
        super()
        this.table = 'righe_ordine'
    }

    async get (cond = []) {
        const {condition, values} = this.dbService.evaluateConditions(cond)
        const stmt = `
        select
        righe_ordine.id,
        ordini.id as id_ordine,
        clienti.ragione_sociale as cliente, 
        progetti.id as id_progetto,
        progetti.impianto as progetto, 
        ordini.importo as importo,
        stati.id as id_stato,
        stati.name as stato,
        righe_ordine.id_servizio,
        servizi.name as servizio,
        righe_ordine.descrizione,
        righe_ordine.brand,
        righe_ordine.costo,
        righe_ordine.costo_spedizione,
        IF(righe_ordine.data_arrivo_merce is not null, date_format(righe_ordine.data_arrivo_merce,'%Y-%m-%d'), null) as data_arrivo_merce
        from ordini 
        join righe_ordine on righe_ordine.id_ordine = ordini.id
        join servizi on servizi.id = righe_ordine.id_servizio
        join progetti on ordini.id_progetto = progetti.id
        join clienti on progetti.id_cliente = clienti.id
        join stati on ordini.id_stato = stati.id and stati.entita = 'ordine'
        where ${condition}
        `
        const result = await this.dbService.query(stmt, values)
        return result.length ? result : []
    }

}
module.exports = RigaOrdine