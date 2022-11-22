const express = require('express')
const router = express.Router();
const db = require('../database')


router.post('/autorite/all/mois/', async(req,res) => {
    const sql = `CALL LISTE_AUTORITE_PAR_MOIS(${req.body.id_autorite},'${req.body.date_du_jour}')`
    // console.log(sql)
    db.query(sql,function(err, result) {
        if(err){
            return res.send({ err });
        }
        else{
            // res.send(sql);
            const array_result = []
            result[0].forEach(element => {
                if(element.type_audience == 'Autorite'){
                    const date_time_start = element.dd_aud_autorite.concat('T',element.td_aud_autorite)
                    const date_time_fin = element.df_aud_autorite.concat('T',element.tf_aud_autorite)
                    if(element.action_autorite == 1){
                        array_result.push({
                            id: element.id_aud_autorite,
                            sender:{
                              id: element.id_autorite_sender,
                              intitule: element.sender_intitule,
                              intitule_code: element.sender_intitule_code
                            },
                            title: element.motif,
                            start: date_time_start,
                            end: date_time_fin,
                            color:'#F10586',
                            color_status: '#da2020',
                            type_audience: element.type_audience,
                            action: element.action_autorite,
                            status_audience: element.status_audience,
                            editable: true  
                        })                       
                    }
                    else if(element.action_autorite == 0){
                        array_result.push({
                            id: element.id_aud_autorite,
                            sender:{
                              id: element.id_autorite_sender,
                              intitule: element.sender_intitule,
                              intitule_code: element.sender_intitule_code
                            },
                            title: element.motif,
                            start: date_time_start,
                            end: date_time_fin,
                            color:'#F10586',
                            color_status: '#09a009', 
                            type_audience: element.type_audience,
                            action: element.action_autorite,
                            status_audience: element.status_audience,
                            editable: true
                        })                        
                    }
                }
                else if (element.type_audience == 'Public'){
                    const date_time_start = element.dd_aud_public.concat('T',element.td_aud_public)
                    const date_time_fin = element.df_aud_public.concat('T',element.tf_aud_public)
                    if(element.action_public == 1){
                        array_result.push({
                            id: element.id_aud_public,
                            title: element.motif,
                            sender:{
                                nom_complet: element.nom_complet,
                                cin: element.cin,
                                numero_telephone: element.numero_telephone,
                                email: element.email
                            },
                            start: date_time_start,
                            end: date_time_fin,
                            color:'#331999',
                            color_status: '#da2020',
                            type_audience: element.type_audience,
                            action: element.action_public,
                            status_audience: element.status_audience,
                            editable: true  
                        })
                    }
                    else if(element.action_public == 0){
                        array_result.push({
                            id: element.id_aud_public,
                            title: element.motif,
                            sender:{
                                nom_complet: element.nom_complet,
                                cin: element.cin,
                                numero_telephone: element.numero_telephone,
                                email: element.email
                            },
                            start: date_time_start,
                            end: date_time_fin,
                            color:'#331999',
                            color_status: '#09a009',
                            type_audience: element.type_audience,
                            action: element.action_public,
                            status_audience: element.status_audience,
                            editable: true
                        })
                    }
                }
                else if (element.type_audience == 'Entretien'){
                    const date_time_start = element.date_debut_entretien.concat('T',element.time_debut_entretien)
                    const date_time_fin = element.date_fin_entretien.concat('T',element.time_fin_entretien)
                    array_result.push({
                        id: element.id_demande_entretien,
                        title: element.motif,
                        start: date_time_start,
                        end: date_time_fin,
                        color:'#4B187E',
                        type_audience: element.type_audience,
                        editable: true  
                    })
                }
                else if(element.type_audience == 'Pas disponible date'){
                    const date_time_start = element.dd_non_dispo_date.concat('T',element.td_non_dispo_date)
                    const date_time_fin = element.df_non_dispo_date.concat('T',element.tf_non_dispo_date)
                    array_result.push({
                        id: element.id_non_dispo_date,
                        title: 'Pas disponible',
                        start: date_time_start,
                        end: date_time_fin,
                        color:'#2B2B2B',
                        type_audience: element.type_audience,
                        editable: false
                    })
                }
                else if(element.type_audience == 'Jour ferie'){
                    const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
                    const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
                    array_result.push({
                      id: String(element.id),
                      title: element.motif,
                      start: date_ferie_debut,
                      end: date_ferie_fin,
                      color:'#EFEC27',
                      type_audience: element.type_audience,
                      editable: false
                    
                    })
                }
                else if(element.type_audience == 'Pas disponible jour'){
                    if(element.jour_non_dispo_jour == 'Sunday'){
                        array_result.push({
                            id: element.id_non_dispo_jour,
                            title: 'Pas disponible',
                            daysOfWeek: [ '0' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Monday'){
                        array_result.push({
                            id: element.id_non_dispo_jour,
                            title: 'Pas disponible',
                            daysOfWeek: [ '1' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Tuesday'){
                        array_result.push({
                            id: element.id_non_dispo_jour,
                            title: 'Pas disponible',
                            daysOfWeek: [ '2' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Wednesday'){
                        array_result.push({
                            id: element.id_non_dispo_jour,
                            title: 'Pas disponible',
                            daysOfWeek: [ '3' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Thursday'){
                        array_result.push({
                            id: element.id_non_dispo_jour,
                            title: 'Pas disponible',
                            daysOfWeek: [ '4' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Friday'){
                        array_result.push({
                            id: element.id_non_dispo_jour,
                            title: 'Pas disponible',
                            daysOfWeek: [ '5' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Saturday'){
                        array_result.push({
                            id: element.id_non_dispo_jour,
                            title: 'Pas disponible',
                            daysOfWeek: [ '6' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }                    
                }
                               
            });            
            return res.json(array_result);
        }
    })
})

router.post('/autorite/all/mois/v2', async(req,res) =>{
    const sql = `CALL LISTE_AUTORITE_PAR_MOIS_v2(${req.body.id_autorite},'${req.body.date_du_jour}')`
    // console.log(sql)
    db.query(sql,function(err, result) {
        if(err){
            return res.send({ err });
        }
        else{
            // res.send(sql);
            const array_result = []
            result[0].forEach(element => {
                if(element.type_audience == 'Autorite'){
                    const date_time_start = element.dd_aud_autorite.concat('T',element.td_aud_autorite)
                    const date_time_fin = element.df_aud_autorite.concat('T',element.tf_aud_autorite)
                    if(element.action_autorite == 1){
                        array_result.push({
                            id: element.id_aud_autorite,
                            sender:{
                              id: element.id_autorite_sender,
                              intitule: element.sender_intitule,
                              intitule_code: element.sender_intitule_code
                            },
                            title: element.motif,
                            start: date_time_start,
                            end: date_time_fin,
                            color:'#F10586',
                            type_audience: element.type_audience,
                            action: element.action_autorite,
                            editable: true  
                        })                       
                    }
                    else if(element.action_autorite == 0){
                        array_result.push({
                            id: element.id_aud_autorite,
                            sender:{
                              id: element.id_autorite_sender,
                              intitule: element.sender_intitule,
                              intitule_code: element.sender_intitule_code
                            },
                            title: element.motif,
                            start: date_time_start,
                            end: date_time_fin,
                            color:'#25AF1A',
                            type_audience: element.type_audience,
                            action: element.action_autorite,
                            editable: true
                        })                        
                    }
                }
                else if (element.type_audience == 'Public'){
                    const date_time_start = element.dd_aud_public.concat('T',element.td_aud_public)
                    const date_time_fin = element.df_aud_public.concat('T',element.tf_aud_public)
                    if(element.action_public == 1){
                        array_result.push({
                            id: element.id_aud_public,
                            title: element.motif,
                            start: date_time_start,
                            end: date_time_fin,
                            color:'#ff9f89',
                            type_audience: element.type_audience,
                            action: element.action_public,
                            editable: true  
                        })
                    }
                    else if(element.action_public == 0){
                        array_result.push({
                            id: element.id_aud_public,
                            title: element.motif,
                            start: date_time_start,
                            end: date_time_fin,
                            color:'#25AF1A',
                            type_audience: element.type_audience,
                            action: element.action_public,
                            editable: true
                        })
                    }
                }
                else if (element.type_audience == 'Entretien'){
                    const date_time_start = element.date_debut_entretien.concat('T',element.time_debut_entretien)
                    const date_time_fin = element.date_fin_entretien.concat('T',element.time_fin_entretien)
                    array_result.push({
                        id: element.id_demande_entretien,
                        title: element.motif,
                        start: date_time_start,
                        end: date_time_fin,
                        color:'#ff9f89',
                        type_audience: element.type_audience,
                        editable: true  
                    })
                }
                else if(element.type_audience == 'Pas disponible date'){
                    const date_time_start = element.dd_non_dispo_date.concat('T',element.td_non_dispo_date)
                    const date_time_fin = element.df_non_dispo_date.concat('T',element.tf_non_dispo_date)
                    array_result.push({
                        id: String(element.id),
                        title: element.status_audience,
                        start: date_time_start,
                        end: date_time_fin,
                        color:'#2B2B2B',
                        type_audience: element.type_audience,
                        editable: false
                    })
                }
                else if(element.type_audience == 'Jour ferie'){
                    const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
                    const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
                    array_result.push({
                      id: String(element.id),
                      title: element.motif,
                      start: date_ferie_debut,
                      end: date_ferie_fin,
                      color:'#EFEC27',
                      type_audience: element.type_audience,
                      editable: false
                    
                    })
                }
                else if(element.type_audience == 'Pas disponible jour'){
                    if(element.jour_non_dispo_jour == 'Sunday'){
                        array_result.push({
                            title: element.status_audience,
                            daysOfWeek: [ '0' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Monday'){
                        array_result.push({
                            title: element.status_audience,
                            daysOfWeek: [ '1' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Tuesday'){
                        array_result.push({
                            title: element.status_audience,
                            daysOfWeek: [ '2' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Wednesday'){
                        array_result.push({
                            title: element.status_audience,
                            daysOfWeek: [ '3' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Thursday'){
                        array_result.push({
                            title: element.status_audience,
                            daysOfWeek: [ '4' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Friday'){
                        array_result.push({
                            title: element.status_audience,
                            daysOfWeek: [ '5' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Saturday'){
                        array_result.push({
                            title: element.status_audience,
                            daysOfWeek: [ '6' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }                    
                }
                               
            });            
            return res.json(array_result);
        }
    })
})

router.post('/autorite/all/faire_audience', async(req,res) =>{
    const id_autorite_sender = req.body.id_autorite_sender
    const sql = `CALL LISTE_FAIRE_AUDIENCE_AUTORITE(${req.body.id_autorite_sender},${req.body.id_autorite_receiver},'${req.body.date_du_jour}')`
    // console.log(sql)
    db.query(sql,function(err, result) {
        if(err){
            return res.send({ err });
        }
        // return res.json(sql)
        else{
            // res.send(sql);
            const array_result = []
            result[0].forEach(element => {
                if(element.type_audience == 'Autorite'){
                    const date_time_start = element.dd_aud_autorite.concat('T',element.td_aud_autorite)
                    const date_time_fin = element.df_aud_autorite.concat('T',element.tf_aud_autorite)
                    if(element.action_autorite == 0){
                        if(element.id_autorite_sender == id_autorite_sender){
                            array_result.push({
                                id: element.id_aud_autorite,
                                sender:{
                                  id: element.id_autorite_sender,
                                  intitule: element.sender_intitule,
                                  intitule_code: element.sender_intitule_code
                                },
                                title: element.motif,
                                start: date_time_start,
                                end: date_time_fin,
                                color:'#25AF1A',
                                type_audience: element.type_audience,
                                action: element.action_autorite,
                                editable: true  
                            })                              
                        }else {
                            array_result.push({
                                id: element.id_aud_autorite,
                                title: element.motif,
                                start: date_time_start,
                                end: date_time_fin,
                                color:'#ff9f89',
                                type_audience: element.type_audience,
                                action: element.action_autorite,
                                editable: false
                            }) 
                        }
                    } 
                    else if(element.action_autorite == 1){
                        if(element.id_autorite_sender == id_autorite_sender){
                            array_result.push({
                                id: element.id_aud_autorite,
                                sender:{
                                  id: element.id_autorite_sender,
                                  intitule: element.sender_intitule,
                                  intitule_code: element.sender_intitule_code
                                },
                                title: element.motif,
                                start: date_time_start,
                                end: date_time_fin,
                                color:'#ff9f89',
                                type_audience: element.type_audience,
                                action: element.action_autorite,
                                editable: false  
                            })                              
                        }else {
                            array_result.push({
                                id: element.id_aud_autorite,
                                title: element.motif,
                                start: date_time_start,
                                end: date_time_fin,
                                color:'#ff9f89',
                                type_audience: element.type_audience,
                                action: element.action_autorite,
                                editable: false
                            }) 
                        }                        
                    }
                }
                else if (element.type_audience == 'Public'){
                    const date_time_start = element.dd_aud_public.concat('T',element.td_aud_public)
                    const date_time_fin = element.df_aud_public.concat('T',element.tf_aud_public)
                    array_result.push({
                        id: element.id_aud_public,
                        title: element.motif,
                        start: date_time_start,
                        end: date_time_fin,
                        color:'#ff9f89',
                        type_audience: element.type_audience,
                        action: element.action_public,
                        editable: false  
                    })
                }
                else if(element.type_audience == 'Pas disponible date'){
                    const date_time_start = element.dd_non_dispo_date.concat('T',element.td_non_dispo_date)
                    const date_time_fin = element.df_non_dispo_date.concat('T',element.tf_non_dispo_date)
                    array_result.push({
                        id: String(element.id),
                        title: element.status_audience,
                        start: date_time_start,
                        end: date_time_fin,
                        color:'#2B2B2B',
                        type_audience: element.type_audience,
                        editable: false
                    })
                }
                else if(element.type_audience == 'Jour ferie'){
                    const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
                    const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
                    array_result.push({
                      id: String(element.id),
                      title: element.motif,
                      start: date_ferie_debut,
                      end: date_ferie_fin,
                      color:'#EFEC27',
                      type_audience: element.type_audience,
                      editable: false
                    
                    })
                }
                else if(element.type_audience == 'Pas disponible jour'){
                    if(element.jour_non_dispo_jour == 'Sunday'){
                        array_result.push({
                            title: element.status_audience,
                            daysOfWeek: [ '0' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Monday'){
                        array_result.push({
                            title: element.status_audience,
                            daysOfWeek: [ '1' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Tuesday'){
                        array_result.push({
                            title: element.status_audience,
                            daysOfWeek: [ '2' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Wednesday'){
                        array_result.push({
                            title: element.status_audience,
                            daysOfWeek: [ '3' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Thursday'){
                        array_result.push({
                            title: element.status_audience,
                            daysOfWeek: [ '4' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Friday'){
                        array_result.push({
                            title: element.status_audience,
                            daysOfWeek: [ '5' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }
                      else if(element.jour_non_dispo_jour == 'Saturday'){
                        array_result.push({
                            title: element.status_audience,
                            daysOfWeek: [ '6' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: '#2B2B2B',
                            editable: false
                        
                        })
                      }                    
                }
                               
            });            
            return res.json(array_result);
        }
    })
})

router.post('/autorite/add',async(req,res)=>{
    // const sql = `CALL si_disponible_autorite('${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}',${req.body.id_autorite_enfant},'${req.body.motif}')`
    const sql = `CALL add_audience_autorite('${req.body.date_debut}','${req.body.date_fin}','${req.body.time_debut}','${req.body.time_fin}',${req.body.id_autorite_enfant_sender},'${req.body.id_autorite_enfant_receiver}','${req.body.motif}')`
    db.query(sql, (error,result) => {
        // res.json(sql)
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

// router.post('/autorite/update',async(req,res)=>{
//     const audience = {
//         date_debut: req.body.date_debut,
//         date_fin: req.body.date_fin, 
//         time_debut: req.body.time_debut,
//         time_fin: req.body.time_fin,
//         id_autorite_enfant_sender: req.body.id_autorite_enfant_sender,
//         id_autorite_enfant_receiver: req.body.id_autorite_enfant_receiver,
//         motif: req.body.motif,
//         id: req.body.id
//     }
//     // const sql = `INSERT INTO stage.demande_audience( date_time_debut, date_time_fin, id_demande_stage, motif, id_direction, type_audience ) VALUES ( '${req.body.date_time_debut}', '${req.body.date_time_fin}', ${req.body.id_demande_stage}, '${req.body.motif}', ${req.body.id_direction}, '${req.body.type_audience}' )`
//     db.query('UPDATE stage.demande_audience_autorite SET ? WHERE id = ' + req.body.id,audience, (error,result) => {
//         if(error) res.send(error)
//         res.json(result)
//     })
// })

router.post('/autorite/update',async(req,res)=>{
    const audience = {
        date_debut: req.body.date_debut,
        date_fin: req.body.date_fin, 
        time_debut: req.body.time_debut,
        time_fin: req.body.time_fin,
        id_autorite_enfant_sender: req.body.id_autorite_enfant_sender,
        id_autorite_enfant_receiver: req.body.id_autorite_enfant_receiver,
        motif: req.body.motif,
        id: req.body.id
    }
    // const sql = `INSERT INTO stage.demande_audience( date_time_debut, date_time_fin, id_demande_stage, motif, id_direction, type_audience ) VALUES ( '${req.body.date_time_debut}', '${req.body.date_time_fin}', ${req.body.id_demande_stage}, '${req.body.motif}', ${req.body.id_direction}, '${req.body.type_audience}' )`
    db.query(`CALL update_audience_autorite(${req.body.id} ,'${req.body.date_debut}','${req.body.date_fin}','${req.body.time_debut}','${req.body.time_fin}',${req.body.id_autorite_enfant_sender},${req.body.id_autorite_enfant_receiver},'${req.body.motif}') `, (error,result) => {
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

router.post('/autorite/delete',async(req,res)=>{
    db.query(`DELETE FROM stage.demande_audience_autorite WHERE id = ${req.body.id}`, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

router.post('/autorite/valider',async(req,res)=>{
    const audience = {
        date_debut: req.body.date_debut,
        date_fin: req.body.date_fin, 
        time_debut: req.body.time_debut,
        time_fin: req.body.time_fin,
        id_autorite_enfant_sender: req.body.id_autorite_enfant_sender,
        id_autorite_enfant_receiver: req.body.id_autorite_enfant_receiver,
        motif: req.body.motif,
        action: 1,
        id: req.body.id
    }
    // console.log(audience)
    // const sql = `CALL si_disponible_autorite('${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}',${req.body.id_autorite_enfant},'${req.body.motif}')`
    const sql = `UPDATE stage.demande_audience_autorite SET ? where id = ${req.body.id}`
    db.query(sql,audience, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

router.post('/autorite/reporter/now',async(req,res)=>{
    const audience = {
        date_debut: req.body.date_debut,
        date_fin: req.body.date_fin, 
        time_debut: req.body.time_debut,
        time_fin: req.body.time_fin,
        id_autorite_enfant_sender: req.body.id_autorite_enfant_sender,
        id_autorite_enfant_receiver: req.body.id_autorite_enfant_receiver,
        motif: req.body.motif,
        action: 1,
        id: req.body.id
    }
    // console.log(audience)
    // const sql = `CALL si_disponible_autorite('${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}',${req.body.id_autorite_enfant},'${req.body.motif}')`
    const sql = `UPDATE stage.demande_audience_autorite SET ? where id = ${req.body.id}`
    db.query(sql,audience, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

router.post('/autorite/reporter/later',async(req,res)=>{
    const audience = {
        date_debut: req.body.date_debut,
        date_fin: req.body.date_fin, 
        time_debut: req.body.time_debut,
        time_fin: req.body.time_fin,
        id_autorite_enfant_sender: req.body.id_autorite_enfant_sender,
        id_autorite_enfant_receiver: req.body.id_autorite_enfant_receiver,
        motif: req.body.motif,
        action: 2,
        id: req.body.id
    }
    console.log(audience)
    // const sql = `CALL si_disponible_autorite('${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}',${req.body.id_autorite_enfant},'${req.body.motif}')`
    const sql = `UPDATE stage.demande_audience_autorite SET ? where id = ${req.body.id}`
    db.query(sql,audience, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})


router.get('/valider/all/:id_autorite_enfant', async(req,res) =>{
    const sql = `SELECT 
    dap.id as id_aud_public,
    dap.date_event_debut as dd_aud_public,
    dap.date_event_fin as df_aud_public,
    dap.time_event_debut as td_aud_public,
    dap.time_event_fin as tf_aud_public,
    dap.action as action_public,
    dap.motif,
	'' id_autorite_sender,
    '' sender_intitule,
    '' sender_intitule_code,
    '' id_aud_autorite,
    '' dd_aud_autorite,             
    '' df_aud_autorite,
    '' td_aud_autorite,
    '' tf_aud_autorite,
    '' action_autorite,
    'Public' type_audience
FROM 
    stage.autorite_enfant AS ae
        INNER JOIN stage.demande_audience_public as dap on ae.id = dap.id_autorite_enfant
        WHERE dap.id_autorite_enfant = ${req.params.id_autorite_enfant} and dap.action = 1
UNION
SELECT 
    '' id_aud_public,
    '' dd_aud_public,
    '' df_aud_public,
    '' td_aud_public,
    '' tf_aud_public,
    '' action_public,
    daa.motif,
	aes.id as id_autorite_sender,
    aes.intitule as sender_intitule,
    aes.intitule_code as sender_intitule_code,
    daa.id as id_aud_autorite,
    daa.date_debut as dd_aud_autorite,             
    daa.date_fin as df_aud_autorite,
    daa.time_debut as td_aud_autorite,
    daa.time_fin as tf_aud_autorite,
    daa.action as action_autorite,
    'Autorite' type_audience
FROM 
    stage.demande_audience_autorite daa
		INNER JOIN stage.autorite_enfant aer on aer.id = daa.id_autorite_enfant_receiver
        INNER JOIN stage.autorite_enfant aes on aes.id = daa.id_autorite_enfant_sender
        where daa.id_autorite_enfant_receiver = ${req.params.id_autorite_enfant} and daa.action = 1`
    // console.log(sql)
    db.query(sql,function(err, result) {
        if(err){
            return res.send({ err });
        }else{
            const array_result = []
            result.forEach(element => {
                if(element.type_audience == 'Public'){
                    array_result.push({
                        id_audience : element.id_aud_public,
                        date_debut : element.dd_aud_public,
                        date_fin : element.df_aud_public,
                        time_debut : element.td_aud_public,
                        time_fin : element.tf_aud_public,
                        motif : element.motif,
                        type_audience : element.type_audience
                    })
                }else if (element.type_audience == 'Autorite'){
                    array_result.push({
                        id_audience : element.id_aud_autorite,
                        sender :{
                            id: element.id_autorite_sender,
                            intitule: element.sender_intitule,
                            intitule_code: element.sender_intitule_code
                        },
                        date_debut : element.dd_aud_autorite,
                        date_fin : element.df_aud_autorite,
                        time_debut : element.td_aud_autorite,
                        time_fin : element.tf_aud_autorite,
                        motif : element.motif,
                        type_audience : element.type_audience
                    })
                }               
            });
            // console.log(array_result)
            return res.json(array_result);
        }
    })
})

router.get('/reporter/all/:id_autorite_enfant', async(req,res) =>{
    const sql = `SELECT 
    dap.id as id_aud_public,
    dap.date_event_debut as dd_aud_public,
    dap.date_event_fin as df_aud_public,
    dap.time_event_debut as td_aud_public,
    dap.time_event_fin as tf_aud_public,
    dap.action as action_public,
    dap.motif,
	'' id_autorite_sender,
    '' sender_intitule,
    '' sender_intitule_code,
    '' id_aud_autorite,
    '' dd_aud_autorite,             
    '' df_aud_autorite,
    '' td_aud_autorite,
    '' tf_aud_autorite,
    '' action_autorite,
    'Public' type_audience
FROM 
    stage.autorite_enfant AS ae
        INNER JOIN stage.demande_audience_public as dap on ae.id = dap.id_autorite_enfant
        WHERE dap.id_autorite_enfant = ${req.params.id_autorite_enfant} and dap.action = 2
UNION
SELECT 
    '' id_aud_public,
    '' dd_aud_public,
    '' df_aud_public,
    '' td_aud_public,
    '' tf_aud_public,
    '' action_public,
    daa.motif,
	aes.id as id_autorite_sender,
    aes.intitule as sender_intitule,
    aes.intitule_code as sender_intitule_code,
    daa.id as id_aud_autorite,
    daa.date_debut as dd_aud_autorite,             
    daa.date_fin as df_aud_autorite,
    daa.time_debut as td_aud_autorite,
    daa.time_fin as tf_aud_autorite,
    daa.action as action_autorite,
    'Autorite' type_audience
FROM 
    stage.demande_audience_autorite daa
		INNER JOIN stage.autorite_enfant aer on aer.id = daa.id_autorite_enfant_receiver
        INNER JOIN stage.autorite_enfant aes on aes.id = daa.id_autorite_enfant_sender
        where daa.id_autorite_enfant_receiver = ${req.params.id_autorite_enfant} and daa.action = 2`
    // console.log(sql)
    db.query(sql,function(err, result) {
        if(err){
            return res.send({ err });
        }else{
            const array_result = []
            result.forEach(element => {
                if(element.type_audience == 'Public'){
                    array_result.push({
                        id_audience : element.id_aud_public,
                        date_debut : element.dd_aud_public,
                        date_fin : element.df_aud_public,
                        time_debut : element.td_aud_public,
                        time_fin : element.tf_aud_public,
                        motif : element.motif,
                        type_audience : element.type_audience
                    })
                }else if (element.type_audience == 'Autorite'){
                    array_result.push({
                        id_audience : element.id_aud_autorite,
                        sender :{
                            id: element.id_autorite_sender,
                            intitule: element.sender_intitule,
                            intitule_code: element.sender_intitule_code
                        },
                        date_debut : element.dd_aud_autorite,
                        date_fin : element.df_aud_autorite,
                        time_debut : element.td_aud_autorite,
                        time_fin : element.tf_aud_autorite,
                        motif : element.motif,
                        type_audience : element.type_audience
                    })
                }               
            });
            // console.log(array_result)
            return res.json(array_result);
        }
    })
})

// router.get('/autorite/notification/:id_autorite_enfant', async(req,res)=>{
//     const sql = `CALL notifications_audience(${req.params.id_autorite_enfant})`
//     db.query(sql,function(err, result) {
//         if(err){
//             return res.send({ err });
//         }
//         else{
//             return res.send(result[0])
//         }
//     })
// })

module.exports = router