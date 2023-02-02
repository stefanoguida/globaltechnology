const Model = require('./model')
class TipoServizio extends Model {
    constructor () {
        super()
        this.table = 'tipi_servizio'
    }
}
module.exports = TipoServizio