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
            const stmt = `
            SELECT COUNT(*) as running_projects FROM (
                SELECT m.* FROM contratti c 
                JOIN milestones m ON c.id = m.id_contratto AND m.id_stato = 12 
                GROUP BY m.id_contratto
            ) t` // stato in lavorazione
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

    async getInstalledKW () {
        try {
            const stmt = `
            SELECT SUM(c.kw) as installed_kw
            FROM contratti c 
            JOIN (
                SELECT * 
                FROM milestones m2 
                WHERE id IN (
                    SELECT MAX(m.id)
                    FROM contratti c 
                    JOIN milestones m ON c.id = m.id_contratto 
                    GROUP BY m.id_contratto
                ) AND id_stato in (11,12)
            ) m ON c.id = m.id_contratto `
            return (await this.dbService.query(stmt))[0] || 0
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
            const stmt = `select IFNULL(sum(ritenuta_valore),0) as total_invoiced from milestones where id_stato in (11,12) and YEAR(created_at) = YEAR(now())`
            return (await this.dbService.query(stmt))[0] || 0
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }

    async getTotalContractsValue () {
        try {
            const stmt = `select IFNULL(sum(importo_contrattato),0) as total_contracts_value from contratti where YEAR(created_at) = YEAR(now())`
            return (await this.dbService.query(stmt))[0] || 0
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }

    async getInvoicedProjects () {
        try {
            const stmt = `
            select * from (
                select 
                c2.ragione_sociale, 
                p.impianto, 
                SUM(IF(m.id_stato = 10, m.importo_valore, 0)) da_fatturare,
                SUM(IF(m.id_stato = 11, m.importo_valore, 0)) fatturato,
                SUM(IF(m.id_stato = 12, m.importo_valore, 0)) pagato,
                sum(m.importo_valore) totale
                from milestones m 
                join contratti c on m.id_contratto = c.id
                join clienti c2 on c.id_cliente = c2.id
                join progetti p on c.id_progetto = p.id 
                group by p.id
            ) t 
            -- where fatturato < pagato
            order by pagato - fatturato
            `
            return await this.dbService.query(stmt)
        }
        catch ( err ) {
            console.log(err)
            return []
        }
    }
}
module.exports = Kpi