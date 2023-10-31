const express = require('express')
const router = express.Router();

const rohiPool = require('../database').rohi
const rohiAudiencePool = require('../database').rohiAudience

// const db = require('../database').conn
// const db_name = require('../database').db_name
const mailing = require('../Controllers/MailingController')
const Function = require('../func/function')

const notification_mailing = require('../Controllers/NotificationController')

const moment = require('../func/date.config')

const { authJwt } = require("../middleware");

require('dotenv/config')

// Liste audience disponible
router.post('/public/heure_disponible_autorite/jour',async(req,res) =>{
    const sql = `CALL liste_place_disponible_public_par_jour('${req.body.date_du_jour}','${req.body.session_navigateur}',${req.body.id_autorite})`
    
    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql,function(err,result){
            if(err){
                return res.send({ err });
            }
            else{
                console.log(result[0])
                return res.json(result[0])    
            }
            rohiAudienceDB.release()
        })
    }).catch((err) => {
        throw err 
     });

})

// Liste audiences par jour
router.post('/public/all', async(req,res) =>{   
    // const date_du_jour = new Date().getFullYear()+'-'+new Date().getMonth()+'-'+new Date().getDate();
    // const sql =`call liste_disponible_public('${req.body.session_navigateur}',${req.body.id_autorite})`
    // console.log(sql)
    // console.log(moment.formatDate("2013-11-18T11:55:00-05"))
    
    const sql = `(SELECT 
        dhd.id as id_date_heure_disponible,
        dhda.id as id_date_heure_disponible_autorite,
        CONCAT(dapdhd.date_debut,'T', dapdhd.heure_debut) as start, 
        CONCAT(dapdhd.date_fin,'T', dapdhd.heure_fin) as end, 
        dhd.heure_debut as hd,
        dhd.heure_fin as hf,
        dap.id as id, 
        dapdhd.id as id_dm_aud_public_heure_dispo,
        dhd.date_disponible,
        dapdhd.heure_debut, 
        dapdhd.heure_fin, 
        dap.motif as title, dap.motif,
        IFNULL(dap.nom,c.nom) as nom,
        IFNULL(dap.prenom,c.prenom) as prenom,
        dap.cin, 
        dap.numero_telephone, 
        dap.email,
        dap.id_agent, 
        CASE 
            WHEN dap.action = 0 THEN 'Non validé' 
            WHEN dap.action = 1 THEN 'Validé' 
            WHEN dap.action = 2 THEN 'Reporté' 
            ELSE 'Aucune' 
        END as status_audience,
        CASE 
            WHEN dap.session_navigateur = '${req.body.session_navigateur}' and dap.action = 0 THEN "#FF0018" 
            WHEN dap.session_navigateur = '${req.body.session_navigateur}' and dap.action = 1 THEN "#407DFF" 
            WHEN dap.session_navigateur = '${req.body.session_navigateur}' and dap.action = 2 THEN "#000000"  
        END as color, 
        CASE 
            WHEN dap.session_navigateur = '${req.body.session_navigateur}' and dap.action = 0 THEN "#FF0018" 
            WHEN dap.session_navigateur = '${req.body.session_navigateur}' and dap.action = 1 THEN "#407DFF" 
            WHEN dap.session_navigateur = '${req.body.session_navigateur}' and dap.action = 2 THEN "#000000" 
        END as color_status, 
        false editable 
        FROM date_heure_disponible_autorite dhda
        JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
        JOIN dm_aud_public_date_heure_dispo dapdhd on dhda.id = dapdhd.id_date_heure_disponible_autorite
        JOIN demande_audience_public dap on dapdhd.id_aud_public = dap.id
        LEFT JOIN rohi_johns.candidat c on dap.id_agent = c.id
        WHERE 
        dhda.id_autorite = ${req.body.id_autorite}
        and dhd.date_disponible >= CURDATE()
        and dap.session_navigateur = '${req.body.session_navigateur}'
        and dap.action >=0 and dap.action <=2
        GROUP BY dapdhd.id_aud_public)
        
        UNION
        (SELECT 
        dhd.id as id_date_heure_disponible,
        dhda.id as id_date_heure_disponible_autorite,
        CONCAT(dhd.date_disponible,'T', dhd.heure_debut) as start, 
        CONCAT(dhd.date_disponible,'T', dhd.heure_fin) as end, 
        dhd.heure_debut as hd,
        dhd.heure_fin as hf,
        '' id, 
        dapdhd.id as id_dm_aud_public_heure_dispo,
        CONCAT(dhd.date_disponible) AS date_disponible,
        dapdhd.heure_debut, 
        dapdhd.heure_fin, 
        'Disponible' title, dap.motif,
        '' nom, 
        '' prenom, 
        '' cin, 
        '' numero_telephone, 
        '' email, 
        '' id_agent,
        '' status_audience, 
        '#0AA913' color, 
        '' color_status, 
        false editable  
        FROM date_heure_disponible_autorite dhda
        JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id 
        LEFT JOIN pas_disponible pd on dhda.id = pd.id_date_heure_disponible_autorite
        LEFT JOIN dm_aud_autorite_date_heure_dispo daadhd on dhda.id = daadhd.id_date_heure_disponible_autorite
        LEFT JOIN demande_audience_autorite daa on daa.id = daadhd.id_dm_aud_autorite
        LEFT JOIN dm_aud_public_date_heure_dispo dapdhd on dhda.id = dapdhd.id_date_heure_disponible_autorite 
        LEFT JOIN demande_audience_public dap on dap.id = dapdhd.id_aud_public
        LEFT JOIN entretien_demande_stage eds on dhda.id = eds.id_date_heure_disponible_autorite 
        WHERE 
        dhda.id_autorite = ${req.body.id_autorite}
        and (timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) >= (select CURRENT_TIMESTAMP()) 
        or timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)) >= (select CURRENT_TIMESTAMP()))
        and eds.id is null 
        and daadhd.id is null 
        and dapdhd.id is null
        and pd.id is NULL)`

    rohiAudiencePool.then(( rohiAudienceDB) => {
        rohiAudienceDB.query(sql,function(err,result){
            if(err){
                return res.send({ err });
            }
            else{
                console.log(result[0][2])
                return res.json(result[0])    
            }
            rohiAudienceDB.release()
        })
    }).catch((err) => {
        throw err 
     });
})

