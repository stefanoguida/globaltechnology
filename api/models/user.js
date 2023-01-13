const Model = require('./model')
class User extends Model {
    constructor () {
        super()
        this.table = 'users'
    }
}
module.exports = User