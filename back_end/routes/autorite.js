const express = require('express')
const router = express.Router();
const db = require('../database')

router.get('/enfant/all/:id_autorite_enfant',async (req,res)=>{
    let sql = `SELECT id, intitule, intitule_code, id_autorite_parent
    FROM
        stage.autorite_enfant t where id != ${req.params.id_autorite_enfant}`
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.send({ err });
        }else{
            return res.json(result);
        }
    });
})

router.get('/enfant/all',async (req,res)=>{
    let sql = `SELECT id, intitule, intitule_code, id_autorite_parent
    FROM
        stage.autorite_enfant t`
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.send({ err });
        }else{
            return res.json(result);
        }
    });
})

router.get('/enfant/:id',async (req,res)=>{
    db.query(`SELECT id, intitule, intitule_code, id_autorite_parent
    FROM
        stage.autorite_enfant t where id =  ?`, [req.params.id], (err, results) => {             
        if(err) {
            console.log(err);
            res.send({message: err})
            // results(err, null);
        } else {
            res.json(results[0]);
        }
    });   
})

module.exports = router