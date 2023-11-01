const express = require('express')
const router = express.Router();

const rohiPool = require('../database').rohi
const rohiAudiencePool = require('../database').rohiAudience

// const db = require('../database').conn
// const db_name = require('../database').db_name
const mailing = require('../Controllers/MailingController')
const notification_mailing = require('../Controllers/NotificationController')

const moment =require('../func/date.config')

const { authJwt } = require('../middleware');

require('dotenv/config')


router.post('/autorite/faire_audience', [authJwt.verifyToken] ,async (req,res) =>{
    const sql = `CALL liste_disponible_autorite(${req.body.id_autorite_sender},${req.body.id_autorite})`
    // console.log(sql)


    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql,function(err,result){
            if(err){
                return res.send({ err });
            }
            else{
                return res.json(result[0])    
            }
            rohiAudienceDB.release()
        })
    }).catch((err) => {
        throw err
    });
})


// router.post('/autorite/all/mois/', async(req,res) => {
//     const sql = `CALL LISTE_AUTORITE_PAR_MOIS(${req.body.id_autorite},'${req.body.date_du_jour}')`
//     // console.log(sql)
//     db.query(sql,function(err, result) {
//         if(err){
//             return res.send({ err });
//         }
//         else{
//             // res.send(sql);
//             const array_result = []
//             result[0].forEach(element => {
//                 if(element.type_audience == 'Autorite'){
//                     const date_time_start = element.dd_aud_autorite.concat('T',element.td_aud_autorite)
//                     const date_time_fin = element.df_aud_autorite.concat('T',element.tf_aud_autorite)
//                     if(element.action_autorite == 1){
//                         array_result.push({
//                             id: element.id_aud_autorite,
//                             autorite:{
//                                 id: element.id,
//                                 intitule: element.intitule,
//                                 intitule_code: element.intitule_code,
//                                 addresse_electronique: element.addresse_electronique,
//                                 mot_de_passe_mailing: element.mot_de_passe_mailing,
//                                 porte: element.porte ,
//                             },
//                             sender:{
//                               id: element.id_autorite_sender,
//                               intitule: element.sender_intitule,
//                               intitule_code: element.sender_intitule_code,
//                               addresse_electronique: element.sender_addresse_electronique,
//                             },
//                             title: element.motif,
//                             start: date_time_start,
//                             end: date_time_fin,
//                             color:'#F10586',
//                             color_status: '#da2020',
//                             type_audience: element.type_audience,
//                             action: element.action_autorite,
//                             status_audience: element.status_audience,
//                             editable: true  
//                         })                       
//                     }
//                     else if(element.action_autorite == 0){
//                         array_result.push({
//                             id: element.id_aud_autorite,
//                             autorite:{
//                                 id: element.id,
//                                 intitule: element.intitule,
//                                 intitule_code: element.intitule_code,
//                                 addresse_electronique: element.addresse_electronique,
//                                 mot_de_passe_mailing: element.mot_de_passe_mailing,
//                                 porte: element.porte ,
//                             },
//                             sender:{
//                               id: element.id_autorite_sender,
//                               intitule: element.sender_intitule,
//                               intitule_code: element.sender_intitule_code,
//                               addresse_electronique: element.sender_addresse_electronique
//                             },
//                             title: element.motif,
//                             start: date_time_start,
//                             end: date_time_fin,
//                             color:'#F10586',
//                             color_status: '#09a009', 
//                             type_audience: element.type_audience,
//                             action: element.action_autorite,
//                             status_audience: element.status_audience,
//                             editable: true
//                         })                        
//                     }
//                 }
//                 else if (element.type_audience == 'Public'){
//                     const date_time_start = element.dd_aud_public.concat('T',element.td_aud_public)
//                     const date_time_fin = element.df_aud_public.concat('T',element.tf_aud_public)
//                     if(element.action_public == 1){
//                         array_result.push({
//                             id: element.id_aud_public,
//                             title: element.motif,
//                             autorite:{
//                                 id: element.id,
//                                 intitule: element.intitule,
//                                 intitule_code: element.intitule_code,
//                                 addresse_electronique: element.addresse_electronique,
//                                 mot_de_passe_mailing: element.mot_de_passe_mailing,
//                                 porte: element.porte ,
//                             },
//                             sender:{
//                                 nom: element.nom,
//                                 prenom: element.prenom,
//                                 cin: element.cin,
//                                 numero_telephone: element.numero_telephone,
//                                 email: element.email
//                             },
//                             start: date_time_start,
//                             end: date_time_fin,
//                             color:'#331999',
//                             color_status: '#da2020',
//                             type_audience: element.type_audience,
//                             action: element.action_public,
//                             status_audience: element.status_audience,
//                             editable: true  
//                         })
//                     }
//                     else if(element.action_public == 0){
//                         array_result.push({
//                             id: element.id_aud_public,
//                             title: element.motif,
//                             autorite:{
//                                 id: element.id,
//                                 intitule: element.intitule,
//                                 intitule_code: element.intitule_code,
//                                 addresse_electronique: element.addresse_electronique,
//                                 mot_de_passe_mailing: element.mot_de_passe_mailing,
//                                 porte: element.porte ,
//                             },
//                             sender:{
//                                 nom: element.nom,
//                                 prenom: element.prenom,
//                                 cin: element.cin,
//                                 numero_telephone: element.numero_telephone,
//                                 email: element.email
//                             },
//                             start: date_time_start,
//                             end: date_time_fin,
//                             color:'#331999',
//                             color_status: '#09a009',
//                             type_audience: element.type_audience,
//                             action: element.action_public,
//                             status_audience: element.status_audience,
//                             editable: true
//                         })
//                     }
//                 }
//                 else if (element.type_audience == 'Entretien'){
//                     const date_time_start = element.date_debut_entretien.concat('T',element.time_debut_entretien)
//                     const date_time_fin = element.date_fin_entretien.concat('T',element.time_fin_entretien)
//                     array_result.push({
//                         id: element.id_demande_entretien,
//                         title: element.motif,
//                         autorite:{
//                             id: element.id,
//                             intitule: element.intitule,
//                             intitule_code: element.intitule_code,
//                             addresse_electronique: element.addresse_electronique,
//                             mot_de_passe_mailing: element.mot_de_passe_mailing,
//                             porte: element.porte ,
//                         },
//                         stagiaire:{
//                             nom: element.nom,
//                             prenom: element.prenom,
//                             cin: element.cin,
//                             numero_telephone: element.numero_telephone,
//                             email: element.email
//                         },
//                         start: date_time_start,
//                         end: date_time_fin,
//                         color:'#4B187E',
//                         type_audience: element.type_audience,
//                         editable: true  
//                     })
//                 }
//                 else if(element.type_audience == 'Pas disponible date'){
//                     const date_time_start = element.dd_non_dispo_date.concat('T',element.td_non_dispo_date)
//                     const date_time_fin = element.df_non_dispo_date.concat('T',element.tf_non_dispo_date)
//                     array_result.push({
//                         id: element.id_non_dispo_date,
//                         title: 'Pas disponible',
//                         start: date_time_start,
//                         end: date_time_fin,
//                         color:'#2B2B2B',
//                         type_audience: element.type_audience,
//                         editable: false
//                     })
//                 }
//                 else if(element.type_audience == 'Jour ferie'){
//                     const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
//                     const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
//                     array_result.push({
//                       id: String(element.id),
//                       title: element.motif,
//                       start: date_ferie_debut,
//                       end: date_ferie_fin,
//                       color:'#EFEC27',
//                       type_audience: element.type_audience,
//                       editable: false
                    
