const Model = require('./model')
class Stato extends Model {
    constructor () {
        super()
        this.table = 'stati'
    }
}
module.exports = Stato