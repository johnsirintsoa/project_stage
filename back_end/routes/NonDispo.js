const express = require('express')
const router = express.Router();
const db = require('../database').conn
const db_name = require('../database').db_name
const mailing = require('../Controllers/MailingController')

router.post('/ajouter_non_disponible', async (req,res) => {
    const autorite = req.body.autorite
    // const sql = `CALL ajouter_non_disponible_autorite(${autorite.id},'${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}')`
    const sql = ` CALL ajouter_non_disponible_autorite (${req.body.id_autorite},'${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}')`
    // res.json(sql)
    db.query(sql,function(err,result){
        if(err){
            return res.send({ err });
        }
        else{
            // return res.json(result[0
            result[0].forEach(element => {
                // console.log(element)
                if(element.type_evenement === 'Public'){
                    const sql1 = `UPDATE demande_audience_public set action = 2 where id = ${element.id}`
                    db.query(sql1, async (err,result)=>{
                        if(err){
                            return res.send({err})
                        }
                        else{
                            const response = await mailing.reporter_evenement(autorite,element)
                            // return res.json({mail:response, data:result})
                        }
                    })
                }
                else if(element.type_evenement === 'Autorité'){
                    const sql1 = `UPDATE demande_audience_autorite set action = 2 where id = ${element.id}`
                    db.query(sql1, async (err,result)=>{
                        if(err){
                            return res.send({err})
                        }
                        else{
                            const response = await mailing.reporter_evenement(autorite,element)
                            // return res.json({mail:response, data:result})
                        }
                    })
                }
                else if(element.type_evenement === 'Entretien'){
                    const sql1 = `UPDATE demande_stage set action = 2 where id = ${element.id}`
                    db.query(sql1, async (err,result)=>{
                        if(err){
                            return res.send({err})
                        }
                        else{
                            const response = await mailing.reporter_evenement(autorite,element)
                            // return res.json({mail:response, data:result})
                        }
                    })
                }
            }); 
            return res.json({message:'Pas disponible'})
        }
    })
})

router.post('/modifier_non_disponible', async (req,res) => {
    const autorite = req.body.autorite
    const evenement = req.body.evenement
    // const sql = ` CALL modifier_non_disponible_autorite (${autorite.id},${evenement.id_date_heure_non_dispo},'${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}')`
    const sql = ` CALL modifier_non_disponible_autorite (${req.body.id_autorite},${req.body.id_date_heure_non_dispo},'${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}')`

    // res.json(sql)
    db.query(sql,function(err,result){
        if(err){
            return res.send({ err });
        }
        else{
            // return res.json(result[0])
            result[0].forEach(element => {

                // console.log(sender)
                if(element.type_evenement === 'Public'){
                    const sql1 = `UPDATE demande_audience_public set action = 2 where id = ${element.id}`
                    db.query(sql1, async (err,result)=>{
                        if(err){
                            return res.send({err})
                        }
                        else{
                            const response = await mailing.reporter_evenement(autorite,element)
                            return res.json({mail:response, data:result})
                        }
                    })
                }
                else if(element.type_evenement === 'Autorité'){
                    const sql1 = `UPDATE demande_audience_autorite set action = 2 where id = ${element.id}`
                    db.query(sql1, async (err,result)=>{
                        if(err){
                            return res.send({err})
                        }
                        else{
                            const response = await mailing.reporter_evenement(autorite,element)
                            return res.json({mail:response, data:result})
                        }
                    })
                }
                else if(element.type_evenement === 'Entretien'){
                    const sql1 = `UPDATE demande_stage set action = 2 where id = ${element.id}`
                    db.query(sql1, async (err,result)=>{
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
    })
})

router.post('/supprimer_non_disponible', async (req,res) => {
    // const autorite = req.body.autorite
    // const evenement = req.body.evenement
    const sql = ` DELETE FROM date_heure_non_disponible_autorite where id = ${req.body.id_date_heure_non_dispo}`
    db.query(sql,function(err,result){
        if(err){
            return res.send({ err });
        }
        else{
            return res.json({result})
        }        
    })
})

module.exports = router