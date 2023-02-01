class Model {
    constructor () {
        this.dbService = require('../services/db')
        this.helper = require('../helper')
    }
    
    async getFirst ( cond = [] ) {
        try {
            const {condition, values} = this.dbService.evaluateConditions(cond)
            const stmt = `select * from ${this.table} where ${condition}` 
            const result = await this.dbService.query(stmt, values)
            return result.length ? result.pop() : {}
        }
        catch( e ) {
            console.log(e)
            return {}
        }
    }

    async get (cond = []) {
        try {
            const {condition, values} = this.dbService.evaluateConditions(cond)
            const stmt = `select * from ${this.table} where ${condition}`
            console.log(stmt)
            const result = await this.dbService.query(stmt, values)
            return result.length ? result : []
        }
        catch ( error ) {
            console.log(error)
            return []
        }
    }

    async insert (data = {}) {
        try {
            if ( !this.helper.dependencies.lodash.isObject(data) ) throw new Error("Data seems not to be an Object")
            if ( !Object.keys(data).length ) throw new Error("Missing data!")
            
            const stmt = `insert ignore into ${this.table} (${Object.keys(data).join(',')}) values (${Object.values(data).map( v => '?').join(',')})`
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

    async bulkInsert (data = []) {
        try {
            if ( !this.helper.dependencies.lodash.isArray(data) ) throw new Error("Data seems not to be an Array!")
            if ( !data.length ) throw new Error("Data seems to be empty!")
            
            // const stmt = `
            // insert into ${this.table} (${Object.keys(data[0]).join(',')}) 
            // values (${Object.values(data[0]).map( v => '?').join(',')})`
            // await this.dbService.query(stmt, data.reduce( (acc,curr) => {
            //     acc.push(Object.values(curr))
            //     return acc
            // }, [] ))
    
            for (let i = 0; i < data.length; i++) {
                await this.insert(data[i])
            }
            return {error: false, code: null, message: "Bulk insert succede"}
            
        }
        catch( error ) {
            console.log(error)
            switch (error.code) {
                default: 
                    return {error: true, code: null, message: "Unknown error"}
            }
        }
    }

    async delete ( id ) {
        try {
            if (!id) throw new Error("Missing row id")
            const stmt = `delete from ${this.table} where id = ${id}`
            await this.dbService.query(stmt)
            return {error: false, code: null, message: "Delete succede"}
        }
        catch( error ) {
            console.log(error)
            switch (error.code) {
                default: 
                    return {error: true, code: null, message: "Unknown error"}
            }
        }
    }

    async update ( data = {}, cond = [] ) {
        try {
            if ( !this.helper.dependencies.lodash.isObject(data) ) throw new Error("Data seems not to be an Object!")
            if ( !Object.keys(data).length ) throw new Error("Missing data!")
    
            const set = Object.keys(data).reduce( (acc, curr) => {
                acc.push(curr + ' = ?' )
                return acc
            }, [] ).join(', ')
            const {condition, values} = this.dbService.evaluateConditions(cond)
            const stmt = `update ${this.table} set ${set} where ${condition}`
            await this.dbService.query(stmt, [...Object.values(data), ...values])
            return {error: false, code: null, message: "Update succede"}
        }
        catch ( error ) {
            console.log(error)
            switch (error.code) {
                default: 
                    return {error: true, code: null, message: "Unknown error"}
            }
        }
    }

    async upsert ( data = {} ) {
        try {
            if ( !this.helper.dependencies.lodash.isObject(data) ) throw new Error("Data seems not to be an Object")
            if ( !Object.keys(data).length ) throw new Error("Missing data!")
            
            const set = Object.keys(data).reduce( (acc, curr) => {
                acc.push(curr + ' = ?' )
                return acc
            }, [] ).join(', ')
    
            const stmt = `
            insert into ${this.table} (${Object.keys(data).join(',')}) 
            values (${Object.values(data).map( v => '?').join(',')})
            on duplicate key update ${set}
            `
            await this.dbService.query(stmt, [
                ...Object.values(data),
                ...Object.values(data)
            ])
            return {error: false, code: null, message: "Upsert succede"}
        }
        catch ( error ) {
            console.log(error)
            switch (error.code) {
                default: 
                    return {error: true, code: null, message: "Unknown error"}
            }
        }
    }

    async getFlatData () {
        try {
            const stmt = `
            SELECT 
            clienti.ragione_sociale as cliente,
            progetti.impianto,
            progetti.luogo,
            progetti.data_inizio as data_inizio_progetto,
            progetti.data_fine as data_fine_progetto,
            stati_progetto.name AS stato_progetto,
            progetti.completamento, 
            contratti.data_offerta,
            contratti.data_accettazione,
            contratti.importo_richiesto,
            IFNULL(contratti.importo_accettato,0) AS importo_accettato,
            contratti.kw,
            IFNULL(servizi.name,'-') AS servizi_in_contratto,
            IFNULL(ordini.data_consegna,'-') AS data_consegna_ordine,
            IFNULL(ordini.importo,0) AS importo_ordine,
            IFNULL(files.tipo,'') AS tipo_file,
            IFNULL(files.path,'') AS file_path
            FROM clienti
            JOIN progetti ON clienti.id = progetti.cliente
            JOIN stati_progetto ON progetti.stato = stati_progetto.code AND stati_progetto.code != 'conclusi'
            LEFT JOIN ordini ON ordini.progetto = progetti.id
            LEFT JOIN righe_ordine ON ordini.id = righe_ordine.ordine  
            LEFT JOIN stati_ordine ON ordini.stato = stati_ordine.id
            LEFT JOIN servizi ON righe_ordine.servizio = servizi.id
            LEFT JOIN contratti ON contratti.progetto = progetti.id
            LEFT JOIN servizi_contratti ON servizi_contratti.contratto = contratti.id AND servizi_contratti.servizio = servizi.id 
            LEFT JOIN stati_contratto ON contratti.stato = stati_contratto.id
            LEFT JOIN files ON files.cliente = clienti.id AND files.progetto = progetti.id 
            `
            const result = await this.dbService.query(stmt)
            return result.length ? result : []
        }
        catch ( error ) {
            console.log(error)
            switch (error.code) {
                default: 
                    return {error: true, code: null, message: "Unknown error"}
            }
        }
    }
}

module.exports = Model