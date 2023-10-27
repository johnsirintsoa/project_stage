const express = require('express')
const router = express.Router();

const rohiPool = require('../database').rohi
const rohiAudiencePool = require('../database').rohiAudience

// const db = require('../database').conn
// const db_name = require('../database').db_name
const mailing = require('../Controllers/MailingController')
const Function = require('../func/function')

const notification_mailing = require('../Controllers/NotificationController')

const { authJwt } = require("../middleware");

require('dotenv/config')

// Liste audience disponible
router.post('/public/heure_disponible_autorite/jour',async(req,res) =>{
    const sql = `CALL liste_place_disponible_public_par_jour('${req.body.date_du_jour}','${req.body.session_navigateur}',${req.body.id_autorite})`
    
    rohiAudiencePool.getConnection(function(err, rohiAudienceDB){
        rohiAudienceDB.query(sql,function(err,result){
            if(err){
                return res.send({ err });
            }
            else{
                return res.json(result[0])    
            }
            rohiAudienceDB.release()
        })
    })

})

// Liste audiences par jour
router.post('/public/all', async(req,res) =>{
    // const date_du_jour = new Date().getFullYear()+'-'+new Date().getMonth()+'-'+new Date().getDate();
    const sql =`call liste_disponible_public('${req.body.session_navigateur}',${req.body.id_autorite})`
    // console.log(sql)
    
    rohiAudiencePool.getConnection(function(err, rohiAudienceDB){
        rohiAudienceDB.query(sql,function(err,result){
            if(err){
                return res.send({ err });
            }
            else{
                return res.json(result[0])    
            }
            rohiAudienceDB.release()
        })
    })
})

// delete audiences
router.post('/public/delete',async(req,res)=>{
    let sql = `DELETE FROM demande_audience_public where id = ${req.body.id} and session_navigateur = '${req.body.session_navigateur}'`
    
    rohiAudiencePool.getConnection(function(error, rohiAudienceDB){
        rohiAudienceDB.query(sql, (error,result) => {
            if(error) res.send(error)
            res.json(result)
            rohiAudienceDB.release()
        })
    })
})

router.post('/public/add',async(req,res)=>{
    const sql = `CALL add_audience_public_V2('${req.body.session_navigateur}','${req.body.nom}','${req.body.prenom}','${req.body.cin}','${req.body.numero_telephone}','${req.body.email}','${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}','${req.body.motif}',${req.body.id_autorite_enfant})`
    rohiAudiencePool.getConnection(function(error, rohiAudienceDB){
        rohiAudienceDB.query(sql, (error,result) => {
            if(error){
                res.send(error)
            } 
            else if(result.length > 0 ){
                res.json(result[0][0])
            }else{
                res.json(result)
            }  
            rohiAudienceDB.release()
        })
    })

})

