const Model = require('./model')
class Contratto extends Model {
    constructor () {
        super()
        this.table = 'contratti'
    }

    // async get (cond) {
    //     try {
    //         const {condition, values} = this.dbService.evaluateConditions(cond)
    //         const stmt = `
    //         SELECT c.*, p.impianto as nome_progetto, sc.code codice_stato, sc.name as stato_contratto
    //         FROM contratti c 
    //         JOIN progetti p on c.progetto = p.id
    //         join stati_contratto sc on c.stato = sc.id
    //         WHERE ${condition}`
    //         const result = await this.dbService.query(stmt, values)
    //         return result.length ? result : []
    //     }
    //     catch ( error ) {
    //         console.log(error)
    //         return []
    //     }
    // }

    async getRunningOffers () {
        try {
            const stmt = `select count(*) as running_offers from contratti where stato = 1`
            return (await this.dbService.query(stmt))[0] || 0
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }
    async getAcceptedOffers () {
        try {
            const stmt = `select count(*) as accepted_offers from contratti where stato = 2`
            return (await this.dbService.query(stmt))[0] || 0
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }
    async getTotalKW () {
        try {
            const stmt = `select IFNULL(sum(kw),0) as total_kw from contratti where stato = 2`
            return (await this.dbService.query(stmt))[0] || 0
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }
    async getTotalInvoiced () {
        try {
            const stmt = `select IFNULL(sum(importo_accettato),0) as total_invoiced from contratti where stato = 2`
            return (await this.dbService.query(stmt))[0] || 0
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }
}
module.exports = Contratto