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
        c.id as id_cliente,
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

    async descTable () {
        return [
            'id',
            'id_cliente',
            'cliente',
            'id_progetto',
            'progetto',
            'luogo',
            'impianto',
            'kw',
            'data_accettazione',
            'importo_contrattato'
        ]
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
    async getKwPerMonth(){
        try {
            const stmt = `
            SELECT date_format(data_accettazione,'%Y-%m-%d') data_accettazione, sum(kw) kw
            FROM ${this.table} 
            WHERE date(data_accettazione) >= date(data_accettazione) - interval 12 month
            GROUP BY YEAR(data_accettazione), MONTH(data_accettazione)
            ORDER BY YEAR(data_accettazione), MONTH(data_accettazione)
            `
            return await this.dbService.query(stmt)
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }
    async getContractsPerMonth(){
        try {
            const stmt = `
            SELECT date_format(data_accettazione,'%Y-%m-%d') data_accettazione, count(*) num_contracts
            FROM ${this.table} 
            WHERE date(data_accettazione) >= date(data_accettazione) - interval 12 month
            GROUP BY YEAR(data_accettazione), MONTH(data_accettazione)
            ORDER BY YEAR(data_accettazione), MONTH(data_accettazione)
            `
            return await this.dbService.query(stmt)
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }
}
module.exports = Contratto