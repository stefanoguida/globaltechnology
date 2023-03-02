const Model = require('./model')
class MetodoPagamento extends Model {
    constructor () {
        super()
        this.table = 'payment_methods'
    }

    async descTable () {
        return [
            'id',
            'trec',
            'created_at',
            'created_by',
            'updated_at',
            'updated_by',
            'code',
            'name'
        ]
    }
}
module.exports = MetodoPagamento