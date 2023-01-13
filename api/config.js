require('dotenv').config()
const path = require('path')
module.exports = {
    filesBaseDir: path.resolve('./storage'),
    db: {
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME
    },
    token: {
        key: process.env.TOKEN_SECRET
    },
    auth: {
        unauthorizedRoutes: ['/','/auth/login','/auth/logout','/auth/register', '/auth/verify-token']
    }
}
