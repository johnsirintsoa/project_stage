const express = require('express')
const router = express.Router();
const db = require('../database').conn
const db_name = require('../database').db_name

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