//                     })
//                 }
//                 else if(element.type_audience == 'Pas disponible jour'){
//                     if(element.jour_non_dispo_jour == 'Sunday'){
//                         array_result.push({
//                             id: element.id_non_dispo_jour,
//                             title: 'Pas disponible',
//                             daysOfWeek: [ '0' ], // these recurrent events move separately
//                             startTime: element.td_non_dispo_jour,
//                             endTime: element.tf_non_dispo_jour,
//                             type_audience: element.type_audience,
//                             color: '#2B2B2B',
//                             editable: false
//                         })
//                       }
//                       else if(element.jour_non_dispo_jour == 'Monday'){
//                         array_result.push({
//                             id: element.id_non_dispo_jour,
//                             title: 'Pas disponible',
//                             daysOfWeek: [ '1' ], // these recurrent events move separately
//                             startTime: element.td_non_dispo_jour,
//                             endTime: element.tf_non_dispo_jour,
//                             type_audience: element.type_audience,
//                             color: '#2B2B2B',
//                             editable: false
                        
//                         })
//                       }
//                       else if(element.jour_non_dispo_jour == 'Tuesday'){
//                         array_result.push({
//                             id: element.id_non_dispo_jour,
//                             title: 'Pas disponible',
//                             daysOfWeek: [ '2' ], // these recurrent events move separately
//                             startTime: element.td_non_dispo_jour,
//                             endTime: element.tf_non_dispo_jour,
//                             type_audience: element.type_audience,
//                             color: '#2B2B2B',
//                             editable: false
                        
//                         })
//                       }
//                       else if(element.jour_non_dispo_jour == 'Wednesday'){
//                         array_result.push({
//                             id: element.id_non_dispo_jour,
//                             title: 'Pas disponible',
//                             daysOfWeek: [ '3' ], // these recurrent events move separately
//                             startTime: element.td_non_dispo_jour,
//                             endTime: element.tf_non_dispo_jour,
//                             type_audience: element.type_audience,
//                             color: '#2B2B2B',
//                             editable: false
                        
//                         })
//                       }
//                       else if(element.jour_non_dispo_jour == 'Thursday'){
//                         array_result.push({
//                             id: element.id_non_dispo_jour,
//                             title: 'Pas disponible',
//                             daysOfWeek: [ '4' ], // these recurrent events move separately
//                             startTime: element.td_non_dispo_jour,
//                             endTime: element.tf_non_dispo_jour,
//                             type_audience: element.type_audience,
//                             color: '#2B2B2B',
//                             editable: false
                        
