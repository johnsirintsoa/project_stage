const express = require('express')
const router = express.Router();
const db = require('../database')

router.get('/all',async (req,res)=>{
    let sql = "SELECT * FROM domaine"
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.send({ err });
        }else{
            return res.json(result);
        }
    });
})

module.exports = router