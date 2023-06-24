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

    async descTable () {
        return [
            'cliente',
            'id_progetto',
            'progetto',
            'importo',
            'id_stato',
            'stato'
        ]
    }

    async generateOrdersFromProject( projectId ) {
        const stmt = `
        SELECT ro.id_servizio FROM progetti p 
        JOIN offerte o ON p.id = o.id_progetto 
        JOIN righe_offerta ro ON o.id = ro.id_offerta 
        JOIN servizi s ON s.id = ro.id_servizio AND s.tipo = 'fornitura'
        WHERE p.id = ${projectId}
        `
        const servizi = await this.dbService.query(stmt)
        if( !servizi.length ) throw new Error(`No services related to project id ${projectId}`)

        const getOrderIdStmt = `SELECT id from ordini where id_progetto = ${projectId}`
        const orderIdRes = await this.dbService.query(getOrderIdStmt)
        console.log(getOrderIdStmt, orderIdRes)
        let orderId
        if ( !orderIdRes.length ) {
            const stmtTestata = `INSERT IGNORE INTO ordini (id_progetto, id_stato) VALUES (?, ?)`
            const result = await this.dbService.query(stmtTestata, [projectId, 7])
            console.log(stmtTestata, [projectId, 7], result)
            orderId = result.insertId
        }
        else {
            orderId = orderIdRes[0].id
        }
        
        for( const servizio of servizi ) {
            const stmtDettaglio = `INSERT IGNORE INTO righe_ordine (id_ordine, id_servizio) VALUES (?, ?)`
            console.log(stmtDettaglio, [orderId, servizio.id_servizio])
            await this.dbService.query(stmtDettaglio, [orderId, servizio.id_servizio])
        }
        return {error: false, code: null, message: "Orders generated successfully!"}
    }
}
module.exports = Ordine