//                         })
//                       }
//                       else if(element.jour_non_dispo_jour == 'Friday'){
//                         array_result.push({
//                             id: element.id_non_dispo_jour,
//                             title: 'Pas disponible',
//                             daysOfWeek: [ '5' ], // these recurrent events move separately
//                             startTime: element.td_non_dispo_jour,
//                             endTime: element.tf_non_dispo_jour,
//                             type_audience: element.type_audience,
//                             color: '#2B2B2B',
//                             editable: false
                        
//                         })
//                       }
//                       else if(element.jour_non_dispo_jour == 'Saturday'){
//                         array_result.push({
//                             id: element.id_non_dispo_jour,
//                             title: 'Pas disponible',
//                             daysOfWeek: [ '6' ], // these recurrent events move separately
//                             startTime: element.td_non_dispo_jour,
//                             endTime: element.tf_non_dispo_jour,
//                             type_audience: element.type_audience,
//                             color: '#2B2B2B',
//                             editable: false
                        
//                         })
//                       }                    
//                 }
                               
//             });            
//             return res.json(array_result);
//         }
//     })
// })

// router.post('/autorite/all/mois/v2', async(req,res) =>{
//     const sql = `CALL LISTE_AUTORITE_PAR_MOIS_v2(${req.body.id_autorite},'${req.body.date_du_jour}')`
//     // console.log(sql)
//     db.query(sql,function(err, result) {
//         if(err){
//             return res.send({ err });
//         }
//         else{
//             // res.send(sql);
//             const array_result = []
//             result[0].forEach(element => {
//                 if(element.type_audience == 'Autorite'){
//                     const date_time_start = element.dd_aud_autorite.concat('T',element.td_aud_autorite)
//                     const date_time_fin = element.df_aud_autorite.concat('T',element.tf_aud_autorite)
//                     if(element.action_autorite == 1){
//                         array_result.push({
//                             id: element.id_aud_autorite,
//                             sender:{
//                               id: element.id_autorite_sender,
//                               intitule: element.sender_intitule,
//                               intitule_code: element.sender_intitule_code
//                             },
//                             title: element.motif,
//                             start: date_time_start,
//                             end: date_time_fin,
//                             color:'#F10586',
//                             type_audience: element.type_audience,
//                             action: element.action_autorite,
//                             editable: true  
//                         })                       
//                     }
//                     else if(element.action_autorite == 0){
//                         array_result.push({
//                             id: element.id_aud_autorite,
//                             sender:{
//                               id: element.id_autorite_sender,
//                               intitule: element.sender_intitule,
//                               intitule_code: element.sender_intitule_code
//                             },
//                             title: element.motif,
//                             start: date_time_start,
//                             end: date_time_fin,
//                             color:'#25AF1A',
//                             type_audience: element.type_audience,
//                             action: element.action_autorite,
//                             editable: true
//                         })                        
//                     }
//                 }
//                 else if (element.type_audience == 'Public'){
//                     const date_time_start = element.dd_aud_public.concat('T',element.td_aud_public)
//                     const date_time_fin = element.df_aud_public.concat('T',element.tf_aud_public)
//                     if(element.action_public == 1){
//                         array_result.push({
//                             id: element.id_aud_public,
//                             title: element.motif,
//                             start: date_time_start,
//                             end: date_time_fin,
//                             color:'#ff9f89',
//                             type_audience: element.type_audience,
//                             action: element.action_public,
//                             editable: true  
//                         })
//                     }
//                     else if(element.action_public == 0){
//                         array_result.push({
//                             id: element.id_aud_public,
//                             title: element.motif,
//                             start: date_time_start,
//                             end: date_time_fin,
//                             color:'#25AF1A',
//                             type_audience: element.type_audience,
//                             action: element.action_public,
//                             editable: true
//                         })
//                     }
//                 }
//                 else if (element.type_audience == 'Entretien'){
//                     const date_time_start = element.date_debut_entretien.concat('T',element.time_debut_entretien)
//                     const date_time_fin = element.date_fin_entretien.concat('T',element.time_fin_entretien)
//                     array_result.push({
//                         id: element.id_demande_entretien,
//                         title: element.motif,
//                         start: date_time_start,
//                         end: date_time_fin,
//                         color:'#ff9f89',
//                         type_audience: element.type_audience,
//                         editable: true  
//                     })
//                 }
//                 else if(element.type_audience == 'Pas disponible date'){
//                     const date_time_start = element.dd_non_dispo_date.concat('T',element.td_non_dispo_date)
//                     const date_time_fin = element.df_non_dispo_date.concat('T',element.tf_non_dispo_date)
//                     array_result.push({
//                         id: String(element.id),
//                         title: element.status_audience,
//                         start: date_time_start,
//                         end: date_time_fin,
//                         color:'#2B2B2B',
//                         type_audience: element.type_audience,
//                         editable: false
//                     })
//                 }
//                 else if(element.type_audience == 'Jour ferie'){
//                     const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
//                     const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
//                     array_result.push({
//                       id: String(element.id),
//                       title: element.motif,
//                       start: date_ferie_debut,
//                       end: date_ferie_fin,
//                       color:'#EFEC27',
//                       type_audience: element.type_audience,
//                       editable: false
                    
