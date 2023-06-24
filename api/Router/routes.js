const express = require('express')
const router = express.Router()
const config = require('../config')
const path = require('path')
const fs = require('fs')
const moment = require('moment')
const Factory = require('../model_factory/factory')
const factory = new Factory()
const multer = require('multer')
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, config.filesBaseDir)
    },
    filename: function (req, file, cb) {
        let filename
        if (fs.existsSync( path.join(config.filesBaseDir,file.originalname) )) {
            const fileDetails = path.parse(file.originalname)
            filename = [fileDetails.name, moment().format('YYYYMMDDhhmmss')].join('-') + fileDetails.ext
        }
        else {
            filename = file.originalname
        }
        cb(null, filename);
     }
  })
const upload = multer({storage: storage})

router.post('/generateOrdersFromProject', async (req, res, next) => {
    try {
        const projectId = req.body.project_id || false
        if( ! projectId ) {
            res.status(200).json({error:true, code: null, message: 'Missing Project ID'})
        }
        else {
            const Model = factory.getInstanceOf('ordine')
            const response = await Model.generateOrdersFromProject(projectId)
            res.status(200).json(response)
        }
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: error.toString() })
    }    
})

router.get('/getContractsPerMonth', async (req, res, next) => {
    try {
        const Model = factory.getInstanceOf('Kpi')
        const data = await Model.getContractsPerMonth()
        res.status(200).json({error: false, code: null, message: "success", data})
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
})

router.get('/getKwPerMonth', async (req, res, next) => {
    try {
        const Model = factory.getInstanceOf('Kpi')
        const data = await Model.getKwPerMonth()
        res.status(200).json({error: false, code: null, message: "success", data})
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
})

router.get('/getRunningOffers', async (req, res, next) => {
    try {
        const Model = factory.getInstanceOf('Kpi')
        const data = await Model.getRunningOffers()
        res.status(200).json({error: false, code: null, message: "success", data})
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
})

router.get('/getAcceptedOffers', async (req, res, next) => {
    try {
        const Model = factory.getInstanceOf('Kpi')
        const data = await Model.getAcceptedOffers()
        res.status(200).json({error: false, code: null, message: "success", data})
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
})

router.get('/getRunningProjects', async (req, res, next) => {
    try {
        const Model = factory.getInstanceOf('Kpi')
        const data = await Model.getRunningProjects()
        res.status(200).json({error: false, code: null, message: "success", data})
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
})

router.get('/getTotalKw', async (req, res, next) => {
    try {
        const Model = factory.getInstanceOf('Kpi')
        const data = await Model.getTotalKW()
        res.status(200).json({error: false, code: null, message: "success", data})
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
})

router.get('/getInstalledKW', async (req, res, next) => {
    try {
        const Model = factory.getInstanceOf('Kpi')
        const data = await Model.getInstalledKW()
        res.status(200).json({error: false, code: null, message: "success", data})
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
})

router.get('/getTotalInvoiced', async (req, res, next) => {
    try {
        console.log('getTotalInvoiced')
        const Model = factory.getInstanceOf('Kpi')
        const data = await Model.getTotalInvoiced()
        res.status(200).json({error: false, code: null, message: "success", data})
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
})

router.get('/getTotalContractsValue', async (req, res, next) => {
    try {
        console.log('getTotalContractsValue')
        const Model = factory.getInstanceOf('Kpi')
        const data = await Model.getTotalContractsValue()
        res.status(200).json({error: false, code: null, message: "success", data})
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
})

router.get('/getProjectsProgress', async (req, res, next) => {
    try {
        const Model = factory.getInstanceOf('Progetto')
        const data = await Model.getProjectsProgress()
        res.status(200).json({error: false, code: null, message: "success", data})
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
})

router.get('/getInvoicedProjects', async (req, res, next) => {
    try {
        const Model = factory.getInstanceOf('Kpi')
        const data = await Model.getInvoicedProjects()
        res.status(200).json({error: false, code: null, message: "success", data})
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
})

router.get('/getFlatData', async (req, res, next) => {
    try {
        const Model = factory.getInstanceOf('Model')
        const data = await Model.getFlatData()
        res.status(200).json({error: false, code: null, message: "success", data})
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
})

router.post('/uploadFile', upload.any(), async (req, res, next) => {
    try {
        if(!req.files) {
            res.send({ error: true, code: 'nofileuploaded', message: 'No file uploaded' });
            return;
        } 
        else {
            const Model = factory.getInstanceOf('File')
            await Model.saveFile(req.files[0], req.body)
        }
        res.status(200).json({error: false, code: null, message: "success"})
    }
    catch( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
} )

router.get('/descTable/:model', async (req, res, next) => {
    try {
        const model = req.params.model || ''
        if (!model) {
            res.send({ error: true, code: 'missingmodel', message: 'Missing model' });
            return;
        }
        const Model = factory.getInstanceOf(model)
        const data = await Model.descTable()
        res.status(200).json({error: false, code: null, message: "success", data})
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
})

router.delete('/file/:id', async (req, res, next) => {
    try {
        if(!req.params.id) {
            res.send({ error: true, code: 'missingid', message: 'Missing file ID' });
            return;
        } 
        else {
            const Model = factory.getInstanceOf('File')
            await Model.deleteFile(req.params.id)
        }
        res.status(200).json({error: false, code: null, message: "success"})
    }
    catch( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
} )

// GET
router.get('/:module/:id?', async (req, res, next) => {
    try {
        const module = req.params.module
        const id = req.params.id || false 
        
        const Model = factory.getInstanceOf(module)
        const data = id ? await Model.getFirst([{field: 'id', op: '=', value: id}]) : await Model.get()
        res.status(200).json({error: false, code: null, message: "success", data})
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
});

// GET WHERE
router.post('/:module/where', async (req, res, next) => {
    try {
        const module = req.params.module
        const condition = req.body.condition || []
        
        const Model = factory.getInstanceOf(module)
        const data = await Model.get(condition)
        res.status(200).json({error: false, code: null, message: "success", data})
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
});

// INSERT
router.post('/:module', async (req, res, next) => {
    try {
        const module = req.params.module
        const data = req.body.data || {}

        const Model = factory.getInstanceOf(module)

        if(Model.helper.dependencies.lodash.isEmpty(data)) {
            res.status(400).json({error: true, code: null, message: 'Malformed payload. Data is empty'})
            return false
        }

        let response

        if ( Model.helper.dependencies.lodash.isArray(data) ) {
            response = await Model.bulkInsert(data)
        }
        else if ( Model.helper.dependencies.lodash.isObject(data) ) {
            response = await Model.insert(data)
        }
        else {
            res.status(400).json({error: false, code: null, message: "Malformed payload"})    
            return false
        }
        
        res.status(200).json(response)
    } 
    catch ( error ) {
        console.log(error)
        res.status(501).json({error: true, code: error.code ,message: "Unknown error"})
    }
});

// UPDATE
router.put('/:module', async (req, res, next) => {
    try {
        const module = req.params.module
        const data = req.body.data || false
        const cond = req.body.condition || []
        
        const Model = factory.getInstanceOf(module)

        if (!data || !Model.helper.dependencies.lodash.isObject(data)) {
            res.status(400).json({error:true, code: null, message: "Malformed payload. Data seems not to be instance of Object or it is empty"})
            return false
        }
        
        const response = await Model.update(data, cond)

        res.status(200).json(response)
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
});

// DELETE WHERE
router.delete('/:module/where', async (req, res, next) => {
    try {
        const module = req.params.module
        const condition = req.body.condition || []
        if(!module || !condition.length ) {
            res.status(400).json({error:true, code: null, message: "Missing module or condition"})
        }
        else {
            const Model = factory.getInstanceOf(module)
            const response = await Model.deleteWhere(condition)
            res.status(200).json(response)
        }
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
});

// DELETE
router.delete('/:module/:id', async (req, res, next) => {
    try {
        const module = req.params.module
        const id = req.params.id
        if(!module || !id) {
            res.status(400).json({error:true, code: null, message: "Missing module or row id"})
        }
        else {
            const Model = factory.getInstanceOf(module)
    
            const response = await Model.delete(id)
            res.status(200).json(response)
        }
    } 
    catch ( error ) {
        console.log(error)
        res.json({error: true, code: null, message: "Unknown error"})
    }
});

module.exports = router