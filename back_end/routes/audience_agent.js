const express = require('express')
const router = express.Router()

const rohiPool = require('../database').rohi
const rohiAudiencePool = require('../database').rohiAudience
// const db = require('../database').rohiAudience
// const db_name = require('../database').db_name
const mailing = require('../Controllers/MailingController')
const Function = require('../func/function')

const notification_mailing = require('../Controllers/NotificationController')

// const rohi = require('../database').rohi
// const db = require('../database').conn
require('dotenv/config')

router.post('/agent/ajouter',async(req,res)=>{
    const nomFormated = req.body.nom.toUpperCase()
    const prenomFormated = Function.upSetFirstLetter(req.body.prenom)

    const sql = `CALL ajouter_audience_agent('${req.body.session_navigateur}','${req.body.id_agent}','${req.body.numero_telephone}','${req.body.email}',${req.body.id_date_heure_disponible_autorite},'${req.body.motif}','${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}')`
    // console.log(sql)

    rohiPool.then((rohiDb) => {
        rohiPool.query(sql, async (error,result) => {
            if(error){
                // throw err
                res.send(error)
            } 
            else if(result.length > 0 ){
                // console.log(req.body)
                const envoyeur = {
                    nom: nomFormated,
                    prenom: prenomFormated,
                    path: req.body.path_agent,
                    motif: req.body.motif,
                    date_debut: req.body.date_debut,
                    date_fin: req.body.heure_fin,
                    heure_debut: req.body.heure_debut,
                    heure_fin: req.body.heure_fin
                }
                const receiver = {
                    email: req.body.autoriteReceiver.email,
                    intitule_code: req.body.autoriteReceiver.sigle,
                    intitule: req.body.autoriteReceiver.child_libelle,
                }
                const mail = await notification_mailing.notification_audience_agent(envoyeur,receiver)
                res.json(result[0][0])
            }   
            else{
                res.json(result[0])
            }
            rohiDb.release()
        })
    }).catch((err) => {
        throw err
    });


})

router.post('/agent/modifier',async(req,res)=>{
    const nomFormated = req.body.nom.toUpperCase()
    const prenomFormated = Function.upSetFirstLetter(req.body.prenom)
    const sql = `call modifier_audience_agent ('${req.body.numero_telephone }','${req.body.email }','${req.body.motif}',${req.body.id_audience},${req.body.id_date_heure_disponible_autorite},${req.body.id_dm_aud_public_heure_dispo})`
    // console.log(sql)
    // console.log(req.body)  
    rohiPool.then((rohiDB) => {
        rohiDB.query(sql,async (error,result) => {
            if(error){
                res.send(error)
            } 
            else if(result.length > 0 ){
                const envoyeur = {
                    nom: nomFormated,
                    prenom: prenomFormated,
                    path: req.body.path_agent,
                    motif: req.body.motif,
                    date_debut: req.body.date_debut,
                    date_fin: req.body.heure_fin,
                    heure_debut: req.body.heure_debut,
                    heure_fin: req.body.heure_fin
                }
                const receiver = {
                    email: req.body.autoriteReceiver.email,
                    intitule_code: req.body.autoriteReceiver.sigle,
                    intitule: req.body.autoriteReceiver.child_libelle,
                }
                const mail = await notification_mailing.notification_audience_agent(envoyeur,receiver)
                res.json(result[0][0])
            }else{
                res.json(result)
            }
            rohiDB.release()
        })
    }).catch((err) => {
        throw err
    });
    

})

module.exports = router