//                     })
//                 }
//                 else if(element.type_audience == 'Pas disponible jour'){
//                     if(element.jour_non_dispo_jour == 'Sunday'){
//                         array_result.push({
//                             title: element.status_audience,
//                             daysOfWeek: [ '0' ], // these recurrent events move separately
//                             startTime: element.td_non_dispo_jour,
//                             endTime: element.tf_non_dispo_jour,
//                             type_audience: element.type_audience,
//                             color: '#2B2B2B',
//                             editable: false
//                         })
//                       }
//                       else if(element.jour_non_dispo_jour == 'Monday'){
//                         array_result.push({
//                             title: element.status_audience,
//                             daysOfWeek: [ '1' ], // these recurrent events move separately
//                             startTime: element.td_non_dispo_jour,
//                             endTime: element.tf_non_dispo_jour,
//                             type_audience: element.type_audience,
//                             color: '#2B2B2B',
//                             editable: false
                        
//                         })
//                       }
//                       else if(element.jour_non_dispo_jour == 'Tuesday'){
//                         array_result.push({
//                             title: element.status_audience,
//                             daysOfWeek: [ '2' ], // these recurrent events move separately
//                             startTime: element.td_non_dispo_jour,
//                             endTime: element.tf_non_dispo_jour,
//                             type_audience: element.type_audience,
//                             color: '#2B2B2B',
//                             editable: false
                        
//                         })
//                       }
//                       else if(element.jour_non_dispo_jour == 'Wednesday'){
//                         array_result.push({
//                             title: element.status_audience,
//                             daysOfWeek: [ '3' ], // these recurrent events move separately
//                             startTime: element.td_non_dispo_jour,
//                             endTime: element.tf_non_dispo_jour,
//                             type_audience: element.type_audience,
//                             color: '#2B2B2B',
//                             editable: false
                        
//                         })
//                       }
//                       else if(element.jour_non_dispo_jour == 'Thursday'){
//                         array_result.push({
//                             title: element.status_audience,
//                             daysOfWeek: [ '4' ], // these recurrent events move separately
//                             startTime: element.td_non_dispo_jour,
//                             endTime: element.tf_non_dispo_jour,
//                             type_audience: element.type_audience,
//                             color: '#2B2B2B',
//                             editable: false
                        
//                         })
//                       }
//                       else if(element.jour_non_dispo_jour == 'Friday'){
//                         array_result.push({
//                             title: element.status_audience,
//                             daysOfWeek: [ '5' ], // these recurrent events move separately
//                             startTime: element.td_non_dispo_jour,
//                             endTime: element.tf_non_dispo_jour,
//                             type_audience: element.type_audience,
//                             color: '#2B2B2B',
//                             editable: false
                        
//                         })
//                       }
//                       else if(element.jour_non_dispo_jour == 'Saturday'){
//                         array_result.push({
//                             title: element.status_audience,
//                             daysOfWeek: [ '6' ], // these recurrent events move separately
//                             startTime: element.td_non_dispo_jour,
//                             endTime: element.tf_non_dispo_jour,
//                             type_audience: element.type_audience,
//                             color: '#2B2B2B',
//                             editable: false
                        
//                         })
//                       }                    
//                 }
                               
//             });            
//             return res.json(array_result);
//         }
//     })
// })


router.post('/autorite/ajouter',[authJwt.verifyToken],async(req,res)=>{
    const date_debut_Formated = moment.formatDate(req.body.date_debut)
    const date_fin_Formated = moment.formatDate(req.body.date_fin)
    // const sql = `CALL si_disponible_autorite('${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}',${req.body.id_autorite_enfant},'${req.body.motif}')`
    // const sql = `CALL ajouter_audience_autorite (${req.body.id_autorite_sender},${req.body.id_autorite_receiver},${req.body.id_date_heure_disponible_autorite},'${req.body.motif}','${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}')`
    const sql = `CALL ajouter_audience_autorite (${req.body.id_autorite_sender},${req.body.id_autorite_receiver},${req.body.id_date_heure_disponible_autorite},'${req.body.motif}','${date_debut_Formated}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}','${req.body.email}','${req.body.numero_telephone}','${req.body.sigle}','${req.body.child_libelle}')`

    // res.json(sql)
    console.log(req.body)
    const subject = {
        motif: req.body.motif,
        date_debut: date_debut_Formated,
        date_fin: date_fin_Formated,
        heure_debut: req.body.heure_debut,
        heure_fin: req.body.heure_fin
    }

    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql, async (error,result) => {
        
            if(error){
                res.send(error)
            } 
            else if(result.length > 0 ){
                const mail = await notification_mailing.notification_audience_autorite(subject,req.body.autoriteSender,req.body.autoriteReceiver)
                res.json(result[0][0])
            }else{
                res.json(result)
            }
            rohiAudienceDB.release()
        })
    }).catch((err) => {
        throw err
    });
})

