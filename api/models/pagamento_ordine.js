const Model = require('./model')
class PagamentoOrdine extends Model {
    constructor () {
        super()
        this.table = 'pagamenti_ordine'
    }
}
module.exports = PagamentoOrdine