router.post('/public/ajouter',async(req,res)=>{
    const nomFormated = req.body.nom.toUpperCase()
    const prenomFormated = Function.upSetFirstLetter(req.body.prenom)
    const sql = `CALL ajouter_audience_public('${req.body.session_navigateur}','${nomFormated}','${prenomFormated}','${req.body.cin}','${req.body.numero_telephone}','${req.body.email}',${req.body.id_date_heure_disponible_autorite},'${req.body.motif}','${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}')`
    // console.log(sql)

    rohiAudiencePool.getConnection(function(error,rohiAudienceDB){
        rohiAudienceDB.query(sql, async (error,result) => {
            if(error){
                res.send(error)
            } 
            else if(result.length > 0 ){
                // console.log(req.body)
                const envoyeur = {
                    nom: nomFormated,
                    prenom: prenomFormated,
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
                const mail = await notification_mailing.notification_audience_public(envoyeur,receiver)
                res.json(result[0][0])
            }   
            else{
                res.json(result[0])
            }
            rohiAudienceDB.release()
        })
    })
})

router.post('/public/supprimer/:id',async(req,res)=>{
    const sql = `call supprimer_audience_public (${req.params.id})`
    
    rohiAudiencePool.getConnection(function(error, rohiAudienceDB){
        rohiAudienceDB.query(sql, (error,result) => {
            if(error){
                res.send(error)
            } 
            else if(result.length > 0 ){
                res.json(result[0][0])
            }
            else{
                res.json(result[0])
            } 
            rohiAudienceDB.release()
        })
    })
})

router.post('/public/modifier',async(req,res)=>{
    const nomFormated = req.body.nom.toUpperCase()
    const prenomFormated = Function.upSetFirstLetter(req.body.prenom)
    const sql = `call modifier_audience_public ('${nomFormated }','${prenomFormated}','${req.body.cin }','${req.body.numero_telephone }','${req.body.email }','${req.body.motif}',${req.body.id_audience},${req.body.id_date_heure_disponible_autorite},${req.body.id_dm_aud_public_heure_dispo})`
    // console.log(sql)
    // console.log(req.body)    

    rohiAudiencePool.getConnection(function(error, rohiAudienceDB){
        rohiAudienceDB.query(sql,async (error,result) => {
            if(error){
                res.send(error)
            } 
            else if(result.length > 0 ){
                const envoyeur = {
                    nom: nomFormated,
                    prenom: prenomFormated,
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
                const mail = await notification_mailing.notification_audience_public(envoyeur,receiver)
                res.json(result[0][0])
            }else{
                res.json(result)
            }
            rohiAudienceDB.release()
        })
    })


})

router.post('/public/update',async(req,res)=>{
    const sql = `CALL update_audience_public ('${req.body.session_navigateur}','${req.body.nom }','${req.body.prenom }','${req.body.cin }','${req.body.numero_telephone }','${req.body.email }','${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}','${req.body.motif}',${req.body.id_autorite_enfant},${req.body.id})`
    
    rohiAudiencePool.getConnection(function(error, rohiAudienceDB){
        rohiAudienceDB.query(sql, (error,result) => {
            if(error){
                res.send(error)
            } 
            else if(result.length > 0 ){
                res.json(result[0][0])
            }else{
                res.json(result)
            }
            rohiAudienceDB.release()
        })
    })
})

// router.post('/public/valider',async(req,res)=>{
 
//     const autorite = req.body.autorite
//     const evenement = req.body.evenement

//     const sql = ` CALL valider_audience_public (${evenement.id_dm_aud_public_date_heure_dispo},${evenement.id}, '${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}',${autorite.id})`
    
    // const entretien_date_time = String(req.body.date_debut).concat('T',req.body.heure_debut)
    // const response = await mailing.audience_public_valide(autorite,evenement,entretien_date_time)
        
//     // res.json(response)
//     db.query(sql,req.body,async (error,result) => {
//         if(error) {
//             res.send(error)
//         }
//         // res.json(sql)
        // else{
        //     if(result ){
        //         res.json({message:'Audience revalidé et envoyé',data:{db:result,mail:response}})
        //     }
        //     else {
        //         res.json({message:'Audience non revalidé ',data:{db:result,mail:response}})
        //     }
        // }
//     })
// })

router.post('/public/valider',[authJwt.verifyToken],async(req,res)=>{

    const sql = ` CALL valider_audience_public (${req.body.id_dm_aud_public_date_heure_dispo},${req.body.id_audience}, '${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}',${req.body.id_autorite})`

    const entretien_date_time = String(req.body.date_debut).concat('T',req.body.heure_debut)

    rohiAudiencePool.getConnection(function(error, rohiAudienceDB){
        rohiAudienceDB.query(sql,req.body,async (error,result) => {
            if(error) {
                res.send(error)
            }
            else{
                const response = await mailing.audience_public_valide(req.body.autorite,req.body.envoyeur,entretien_date_time)
                if(result ){
                    res.json({message:'Audience validé et envoyé',data:{db:result,mail:response}})
                }
                else {
                    res.json({message:'Audience revalidé ',data:{db:result,mail:response}})
                }
            }
            rohiAudienceDB.release()
        })
    })
})

// router.post('/public/revalider',async(req,res)=>{


//     const autorite = req.body.autorite
//     const evenement = req.body.evenement

//     const entretien_date_time = String(req.body.date_debut).concat('T',req.body.heure_debut)
//     const response = await mailing.audience_public_revalide(autorite,evenement,entretien_date_time)
    
//     // const sql = `UPDATE ${db_name}.demande_audience_public SET ? where id = ${req.body.id}`
//     const sql = `CALL revalider_audience_public(${evenement.id_dm_aud_public_date_heure_dispo},${evenement.id}, '${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}',${autorite.id})`
//     db.query(sql,req.body,async (error,result) => {
//         if(error) {
//             res.send(error)
//         }
//         else{
//             if(response && result ){
//                 res.json({message:'Audience validé et envoyé',mail:response,data:result})
//             }
//             else {
//                 res.json({message:'Audience non validé '})
//             }
//         }
//     })
// })

router.post('/public/revalider',[authJwt.verifyToken],async(req,res)=>{
    
    const entretien_date_time = String(req.body.date_debut).concat('T',req.body.heure_debut)
    const response = await mailing.audience_public_revalide(req.body.autorite,req.body.envoyeur,entretien_date_time)

    const sql = `CALL revalider_audience_public(${req.body.id_dm_aud_public_date_heure_dispo},${req.body.id_audience}, '${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}',${req.body.id_autorite})`
    
    rohiAudiencePool.getConnection(function(error, rohiAudienceDB){
        rohiAudienceDB.query(sql,req.body,async (error,result) => {
            if(error) {
                res.send(error)
            }
            else{
                if(response && result ){
                    res.json({message:'Audience validé et envoyé',mail:response,data:result})
                }
                else {
                    res.json({message:'Audience non validé '})
                }
            }
        })
    })
})

// router.post('/public/reporter/now',async(req,res)=>{

//     const autorite = req.body.autorite
//     const evenement = req.body.evenement
//     // const sql = `UPDATE ${db_name}.demande_audience_public SET ? where id = ${req.body.id}`
//     const sql = `CALL reporter_audience_public_maintenant (${evenement.id_dm_aud_public_date_heure_dispo},${evenement.id}, '${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}',${autorite.id})`
    
//     // res.json(req.body)

//     const entretien_date_time = String(req.body.date_debut).concat('T',req.body.heure_debut)
//     const response = await mailing.audience_public_reporte(autorite,evenement,entretien_date_time)

//     db.query(sql,req.body,async (error,result) => {
//         if(error) {
//             res.send(error)
//         }
//         // res.json(sql)
//         else{
//             if(result ){
//                 res.json({message:'Audience reporté et envoyé',data:{db:result,mail:response}})
//             }
//             else {
//                 res.json({message:'Audience non validé ',data:{db:result,mail:response}})
//             }
//         }
//     })
// })

router.post('/public/reporter/now',[authJwt.verifyToken],async(req,res)=>{

    const entretien_date_time = String(req.body.date_debut).concat('T',req.body.heure_debut)
    const response = await mailing.audience_public_reporte(req.body.autorite,req.body.envoyeur,entretien_date_time)

    const sql = `CALL reporter_audience_public_maintenant (${req.body.id_dm_aud_public_date_heure_dispo},${req.body.id_audience}, '${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}',${req.body.id_autorite})`

    rohiAudiencePool.getConnection(function(error, rohiAudienceDB){
        rohiAudienceDB.query(sql,req.body,async (error,result) => {
            if(error) {
                res.send(error)
            }
            // res.json(sql)
            else{
                if(result ){
                    res.json({message:'Audience reporté et envoyé',data:{db:result,mail:response}})
                }
                else {
                    res.json({message:'Audience non validé ',data:{db:result,mail:response}})
                }
            }
            rohiAudienceDB.release()
        })
    })
})

router.post('/public/reporter/later',[authJwt.verifyToken],async(req,res)=>{

    const autorite = req.body.autorite
    const id_autorite = autorite.id_autorite
    // const evenement = req.body.evenement
    // console.log(req.body)
    // const sql = `CALL si_disponible_autorite('${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}',${req.body.id_autorite_enfant},'${req.body.motif}')`
    
    // const sql = `UPDATE ${db_name}.demande_audience_public SET action = 2 where id = ${req.body.id}`
    
    const sql = `CALL reporter_audience_public_plus_tard(${req.body.id_dm_aud_public_date_heure_dispo},${req.body.id_audience},'${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}', ${id_autorite})`
    // const sql = `CALL reporter_audience_public_plus_tard (${evenement.id_dm_aud_public_date_heure_dispo},${evenement.id}, '${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}',${autorite.id})`
    // console.log(sql)
    // res.json(sql)

    rohiAudiencePool.getConnection(function(error, rohiAudienceDB){
        rohiAudienceDB.query(sql, async (error,result) => {
            if(error) {
                res.send(error)
            }
            else{
                const entretien_date_time = String(req.body.date_debut).concat('T',req.body.heure_debut)
                const response = await mailing.audience_public_reporte_plus_tard(autorite,req.body.envoyeur,entretien_date_time)
                if(response && result ){
                    res.json({message:'Audience reporté et envoyé',mail:response,data:result})
                }
                else {
                    res.json({message:'Audience non reporté'})
                }
            }
            rohiAudienceDB.release()
        })   
    })


})

module.exports = router