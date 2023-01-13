const Model = require('./model')
class StatoProgetto extends Model {
    constructor () {
        super()
        this.table = 'stati_progetto'
    }
}
module.exports = StatoProgetto