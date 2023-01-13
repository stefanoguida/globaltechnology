const Model = require('./model')
class Cliente extends Model {
    constructor () {
        super()
        this.table = 'clienti'
    }
}
module.exports = Cliente