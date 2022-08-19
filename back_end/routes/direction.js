const express = require('express')
const router = express.Router();
const Direction = require('../models/Direction')

// router.get('/all',async (req,res)=>{
//     res.send('Hello world')
// })


// get all doleance
router.get('/all',async (req,res)=>{
    try {
        const directions = await Direction.find()
        res.json(directions)
    } catch (err) {
        res.json({message: err})
    }
})

module.exports = router