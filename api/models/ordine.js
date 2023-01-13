const Model = require('./model')
class Ordine extends Model {
    constructor () {
        super()
        this.table = 'ordini'
    }
}
module.exports = Ordine