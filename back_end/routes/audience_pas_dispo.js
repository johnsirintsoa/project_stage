const express = require('express')
const router = express.Router();
const db = require('../database').conn
const db_name = require('../database').db_name

/**
    * Disponibilite date Add procedure
    * Disponibilite date Add insert
    * Disponibilite date Update
 */
// Add non disponible autorite date
router.post('/non_disponible_autorite_date/add',async(req,res)=>{
    const sql = `CALL add_non_disponibilite_autorite_date('${req.body.date_debut}','${req.body.date_fin}','${req.body.time_debut}','${req.body.time_fin}',${req.body.id_autorite})`
    db.query(sql, (error,result) => {
        if(error){
            res.send(error)
        } 
        else if (result[0][0].message == 'Aucun évenement'){
            res.json(result[0][0])
        }
        else if(result[0].length>0){
            const array_result = []
            result[0].forEach(element => {
                if (element.type_evenement == 'Public'){
                    if(element.status_evenement == 'Validé'){
                        array_result.push({
                            id: element.id,
                            title: element.title,
                            sender:{
                                nom: element.nom,
                                prenom: element.prenom,
                                cin: element.cin,
                                numero_telephone: element.numero_telephone,
                                email: element.email
                            },
                            start: element.start,
                            end: element.end,
                            color:'#3788d8',
                            color_status:'#da2020',
                            type_evenement: element.type_evenement,
                            status_evenement: element.status_evenement,
                            editable: true  
                        })
                    }
                    else if(element.status_evenement == 'Non validé'){
                        array_result.push({
                            id: element.id,
                            title: element.title,
                            sender:{
                                nom: element.nom,
                                prenom: element.prenom,
                                cin: element.cin,
                                numero_telephone: element.numero_telephone,
                                email: element.email
                            },
                            start: element.start,
                            end: element.end,
                            color:'#ff9f89',
                            color_status:'#09a009',
                            type_evenement: element.type_evenement,
                            status_evenement: element.status_evenement,
                            editable: true  
                        })
                    }
                }
                else if(element.type_evenement == 'Autorité'){
                    if(element.status_evenement == 'Validé'){
                        array_result.push({
                            id: element.id,
                            sender:{
                              id: element.id_autorite_enfant_sender,
                              intitule: element.intitule,
                              intitule_code: element.intitule_code
                            },
                            title: element.title,
                            start: element.start,
                            end: element.end,
                            color:'#ff9f89',
                            color_status: '#09a009',
                            type_evenement: element.type_evenement,
                            status_evenement: element.status_evenement,
                            editable: true  
                        })                       
                    }
                    else if(element.status_evenement == 'Non validé'){
                        array_result.push({
                            id: element.id,
                            sender:{
                              id: element.id_autorite_enfant_sender,
                              intitule: element.intitule,
                              intitule_code: element.intitule_code
                            },
                            title: element.title,
                            start: element.start,
                            end: element.end,
                            color:'#ff9f89',
                            color_status: '#09a009',
                            type_evenement: element.type_evenement,
                            status_evenement: element.status_evenement,
                            editable: true  
                        })                        
                    }
                }
                else if(element.type_evenement == 'Entretien')
                {
                    if(element.status_evenement == 'Stage'){
                        array_result.push({
                            id: element.id,
                            sender:{
                                nom: element.nom,
                                prenom: element.prenom,
                                cin: element.cin,
                                numero_telephone: element.numero_telephone,
                                email: element.email
                            },
                            title: element.title,
                            start: element.start,
                            end: element.end,
                            color:'#4B187E',
                            color_status: '#4B187E',
                            type_evenement: element.type_evenement,
                            status_evenement: element.status_evenement,
                            editable: true  
                        })                       
                    }
                }
                else if(element.type_evenement == 'Jour férié')
                {
                    array_result.push({
                        id: element.id,
                        title: element.title,
                        start: element.start,
                        end: element.end,
                        color:'#ff9f89',
                        color_status: '#09a009',
                        type_evenement: element.type_evenement,
                        status_evenement: element.status_evenement,
                        editable: true  
                    })      
                }
                else if(element.type_evenement == 'Pas disponible jour'){
                    if(element.jour == 'Sunday'){
                        array_result.push({
                            id: element.id,
                            title: element.status_evenement,
                            daysOfWeek: [ '0' ], // these recurrent events move separately
                            startTime: element.time_non_dispo_jour_debut,
                            endTime: element.time_non_dispo_jour_fin,
                            status_evenement: element.status_evenement,
                            type_evenement: element.type_evenement,
                            color: '#2B2B2B',
                            color_status: '#678479',
                            editable: true
                        })
                    }
                    else if(element.jour == 'Monday'){
                    array_result.push({
                        id: element.id,
                        title: element.status_evenement,
                        daysOfWeek: [ '1' ], // these recurrent events move separately
                        startTime: element.time_non_dispo_jour_debut,
                        endTime: element.time_non_dispo_jour_fin,
                        status_evenement: element.status_evenement,
                        type_evenement: element.type_evenement,
                        color: '#2B2B2B',
                        color_status: '#678479',
                        editable: true
                    
                    })
                    }
                    else if(element.jour == 'Tuesday'){
                    array_result.push({
                        id: element.id,
                        title: element.status_evenement,
                        daysOfWeek: [ '2' ], // these recurrent events move separately
                        startTime: element.time_non_dispo_jour_debut,
                        endTime: element.time_non_dispo_jour_fin,
                        status_evenement: element.status_evenement,
                        type_evenement: element.type_evenement,
                        color: '#2B2B2B',
                        color_status: '#678479',
                        editable: true
                    
                    })
                    }
                    else if(element.jour == 'Wednesday'){
                    array_result.push({
                        id: element.id,
                        title: element.status_evenement,
                        daysOfWeek: [ '3' ], // these recurrent events move separately
                        startTime: element.time_non_dispo_jour_debut,
                        endTime: element.time_non_dispo_jour_fin,
                        status_evenement: element.status_evenement,
                        type_evenement: element.type_evenement,
                        color: '#2B2B2B',
                        color_status: '#678479',
                        editable: true
                    
                    })
                    }
                    else if(element.jour == 'Thursday'){
                    array_result.push({
                        id: element.id,
                        title: element.status_evenement,
                        daysOfWeek: [ '4' ], // these recurrent events move separately
                        startTime: element.time_non_dispo_jour_debut,
                        endTime: element.time_non_dispo_jour_fin,
                        status_evenement: element.status_evenement,
                        type_evenement: element.type_evenement,
                        color: '#2B2B2B',
                        color_status: '#678479',
                        editable: true
                    
                    })
                    }
                    else if(element.jour == 'Friday'){
                    array_result.push({
                        id: element.id,
                        title: element.status_evenement,
                        daysOfWeek: [ '5' ], // these recurrent events move separately
                        startTime: element.time_non_dispo_jour_debut,
                        endTime: element.time_non_dispo_jour_fin,
                        status_evenement: element.status_evenement,
                        type_evenement: element.type_evenement,
                        color: '#2B2B2B',
                        color_status: '#678479',
                        editable: true
                    
                    })
                    }
                    else if(element.jour == 'Saturday'){
                    array_result.push({
                        id: element.id,
                        title: element.status_evenement,
                        daysOfWeek: [ '6' ], // these recurrent events move separately
                        startTime: element.time_non_dispo_jour_debut,
                        endTime: element.time_non_dispo_jour_fin,
                        status_evenement: element.status_evenement,
                        type_evenement: element.type_evenement,
                        color: '#2B2B2B',
                        color_status: '#678479',
                        editable: true
                    
                    })
                    }         
                }
                else if(element.type_evenement == 'Pas disponible date'){
                    array_result.push({
                        id: element.id,
                        title: element.status_evenement,
                        start: element.start,
                        end: element.end,
                        color:'#2B2B2B',
                        color_status: '#434242',
                        status_evenement: element.status_evenement,
                        type_evenement: element.type_evenement,
                        editable: true
                    })
                }
            });
            res.json(array_result)
        }
    })
})