router.post('/autorite/modifier',[authJwt.verifyToken],async(req,res)=>{
    // console.log(req.body)
    const date_debut_Formated = moment.formatDate(req.body.date_debut)
    const date_fin_Formated = moment.formatDate(req.body.date_fin)

    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(`CALL modifier_audience_autorite (${req.body.id_date_heure_disponible_autorite} ,${req.body.id_dm_aud_autorite_date_heure_dispo},'${req.body.motif}','${req.body.email}','${req.body.numero_telephone}',${req.body.id_audience}) `, async (error,result) => {
            if(error){
                res.send(error)
            } 
            else if(result.length > 0 ){
                const subject = {
                    motif: req.body.motif,
                    date_debut:date_debut_Formated,
                    date_fin: date_fin_Formated,
                    heure_debut: req.body.heure_debut,
                    heure_fin: req.body.heure_fin
                }
                const mail = await notification_mailing.notification_audience_autorite(subject,req.body.autoriteSender,req.body.autoriteReceiver)
                res.json(result[0][0])
            }else{
                res.json(result)
            }
            rohiAudienceDB.release()
        })
    }).catch((err) => {
        throw err
    });

})

router.post('/autorite/supprimer',[authJwt.verifyToken],async(req,res)=>{
    // const sql = `
    //     DELETE FROM stage5.demande_audience_autorite where id = ${req.body.id};
    //     DELETE FROM stage5.dm_aud_autorite_date_heure_dispo WHERE id_dm_aud_autorite IS NULL;
    //     SELECT "Votre audience a bien été supprimée" as message;`

    const sql = `DELETE FROM ${process.env.DB_APP}.demande_audience_autorite where id = ${req.body.id};`
    
    // const sql1 = `CALL supprimer_audience_autorite (${req.body.id})`

    rohiAudiencePool.then( (rohiAudienceDB) => {
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
    }).catch((err) => {
        throw err
    });


})

// router.post('/autorite/valider',async(req,res)=>{

//     const autorite = req.body.autorite
//     const evenement = req.body.evenement    

//     const sql = ` CALL valider_audience_autorite (${evenement.id_dm_aud_aut_date_heure_dispo},${evenement.id_audience}, '${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}',${autorite.id})`
    
//     const entretien_date_time = String(date_debut_Formated).concat('T',req.body.heure_debut)

//     db.query(sql, req.body,async(error,result) => {
//         if(error) {
//             res.send(error)
//         }
//         else{
//             const response = await mailing.audience_autorite_valide(autorite,evenement,entretien_date_time)
//             if(response && result ){
//                 res.json({message:'Audience validé et envoyé',mail:response,data:result})
//             }
//             else {
//                 res.json({message:'Audience non validé '})
//             }
//         }
//     })
// })

router.post('/autorite/valider',[authJwt.verifyToken],async(req,res)=>{
    const date_debut_Formated = moment.formatDate(req.body.date_debut)
    const date_fin_Formated = moment.formatDate(req.body.date_fin)
    const autorite = req.body.autorite
    const envoyeur = req.body.envoyeur
    
    // console.log(req.body)

    const entretien_date_time = String(date_debut_Formated).concat('T',req.body.heure_debut)

    const sql = ` CALL valider_audience_autorite (${req.body.id_dm_aud_aut_date_heure_dispo},${req.body.id_audience}, '${date_debut_Formated}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}',${req.body.id_autorite})`
    

    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql, req.body,async(error,result) => {
            if(error) {
                res.send(error)
            }
            else{
                const response = await mailing.audience_autorite_valide(autorite,envoyeur,entretien_date_time)
                if(response && result ){
                    res.json({message:'Audience validé et envoyé',mail:response,data:result})
                }
                else {
                    res.json({message:'Audience non validé '})
                }
            }
            rohiAudienceDB.release()
        })  
    }).catch((err) => {
        throw err
    });
})

router.post('/autorite/revalider',[authJwt.verifyToken],async(req,res)=>{
    const date_debut_Formated = moment.formatDate(req.body.date_debut)
    const date_fin_Formated = moment.formatDate(req.body.date_fin)
    const autorite = req.body.autorite
    const envoyeur = req.body.envoyeur

    const entretien_date_time = String(date_debut_Formated).concat('T',req.body.heure_debut)
    const response = await mailing.audience_public_revalide(autorite,envoyeur,entretien_date_time)

    const sql = `CALL revalider_audience_autorite(${req.body.id_dm_aud_aut_date_heure_dispo},${req.body.id_audience}, '${date_debut_Formated}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}',${req.body.id_autorite})`
    

    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql, req.body,async(error,result) => {
            if(error) {
                res.send(error)
            }
            else{
                const entretien_date_time = String(date_debut_Formated).concat('T',req.body.heure_debut)
                const response = await mailing.audience_autorite_revalide(autorite,envoyeur,entretien_date_time)
                if(response && result ){
                    res.json({message:'Audience validé et envoyé',mail:response,data:result})
                }
                else {
                    res.json({message:'Audience non validé '})
                }
            }
            rohiAudienceDB.release()
        })
    }).catch((err) => {
        throw err
    });

})

