const express = require('express')
const router = express.Router();
const db = require('../database')

router.get('/all',async (req,res)=>{
    try {
        let sql = "SELECT * FROM domaine"
        const domaine = await db.promise().query(sql)
        res.json(domaine[0])
    } catch (err) {
        res.json({message: err})
    }
})

module.exports = router