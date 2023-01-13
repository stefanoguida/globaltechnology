const Model = require('./model')
class StatoOrdine extends Model {
    constructor () {
        super()
        this.table = 'stati_ordine'
    }
}
module.exports = StatoOrdine