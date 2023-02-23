const Model = require('./model')
class Kpi extends Model {
    constructor () {
        super()
    }

    async getRunningOffers () {
        try {
            const stmt = `select count(*) as running_offers from offerte`
            return (await this.dbService.query(stmt))[0] || 0
        }
        catch ( err ) {
            console.log(err)
            return []
        }
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

    async getAcceptedOffers () {
        try {
            const stmt = `select count(*) as accepted_offers from contratti`
            return (await this.dbService.query(stmt))[0] || 0
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }

    async getContractsPerMonth () {
        try {
            const stmt = `
            SELECT date_format(data_accettazione,'%Y-%m-%d') data_accettazione, count(*) num_contracts
            FROM contratti
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

    async getTotalKW () {
        try {
            const stmt = `select IFNULL(sum(kw),0) as total_kw from contratti`
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
            FROM contratti
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

    async getTotalInvoiced () {
        try {
            const stmt = `select IFNULL(sum(importo_valore),0) as total_invoiced from milestones where id_stato in (11,12) and YEAR(created_at) = YEAR(now())`
            return (await this.dbService.query(stmt))[0] || 0
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }
}
module.exports = Kpi