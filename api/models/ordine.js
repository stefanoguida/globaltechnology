const Model = require('./model')
class Ordine extends Model {
    constructor () {
        super()
        this.table = 'ordini'
    }

    async get (cond = []) {
        const {condition, values} = this.dbService.evaluateConditions(cond)
        const stmt = `
        select
        clienti.ragione_sociale as cliente, 
        progetti.id as id_progetto,
        progetti.impianto as progetto, 
        ordini.importo as importo,
        stati.id as id_stato,
        stati.name as stato
        from ordini 
        join progetti on ordini.id_progetto = progetti.id
        join clienti on progetti.id_cliente = clienti.id
        join stati on ordini.id_stato = stati.id and stati.entita = 'ordine'
        where ${condition}
        `
        const result = await this.dbService.query(stmt, values)
        return result.length ? result : []
    }
}
module.exports = Ordine