// router.post('/autorite/reporter/now',async(req,res)=>{
//     const autorite = req.body.autorite
//     const evenement = req.body.evenement
//     // const sql = `UPDATE ${db_name}.demande_audience_public SET ? where id = ${req.body.id}`
//     const sql = `CALL reporter_audience_autorite_maintenant (${req.body.id_dm_aud_aut_date_heure_dispo},${req.body.id_audience}, '${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}',${req.body.id_autorite})`
//     // const audience = {
//     //     date_debut: req.body.date_debut,
//     //     date_fin: req.body.date_fin, 
//     //     time_debut: req.body.time_debut,
//     //     time_fin: req.body.time_fin,
//     //     id_autorite_enfant_sender: req.body.id_autorite_enfant_sender,
//     //     id_autorite_enfant_receiver: req.body.id_autorite_enfant_receiver,
//     //     motif: req.body.motif,
//     //     action: 1,
//     //     id: req.body.id
//     // }
//     // console.log(sql)
//     // const sql = `CALL si_disponible_autorite('${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}',${req.body.id_autorite_enfant},'${req.body.motif}')`
//     db.query(sql,req.body, async (error,result) => {
//         if(error) {
//             res.send(error)
//         }
//         else{
//             const entretien_date_time = String(date_debut_Formated).concat('T',req.body.heure_debut)
//             const response = await mailing.audience_autorite_reporte(autorite,evenement,entretien_date_time)
//             if(response && result ){
//                 res.json({message:'Audience reportée et envoyé',mail:response,data:result})
//             }
//             else {
//                 res.json({message:'Audience non reportée '})
//             }
//         }
//     })
// })

router.post('/autorite/reporter/now',[authJwt.verifyToken],async(req,res)=>{  
    const date_debut_Formated = moment.formatDate(req.body.date_debut)
    const date_fin_Formated = moment.formatDate(req.body.date_fin)
    const autorite = req.body.autorite
    const envoyeur = req.body.envoyeur
    const sql = `CALL reporter_audience_autorite_maintenant (${req.body.id_dm_aud_aut_date_heure_dispo},${req.body.id_audience}, '${date_debut_Formated}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}',${req.body.id_autorite})`
    
    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql,req.body, async (error,result) => {
            if(error) {
                res.send(error)
            }
            else{
                const entretien_date_time = String(date_debut_Formated).concat('T',req.body.heure_debut)
                const response = await mailing.audience_autorite_reporte(autorite,envoyeur,entretien_date_time)
                if(response && result ){
                    res.json({message:'Audience reportée et envoyé',mail:response,data:result})
                }
                else {
                    res.json({message:'Audience non reportée '})
                }
            }
        })
    }).catch((err) => {
       throw err 
    });
})

router.post('/autorite/reporter/click',[authJwt.verifyToken],async(req,res)=>{
    const date_debut_Formated = moment.formatDate(req.body.date_debut)
    const date_fin_Formated = moment.formatDate(req.body.date_fin)
    const autorite = req.body.autorite
    const envoyeur = req.body.envoyeur
    
    const sql = `CALL reporter_audience_autorite_plus_tard (${req.body.id_dm_aud_aut_date_heure_dispo},${req.body.id_audience}, '${date_debut_Formated}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}',${autorite.id})`
    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql, async(error,result) => {
            if(error) {
                res.send(error)
            }
            else{
                const response = await mailing.audience_autorite_reporte_plus_tard(autorite,envoyeur)
                if(response && result ){
                    res.json({message:'Audience reportée et envoyé',mail:response,data:result})
                }
                else {
                    res.json({message:'Audience non reportée '})
                }
            }
        })
   }).catch((err) => {
        throw err
   });
})

router.post('/autorite/reporter/later',[authJwt.verifyToken],async(req,res)=>{
    const date_debut_Formated = moment.formatDate(req.body.date_debut)
    const date_fin_Formated = moment.formatDate(req.body.date_fin)
    const autorite = req.body.autorite
    const evenement = req.body.evenement
    
    const sql = `CALL reporter_audience_autorite_plus_tard (${evenement.id_dm_aud_aut_date_heure_dispo},${evenement.id_audience}, '${date_debut_Formated}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}',${autorite.id})`
    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql, async(error,result) => {
            if(error) {
                res.send(error)
            }
            else{
                const autorite = req.body.autorite
                const sender =  evenement.autorite_sender
                const response = await mailing.audience_autorite_reporte_plus_tard(autorite,sender)
                if(response && result ){
                    res.json({message:'Audience reportée et envoyé',mail:response,data:result})
                }
                else {
                    res.json({message:'Audience non reportée '})
                }
            }
        })
    }).catch((err) => {
       throw err 
    });
})


