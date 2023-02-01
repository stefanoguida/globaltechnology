const Model = require('./model')
class TipoProgetto extends Model {
    constructor () {
        super()
        this.table = 'tipi_progetto'
    }
}
module.exports = TipoProgetto