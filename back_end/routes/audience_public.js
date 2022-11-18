const express = require('express')
const router = express.Router();
const db = require('../database')

// liste audiences
// router.get('/public/all/:id_audience_autorite', async(req,res) =>{
//     const sql = `SELECT 
//     ae.id,
//     ae.intitule,
//     ae.intitule_code,
//     dap.id as id_aud_public,
//     dap.date_event_debut as dd_aud_public,
//     dap.date_event_fin as df_aud_public,
//     dap.time_event_debut as td_aud_public,
//     dap.time_event_fin as tf_aud_public,
//     dap.action as action_public,
//     'Occupé' motif,
// 	'' id_autorite_sender,
//     '' sender_intitule,
//     '' sender_intitule_code,
//     '' id_aud_autorite,
//     '' dd_aud_autorite,             
//     '' df_aud_autorite,
//     '' td_aud_autorite,
//     '' tf_aud_autorite,
//     '' action_autorite,
//     '' dd_non_dispo_date,
//     '' df_non_dispo_date,
//     '' td_non_dispo_date,
//     '' tf_non_dispo_date,
//     '' jour_non_dispo_jour,
//     '' td_non_dispo_jour,
//     '' tf_non_dispo_jour,
//     '' date_ferie,
//     '' td_ferie,
//     '' tf_ferie,
//     'Public' type_audience
// FROM 
//     stage.autorite_enfant AS ae
//         INNER JOIN stage.demande_audience_public as dap on ae.id = dap.id_autorite_enfant
//         WHERE dap.id_autorite_enfant = ${req.params.id_audience_autorite} and dap.action != 2 
// UNION
// SELECT 
//     aer.id,
//     aer.intitule,
//     aer.intitule_code,
//     '' id_aud_public,
//     '' dd_aud_public,
//     '' df_aud_public,
//     '' td_aud_public,
//     '' tf_aud_public,
//     '' action_public,
//     'Occupé' motif,
// 	aes.id as id_autorite_sender,
//     aes.intitule as sender_intitule,
//     aes.intitule_code as sender_intitule_code,
//     daa.id as id_aud_autorite,
//     daa.date_debut as dd_aud_autorite,             
//     daa.date_fin as df_aud_autorite,
//     daa.time_debut as td_aud_autorite,
//     daa.time_fin as tf_aud_autorite,
//     daa.action as action_autorite,
//     '' dd_non_dispo_date,
//     '' df_non_dispo_date,
//     '' td_non_dispo_date,
//     '' tf_non_dispo_date,
//     '' jour_non_dispo_jour,
//     '' td_non_dispo_jour,
//     '' tf_non_dispo_jour,
//     '' date_ferie,
//     '' td_ferie,
//     '' tf_ferie,
//     'Autorite' type_audience
// FROM 
//     stage.demande_audience_autorite daa
// 		INNER JOIN stage.autorite_enfant aer on aer.id = daa.id_autorite_enfant_receiver
//         INNER JOIN stage.autorite_enfant aes on aes.id = daa.id_autorite_enfant_sender
//         where daa.id_autorite_enfant_receiver = ${req.params.id_audience_autorite} and daa.action != 2 
// UNION
// SELECT 
//     ae.id,
//     ae.intitule,
//     ae.intitule_code,
//     '' id_aud_public,
//     '' dd_aud_public,
//     '' df_aud_public,
//     '' td_aud_public,
//     '' tf_aud_public,
//     '' action_public,
//     'Pas disponible' motif,
//     '' id_autorite_sender,
//     '' sender_intitule,
//     '' sender_intitule_code,
//     '' id_aud_autorite,
//     '' dd_aud_autorite,             
//     '' df_aud_autorite,
//     '' td_aud_autorite,
//     '' tf_aud_autorite,
//     '' action_autorite,
//     ndad.date_non_dispo_debut as dd_non_dispo_date,
//     ndad.date_non_dispo_fin as df_non_dispo_date,
//     ndad.time_debut as td_non_dispo_date,
//     ndad.time_fin as tf_non_dispo_date,
//     '' jour_non_dispo_jour,
//     '' td_non_dispo_jour,
//     '' tf_non_dispo_jour,
//     '' date_ferie,
//     '' td_ferie,
//     '' tf_ferie,
//     'Pas disponible date' type_audience
// FROM 
//     stage.autorite_enfant AS ae
//         INNER JOIN stage.non_disponibilite_autorite_date as ndad on ae.id = ndad.id_autorite_enfant
//         where ndad.id_autorite_enfant = ${req.params.id_audience_autorite}
// UNION
// SELECT
//     '' id,
//     '' intitule,
//     '' intitule_code,
//     '' id_aud_public,
//     '' dd_aud_public,
//     '' df_aud_public,
//     '' td_aud_public,
//     '' tf_aud_public,
//     '' action_public,
//     jf.nom_evenement as motif,
//     '' id_autorite_sender,
//     '' sender_intitule,
//     '' sender_intitule_code,
//     '' id_aud_autorite,
//     '' dd_aud_autorite,             
//     '' df_aud_autorite,
//     '' td_aud_autorite,
//     '' tf_aud_autorite,
//     '' action_autorite,
//     '' dd_non_dispo_date,
//     '' df_non_dispo_date,
//     '' td_non_dispo_date,
//     '' tf_non_dispo_date,
//     '' jour_non_dispo_jour,
//     '' td_non_dispo_jour,
//     '' tf_non_dispo_jour,
//     CONCAT(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour) as date_ferie,
//     time_event_debut as td_ferie,
//     time_event_fin as tf_ferie,
//     'Jour ferie' type_audience
// FROM 
//     stage.jour_ferie as jf
// UNION
// SELECT 
//     ae.id,
//     ae.intitule,
//     ae.intitule_code,
//     '' id_aud_public,
//     '' dd_aud_public,
//     '' df_aud_public,
//     '' td_aud_public,
//     '' tf_aud_public,
//     '' action_public,
//     'Pas disponible' motif,
//     '' id_autorite_sender,
//     '' sender_intitule,
//     '' sender_intitule_code,
//     '' id_aud_autorite,
//     '' dd_aud_autorite,             
//     '' df_aud_autorite,
//     '' td_aud_autorite,
//     '' tf_aud_autorite,
//     '' action_autorite,
//     '' dd_non_dispo_date,
//     '' df_non_dispo_date,
//     '' td_non_dispo_date,
//     '' tf_non_dispo_date,
//     ndaj.jour as jour_non_dispo_jour,
//     ndaj.time_non_dispo_jour_debut as td_non_dispo_jour,
//     ndaj.time_non_dispo_jour_fin as tf_non_dispo_jour,
//     '' date_ferie,
//     '' td_ferie,
//     '' tf_ferie,
//     'Pas disponible jour' type_audience

