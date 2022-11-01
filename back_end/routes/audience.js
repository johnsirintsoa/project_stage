const express = require('express')
const router = express.Router();
const db = require('../database')

// liste audiences
router.get('/public/all',async (req,res)=>{
    let sql = `SELECT c.id,date_event_debut, motif, id_autorite_enfant, date_event_fin, time_event_debut, time_event_fin,autorite_enfant.intitule,autorite_enfant.intitule_code
    FROM
        stage.demande_audience_public c join autorite_enfant on c.id_autorite_enfant = autorite_enfant.id`
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.send({ err });
        }else{
            return res.json(result);
        }
    });
})

// delete audiences
router.delete('/public/delete/:audience_id',async(req,res)=>{
    let sql = "DELETE FROM stage.demande_audience_public where id ='".concat(req.params.audience_id,"'")
    db.query(sql, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

// date and time
router.post('/public/add',async(req,res)=>{
    const sql = `INSERT INTO stage.demande_audience_public( date_event_debut, date_event_fin, time_event_debut, time_event_fin, motif, id_autorite_enfant ) VALUES ( '${req.body.date_event_debut}','${req.body.date_event_fin}', '${req.body.time_event_debut}','${req.body.time_event_fin}', '${req.body.motif}', ${req.body.id_autorite_enfant})`
    db.query(sql, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

router.post('/public/update',async(req,res)=>{
    const audience = {
        date_event_debut: req.body.date_event_debut,
        date_event_fin: req.body.date_event_fin, 
        time_event_debut: req.body.time_event_debut,
        time_event_fin: req.body.time_event_fin,
        motif: req.body.motif,
        id: req.body.id
    }
    // const sql = `INSERT INTO stage.demande_audience( date_time_debut, date_time_fin, id_demande_stage, motif, id_direction, type_audience ) VALUES ( '${req.body.date_time_debut}', '${req.body.date_time_fin}', ${req.body.id_demande_stage}, '${req.body.motif}', ${req.body.id_direction}, '${req.body.type_audience}' )`
    db.query('UPDATE stage.demande_audience_public SET ? WHERE id = ' + req.body.id,audience, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

router.get('/demande_audiences/all/:id_audience_autorite', async(req,res) =>{
    db.query(`
    SELECT 
        ae.id,
        ae.intitule,
        ae.intitule_code,
        dap.date_event_debut as dd_aud_public,
        dap.date_event_fin as df_aud_public,
        dap.time_event_debut as td_aud_public,
        dap.time_event_fin as tf_aud_public,
        dap.motif,
        '' dd_aud_autorite,
        '' df_aud_autorite,
        '' td_aud_autorite,
        '' tf_aud_autorite,
        '' dd_non_dispo_date,
        '' df_non_dispo_date,
        '' td_non_dispo_date,
        '' tf_non_dispo_date,
        '' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour,
        'Occupé' status_audience
    FROM 
        stage.autorite_enfant AS ae
            INNER JOIN stage.demande_audience_public as dap on ae.id = dap.id_autorite_enfant
            WHERE dap.id_autorite_enfant = ${req.params.id_audience_autorite}
    UNION
    SELECT 
        ae.id,
        ae.intitule,
        ae.intitule_code,
        '' dd_aud_public,
        '' df_aud_public,
        '' td_aud_public,
        '' tf_aud_public,
        daa.motif,
        daa.date_debut as dd_aud_autorite,             
        daa.date_fin as df_aud_autorite,
        daa.time_debut as td_aud_autorite,
        daa.time_fin as tf_aud_autorite,
        '' dd_non_dispo_date,
        '' df_non_dispo_date,
        '' td_non_dispo_date,
        '' tf_non_dispo_date,
        '' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour,
        'Occupé' status_audience
        
    FROM 
        stage.autorite_enfant AS ae
            INNER JOIN stage.demande_audience_autorite as daa on ae.id = daa.id_autorite_enfant_receiver
            where daa.id_autorite_enfant_receiver = ${req.params.id_audience_autorite}
    UNION
    SELECT 
        ae.id,
        ae.intitule,
        ae.intitule_code,
        '' dd_aud_public,
        '' df_aud_public,
        '' td_aud_public,
        '' tf_aud_public,
        'Pas disponible' motif,
        '' dd_aud_autorite,             
        '' df_aud_autorite,
        '' td_aud_autorite,
        '' tf_aud_autorite,
        ndad.date_non_dispo_debut as dd_non_dispo_date,
        ndad.date_non_dispo_fin as df_non_dispo_date,
        ndad.time_debut as td_non_dispo_date,
        ndad.time_fin as tf_non_dispo_date,
        '' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour,
        'Pas disponible' status_audience
    FROM 
        stage.autorite_enfant AS ae
            INNER JOIN stage.non_disponibilite_autorite_date as ndad on ae.id = ndad.id_autorite_enfant
            where ndad.id_autorite_enfant = ${req.params.id_audience_autorite}
    UNION
    SELECT 
        ae.id,
        ae.intitule,
        ae.intitule_code,
        '' dd_aud_public,
        '' df_aud_public,
        '' td_aud_public,
        '' tf_aud_public,
        '' motif,
        '' dd_aud_autorite,             
        '' df_aud_autorite,
        '' td_aud_autorite,
        '' tf_aud_autorite,
        '' dd_non_dispo_date,
        '' df_non_dispo_date,
        '' td_non_dispo_date,
        '' tf_non_dispo_date,
        ndaj.jour as jour_non_dispo_jour,
        ndaj.time_non_dispo_jour_debut as td_non_dispo_jour,
        ndaj.time_non_dispo_jour_fin as tf_non_dispo_jour,
        'Pas disponible'

    FROM 
        stage.autorite_enfant as ae
            INNER JOIN stage.non_disponibilite_autorite_jour as ndaj on ae.id = ndaj.id_autorite_enfant
            where ndaj.id_autorite_enfant = ${req.params.id_audience_autorite}
    `,function(err, result) {
        if(err){
            return res.send({ err });
        }else{
            return res.json(result);
        }
    })
})

module.exports = router