const fs = require('fs')
const modules = {}
fs.readdirSync(__dirname).forEach(filename => {
    const moduleName = filename.replace(/(\.\/|\.js)/g, "").replace(/^\w/, c => c.toUpperCase());
    modules[moduleName] = require(__dirname + '/' + filename)
})
module.exports = modules