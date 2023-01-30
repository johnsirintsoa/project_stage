const express = require('express')
const router = express.Router();
const db = require('../database').conn
const db_name = require('../database').db_name
const mailing = require('../Controllers/MailingController')



// Liste audience disponible
router.post('/public/heure_disponible_autorite/jour',async(req,res) =>{
    const sql = `CALL liste_place_disponible_public_par_jour('${req.body.date_du_jour}','${req.body.session_navigateur}',${req.body.id_autorite})`
    db.query(sql,function(err,result){
        if(err){
            return res.send({ err });
        }
        else{
            return res.json(result[0])    
        }
    })
})

// Liste audiences par jour
router.post('/public/all', async(req,res) =>{
    // const date_du_jour = new Date().getFullYear()+'-'+new Date().getMonth()+'-'+new Date().getDate();
    const sql =`call liste_disponible_public('${req.body.session_navigateur}',${req.body.id_autorite})`
    // console.log(sql)
    db.query(sql,function(err,result){
        if(err){
            return res.send({ err });
        }
        else{
            return res.json(result[0])    
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
                else if(element.type_audience == 'Jour ouvrable'){
                    if(element.jour_non_dispo_jour == 'Sunday'){
                        result_array.push({
                            display: 'background',
                            Overlap: false,
                            title: element.title,
                            daysOfWeek: [ '0' ], // these recurrent events move separately
                            startTime: element.td_non_dispo_jour,
                            endTime: element.tf_non_dispo_jour,
                            type_audience: element.type_audience,
                            color: element.color,
                            status_audience: element.status_audience
                        })
                }
                else if(element.jour_non_dispo_jour == 'Monday'){
                    result_array.push({
                        display: 'background',
                        Overlap: false,
                        title: element.title,
                        daysOfWeek: [ '1' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: element.color,
                        status_audience: element.status_audience
                    })
                }
                else if(element.jour_non_dispo_jour == 'Tuesday'){
                    result_array.push({
                        display: 'background',
                        Overlap: false,
                        title: element.title,
                        daysOfWeek: [ '2' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: element.color,
                        status_audience: element.status_audience
                    })
                }
                else if(element.jour_non_dispo_jour == 'Wednesday'){
                    result_array.push({
                        display: 'background',
                        Overlap: false,
                        title: element.title,
                        daysOfWeek: [ '3' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: element.color,
                        status_audience: element.status_audience
                    })
                }
                else if(element.jour_non_dispo_jour == 'Thursday'){
                    result_array.push({
                        display: 'background',
                        Overlap: false,
                        title: element.title,
                        daysOfWeek: [ '4' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: element.color,
                        status_audience: element.status_audience
                    })
                }
                else if(element.jour_non_dispo_jour == 'Friday'){
                    result_array.push({
                        display: 'background',
                        Overlap: false,
                        title: element.title,
                        daysOfWeek: [ '5' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: element.color,
                        status_audience: element.status_audience
                    })
                }
                else if(element.jour_non_dispo_jour == 'Saturday'){
                    result_array.push({
                        display: 'background',
                        Overlap: false,
                        title: element.title,
                        daysOfWeek: [ '6' ], // these recurrent events move separately
                        startTime: element.td_non_dispo_jour,
                        endTime: element.tf_non_dispo_jour,
                        type_audience: element.type_audience,
                        color: element.color,
                        status_audience: element.status_audience
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
    let sql = `DELETE FROM ${db_name}.demande_audience_public where id = ${req.body.id} and session_navigateur = '${req.body.session_navigateur}'`
    db.query(sql, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

router.post('/public/add',async(req,res)=>{
    const sql = `CALL add_audience_public_V2('${req.body.session_navigateur}','${req.body.nom}','${req.body.prenom}','${req.body.cin}','${req.body.numero_telephone}','${req.body.email}','${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}','${req.body.motif}',${req.body.id_autorite_enfant})`
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

router.post('/public/ajouter',async(req,res)=>{
    const sql = `CALL ajouter_audience_public('${req.body.session_navigateur}','${req.body.nom}','${req.body.prenom}','${req.body.cin}','${req.body.numero_telephone}','${req.body.email}',${req.body.id_date_heure_disponible_autorite},'${req.body.motif}','${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}')`
        db.query(sql, (error,result) => {
        if(error){
            res.send(error)
        } 
        else if(result.length > 0 ){
            res.json(result[0][0])
        }   
        else{
            res.json(result[0])
        }
        
    })
})

router.post('/public/supprimer/:id',async(req,res)=>{
    const sql = `call supprimer_audience_public (${req.params.id})`
        db.query(sql, (error,result) => {
        if(error){
            res.send(error)
        } 
        else if(result.length > 0 ){
            res.json(result[0][0])
        }
        else{
            res.json(result[0])
        }
        
    })
})

router.post('/public/modifier',async(req,res)=>{
    const sql = `call modifier_audience_public ('${req.body.nom }','${req.body.prenom }','${req.body.cin }','${req.body.numero_telephone }','${req.body.email }','${req.body.motif}',${req.body.id_audience},${req.body.id_date_heure_disponible_autorite},${req.body.id_dm_aud_public_heure_dispo})`
    // console.log(sql)
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
 
    const autorite = req.body.autorite
    const evenement = req.body.evenement

    const sql = ` CALL valider_audience_public (${evenement.id_dm_aud_public_date_heure_dispo},${evenement.id}, '${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}',${autorite.id})`
    
    const entretien_date_time = String(req.body.date_debut).concat('T',req.body.heure_debut)
    const response = await mailing.audience_public_valide(autorite,evenement,entretien_date_time)
        
    // res.json(response)
    db.query(sql,req.body,async (error,result) => {
        if(error) {
            res.send(error)
        }
        // res.json(sql)
        else{
            if(result ){
                res.json({message:'Audience revalidé et envoyé',data:{db:result,mail:response}})
            }
            else {
                res.json({message:'Audience non revalidé ',data:{db:result,mail:response}})
            }
        }
    })
})

router.post('/public/revalider',async(req,res)=>{


    const autorite = req.body.autorite
    const evenement = req.body.evenement

    const entretien_date_time = String(req.body.date_debut).concat('T',req.body.heure_debut)
    const response = await mailing.audience_public_revalide(autorite,evenement,entretien_date_time)
    
    // const sql = `UPDATE ${db_name}.demande_audience_public SET ? where id = ${req.body.id}`
    const sql = `CALL revalider_audience_public(${evenement.id_dm_aud_public_date_heure_dispo},${evenement.id}, '${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}',${autorite.id})`
    db.query(sql,req.body,async (error,result) => {
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

router.post('/public/reporter/now',async(req,res)=>{

    const autorite = req.body.autorite
    const evenement = req.body.evenement
    // const sql = `UPDATE ${db_name}.demande_audience_public SET ? where id = ${req.body.id}`
    const sql = `CALL reporter_audience_public_maintenant (${evenement.id_dm_aud_public_date_heure_dispo},${evenement.id}, '${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}',${autorite.id})`
    
    // res.json(req.body)

    const entretien_date_time = String(req.body.date_debut).concat('T',req.body.heure_debut)
    const response = await mailing.audience_public_reporte(autorite,evenement,entretien_date_time)

    db.query(sql,req.body,async (error,result) => {
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
    })
})

router.post('/public/reporter/later',async(req,res)=>{

    const autorite = req.body.autorite
    const evenement = req.body.evenement
    
    // console.log(audience)
    // const sql = `CALL si_disponible_autorite('${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}',${req.body.id_autorite_enfant},'${req.body.motif}')`
    
    // const sql = `UPDATE ${db_name}.demande_audience_public SET action = 2 where id = ${req.body.id}`
    
    const sql = `CALL reporter_audience_public_plus_tard (${evenement.id_dm_aud_public_date_heure_dispo},${evenement.id}, '${req.body.date_debut}','${req.body.date_fin}','${req.body.heure_debut}','${req.body.heure_fin}',${autorite.id})`
    
    // res.json(sql)

    db.query(sql, async (error,result) => {
        if(error) {
            res.send(error)
        }
        else{
            const entretien_date_time = String(req.body.date_debut).concat('T',req.body.heure_debut)
            const response = await mailing.audience_public_reporte_plus_tard(autorite,evenement,entretien_date_time)
            if(response && result ){
                res.json({message:'Audience reporté et envoyé',mail:response,data:result})
            }
            else {
                res.json({message:'Audience non reporté'})
            }
        }
    })
})

module.exports = router