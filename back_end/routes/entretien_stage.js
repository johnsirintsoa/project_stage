const express = require('express')
const router = express.Router();
const db = require('../database')

router.post('/add',async(req,res)=>{
    const sql = `CALL add_entretien_stage('${req.body.date_debut}','${req.body.date_fin}','${req.body.time_debut}','${req.body.time_fin}',${req.body.id_autorite_enfant},'${req.body.id_demande_stage}')`
        db.query(sql, (error,result) => {
        if(error){
            res.send(error)
        } 
        else if(result.length > 0 ){
            res.json(result[0][0])
        }else{
            res.json(result)
        }
        
    })
})

router.post('/update',async(req,res)=>{
    // const audience = {
    //     date_debut: req.body.date_debut,
    //     date_fin: req.body.date_fin, 
    //     time_debut: req.body.time_debut,
    //     time_fin: req.body.time_fin,
    //     id_autorite_enfant_receiver: req.body.id_autorite_enfant_receiver,
    //     id_entretien_stage: req.body.id,
    // }
    // const sql = `INSERT INTO stage.demande_audience( date_time_debut, date_time_fin, id_demande_stage, motif, id_direction, type_audience ) VALUES ( '${req.body.date_time_debut}', '${req.body.date_time_fin}', ${req.body.id_demande_stage}, '${req.body.motif}', ${req.body.id_direction}, '${req.body.type_audience}' )`
    db.query(`CALL update_entretien_stage('${req.body.date_debut}','${req.body.date_fin}','${req.body.time_debut}','${req.body.time_fin}',${req.body.id} ,${req.body.id_autorite_enfant_receiver}) `, (error,result) => {
        if(error){
            res.send(error)
        } 
        else if(result.length > 0 ){
            res.json(result[0][0])
        }else{
            res.json(result)
        }
    })
})

router.get('/delete/:id',async(req,res)=>{
    db.query(`DELETE FROM entretien_demande_stage where id = ${req.params.id}`,(error,result)=>{
        if(error){
            res.send(error)
        }else{
            res.json(result)
        }
    })
})

module.exports = router