const express = require('express')
const router = express.Router();
const db = require('../database')

// liste audiences
router.get('/all',async (req,res)=>{
    let sql = `SELECT c.id,date_event_debut, motif, id_direction, date_event_fin, time_event_debut, time_event_fin,direction.intitule,direction.intitule_code
    FROM
        stage.demande_audience_public c join direction on c.id_direction = direction.id`
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
    let sql = "DELETE FROM stage.demande_audience_public where id ='".concat(req.params.audience_id,"'")
    db.query(sql, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

// dateTIME
// router.post('/add',async(req,res)=>{
//     const sql = `INSERT INTO stage.demande_audience( date_time_debut, date_time_fin, id_demande_stage, motif, id_direction, type_audience ) VALUES ( '${req.body.date_time_debut}', '${req.body.date_time_fin}', (SELECT id FROM stage.demande_stage e where  nom = ' ' and prenom =' ' and e_mail = ' ' and telephone = ' '), '${req.body.motif}', ${req.body.id_direction}, '${req.body.type_audience}' )`
//     db.query(sql, (error,result) => {
//         if(error) res.send(error)
//         res.json(result)
//     })
// })

// date and time
router.post('/add',async(req,res)=>{
    const sql = `INSERT INTO stage.demande_audience_public( date_event_debut, date_event_fin, time_event_debut, time_event_fin, motif, id_direction ) VALUES ( '${req.body.date_event_debut}','${req.body.date_event_fin}', '${req.body.time_event_debut}','${req.body.time_event_fin}', '${req.body.motif}', ${req.body.id_direction})`
    db.query(sql, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

// Test
// router.post('/test/add',async(req,res)=>{
//     // const sql = `INSERT INTO stage.test
// 	// ( date_x, time_x) VALUES ( NOW(),'${req.body.time_x}' )`
//     const sql = `INSERT INTO stage.test
// 	( date_x_debut, date_x_fin, time_x_debut, time_x_fin)  VALUES ( '${req.body.date_x_debut}','${req.body.date_x_fin}','${req.body.time_x_debut}','${req.body.time_x_fin}' )`
//     db.query(sql, (error,result) => {
//         if(error) res.send(error)
//         res.json(result)
//     })
// })

router.get('/test/all',async (req,res)=>{
    let sql = "SELECT * FROM stage.test t"
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.send({ err });
        }else{
            return res.json(result);
        }
    });
})

// 

// router.post('/disponibilite/add',async(req,res)=>{
//     const sql = `INSERT INTO stage.demande_audience( date_time_debut, date_time_fin, id_demande_stage, motif, id_direction, type_audience) VALUES ( '${req.body.date_time_debut}', '${req.body.date_time_fin}', (SELECT id FROM stage.demande_stage e where  nom = ' ' and prenom =' ' and e_mail = ' ' and telephone = ' '), '${req.body.motif}', ${req.body.id_direction}, '${req.body.type_audience}' )`
//     db.query(sql, (error,result) => {
//         if(error) res.send(error)
//         res.json(result)
//     })
// })

router.post('/update',async(req,res)=>{
    const audience = {
        date_event_debut: req.body.date_event_debut,
        date_event_fin: req.body.date_event_fin, 
        time_event_debut: req.body.time_event_debut,
        time_event_fin: req.body.time_event_fin,
        motif: req.body.motif,
        id_direction: req.body.id_direction,
        id: req.body.id
    }
    // const sql = `INSERT INTO stage.demande_audience( date_time_debut, date_time_fin, id_demande_stage, motif, id_direction, type_audience ) VALUES ( '${req.body.date_time_debut}', '${req.body.date_time_fin}', ${req.body.id_demande_stage}, '${req.body.motif}', ${req.body.id_direction}, '${req.body.type_audience}' )`
    db.query('UPDATE stage.demande_audience_public SET ? WHERE id = ' + req.body.id,audience, (error,result) => {
        if(error) res.send(error)
        res.json(result)
    })
})

module.exports = router