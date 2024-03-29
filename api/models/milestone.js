const Model = require('./model')
class Milestone extends Model {
    constructor () {
        super()
        this.table = 'milestones'
    }

    async get (cond = []) {
        const {condition, values} = this.dbService.evaluateConditions(cond)
        const stmt = `
        SELECT 
		cl.id as id_cliente,
        cl.ragione_sociale as cliente,
        p.id as id_progetto,
        p.impianto as impianto,
        m.*,
        pm.name as tipo_pagamento,
        s.name as stato
        FROM ${this.table} m
        JOIN stati s ON m.id_stato = s.id and s.entita = 'milestone'
        JOIN contratti c ON c.id = m.id_contratto
        JOIN progetti p ON p.id = c.id_progetto
        JOIN clienti cl on cl.id = p.id_cliente
        JOIN payment_methods pm on m.id_payment_method = pm.id
        where ${condition}
        `
        return await this.dbService.query(stmt, values)
    }

    async descTable () {
        return [
            'id',
            'trec',
            'created_at',
            'created_by',
            'updated_at',
            'updated_by',
            'impianto',
            'id_contratto',
            'descrizione',
            'Note',
            'importo_percentuale',
            'importo_valore',
            'ritenuta_percentuale',
            'ritenuta_valore',
            'fatturato_percentuale',
            'id_payment_method',
            'data_fatturazione',
            'data_pagamento',
            'tipo_pagamento',
            'id_stato',
            'stato'
        ]
    }

    async insert (data = {}) {
        try {
            if ( !this.helper.dependencies.lodash.isObject(data) ) throw new Error("Data seems not to be an Object")
            if ( !Object.keys(data).length ) throw new Error("Missing data!")
            
            const stmt = `replace into ${this.table} (${Object.keys(data).join(',')}) values (${Object.values(data).map( v => '?').join(',')})`
            const result = await this.dbService.query(stmt, Object.values(data))
            return {error: false, code: null, message: "Insert succede", data: result}
        }
        catch ( error ) {
            console.log(error)
            switch (error.code) {
                case "ER_DUP_ENTRY":
                    return {error: true, code: error.code, message: "Record already exist."}
                default: 
                    return {error: true, code: null, message: "Unknown error"}
            }
        }
    }

}
module.exports = Milestone