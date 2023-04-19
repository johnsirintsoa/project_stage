const express = require('express')
const router = express.Router();
const db = require('../database').conn
const db_name = require('../database').db_name
const mailing = require('../Controllers/MailingController')

router.post('/add',async(req,res) => {
    const autorite = req.body.autorite
    const stage = req.body.stage
    const sql = `CALL ajouter_entretien_stage(${stage.id}, ${req.body.id_date_heure_disponible_autorite})`
    // res.json(req.body)
    // console.log(req.body)   
    db.query(sql, async(error,result) => {
        if(error) {
            res.send(error)
        } 
        else{
            const aut = {
                intitule: autorite.child_libelle,
                intitule_code: autorite.sigle
            }
            const entretien_date_time = String(result[0][0].date_debut).concat('T',result[0][0].heure_debut)
            const response = await mailing.entretien_valide(aut,stage,entretien_date_time)
            
            if(response && result ){
                res.json({mail:response,data:result[0][0]})
            }
            else {
                res.json({message:'Entretien non validé et envoyé'})
            }
        }
        
    })
})


router.post('/update',async(req,res)=>{
    const autorite = req.body.autorite
    const stage = req.body.stage
    // console.log(req.body)
    const sql = `CALL modifier_entretien_stage(${req.body.id_date_heure_disponible_autorite},${stage.id}) `
    
    db.query(sql, async (error,result) => {
        if(error){
            res.send(error)
        } 
        else{
            const entretien_date_time = String(result[0][0].date_debut).concat('T',result[0][0].heure_debut)
            const aut = {
                intitule: autorite.child_libelle,
                intitule_code: autorite.sigle
            }
            const response = await mailing.entretien_reporte(aut,stage,entretien_date_time)
            
            if(response && result ){
                res.json({mail:response,data:result[0][0]})
            }
            else {
                res.json({message:'Entretien non validé et envoyé'})
            }
        }
    })
})

router.post('/updateCalendar',async(req,res) => {
    const autorite = req.body.autorite
    const stagiaire = req.body.stagiaire
    // IN id_entretien_stage int,IN id_demande_stage INT,IN date_debut date,IN date_fin date,IN heure_debut time,in heure_fin time, IN id_autorite INT
    // const sql = `CALL modifier_entretien_stage_calendrier(${stage.id_entretien_stage},${stage.id},'${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}',${autorite.id})`
    const sql = `CALL modifier_entretien_stage_calendrier(${req.body.id_entretien_stage},${req.body.id_demande_stage},'${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}',${req.body.id_autorite})`
    console.log(sql)
    db.query(sql, async (error,result) => {
        if(error){
            res.send(error)
        } 
        else{
            const entretien_date_time = String(req.body.date_debut).concat('T',req.body.heure_debut)
            const response = await mailing.entretien_reporte(autorite,stagiaire,entretien_date_time)
            if(result ){
                res.json({data:result})
            }
            // if(response && result ){
            //     res.json({data:result})
            // }
            else {
                res.json({message:'Entretien non validé et envoyé'})
            }
        }
    })
    // db.query(sql, async (error,result) => {
    //     if(error){
    //         res.send(error)
    //     } 
    //     else{
    //         const entretien_date_time = String(req.body.date_debut).concat('T',req.body.heure_debut)
    //         const response = await mailing.entretien_reporte(autorite,stage,entretien_date_time)
            
    //         if(response && result ){
    //             res.json({mail:response,data:result})
    //         }
    //         else {
    //             res.json({message:'Entretien non validé et envoyé'})
    //         }
    //     }
    // })
})

router.post('/delete',async(req,res)=>{
    const autorite = req.body.autorite
    const stage = req.body.stage
    const sql = `call supprimer_entretien_stage (${stage.id})`
    // res.json(sql)
    db.query(sql,async (error,result)=>{
        if(error){
            res.send(error)
        }
        else{
            // const aut = {
            //     intitule: autorite.child_libelle,
            //     intitule_code: autorite.sigle
            // }
            const response = await mailing.entretien_supprimer(autorite,stage)
            
            if(response && result ){
                res.json({message:'Cette demande de stage est maintenant considérée comme une demande non validé',mail:response,data:result[0][0]})
            }
            else {
                res.json({message:'Entretien non supprimé',mail:response,data:result[0][0]})
            }
        }
    })
})

module.exports = router