// FROM 
//     stage.autorite_enfant as ae
//         INNER JOIN stage.non_disponibilite_autorite_jour as ndaj on ae.id = ndaj.id_autorite_enfant
//         where ndaj.id_autorite_enfant = ${req.params.id_audience_autorite}`
//     // console.log(sql)
//     db.query(sql,function(err, result) {
//         if(err){
//             return res.send({ err });
//         }else{
//             const result_array = [];
//             result.forEach(element => {
//                 if(element.type_audience == 'Public'){
//                     const date_time_start = String(element.dd_aud_public).concat('T',element.td_aud_public)
//                     const date_time_fin = String(element.df_aud_public).concat('T',element.tf_aud_public)
//                     result_array.push({
//                       id: String(element.id),
//                       title: element.motif,
//                       start: date_time_start,
//                       end: date_time_fin,
//                       color:'#ff9f89',
//                       type_audience: element.type_audience
//                     })
//                 }
//                 else if(element.type_audience =='Autorite'){
//                     const date_time_start = String(element.dd_aud_autorite).concat('T',element.td_aud_autorite)
//                     const date_time_fin = String(element.df_aud_autorite).concat('T',element.tf_aud_autorite)
//                     result_array.push({
//                         id: String(element.id),
//                         title: element.motif,
//                         start: date_time_start,
//                         end: date_time_fin,
//                         color:'#ff9f89',
//                         type_audience: element.type_audience
//                     })
//                 }
//                 else if(element.type_audience == 'Pas disponible date'){
//                     const date_time_start = String(element.dd_non_dispo_date).concat('T',element.td_non_dispo_date)
//                     const date_time_fin = String(element.df_non_dispo_date).concat('T',element.tf_non_dispo_date)
//                     result_array.push({
//                         id: String(element.id),
//                         title: element.motif,
//                         start: date_time_start,
//                         end: date_time_fin,
//                         color:'#2B2B2B',
//                         type_audience: element.type_audience
//                     })
//                 }
//                 else if(element.type_audience == 'Jour ferie'){
//                     const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
//                     const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
//                     result_array.push({
//                         id: String(element.id),
//                         title: element.motif,
//                         start: date_ferie_debut,
//                         end: date_ferie_fin,
//                         color:'#EFEC27',
//                         type_audience: element.type_audience
//                     })
//                 }
//                 else if(element.type_audience == 'Pas disponible jour'){
//                     const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
//                     const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
//                     if(element.jour_non_dispo_jour == 'Sunday'){
//                         result_array.push({
//                         title: element.motif,
//                         daysOfWeek: [ '0' ], // these recurrent events move separately
//                         startTime: element.td_non_dispo_jour,
//                         endTime: element.tf_non_dispo_jour,
//                         type_audience: element.type_audience,
//                         color: '#2B2B2B'
//                     })
//                 }
//                 else if(element.jour_non_dispo_jour == 'Monday'){
//                     result_array.push({
//                         title: element.motif,
//                         daysOfWeek: [ '1' ], // these recurrent events move separately
//                         startTime: element.td_non_dispo_jour,
//                         endTime: element.tf_non_dispo_jour,
//                         type_audience: element.type_audience,
//                         color: '#2B2B2B'
//                     })
//                 }
//                 else if(element.jour_non_dispo_jour == 'Tuesday'){
//                     result_array.push({
//                         title: element.motif,
//                         daysOfWeek: [ '2' ], // these recurrent events move separately
//                         startTime: element.td_non_dispo_jour,
//                         endTime: element.tf_non_dispo_jour,
//                         type_audience: element.type_audience,
//                         color: '#2B2B2B'
//                     })
//                 }
//                 else if(element.jour_non_dispo_jour == 'Wednesday'){
//                     result_array.push({
//                         title: element.motif,
//                         daysOfWeek: [ '3' ], // these recurrent events move separately
//                         startTime: element.td_non_dispo_jour,
//                         endTime: element.tf_non_dispo_jour,
//                         type_audience: element.type_audience,
//                         color: '#2B2B2B'
//                     })
//                 }
//                 else if(element.jour_non_dispo_jour == 'Thursday'){
//                     result_array.push({
//                         title: element.motif,
//                         daysOfWeek: [ '4' ], // these recurrent events move separately
//                         startTime: element.td_non_dispo_jour,
//                         endTime: element.tf_non_dispo_jour,
//                         type_audience: element.type_audience,
//                         color: '#2B2B2B'
//                     })
//                 }
//                 else if(element.jour_non_dispo_jour == 'Friday'){
//                     result_array.push({
//                         title: element.motif,
//                         daysOfWeek: [ '5' ], // these recurrent events move separately
//                         startTime: element.td_non_dispo_jour,
//                         endTime: element.tf_non_dispo_jour,
//                         type_audience: element.type_audience,
//                         color: '#2B2B2B'
//                     })
//                 }
//                 else if(element.jour_non_dispo_jour == 'Saturday'){
//                     result_array.push({
//                         title: element.motif,
//                         daysOfWeek: [ '6' ], // these recurrent events move separately
//                         startTime: element.td_non_dispo_jour,
//                         endTime: element.tf_non_dispo_jour,
//                         type_audience: element.type_audience,
//                         color: '#2B2B2B'
//                     })
//                 }
//                 }               
//             });
//             return res.json(result_array);
//         }
//     })
// })