// insert non_disponibilite_autorite_date
router.post('/non_disponible_autorite_date/insert/add',async(req,res)=>{
    const sql = 
    `INSERT INTO stage.non_disponibilite_autorite_date( date_non_dispo_debut, date_non_dispo_fin, time_debut, time_fin, id_autorite_enfant) VALUES ('${req.body.date_debut}','${req.body.date_fin}','${req.body.time_debut}','${req.body.time_fin}',${req.body.id_autorite})`
    db.query(sql, (error,result) => {
        if(error){
            res.send(error)
        } 
        else {
            res.json(result[0])
        }
    })
})

// update non_disponibilite_autorite_date
router.post('/non_disponible_autorite_date/update',async(req,res)=>{
    const audience = {
        date_non_dispo_debut : req.body.date_debut,
        date_non_dispo_fin : req.body.date_fin,
        time_debut: req.body.time_debut,
        time_fin: req.body.time_fin,
        id_autorite_enfant: req.body.id_autorite
    } 
    const sql = `UPDATE stage.non_disponibilite_autorite_date SET ? where id = ${req.body.id}`
    db.query(sql,audience, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

/**
    * Disponibilite jour Add procedure
    * Disponibilite jour Add insert
    * Disponibilite jour Update
 */
// Add non disponible autorite jour
router.post('/non_disponible_autorite_jour/add',async(req,res)=>{
    const sql = `CALL add_non_disponibilite_autorite_jour('${req.body.jour_date}','${req.body.time_non_dispo_jour_debut}','${req.body.time_non_dispo_jour_fin}',${req.body.id_autorite})`
    db.query(sql, (error,result) => {
        if(error){
            res.send(error)
        } 
        else if (result[0][0].message == 'Aucun évenement'){
            res.json(result[0][0])
        }
        else if(result[0].length>0){
            const array_result = []
            result[0].forEach(element => {
                if (element.type_evenement == 'Public'){
                    if(element.status_evenement == 'Validé'){
                        array_result.push({
                            id: element.id,
                            title: element.title,
                            sender:{
                                nom: element.nom,
                                prenom: element.prenom,
                                cin: element.cin,
                                numero_telephone: element.numero_telephone,
                                email: element.email
                            },
                            start: element.start,
                            end: element.end,
                            color:'#3788d8',
                            color_status:'#da2020',
                            type_evenement: element.type_evenement,
                            status_evenement: element.status_evenement,
                            editable: true  
                        })
                    }
                    else if(element.status_evenement == 'Non validé'){
                        array_result.push({
                            id: element.id,
                            title: element.title,
                            sender:{
                                nom: element.nom,
                                prenom: element.prenom,
                                cin: element.cin,
                                numero_telephone: element.numero_telephone,
                                email: element.email
                            },
                            start: element.start,
                            end: element.end,
                            color:'#ff9f89',
                            color_status:'#09a009',
                            type_evenement: element.type_evenement,
                            status_evenement: element.status_evenement,
                            editable: true  
                        })
                    }
                }
                else if(element.type_evenement == 'Autorité'){
                    if(element.status_evenement == 'Validé'){
                        array_result.push({
                            id: element.id,
                            sender:{
                              id: element.id_autorite_enfant_sender,
                              intitule: element.intitule,
                              intitule_code: element.intitule_code
                            },
                            title: element.title,
                            start: element.start,
                            end: element.end,
                            color:'#ff9f89',
                            color_status: '#09a009',
                            type_evenement: element.type_evenement,
                            status_evenement: element.status_evenement,
                            editable: true  
                        })                       
                    }
                    else if(element.status_evenement == 'Non validé'){
                        array_result.push({
                            id: element.id,
                            sender:{
                              id: element.id_autorite_enfant_sender,
                              intitule: element.intitule,
                              intitule_code: element.intitule_code
                            },
                            title: element.title,
                            start: element.start,
                            end: element.end,
                            color:'#ff9f89',
                            color_status: '#09a009',
                            type_evenement: element.type_evenement,
                            status_evenement: element.status_evenement,
                            editable: true  
                        })                        
                    }
                }
                else if(element.type_evenement == 'Entretien')
                {
                    if(element.status_evenement == 'Stage'){
                        array_result.push({
                            id: element.id,
                            sender:{
                                nom: element.nom,
                                prenom: element.prenom,
                                cin: element.cin,
                                numero_telephone: element.numero_telephone,
                                email: element.email
                            },
                            title: element.title,
                            start: element.start,
                            end: element.end,
                            color:'#4B187E',
                            color_status: '#4B187E',
                            type_evenement: element.type_evenement,
                            status_evenement: element.status_evenement,
                            editable: true  
                        })                       
                    }
                }
                else if(element.type_evenement == 'Jour férié')
                {
                    array_result.push({
                        id: element.id,
                        title: element.title,
                        start: element.start,
                        end: element.end,
                        color:'#ff9f89',
                        color_status: '#09a009',
                        type_evenement: element.type_evenement,
                        status_evenement: element.status_evenement,
                        editable: true  
                    })      
                }
                else if(element.type_evenement == 'Pas disponible jour'){
                    if(element.jour == 'Sunday'){
                        array_result.push({
                            id: element.id,
                            title: element.status_evenement,
                            daysOfWeek: [ '0' ], // these recurrent events move separately
                            startTime: element.time_non_dispo_jour_debut,
                            endTime: element.time_non_dispo_jour_fin,
                            status_evenement: element.status_evenement,
                            type_evenement: element.type_evenement,
                            color: '#2B2B2B',
                            color_status: '#678479',
                            editable: true
                        })
                    }
                    else if(element.jour == 'Monday'){
                    array_result.push({
                        id: element.id,
                        title: element.status_evenement,
                        daysOfWeek: [ '1' ], // these recurrent events move separately
                        startTime: element.time_non_dispo_jour_debut,
                        endTime: element.time_non_dispo_jour_fin,
                        status_evenement: element.status_evenement,
                        type_evenement: element.type_evenement,
                        color: '#2B2B2B',
                        color_status: '#678479',
                        editable: true
                    
                    })
                    }
                    else if(element.jour == 'Tuesday'){
                    array_result.push({
                        id: element.id,
                        title: element.status_evenement,
                        daysOfWeek: [ '2' ], // these recurrent events move separately
                        startTime: element.time_non_dispo_jour_debut,
                        endTime: element.time_non_dispo_jour_fin,
                        status_evenement: element.status_evenement,
                        type_evenement: element.type_evenement,
                        color: '#2B2B2B',
                        color_status: '#678479',
                        editable: true
                    
                    })
                    }
                    else if(element.jour == 'Wednesday'){
                    array_result.push({
                        id: element.id,
                        title: element.status_evenement,
                        daysOfWeek: [ '3' ], // these recurrent events move separately
                        startTime: element.time_non_dispo_jour_debut,
                        endTime: element.time_non_dispo_jour_fin,
                        status_evenement: element.status_evenement,
                        type_evenement: element.type_evenement,
                        color: '#2B2B2B',
                        color_status: '#678479',
                        editable: true
                    
                    })
                    }
                    else if(element.jour == 'Thursday'){
                    array_result.push({
                        id: element.id,
                        title: element.status_evenement,
                        daysOfWeek: [ '4' ], // these recurrent events move separately
                        startTime: element.time_non_dispo_jour_debut,
                        endTime: element.time_non_dispo_jour_fin,
                        status_evenement: element.status_evenement,
                        type_evenement: element.type_evenement,
                        color: '#2B2B2B',
                        color_status: '#678479',
                        editable: true
                    
                    })
                    }
                    else if(element.jour == 'Friday'){
                    array_result.push({
                        id: element.id,
                        title: element.status_evenement,
                        daysOfWeek: [ '5' ], // these recurrent events move separately
                        startTime: element.time_non_dispo_jour_debut,
                        endTime: element.time_non_dispo_jour_fin,
                        status_evenement: element.status_evenement,
                        type_evenement: element.type_evenement,
                        color: '#2B2B2B',
                        color_status: '#678479',
                        editable: true
                    
                    })
                    }
                    else if(element.jour == 'Saturday'){
                    array_result.push({
                        id: element.id,
                        title: element.status_evenement,
                        daysOfWeek: [ '6' ], // these recurrent events move separately
                        startTime: element.time_non_dispo_jour_debut,
                        endTime: element.time_non_dispo_jour_fin,
                        status_evenement: element.status_evenement,
                        type_evenement: element.type_evenement,
                        color: '#2B2B2B',
                        color_status: '#678479',
                        editable: true
                    
                    })
                    }         
                }
                else if(element.type_evenement == 'Pas disponible date'){
                    array_result.push({
                        id: element.id,
                        title: element.status_evenement,
                        start: element.start,
                        end: element.end,
                        color:'#2B2B2B',
                        color_status: '#434242',
                        status_evenement: element.status_evenement,
                        type_evenement: element.type_evenement,
                        editable: true
                    })
                }
            });
            res.json(array_result)
        }
    })
})

// insert non_disponibilite_autorite_date
router.post('/non_disponible_autorite_jour/insert/add',async(req,res)=>{
    const sql = 
    `INSERT INTO stage.non_disponibilite_autorite_jour
	( jour, time_non_dispo_jour_debut, time_non_dispo_jour_fin, id_autorite_enfant) VALUES('${req.body.jour_date}','${req.body.time_non_dispo_jour_debut}','${req.body.time_non_dispo_jour_fin}',${req.body.id_autorite})`
    db.query(sql, (error,result) => {
        if(error){
            res.send(error)
        } 
        else {
            res.json(result[0])
        }
    })
})

// update non_disponibilite_autorite_date
router.post('/non_disponible_autorite_jour/update',async(req,res)=>{
    const audience = {
        time_non_dispo_jour_debut: req.body.time_non_dispo_jour_debut,
        time_non_dispo_jour_fin: req.body.time_non_dispo_jour_fin,
        jour: req.body.jour_date,
        id_autorite_enfant: req.body.id_autorite
    }
    const sql = `UPDATE stage.non_disponibilite_autorite_jour SET ? where id = ${req.body.id}`
    db.query(sql,audience, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

module.exports = router