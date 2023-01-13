const Model = require('./model')
class Servizio extends Model {
    constructor () {
        super()
        this.table = 'servizi'
    }
}
module.exports = Servizio