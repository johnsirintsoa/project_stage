const express = require('express')
const router = express.Router();

const rohiPool = require('../database').rohi
const rohiAudiencePool = require('../database').rohiAudience
// const db = require('../database').conn
// const db_name = require('../database').db_name

const mailing = require('../Controllers/MailingController')
const { authJwt } = require("../middleware");

const moment = require('../func/date.config')


router.post('/ajouter_non_disponible', [authJwt.verifyToken],async (req,res) => {
    const date_debut_Formated = moment.formatDate(req.body.date_debut)
    const date_fin_Formated = moment.formatDate(req.body.date_fin)
    const autorite = req.body.autorite
    // const sql = `CALL ajouter_non_disponible_autorite(${autorite.id},'${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}')`
    const sql = ` CALL ajouter_non_disponible_autorite (${req.body.id_autorite},'${date_debut_Formated}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}')`
 
    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql,function(err,result){
            if(err){
                throw err
                // return res.send({ err });
            }
            else{
                // console.log(result[0])
                // return res.json(result[0
                result[0].forEach(element => {
                    // console.log(element)
                    if(element.type_evenement == 'Public'){
                        const sql1 = `UPDATE demande_audience_public set action = 2 where id = ${element.id}`
                        rohiAudienceDB.query(sql1, async (err,result)=>{
                            if(err){
                                return res.send({err})
                            }
                            else{
                                const response = await mailing.reporter_evenement(autorite,element)
                                // return res.json({mail:response, data:result})
                            }
                        })
                    }
                    else if(element.type_evenement == 'Agent'){
                        console.log(element)
                        const sql1 = `UPDATE demande_audience_public set action = 2 where id = ${element.id}`
                        rohiAudienceDB.query(sql1, async (err,result)=>{
                            if(err){
                                return res.send({err})
                            }
                            else{
                                const response = await mailing.reporter_evenement(autorite,element)
                                // return res.json({mail:response, data:result})
                            }
                        })
                    }
                    else if(element.type_evenement == 'Autorité'){
                        const sql1 = `UPDATE demande_audience_autorite set action = 2 where id = ${element.id}`
                        rohiAudienceDB.query(sql1, async (err,result)=>{
                            if(err){
                                return res.send({err})
                            }
                            else{
                                const response = await mailing.reporter_evenement(autorite,element)
                                // return res.json({mail:response, data:result})
                            }
                        })
                    }
                    else if(element.type_evenement == 'Entretien'){
                        const sql1 = `UPDATE demande_stage set action = 2 where id = ${element.id}`
                        rohiAudienceDB.query(sql1, async (err,result)=>{
                            if(err){
                                return res.send({err})
                            }
                            else{
                                const response = await mailing.reporter_evenement(autorite,element)
                                // return res.json({mail:response, data:result})
                                // console.log(response)
                            }
                        })
                    }
                }); 
                return res.json({message:'Pas disponible'})
            }
            rohiAudienceDB.release()
        })
    }).catch((err) => {
        throw err 
     });


})

router.post('/modifier_non_disponible', [authJwt.verifyToken],async (req,res) => {
    const date_debut_Formated = moment.formatDate(req.body.date_debut)
    const date_fin_Formated = moment.formatDate(req.body.date_fin)
    const autorite = req.body.autorite
    const evenement = req.body.evenement
    // const sql = ` CALL modifier_non_disponible_autorite (${autorite.id},${evenement.id_date_heure_non_dispo},'${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}')`
    const sql = ` CALL modifier_non_disponible_autorite (${req.body.id_autorite},${req.body.id_date_heure_non_dispo},'${date_debut_Formated}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}')`

    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql,function(err,result){
            if(err){
                return res.send({ err });
            }
            else{
                // return res.json(result[0])
                result[0].forEach(element => {
    
                    // console.log(sender)
                    if(element.type_evenement == 'Public'){
                        const sql1 = `UPDATE demande_audience_public set action = 2 where id = ${element.id}`
                        rohiAudienceDB.query(sql1, async (err,result)=>{
                            if(err){
                                return res.send({err})
                            }
                            else{
                                const response = await mailing.reporter_evenement(autorite,element)
                                return res.json({mail:response, data:result})
                            }
                        })
                    }
                    else if(element.type_evenement == 'Agent'){
                        console.log(element)
                        const sql1 = `UPDATE demande_audience_public set action = 2 where id = ${element.id}`
                        rohiAudienceDB.query(sql1, async (err,result)=>{
                            if(err){
                                return res.send({err})
                            }
                            else{
                                const response = await mailing.reporter_evenement(autorite,element)
                                // return res.json({mail:response, data:result})
                            }
                        })
                    }
                    else if(element.type_evenement == 'Autorité'){
                        const sql1 = `UPDATE demande_audience_autorite set action = 2 where id = ${element.id}`
                        rohiAudienceDB.query(sql1, async (err,result)=>{
                            if(err){
                                return res.send({err})
                            }
                            else{
                                const response = await mailing.reporter_evenement(autorite,element)
                                return res.json({mail:response, data:result})
                            }
                        })
                    }
                    else if(element.type_evenement == 'Entretien'){
                        const sql1 = `UPDATE demande_stage set action = 2 where id = ${element.id}`
                        rohiAudienceDB.query(sql1, async (err,result)=>{
                            if(err){
                                return res.send({err})
                            }
                            else{
                                const response = await mailing.reporter_evenement(autorite,element)
                                return res.json({mail:response, data:result})
                            }
                        })
                    }
                }); 
                return res.json({message:'Pas disponible'})
            }
            rohiAudienceDB.release()
        })  
    }).catch((err) => {
        throw err 
     });
})

router.post('/supprimer_non_disponible', [authJwt.verifyToken],async (req,res) => {
    // const autorite = req.body.autorite
    // const evenement = req.body.evenement
    const sql = ` DELETE FROM date_heure_non_disponible_autorite where id = ${req.body.id_date_heure_non_dispo}`
    
    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql,function(err,result){
            if(err){
                return res.send({ err });
            }
            else{
                return res.json({result})
            } 
            rohiAudienceDB.release()       
        })
    }).catch((err) => {
        throw err 
     });
})

module.exports = router