const express = require('express')
const router = express.Router();
const rohi = require('../database').rohi
const db = require('../database').conn

const { authJwt } = require("../middleware");


router.post('/barre/doleance', [authJwt.verifyToken], async(req,res) =>{
    let annee = ''
    if(!req.body.annee)
    {
        annee = '(SELECT YEAR(CURRENT_TIME()))'
    }
    else {
        annee = req.body.annee
    }

    const sql = `select 
    'Jan' as x,  count(IF(MONTH(d.date_publication) = 1,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION
    select 
    'Fev' as x,  count(IF(MONTH(d.date_publication) = 2,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION
    select
    'Mar' as x,  count(IF(MONTH(d.date_publication) = 3,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION 
    select 
    'Avr' as x,  count(IF(MONTH(d.date_publication) = 4,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION
    select 
    'Mai' as x,  count(IF(MONTH(d.date_publication) = 5,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION
    select 
    'Jui' as x,  count(IF(MONTH(d.date_publication) = 6,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee}
    
    UNION 
    select 
    'Juil' as x,  count(IF(MONTH(d.date_publication) = 7,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION
    select 
    'Aou' as x,  count(IF(MONTH(d.date_publication) = 8,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION
    select 
    'Sept' as x,  count(IF(MONTH(d.date_publication) = 9,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION 
    select
    'Oct' as x,  count(IF(MONTH(d.date_publication) = 10,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION
    select
    'Nov' as x,  count(IF(MONTH(d.date_publication) = 11,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION 
    select
    'Dec' as x,  count(IF(MONTH(d.date_publication) = 12,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} `
    
    rohi.query(sql, function(err,result){
        if(err){
            return res.send({err})
        }
        else {
            return res.json(result)
        }
    })


    // console.log(sql)
    // // res.send(sql)
})

router.post('/barre/stage', [authJwt.verifyToken],async(req,res) =>{
    let annee = ''
    if(!req.body.annee)
    {
        annee = '(SELECT YEAR(CURRENT_TIME()))'
    }
    else {
        annee = req.body.annee
    }

    const sql = `
    select 
    d.nom_domaine as x,
    IF(ds.id = NULL ,0,count(ds.id)) as y
    from stage5.domaine d 
    LEFT JOIN stage5.demande_stage ds on d.id = ds.id_domaine
    WHERE 
    (ds.id_autorite_enfant = ${req.body.id_autorite} and year(ds.date_creation) = ${req.body.annee}) 
    or (ds.id is null and year(ds.date_creation) = ${req.body.annee})
    group by d.id order by x`
    console.log(sql)
    
    rohi.query(sql, function(err,result){
        if(err){
            return res.send({err})
        }
        else {
            return res.json(result)
        }
    })
})
module.exports = router