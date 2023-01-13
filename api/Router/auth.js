const express = require('express')
const router = express.Router()
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')
const config = require('../config')
const ModelFactory = require('../model_factory/factory')

// Login
router.post('/login', async (req, res, next) => {
    try {
        const email = req.body.email || false
        const password = req.body.password || false
        if (!email || !password) {
            res.json({error: true, user: {}, message: "Credenziali mancanti!"})
        } else {
            const Factory = new ModelFactory()
            const user = Factory.getInstanceOf('User')
            const cond = [{field: 'email', op: '=', value: email}]
            const userinfo = await user.getFirst(cond)
            if (Object.keys(userinfo).length) {
                const valid = bcrypt.compareSync(password, userinfo.password)
                if (valid) {
                    res.json({
                        error: false,
                        user: {
                            token: jwt.sign( {name: userinfo.name,surname: userinfo.surname}, config.token.key, {expiresIn: '8h'} ),
                            nome: userinfo.name,
                            cognome: userinfo.surname,
                            email: userinfo.email
                        },
                        message: "Login successfully!"
                    })
                } 
                else {
                    res.json({error: true, user: {}, message: "Credenziali errate!"})
                }
            } 
            else {
                res.json({error: true, user: {}, message: "Utente inesistente!"})
            }
        }
    } 
    catch (e) {
        console.log(e)
        res.json({error: true, user: {}, message: "Error Generico!\nContattare l'assistenza"})
    }
});

// Register
router.post('/register', async (req, res, next) => {
    try {
        const name = req.body.name || false
        const surname = req.body.surname || false
        const email = req.body.email || false
        let password = req.body.password || false
        const values = [name, surname, email, password]

        if (values.filter(Boolean).length < 4) throw new Error('Register - Missing params')
        password = bcrypt.hashSync(password, 10)

        try {
            const Factory = new ModelFactory()
            const user = Factory.getInstanceOf('User')
            await user.insert({name, surname, email, password})
        } 
        catch (e) {
            switch (e.code) {
                case "ER_DUP_ENTRY":
                    res.json({error: true,message: "Utente già registrato!\n"})
                default:
                    res.json({error: true,message: "Errore Generico.\nContattare l'assistenza"})
            }
        }

        res.status(200).json({error: false,message: ""})
    } catch (e) {
        console.log(e)
        res.status(500).json({error: false,message: "Errore Generico.\nContattare l'assistenza"})
    }
})

// Log out
router.post('/logout', async (req, res, next) => {
    try {
        const email = req.body.email || false
        if (!email) throw new Error('Logout - Missing params')

        const Factory = new ModelFactory()
        const user = Factory.getInstanceOf('User')
        
        await user.update({token: null}, [{field:'email', op:'=', value:email}])

        res.status(200).send(true)
    } catch (e) {
        console.log(e)
        next(e)
    }
})

// Log out
router.all('/verify-token', async (req, res, next) => {
    try {
        const authHeader = req.headers['authorization']
        const token = authHeader && authHeader.split(' ')[1]

        if (token == null) return res.sendStatus(401)
        jwt.verify(token,config.token.key, (err, user) => {
            if (err) return res.status(200).send(err)
            res.status(200).json({expiredAt : false, message :  "verified", name : "TokenValid"})
        })

    } catch (e) {
        res.status(403).send(e.toString())
    }
})

module.exports = router;