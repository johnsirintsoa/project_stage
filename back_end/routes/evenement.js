const express = require('express')
const router = express.Router();

const rohiPool = require('../database').rohi
const rohiAudiencePool = require('../database').rohiAudience

// const db = require('../database').conn
// const db_name = require('../database').db_name
const mailing = require('../Controllers/MailingController')
const { authJwt } = require("../middleware");


router.post('/valider', [authJwt.verifyToken],async (req,res) =>{
    const date_debut_Formated = req.body.date_debut.split('T')[0]
    const date_fin_Formated = req.body.date_fin.split('T')[0]
    const sql = `CALL valider_evenement(
        ${req.body.id_date_heure_disponible_autorite},
        ${req.body.id_evenement},
        '${req.body.type_evenement}',
        '${date_debut_Formated}',
        '${date_fin_Formated}',
        '${req.body.heure_debut}',
        '${req.body.heure_fin}'
    )`
    // console.log(req.body)
    const autorite = req.body.autorite
    const sender = req.body.sender
    const evenement = req.body.evenement

    // res.json(sql)
    const entretien_date_time = String(date_debut_Formated).concat('T',req.body.heure_debut)
    const type_evenement = req.body.type_evenement
    let response = ''
    if (type_evenement === 'Public'){
        response = await mailing.audience_public_valide(autorite,sender,entretien_date_time)    
    }
    else if (type_evenement === 'Autorité'){
        response = await mailing.audience_autorite_valide(autorite,evenement,entretien_date_time)         
    }
    else if (type_evenement === 'Entretien'){
        
        response = await mailing.entretien_valide(autorite,sender,entretien_date_time)
    }
 
    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql,function(err,result){
            // console.log(result)
            if(err){
                return res.send({ err });
            }
            else{
                if(result ){
                    return res.json({data:{db:result[0][0],mail:response}})
                }
                else {
                    return res.json({data:{db:result[0][0],mail:response}})
                }
            }
            rohiAudienceDB.release()
        })
    }).catch((err) => {
        throw err 
     });
})

router.post('/revalider', [authJwt.verifyToken],async (req,res) =>{
    const date_debut_Formated = req.body.date_debut.split('T')[0]
    const date_fin_Formated = req.body.date_fin.split('T')[0]
    const sql = `CALL valider_evenement(
        ${req.body.id_date_heure_disponible_autorite},
        ${req.body.id_evenement},
        '${req.body.type_evenement}',
        '${date_debut_Formated}',
        '${date_fin_Formated}',
        '${req.body.heure_debut}',
        '${req.body.heure_fin}'
    )`
    // console.log(req.body)
    const autorite = req.body.autorite
    const sender = req.body.sender
    const evenement = req.body.evenement

    // res.json(sql)
    const entretien_date_time = String(date_debut_Formated).concat('T',req.body.heure_debut)
    const type_evenement = req.body.type_evenement
    let response = ''
    if (type_evenement === 'Public'){
        response = await mailing.audience_public_revalide(autorite,sender,entretien_date_time)    
    }
    else if (type_evenement === 'Agent'){
        response = await mailing.audience_public_revalide(autorite,sender,entretien_date_time)    
    }
    else if (type_evenement === 'Autorité'){
        const autorite_sender = evenement
        response = await mailing.audience_autorite_revalide(autorite,autorite_sender,entretien_date_time)         
    }
    else if (type_evenement === 'Entretien'){
        
        response = await mailing.entretien_reporte(autorite,sender,entretien_date_time)
    }

    rohiAudiencePool.then(( rohiAudienceDB) => {
        rohiAudienceDB.query(sql,function(err,result){
            // console.log(result)
            if(err){
                return res.send({ err });
            }
            else{
                if(result ){
                    return res.json({data:{db:result[0][0],mail:response,message:'Votre évènement a bien été modifié'}})
                }
                else {
                    return res.json({data:{db:result[0][0],mail:response}})
                }
            }
            rohiAudienceDB.release()
        })
    }).catch((err) => {
        throw err 
     });

})


router.post('/terminer', [authJwt.verifyToken],async (req,res) =>{

    const type_evenement = req.body.type_evenement
    const id = req.body.id_evenement 

    let sql = ''
    if (type_evenement === 'Public'){
        sql = `UPDATE demande_audience_public SET est_termine = ${req.body.est_termine} where id = ${req.body.id_evenement}`    
    }
    else if (type_evenement === 'Agent'){
        sql = `UPDATE demande_audience_public SET est_termine = ${req.body.est_termine} where id = ${req.body.id_evenement}`    
    }
    else if (type_evenement === 'Autorité'){
        sql = `UPDATE demande_audience_autorite SET est_termine = ${req.body.est_termine} where id = ${req.body.id_evenement}`             
    }
    else if (type_evenement === 'Entretien'){
        sql = `UPDATE demande_stage SET est_termine = ${req.body.est_termine} where id = ${req.body.id_evenement}`    
    }

    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql,function(err,result){
            // console.log(result)
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