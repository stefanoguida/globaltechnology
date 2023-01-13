const Model = require('./model')
class StatoContratto extends Model {
    constructor () {
        super()
        this.table = 'stati_contratto'
    }
}
module.exports = StatoContratto