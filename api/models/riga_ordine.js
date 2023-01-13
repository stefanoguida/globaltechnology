const Model = require('./model')
class RigaOrdine extends Model {
    constructor () {
        super()
        this.table = 'righe_ordine'
    }
}
module.exports = RigaOrdine