const express = require('express')
const router = express.Router();
const db = require('../database').conn
const db_name = require('../database').db_name
const mailing = require('../Controllers/MailingController')

router.post('/calendrier', async (req,res) =>{
    const sql = `CALL calendrier_autorite(${req.body.id_autorite},${req.body.est_admin})`
    db.query(sql,function(err,result){
        if(err){
            return res.send({ err });
        }
        else{
            return res.json(result[0])    
        }
    })
})

router.post('/filtre_calendrier', async (req,res) =>{
    // res.json(req.body)
    const autorite = req.body.autorite
    const sql = `CALL filtre_calendrier_evenement(
                '${req.body.date_debut}',
                '${req.body.date_fin}',
                '${req.body.type_evenement}',
                ${req.body.status},
                ${autorite.id_autorite_enfant}
            )`
    // res.json(sql)
    db.query(sql,function(err,result){
        if(err){
            return res.send({ err });
        }
        else{
            return res.json(result[0])    
        }
    })
})

router.post('/place_disponible', async (req,res) =>{
    const sql = `CALL places_disponible(${req.body.id_date_heure_disponible_autorite},${req.body.id_autorite})`
    // console.log(sql)
    // res.json(sql)
    db.query(sql,function(err,result){
        // console.log(result)
        if(err){
            return res.send({ err });
        }
        else{
            return res.json(result[0] )    
        }
    })
})





router.get('/liste',async(req,res)=>{
    let sql = `SELECT
    ae.id ,
    ae.intitule ,
    ae.intitule_code
    FROM
    stage5.autorite_enfant ae`
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.send({ err });
        }
        else{
            return res.json(result)
        }
    });
})

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