// router.get('/autorite/valider/all/:id_autorite_enfant', async(req,res) =>{
//     const sql = `SELECT 
//     dap.id as id,
// 	dap.motif,
//     dap.date_event_debut as date_debut,
//     dap.date_event_fin as date_fin,
//     dap.time_event_debut as time_debut,
//     dap.time_event_fin as time_fin,
// 	CASE
//     	WHEN dap.action = 0 THEN 'Non validé'
// 		WHEN dap.action = 1 THEN 'Validé'
// 		WHEN dap.action = 2 THEN 'Reporté' 
// 	END as status_audience,
// 	'' id_autorite_sender,
//     '' sender_intitule,
//     '' sender_intitule_code,
// 	dap.email as addresse_electronique,
// 	dap.nom as nom,
// 	dap.prenom as prenom,
// 	dap.numero_telephone,
// 	dap.cin,
// 	ae.id as id_autorite,
// 	ae.intitule as intitule_autorite,
// 	ae.intitule_code as intitule_code_autorite,
// 	ae.addresse_electronique as addresse_electronique_autorite,
// 	ae.mot_de_passe_mailing,
// 	ae.porte as porte_autorite,
//     'Public' type_audience
//     FROM 
//         stage.autorite_enfant AS ae
//             INNER JOIN stage.demande_audience_public as dap on ae.id = dap.id_autorite_enfant
//             WHERE dap.id_autorite_enfant = ${req.params.id_autorite_enfant} and dap.action = 1
//     UNION
//     SELECT 
//         daa.id as id,
//         daa.motif as motif,
//         daa.date_debut as date_debut,             
//         daa.date_fin as date_fin,
//         daa.time_debut as time_debut,
//         daa.time_fin as time_fin,
//         CASE
//             WHEN daa.action = 0 THEN 'Non validé'
//             WHEN daa.action = 1 THEN 'Validé'
//             WHEN daa.action = 2 THEN 'Reporté' 
//         END as status_audience,
//         aes.id as id_autorite_sender,
//         aes.intitule as sender_intitule,
//         aes.intitule_code as sender_intitule_code,
//         aes.addresse_electronique,
//         '' nom,
//         '' prenom,
//         '' numero_telephone,
//         '' cin,
//         aer.id as id_autorite,
//         aer.intitule as intitule_autorite,
//         aer.intitule_code as intitule_code_autorite,
//         aer.addresse_electronique as addresse_electronique_autorite,
//         aer.mot_de_passe_mailing,
//         aer.porte as porte_autorite,
//         'Autorité' type_audience
//     FROM 
//         stage.demande_audience_autorite daa
//             INNER JOIN stage.autorite_enfant aer on aer.id = daa.id_autorite_enfant_receiver
//             INNER JOIN stage.autorite_enfant aes on aes.id = daa.id_autorite_enfant_sender
//             where daa.id_autorite_enfant_receiver = ${req.params.id_autorite_enfant} and daa.action = 1`
//     // console.log(sql)
//     db.query(sql,function(err, result) {
//         if(err){
//             return res.send({ err });
//         }else{
//             const array_result = []
//             result.forEach(element => {
//                 if(element.type_audience == 'Public'){
//                     array_result.push({
//                         id : element.id,
//                         motif : element.motif,
//                         date_debut : element.date_debut,
//                         date_fin : element.date_fin,
//                         time_debut : element.time_debut,
//                         time_fin : element.time_fin,
//                         autorite:{
//                             id: element.id_autorite,
//                             intitule: element.intitule_autorite,
//                             intitule_code: element.intitule_code_autorite,
//                             addresse_electronique: element.addresse_electronique_autorite,
//                             mot_de_passe_mailing: element.mot_de_passe_mailing,
//                             porte: element.porte_autorite,
//                         },
//                         sender:{
//                             nom: element.nom,
//                             prenom: element.prenom,
//                             cin: element.cin,
//                             numero_telephone: element.numero_telephone,
//                             email: element.addresse_electronique
//                         },
//                         status_audience: element.status_audience,
//                         type_audience : element.type_audience
//                     })
//                 }
//                 else if (element.type_audience == 'Autorité'){
//                     array_result.push({
//                         id : element.id,
//                         motif : element.motif,
//                         date_debut : element.date_debut,
//                         date_fin : element.date_fin,
//                         time_debut : element.time_debut,
//                         time_fin : element.time_fin,
//                         autorite:{
//                             id: element.id_autorite,
//                             intitule: element.intitule_autorite,
//                             intitule_code: element.intitule_code_autorite,
//                             addresse_electronique: element.addresse_electronique_autorite,
//                             mot_de_passe_mailing: element.mot_de_passe_mailing,
//                             porte: element.porte_autorite,
//                         },
//                         sender:{
//                             id: element.id_autorite_sender,
//                             intitule: element.sender_intitule,
//                             intitule_code: element.sender_intitule_code,
//                             addresse_electronique: element.addresse_electronique,
//                             porte: element.porte,
//                         },
//                         status_audience: element.status_audience,
//                         type_audience : element.type_audience
//                     })
//                 }               
//             });
//             // console.log(array_result)
//             return res.json(array_result);
//         }
//     })
// })

