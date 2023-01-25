const fs = require('fs')
module.exports = {
    dependencies: {
        lodash: require('lodash'),
        fileupload: require('express-fileupload'),
        morgan: require('morgan')
    },
    deleteFile: path => fs.unlinkSync(path)
}