// delete audiences
router.post('/public/delete',async(req,res)=>{
    let sql = `DELETE FROM demande_audience_public where id = ${req.body.id} and session_navigateur = '${req.body.session_navigateur}'`
    
    rohiAudiencePool.then(( rohiAudienceDB) => {
        rohiAudienceDB.query(sql, (error,result) => {
            if(error) res.send(error)
            res.json(result)
            rohiAudienceDB.release()
        })
    }).catch((err) => {
        throw err 
     });
})

router.post('/public/add',async(req,res)=>{
    // const sql = `CALL add_audience_public_V2('${req.body.session_navigateur}','${req.body.nom}','${req.body.prenom}','${req.body.cin}','${req.body.numero_telephone}','${req.body.email}','${req.body.date_event_debut.split}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}','${req.body.motif}',${req.body.id_autorite_enfant})`
    const sql = `CALL add_audience_public_V2('${req.body.session_navigateur}','${req.body.nom}','${req.body.prenom}','${req.body.cin}','${req.body.numero_telephone}','${req.body.email}','${req.body.date_event_debut.split('T')[0]}','${req.body.date_event_fin.split('T')[0]}','${req.body.time_event_debut}','${req.body.time_event_fin}','${req.body.motif}',${req.body.id_autorite_enfant})`
    
    rohiAudiencePool.then((rohiAudienceDB) => {
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

router.post('/public/ajouter',async(req,res)=>{
    const nomFormated = req.body.nom.toUpperCase()
    const prenomFormated = Function.upSetFirstLetter(req.body.prenom)
    const date_debut_Formated = moment.formatDate(req.body.date_debut)
    // console.log(moment.format())
    // console.log(date_debut_Formated)
    // console.new Date(info.date_debut).toJSON().slice(0,10)
    const date_fin_Formated = moment.formatDate(req.body.date_fin)

    // const sql = `CALL ajouter_audience_public('${req.body.session_navigateur}','${nomFormated}','${prenomFormated}','${req.body.cin}','${req.body.numero_telephone}','${req.body.email}',${req.body.id_date_heure_disponible_autorite},'${req.body.motif}','${req.body.date_debut}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}')`
    const sql = `CALL ajouter_audience_public('${req.body.session_navigateur}','${nomFormated}','${prenomFormated}','${req.body.cin}','${req.body.numero_telephone}','${req.body.email}',${req.body.id_date_heure_disponible_autorite},'${req.body.motif}','${date_debut_Formated}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}')`
    // console.log(sql)

    rohiAudiencePool.then((rohiAudienceDB) => {
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
                    date_debut: date_debut_Formated,
                    date_fin: date_fin_Formated,
                    heure_debut: req.body.heure_debut,
                    heure_fin: req.body.heure_fin
                }
                // console.log(envoyeur)
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
    }).catch((err) => {
        throw err 
     });
})

router.post('/public/supprimer/:id',async(req,res)=>{
    const sql = `call supprimer_audience_public (${req.params.id})`
    
    rohiAudiencePool.then(( rohiAudienceDB) => {
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
    }).catch((err) => {
        throw err 
     });
})

router.post('/public/modifier',async(req,res)=>{
    const nomFormated = req.body.nom.toUpperCase()
    const prenomFormated = Function.upSetFirstLetter(req.body.prenom)
    const date_debut_Formated = moment.formatDate(req.body.date_debut)
    const date_fin_Formated = moment.formatDate(req.body.date_fin)
    const sql = `call modifier_audience_public ('${nomFormated }','${prenomFormated}','${req.body.cin }','${req.body.numero_telephone }','${req.body.email }','${req.body.motif}',${req.body.id_audience},${req.body.id_date_heure_disponible_autorite},${req.body.id_dm_aud_public_heure_dispo})`
    // console.log(sql)
    // console.log(req.body)    

    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql,async (error,result) => {
            if(error){
                res.send(error)
            } 
            else if(result.length > 0 ){
                const envoyeur = {
                    nom: nomFormated,
                    prenom: prenomFormated,
                    motif: req.body.motif,
                    date_debut: date_debut_Formated,
                    date_fin: date_fin_Formated,
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
    }).catch((err) => {
        throw err 
     });


})

router.post('/public/update',async(req,res)=>{
    const date_debut_Formated = moment.formatDate(req.body.date_debut)
    const date_fin_Formated = moment.formatDate(req.body.date_fin)
    // const sql = `CALL update_audience_public ('${req.body.session_navigateur}','${req.body.nom }','${req.body.prenom }','${req.body.cin }','${req.body.numero_telephone }','${req.body.email }','${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}','${req.body.motif}',${req.body.id_autorite_enfant},${req.body.id})`
    const sql = `CALL update_audience_public ('${req.body.session_navigateur}','${req.body.nom }','${req.body.prenom }','${req.body.cin }','${req.body.numero_telephone }','${req.body.email }','${date_debut_Formated}','${date_fin_Formated}','${req.body.time_event_debut}','${req.body.time_event_fin}','${req.body.motif}',${req.body.id_autorite_enfant},${req.body.id})`
    
    rohiAudiencePool.then(( rohiAudienceDB) => {
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

// router.post('/public/valider',async(req,res)=>{
 
//     const autorite = req.body.autorite
//     const evenement = req.body.evenement

//     const sql = ` CALL valider_audience_public (${evenement.id_dm_aud_public_date_heure_dispo},${evenement.id}, '${req.body.date_debut}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}',${autorite.id})`
    
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
    const date_debut_Formated = moment.formatDate(req.body.date_debut)
    const date_fin_Formated = moment.formatDate(req.body.date_fin)
    const sql = ` CALL valider_audience_public (${req.body.id_dm_aud_public_date_heure_dispo},${req.body.id_audience}, '${req.body.date_debut}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}',${req.body.id_autorite})`

    const entretien_date_time = String(req.body.date_debut.split('T')).concat('T',req.body.heure_debut)

    rohiAudiencePool.then(( rohiAudienceDB) => {
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
    }).catch((err) => {
        throw err 
     });
})

// router.post('/public/revalider',async(req,res)=>{


//     const autorite = req.body.autorite
//     const evenement = req.body.evenement

//     const entretien_date_time = String(req.body.date_debut).concat('T',req.body.heure_debut)
//     const response = await mailing.audience_public_revalide(autorite,evenement,entretien_date_time)
    
//     // const sql = `UPDATE ${db_name}.demande_audience_public SET ? where id = ${req.body.id}`
//     const sql = `CALL revalider_audience_public(${evenement.id_dm_aud_public_date_heure_dispo},${evenement.id}, '${req.body.date_debut}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}',${autorite.id})`
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
    const date_debut_Formated = moment.formatDate(req.body.date_debut)
    const date_fin_Formated = moment.formatDate(req.body.date_fin)

    const entretien_date_time = String(req.body.date_debut).concat('T',req.body.heure_debut)
    const response = await mailing.audience_public_revalide(req.body.autorite,req.body.envoyeur,entretien_date_time)

    const sql = `CALL revalider_audience_public(${req.body.id_dm_aud_public_date_heure_dispo},${req.body.id_audience}, '${date_debut_Formated}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}',${req.body.id_autorite})`
    
    rohiAudiencePool.then((rohiAudienceDB) => {
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
    }).catch((err) => {
        throw err 
     });
})

// router.post('/public/reporter/now',async(req,res)=>{

//     const autorite = req.body.autorite
//     const evenement = req.body.evenement
//     // const sql = `UPDATE ${db_name}.demande_audience_public SET ? where id = ${req.body.id}`
//     const sql = `CALL reporter_audience_public_maintenant (${evenement.id_dm_aud_public_date_heure_dispo},${evenement.id}, '${req.body.date_debut}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}',${autorite.id})`
    
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
    const date_debut_Formated = moment.formatDate(req.body.date_debut)
    const date_fin_Formated = moment.formatDate(req.body.date_fin)

    const entretien_date_time = String(req.body.date_debut).concat('T',req.body.heure_debut)
    const response = await mailing.audience_public_reporte(req.body.autorite,req.body.envoyeur,entretien_date_time)

    const sql = `CALL reporter_audience_public_maintenant (${req.body.id_dm_aud_public_date_heure_dispo},${req.body.id_audience}, '${date_debut_Formated}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}',${req.body.id_autorite})`

    rohiAudiencePool.then((rohiAudienceDB) => {
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
    }).catch((err) => {
        throw err 
     });
})

router.post('/public/reporter/later',[authJwt.verifyToken],async(req,res)=>{

    const date_debut_Formated = moment.formatDate(req.body.date_debut)
    const date_fin_Formated = moment.formatDate(req.body.date_fin)
    
    const autorite = req.body.autorite
    const id_autorite = autorite.id_autorite
    // const evenement = req.body.evenement
    // console.log(req.body)
    // const sql = `CALL si_disponible_autorite('${req.body.date_event_debut}','${req.body.date_event_fin}','${req.body.time_event_debut}','${req.body.time_event_fin}',${req.body.id_autorite_enfant},'${req.body.motif}')`
    
    // const sql = `UPDATE ${db_name}.demande_audience_public SET action = 2 where id = ${req.body.id}`
    
    const sql = `CALL reporter_audience_public_plus_tard(${req.body.id_dm_aud_public_date_heure_dispo},${req.body.id_audience},'${date_debut_Formated}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}', ${id_autorite})`
    // const sql = `CALL reporter_audience_public_plus_tard (${evenement.id_dm_aud_public_date_heure_dispo},${evenement.id}, '${req.body.date_debut}','${date_fin_Formated}','${req.body.heure_debut}','${req.body.heure_fin}',${autorite.id})`
    // console.log(sql)
    // res.json(sql)

    rohiAudiencePool.then((rohiAudienceDB) => {
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
    }).catch((err) => {
        throw err 
     });


})

module.exports = router