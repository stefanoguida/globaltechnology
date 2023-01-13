// Settaggio del timezone del server impostato ad un offset di +00:00
process.env.TZ = 'Europe/Rome';
  
// Intercettazione di errori inaspettati
process.on('uncaughtException', (error) => {
    console.log(`UNEXPECTED ERROR:`)
    console.dir(error, {depth: null})
});

// Intercettazione di Promise rejection non gestite
process.on('unhandledRejection', (error, promise) => {
    console.log('PROMISE REJECTION NOT MANAGED:\n--- ERROR:', promise, error)
})

const http = require('http')
const express = require('express')
const bodyParser = require('body-parser')
const jwt = require('jsonwebtoken');
const Router = require('./Router')
const config = require('./config')

// App
const app = express();
app.disable('x-powered-by');
app.use(express.static(__dirname + '/public'));
app.use(bodyParser.json({ limit: '5mb' }));
app.use(bodyParser.urlencoded({extended: true}));

/**
 * Headers di default per le risposte gestite da questo server
 */
app.use((req, res, next) => {
    res.header('Charset', 'utf-8');
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization, Cache-Control, User-Agent');
    res.header('Access-Control-Expose-Headers', 'Authorization');
    res.header('Content-Type', 'application/json');
    res.header('Access-Control-Allow-Credentials', 'false');
    res.header('Access-Control-Allow-Methods', 'PUT, POST, PATCH, DELETE, GET');
    res.header('X-Frame-Options', 'sameorigin');
    res.header('Strict-Transport-Security', 'max-age=86400000; includeSubDomains');
    res.header('X-Content-Type-Options', 'nosniff');
    res.header('X-Download-Options', 'noopen');
    res.header('X-XSS-Protection', '1; mode=block');
    if (req.method === 'OPTIONS') {
        return res.status(200).json({});
    }
    next();
});

// Middleware JWT Validation
app.use( (req, res, next) => {
    console.log(`[${req.method}]`,req.path,req.params,req.body, req.headers['authorization'])
    if (config.auth.unauthorizedRoutes.includes(req.path)){
        next()
    }
    else {
        try {
            const authHeader = req.headers['authorization']
            const token = authHeader && authHeader.split(' ')[1]
            if (token == null) return res.sendStatus(401)
            jwt.verify(token, config.token.key, (err, user) => {
                if (err) return res.status(403).send(err)
                next()
            })
    
        } catch (e) {
            res.status(403).send(e.toString())
        }
    }
})
  
// Rotta di verifica di funzionamento del servizio
app.get('/', (req, res) => res.status(200).send('Global Technology Service online') )

app.use('/auth', Router.auth)

app.use('/', Router.routes)

// Middleware per la gestione degli errori 404
app.use((req, res, next) => res.status(404).send('Not Found') );

// Middleware per la gestione generica degli errori
app.use((err, req, res, next) => res.status(500).send('Internal Server Error') );

// Connessione http
http.createServer(app).listen(80, () => console.log(`Running on 80`) );