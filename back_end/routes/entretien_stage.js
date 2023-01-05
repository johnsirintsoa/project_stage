const express = require('express')
const router = express.Router();
const db = require('../database').conn
const db_name = require('../database').db_name
const mailing = require('../Controllers/MailingController')

router.post('/add',async(req,res) => {
    const sql = `CALL add_entretien_stage('${req.body.date_debut}','${req.body.date_fin}','${req.body.time_debut}','${req.body.time_fin}',${req.body.id_autorite_enfant},'${req.body.id_demande_stage}')`
        db.query(sql, async(error,result) => {
        if(error) {
            res.send(error)
        } 
        else if(result.length > 0 ) {
            res.json(result[0][0])
        }
        else{
            const autorite = req.body.autorite
            const stagiaire = {
                mail : req.body.e_mail,
                nom : req.body.nom,
                prenom : req.body.prenom,
                telephone: req.body.telephone,
                e_mail: req.body.e_mail,
                cin: req.body.cin, 
            }
            const entretien_date_time = String(req.body.date_debut).concat('T',req.body.time_debut)
            const response = await mailing.entretien_valide(autorite,stagiaire,entretien_date_time)
            
            if(response && result ){
                res.json(result)
            }
            else {
                res.json({message:'Validation non validé et envoyé'})
            }
        }
        
    })
})

// router.post('/add',async(req,res) => {
//     // res.json({arg:req.body})
    // const autorite = req.body.autorite
    // const stagiaire = {
    //     mail : req.body.e_mail,
    //     nom : req.body.nom,
    //     prenom : req.body.prenom,
    //     telephone: req.body.telephone,
    //     e_mail: req.body.e_mail,
    //     cin: req.body.cin, 
    // }
    // const entretien_date_time = String(req.body.date_debut).concat('T',req.body.time_debut)
    // // console.log(stagiaire,autorite,entretien_date_time)
    // const response = await mailing.entretien_valide(autorite,stagiaire,entretien_date_time)
    // res.json(response)
// })

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
    db.query(`CALL update_entretien_stage('${req.body.date_debut}','${req.body.date_fin}','${req.body.time_debut}','${req.body.time_fin}',${req.body.id} ,${req.body.id_autorite_enfant_receiver}) `, async (error,result) => {
        if(error){
            res.send(error)
        } 
        else if(result.length > 0 ){
            res.json(result[0][0])
        }else{
            const autorite = req.body.autorite
            const stagiaire = {
                mail : req.body.e_mail,
                nom : req.body.nom,
                prenom : req.body.prenom,
                telephone: req.body.telephone,
                e_mail: req.body.e_mail,
                cin: req.body.cin, 
            }
            const entretien_date_time = String(req.body.date_debut).concat('T',req.body.time_debut)
            const response = await mailing.entretien_reporte(autorite,stagiaire,entretien_date_time)
            
            if(response && result ){
                res.json(result)
            }
            else {
                res.json({message:'Entretien reporté et envoyé',mail:response,result})
            }
        }
    })
})

router.post('/delete',async(req,res)=>{
    db.query(`DELETE FROM entretien_demande_stage where id = ${req.body.id_entretien}`,async (error,result)=>{
        if(error){
            res.send(error)
        }
        else{
            const autorite = req.body.autorite
            const stagiaire = {
                mail : req.body.e_mail,
                nom : req.body.nom,
                prenom : req.body.prenom,
                telephone: req.body.telephone,
                e_mail: req.body.e_mail,
                cin: req.body.cin, 
            }
            const response = await mailing.entretien_supprimer(autorite,stagiaire)
            
            if(response && result ){
                res.json(result)
            }
            else {
                res.json({message:'Entretien supprimé',mail:response,result})
            }
        }
    })
})

module.exports = router