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
        tp.name as tipo_progetto,
        o.kw,
        o.data_accettazione,
        o.importo_contrattato, 
        o.ritenuta_su_milestones,
        sum(if(f.path is null, 0, 1)) has_pdf
        FROM contratti o
        JOIN progetti p ON o.id_progetto = p.id
        JOIN tipi_progetto tp on p.id_tipo_progetto = tp.id
        JOIN clienti c ON p.id_cliente = c.id
        LEFT JOIN files f on f.id_riferimento = o.id and f.tipo = 'contratto'
        where ${condition}
        GROUP BY o.id
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
            'tipo_progetto',
            'kw',
            'data_accettazione',
            'importo_contrattato',
            'ritenuta_su_milestones'
        ]
    }

}
module.exports = Contratto