// Liste audiences par jour
router.post('/public/all/jour', async(req,res) =>{
    // const date_du_jour = new Date().getFullYear()+'-'+new Date().getMonth()+'-'+new Date().getDate();
    const sql =`CALL LISTE_PUBLIC_PAR_JOUR(${req.body.id_autorite},'${req.body.date_du_jour}')`
    db.query(sql,function(err, result) {
        if(err){
            return res.send({ err });
        }else{
            // res.send(sql)
            const result_array = [];
            result[0].forEach(element => {
                if(element.type_audience == 'Public'){
                    const date_time_start = String(element.dd_aud_public).concat('T',element.td_aud_public)
                    const date_time_fin = String(element.df_aud_public).concat('T',element.tf_aud_public)
                    result_array.push({
                        id: String(element.id),
                        title: element.motif,
                        start: date_time_start,
                        end: date_time_fin,
                        color:'#ff9f89',
                        type_audience: element.type_audience
                    })
                }
                else if(element.type_audience =='Autorite'){
                    const date_time_start = String(element.dd_aud_autorite).concat('T',element.td_aud_autorite)
                    const date_time_fin = String(element.df_aud_autorite).concat('T',element.tf_aud_autorite)
                    result_array.push({
                        id: String(element.id),
                        title: element.motif,
                        start: date_time_start,
                        end: date_time_fin,
                        color:'#ff9f89',
                        type_audience: element.type_audience
                    })
                }
                else if(element.type_audience == 'Pas disponible date'){
                    const date_time_start = String(element.dd_non_dispo_date).concat('T',element.td_non_dispo_date)
                    const date_time_fin = String(element.df_non_dispo_date).concat('T',element.tf_non_dispo_date)
                    result_array.push({
                        id: String(element.id),
                        title: element.motif,
                        start: date_time_start,
                        end: date_time_fin,
                        color:'#2B2B2B',
                        type_audience: element.type_audience
                    })
                }
                else if(element.type_audience == 'Jour ferie'){
                    const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
                    const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
                    result_array.push({
                        id: String(element.id),
                        title: element.motif,
                        start: date_ferie_debut,
                        end: date_ferie_fin,
                        color:'#EFEC27',
                        type_audience: element.type_audience
                    })
                }
                else if(element.type_audience == 'Pas disponible jour'){
                    const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
                    const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
                    if(element.jour_non_dispo_jour == 'Sunday'){
                        result_array.push({
                        title: element.motif,
                        daysOfWeek: [ '0' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: '#2B2B2B'
                    })
                }
                else if(element.jour_non_dispo_jour == 'Monday'){
                    result_array.push({
                        title: element.motif,
                        daysOfWeek: [ '1' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: '#2B2B2B'
                    })
                }
                else if(element.jour_non_dispo_jour == 'Tuesday'){
                    result_array.push({
                        title: element.motif,
                        daysOfWeek: [ '2' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: '#2B2B2B'
                    })
                }
                else if(element.jour_non_dispo_jour == 'Wednesday'){
                    result_array.push({
                        title: element.motif,
                        daysOfWeek: [ '3' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: '#2B2B2B'
                    })
                }
                else if(element.jour_non_dispo_jour == 'Thursday'){
                    result_array.push({
                        title: element.motif,
                        daysOfWeek: [ '4' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: '#2B2B2B'
                    })
                }
                else if(element.jour_non_dispo_jour == 'Friday'){
                    result_array.push({
                        title: element.motif,
                        daysOfWeek: [ '5' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: '#2B2B2B'
                    })
                }
                else if(element.jour_non_dispo_jour == 'Saturday'){
                    result_array.push({
                        title: element.motif,
                        daysOfWeek: [ '6' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: '#2B2B2B'
                    })
                }
                }               
            });
            return res.json(result_array);
            // return res.json(result[0]);

        }
    })

})

router.post('/public/all/semaine', async(req,res) =>{
    const sql =`CALL LISTE_PUBLIC_PAR_SEMAINE(${req.body.id_autorite},'${req.body.date_actu}')`
    db.query(sql,function(err, result) {
        if(err){
            return res.send({ err });
        }else{
            const result_array = [];
            result[0].forEach(element => {
                if(element.type_audience == 'Public'){
                    const date_time_start = String(element.dd_aud_public).concat('T',element.td_aud_public)
                    const date_time_fin = String(element.df_aud_public).concat('T',element.tf_aud_public)
                    result_array.push({
                        id: String(element.id),
                        title: element.motif,
                        start: date_time_start,
                        end: date_time_fin,
                        color:'#ff9f89',
                        type_audience: element.type_audience
                    })
                }
                else if(element.type_audience =='Autorite'){
                    const date_time_start = String(element.dd_aud_autorite).concat('T',element.td_aud_autorite)
                    const date_time_fin = String(element.df_aud_autorite).concat('T',element.tf_aud_autorite)
                    result_array.push({
                        id: String(element.id),
                        title: element.motif,
                        start: date_time_start,
                        end: date_time_fin,
                        color:'#ff9f89',
                        type_audience: element.type_audience
                    })
                }
                else if(element.type_audience == 'Pas disponible date'){
                    const date_time_start = String(element.dd_non_dispo_date).concat('T',element.td_non_dispo_date)
                    const date_time_fin = String(element.df_non_dispo_date).concat('T',element.tf_non_dispo_date)
                    result_array.push({
                        id: String(element.id),
                        title: element.motif,
                        start: date_time_start,
                        end: date_time_fin,
                        color:'#2B2B2B',
                        type_audience: element.type_audience
                    })
                }
                else if(element.type_audience == 'Jour ferie'){
                    const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
                    const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
                    result_array.push({
                        id: String(element.id),
                        title: element.motif,
                        start: date_ferie_debut,
                        end: date_ferie_fin,
                        color:'#EFEC27',
                        type_audience: element.type_audience
                    })
                }
                else if(element.type_audience == 'Pas disponible jour'){
                    const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
                    const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
                    if(element.jour_non_dispo_jour == 'Sunday'){
                        result_array.push({
                        title: element.motif,
                        daysOfWeek: [ '0' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: '#2B2B2B'
                    })
                }
                else if(element.jour_non_dispo_jour == 'Monday'){
                    result_array.push({
                        title: element.motif,
                        daysOfWeek: [ '1' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: '#2B2B2B'
                    })
                }
                else if(element.jour_non_dispo_jour == 'Tuesday'){
                    result_array.push({
                        title: element.motif,
                        daysOfWeek: [ '2' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: '#2B2B2B'
                    })
                }
                else if(element.jour_non_dispo_jour == 'Wednesday'){
                    result_array.push({
                        title: element.motif,
                        daysOfWeek: [ '3' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: '#2B2B2B'
                    })
                }
                else if(element.jour_non_dispo_jour == 'Thursday'){
                    result_array.push({
                        title: element.motif,
                        daysOfWeek: [ '4' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: '#2B2B2B'
                    })
                }
                else if(element.jour_non_dispo_jour == 'Friday'){
                    result_array.push({
                        title: element.motif,
                        daysOfWeek: [ '5' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: '#2B2B2B'
                    })
                }
                else if(element.jour_non_dispo_jour == 'Saturday'){
                    result_array.push({
                        title: element.motif,
                        daysOfWeek: [ '6' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: '#2B2B2B'
                    })
                }
                }               
            });
            return res.json(result_array);
        }
    })
})

router.post('/public/all/mois', async(req,res) =>{
    // const date_du_jour = new Date().getFullYear()+'-'+new Date().getMonth()+'-'+new Date().getDate();
    const sql =`CALL LISTE_PUBLIC_PAR_MOIS_V3(${req.body.id_autorite},'${req.body.date_du_jour}','${req.body.session_navigateur}')`
    db.query(sql,function(err, result) {
        if(err){
            return res.send({ err });
        }else{
            // res.send(result[0])
            const result_array = [];
            result[0].forEach(element => {
                if(element.type_audience == 'Public'){
                    if(element.color_status == null && element.status_audience == null){
                        result_array.push({
                            id: element.id,
                            title: element.title,
                            start: element.start,
                            end: element.end,
                            color:element.color,
                            type_audience: element.type_audience,
                        }) 
                    }
                    else{
                        if(element.status_audience == 'Validé'){
                            result_array.push({
                                id: element.id,
                                title: element.title,
                                start: element.start,
                                end: element.end,
                                color:element.color,
                                type_audience: element.type_audience,
                                color_status: element.color_status,
                                status_audience: element.status_audience,
                                nom:element.nom,
                                prenom:element.prenom,
                                numero_telephone:element.numero_telephone,
                                email:element.email,
                                cin:element.cin,
                                session_navigateur: element.session_navigateur,
                                editable: false
                            })
                        }
                        else if(element.status_audience == 'Non validé'){
                            result_array.push({
                                id: element.id,
                                title: element.title,
                                start: element.start,
                                end: element.end,
                                color:element.color,
                                type_audience: element.type_audience,
                                color_status: element.color_status,
                                status_audience: element.status_audience,
                                nom:element.nom,
                                prenom:element.prenom,
                                numero_telephone:element.numero_telephone,
                                email:element.email,
                                cin:element.cin,
                                session_navigateur: element.session_navigateur,
                                editable: true
                            })
                        }
                    }
                }
                else if(element.type_audience =='Autorité'){
                    result_array.push({
                        id: element.id,
                        title: element.title,
                        start: element.start,
                        end: element.end,
                        color: element.color,
                        type_audience: element.type_audience
                    })
                }
                else if(element.type_audience =='Entretien'){
                    result_array.push({
                        id: element.id,
                        title: element.title,
                        start: element.start,
                        end: element.end,
                        color: element.color,
                        type_audience: element.type_audience
                    })
                }
                else if(element.type_audience == 'Pas disponible date'){
                    result_array.push({
                        id: element.id,
                        title: element.title,
                        start: element.start,
                        end: element.end,
                        color: element.color,
                        type_audience: element.type_audience
                    })
                }
                else if(element.type_audience == 'Jour ferie'){
                    result_array.push({
                        id: element.id,
                        title: element.title,
                        start: element.start,
                        end: element.end,
                        color: element.color,
                        type_audience: element.type_audience
                    })
                }
                else if(element.type_audience == 'Pas disponible jour'){
                    if(element.jour_non_dispo_jour == 'Sunday'){
                        result_array.push({
                            title: element.title,
                            daysOfWeek: [ '0' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: element.color
                        })
                }
                else if(element.jour_non_dispo_jour == 'Monday'){
                    result_array.push({
                        title: element.title,
                        daysOfWeek: [ '1' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: element.color
                    })
                }
                else if(element.jour_non_dispo_jour == 'Tuesday'){
                    result_array.push({
                        title: element.title,
                        daysOfWeek: [ '2' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: element.color
                    })
                }
                else if(element.jour_non_dispo_jour == 'Wednesday'){
                    result_array.push({
                        title: element.title,
                        daysOfWeek: [ '3' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: element.color
                    })
                }
                else if(element.jour_non_dispo_jour == 'Thursday'){
                    result_array.push({
                        title: element.title,
                        daysOfWeek: [ '4' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: element.color
                    })
                }
                else if(element.jour_non_dispo_jour == 'Friday'){
                    result_array.push({
                        title: element.title,
                        daysOfWeek: [ '5' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: element.color
                    })
                }
                else if(element.jour_non_dispo_jour == 'Saturday'){
                    result_array.push({
                        title: element.title,
                        daysOfWeek: [ '6' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: element.color
                    })
                }
                }               
            });
            return res.json(result_array);
        }
    })
})

// delete audiences
router.post('/public/delete',async(req,res)=>{
    let sql = `DELETE FROM stage.demande_audience_public where id = ${req.body.id} and session_navigateur = '${req.body.session_navigateur}'`
    db.query(sql, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

// router.post('/public/add',async(req,res)=>{
//     const sql = `CALL si_disponible_public('${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}','${req.body.motif}',${req.body.id_autorite_enfant})`
//         db.query(sql, (error,result) => {
//         if(error){
//             res.send(error)
//         } 
//         else if(result.length > 0 ){
//             res.json(result[0][0])
//         }else{
//             res.json(result)
//         }
        
//     })
// })

router.post('/public/add',async(req,res)=>{
    const sql = `CALL add_audience_public('${req.body.session_navigateur}','${req.body.nom}','${req.body.prenom}','${req.body.cin}','${req.body.numero_telephone}','${req.body.email}','${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}','${req.body.motif}',${req.body.id_autorite_enfant})`
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

router.post('/public/update',async(req,res)=>{
    // const audience = {
    //     date_event_debut: req.body.date_event_debut,
    //     date_event_fin: req.body.date_event_fin, 
    //     time_event_debut: req.body.time_event_debut,
    //     time_event_fin: req.body.time_event_fin,
    //     motif: req.body.motif,
    //     id: req.body.id,
    //     session_navigateur: req.session_navigateur
    // }
    // const sql = `INSERT INTO stage.demande_audience( date_time_debut, date_time_fin, id_demande_stage, motif, id_direction, type_audience ) VALUES ( '${req.body.date_time_debut}', '${req.body.date_time_fin}', ${req.body.id_demande_stage}, '${req.body.motif}', ${req.body.id_direction}, '${req.body.type_audience}' )`
    const sql = `CALL update_audience_public ('${req.body.session_navigateur}','${req.body.nom }','${req.body.prenom }','${req.body.cin }','${req.body.numero_telephone }','${req.body.email }','${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}','${req.body.motif}',${req.body.id_autorite_enfant},${req.body.id})`
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

router.post('/public/valider',async(req,res)=>{
    const audience = {
        date_event_debut: req.body.date_debut,
        date_event_fin: req.body.date_fin, 
        time_event_debut: req.body.time_debut,
        time_event_fin: req.body.time_fin,
        id_autorite_enfant: req.body.id_autorite_enfant,
        motif: req.body.motif,
        action: 1,
        id: req.body.id
    }
    const sql = `UPDATE stage.demande_audience_public SET ? where id = ${req.body.id}`
    db.query(sql,audience,(error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

router.post('/public/reporter/now',async(req,res)=>{
    const audience = {
        date_event_debut: req.body.date_debut,
        date_event_fin: req.body.date_fin, 
        time_event_debut: req.body.time_debut,
        time_event_fin: req.body.time_fin,
        id_autorite_enfant: req.body.id_autorite_enfant,
        motif: req.body.motif,
        action: 1,
        id: req.body.id
    }
    // console.log(audience)
    // const sql = `CALL si_disponible_autorite('${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}',${req.body.id_autorite_enfant},'${req.body.motif}')`
    const sql = `UPDATE stage.demande_audience_public SET ? where id = ${req.body.id}`
    db.query(sql,audience, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

router.post('/public/reporter/later',async(req,res)=>{
    const audience = {
        date_event_debut: req.body.date_debut,
        date_event_fin: req.body.date_fin, 
        time_event_debut: req.body.time_debut,
        time_event_fin: req.body.time_fin,
        id_autorite_enfant: req.body.id_autorite_enfant,
        motif: req.body.motif,
        action: 2,
        id: req.body.id
    }
    console.log(audience)
    // const sql = `CALL si_disponible_autorite('${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}',${req.body.id_autorite_enfant},'${req.body.motif}')`
    const sql = `UPDATE stage.demande_audience_public SET ? where id = ${req.body.id}`
    db.query(sql,audience, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

module.exports = router