// router.get('/autorite/reporter/all/:id_autorite_enfant', async(req,res) =>{
//     const sql = `SELECT 
//     dap.id as id,
// 	dap.motif,
//     dap.date_event_debut as date_debut,
//     dap.date_event_fin as date_fin,
//     dap.time_event_debut as time_debut,
//     dap.time_event_fin as time_fin,
// 	CASE
//     	WHEN dap.action = 0 THEN 'Non validé'
// 		WHEN dap.action = 1 THEN 'Validé'
// 		WHEN dap.action = 2 THEN 'Reporté' 
// 	END as status_audience,
// 	'' id_autorite_sender,
//     '' sender_intitule,
//     '' sender_intitule_code,
// 	dap.email as addresse_electronique,
// 	dap.nom as nom,
// 	dap.prenom as prenom,
// 	dap.numero_telephone,
// 	dap.cin,
// 	ae.id as id_autorite,
// 	ae.intitule as intitule_autorite,
// 	ae.intitule_code as intitule_code_autorite,
// 	ae.addresse_electronique as addresse_electronique_autorite,
// 	ae.mot_de_passe_mailing,
// 	ae.porte as porte_autorite,
//     'Public' type_audience
//     FROM 
//         stage.autorite_enfant AS ae
//             INNER JOIN stage.demande_audience_public as dap on ae.id = dap.id_autorite_enfant
//             WHERE dap.id_autorite_enfant = ${req.params.id_autorite_enfant} and dap.action = 2
//     UNION
//     SELECT 
//         daa.id as id,
//         daa.motif as motif,
//         daa.date_debut as date_debut,             
//         daa.date_fin as date_fin,
//         daa.time_debut as time_debut,
//         daa.time_fin as time_fin,
//         CASE
//             WHEN daa.action = 0 THEN 'Non validé'
//             WHEN daa.action = 1 THEN 'Validé'
//             WHEN daa.action = 2 THEN 'Reporté' 
//         END as status_audience,
//         aes.id as id_autorite_sender,
//         aes.intitule as sender_intitule,
//         aes.intitule_code as sender_intitule_code,
//         aes.addresse_electronique,
//         '' nom,
//         '' prenom,
//         '' numero_telephone,
//         '' cin,
//         aer.id as id_autorite,
//         aer.intitule as intitule_autorite,
//         aer.intitule_code as intitule_code_autorite,
//         aer.addresse_electronique as addresse_electronique_autorite,
//         aer.mot_de_passe_mailing,
//         aer.porte as porte_autorite,
//         'Autorité' type_audience
//     FROM 
//         stage.demande_audience_autorite daa
//             INNER JOIN stage.autorite_enfant aer on aer.id = daa.id_autorite_enfant_receiver
//             INNER JOIN stage.autorite_enfant aes on aes.id = daa.id_autorite_enfant_sender
//             where daa.id_autorite_enfant_receiver = ${req.params.id_autorite_enfant} and daa.action = 2`
//     // console.log(sql)
//     db.query(sql,function(err, result) {
//         if(err){
//             return res.send({ err });
//         }else{
//             // return res.send(sql);
//             const array_result = []
//             result.forEach(element => {
//                 if(element.type_audience == 'Public'){
//                     array_result.push({
//                         id : element.id,
//                         motif : element.motif,
//                         date_debut : element.date_debut,
//                         date_fin : element.date_fin,
//                         time_debut : element.time_debut,
//                         time_fin : element.time_fin,
//                         autorite:{
//                             id: element.id_autorite,
//                             intitule: element.intitule_autorite,
//                             intitule_code: element.intitule_code_autorite,
//                             addresse_electronique: element.addresse_electronique_autorite,
//                             mot_de_passe_mailing: element.mot_de_passe_mailing,
//                             porte: element.porte_autorite,
//                         },
//                         sender:{
//                             nom: element.nom,
//                             prenom: element.prenom,
//                             cin: element.cin,
//                             numero_telephone: element.numero_telephone,
//                             addresse_electronique: element.addresse_electronique
//                         },
//                         status_audience: element.status_audience,
//                         type_audience : element.type_audience
//                     })
//                 }else if (element.type_audience == 'Autorité'){
//                     array_result.push({
//                         id : element.id,
//                         motif : element.motif,
//                         date_debut : element.date_debut,
//                         date_fin : element.date_fin,
//                         time_debut : element.time_debut,
//                         time_fin : element.time_fin,
//                         autorite:{
//                             id: element.id_autorite,
//                             intitule: element.intitule_autorite,
//                             intitule_code: element.intitule_code_autorite,
//                             addresse_electronique: element.addresse_electronique_autorite,
//                             mot_de_passe_mailing: element.mot_de_passe_mailing,
//                             porte: element.porte_autorite,
//                         },
//                         sender:{
//                             id: element.id_autorite_sender,
//                             intitule: element.sender_intitule,
//                             intitule_code: element.sender_intitule_code,
//                             addresse_electronique: element.addresse_electronique,
//                             porte: element.porte,
//                         },
//                         status_audience: element.status_audience,
//                         type_audience : element.type_audience
//                     })
//                 }               
//             });
//             // console.log(array_result)
//             return res.json(array_result);
//         }
//     })
// })



module.exports = router