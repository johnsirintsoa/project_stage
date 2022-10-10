const express = require('express')
const router = express.Router();
const db = require('../database')

// liste audiences
router.get('/all',async (req,res)=>{
    let sql = "SELECT e.id,date_time_debut, date_time_fin, motif,direction.id as id_direction, direction.intitule,direction.intitule_code,type_audience FROM stage.demande_audience e inner join demande_stage on e.id_demande_stage = demande_stage.id join direction on e.id_direction = direction.id"
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.send({ err });
        }else{
            return res.json(result);
        }
    });
})

// delete audiences
router.delete('/delete/:audience_id',async(req,res)=>{
    let sql = "DELETE FROM stage.demande_audience where id ='".concat(req.params.audience_id,"'")
    db.query(sql, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

router.post('/add',async(req,res)=>{
    const sql = `INSERT INTO stage.demande_audience( date_time_debut, date_time_fin, id_demande_stage, motif, id_direction, type_audience ) VALUES ( '${req.body.date_time_debut}', '${req.body.date_time_fin}', (SELECT id FROM stage.demande_stage e where  nom = ' ' and prenom =' ' and e_mail = ' ' and telephone = ' '), '${req.body.motif}', ${req.body.id_direction}, '${req.body.type_audience}' )`
    db.query(sql, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

router.post('/disponibilite/add',async(req,res)=>{
    const sql = `INSERT INTO stage.demande_audience( date_time_debut, date_time_fin, id_demande_stage, motif, id_direction, type_audience) VALUES ( '${req.body.date_time_debut}', '${req.body.date_time_fin}', (SELECT id FROM stage.demande_stage e where  nom = ' ' and prenom =' ' and e_mail = ' ' and telephone = ' '), '${req.body.motif}', ${req.body.id_direction}, '${req.body.type_audience}' )`
    db.query(sql, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

router.post('/update',async(req,res)=>{
    const audience = {
        date_time_debut: req.body.date_time_debut,
        date_time_fin: req.body.date_time_fin,
        id_demande_stage: 35,
        motif: req.body.motif,
        id_direction: req.body.id_direction,
        type_audience: req.body.type_audience,
        id: req.body.id
    }
    // const sql = `INSERT INTO stage.demande_audience( date_time_debut, date_time_fin, id_demande_stage, motif, id_direction, type_audience ) VALUES ( '${req.body.date_time_debut}', '${req.body.date_time_fin}', ${req.body.id_demande_stage}, '${req.body.motif}', ${req.body.id_direction}, '${req.body.type_audience}' )`
    db.query('UPDATE stage.demande_audience SET ? WHERE id = ' + req.body.id,audience, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

module.exports = router