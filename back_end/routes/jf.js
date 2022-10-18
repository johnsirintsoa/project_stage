const express = require('express')
const router = express.Router()
const db = require('../database')

router.get('/all',async (req,res)=>{
    // console.log('Hello world...')
    let sql = "SELECT nom_evenement, numero_du_jour, mois_du_jour FROM stage.jour_ferie e"
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.send({ err });
        }else{
            return res.json(result);
        }
    });
})

module.exports = router