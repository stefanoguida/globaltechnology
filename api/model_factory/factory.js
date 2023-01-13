const fs = require('fs')
const path = require('path');
let instance
class ModelFactory {
    constructor( ) {
        if ( instance ) return instance
        
        this.models = {}
        fs.readdirSync(path.join(__dirname, '../models')).forEach(filename => {
            const moduleName = filename.replace(/(\.\/|\.js)/g, "").replace(/^\w/, c => c.toUpperCase());
            if (moduleName !== 'Index')
                this.models[moduleName] = require(path.join(__dirname , '../models/' , filename))
        })

        instance = this
    }

    getInstanceOf( module, params = {} ) {
        module = module.replace(/^\w/, c => c.toUpperCase())
        return new this.models[module](params)
    }
}

module.exports = ModelFactory