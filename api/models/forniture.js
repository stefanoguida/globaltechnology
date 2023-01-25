const Model = require('./model')
class Fornitura extends Model {
    constructor () {
        super()
        this.table = 'forniture'
    }
}
module.exports = Fornitura