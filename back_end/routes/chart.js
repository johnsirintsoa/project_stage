const express = require('express')
const router = express.Router();

const rohiPool = require('../database').rohi
const rohiAudiencePool = require('../database').rohiAudience

// const rohi = require('../database').rohi
// const db = require('../database').conn

const { authJwt } = require("../middleware");

require('dotenv/config')


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
    ${process.env.DB_APP}.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION
    select 
    'Fev' as x,  count(IF(MONTH(d.date_publication) = 2,1,NULL)) 'y'
    from 
    ${process.env.DB_APP}.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION
    select
    'Mar' as x,  count(IF(MONTH(d.date_publication) = 3,1,NULL)) 'y'
    from 
    ${process.env.DB_APP}.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION 
    select 
    'Avr' as x,  count(IF(MONTH(d.date_publication) = 4,1,NULL)) 'y'
    from 
    ${process.env.DB_APP}.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION
    select 
    'Mai' as x,  count(IF(MONTH(d.date_publication) = 5,1,NULL)) 'y'
    from 
    ${process.env.DB_APP}.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION
    select 
    'Jui' as x,  count(IF(MONTH(d.date_publication) = 6,1,NULL)) 'y'
    from 
    ${process.env.DB_APP}.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee}
    
    UNION 
    select 
    'Juil' as x,  count(IF(MONTH(d.date_publication) = 7,1,NULL)) 'y'
    from 
    ${process.env.DB_APP}.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION
    select 
    'Aou' as x,  count(IF(MONTH(d.date_publication) = 8,1,NULL)) 'y'
    from 
    ${process.env.DB_APP}.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION
    select 
    'Sept' as x,  count(IF(MONTH(d.date_publication) = 9,1,NULL)) 'y'
    from 
    ${process.env.DB_APP}.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION 
    select
    'Oct' as x,  count(IF(MONTH(d.date_publication) = 10,1,NULL)) 'y'
    from 
    ${process.env.DB_APP}.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION
    select
    'Nov' as x,  count(IF(MONTH(d.date_publication) = 11,1,NULL)) 'y'
    from 
    ${process.env.DB_APP}.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} 
    
    UNION 
    select
    'Dec' as x,  count(IF(MONTH(d.date_publication) = 12,1,NULL)) 'y'
    from 
    ${process.env.DB_APP}.doleance d 
    where d.id_autorite = ${req.body.id_autorite} and year(d.date_publication) = ${annee} `
    
    rohiAudiencePool.getConnection(function(error, rohiAudienceDB){
        rohiAudienceDB.query(sql, function(err,result){
            if(err){
                return res.send({err})
            }
            else {
                return res.json(result)
            }
            rohiAudienceDB.release()
        })
    })
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
    from ${process.env.DB_APP}.domaine d 
    LEFT JOIN ${process.env.DB_APP}.demande_stage ds on d.id = ds.id_domaine
    WHERE 
    (ds.id_autorite_enfant = ${req.body.id_autorite} and year(ds.date_creation) = ${req.body.annee}) 
    or (ds.id is null and year(ds.date_creation) = ${req.body.annee})
    group by d.id order by x`
    console.log(sql)
    
    rohiAudiencePool.getConnection(function(error, rohiAudienceDB){
        rohiAudienceDB.query(sql, function(err,result){
            if(err){
                return res.send({err})
            }
            else {
                return res.json(result)
            }
            rohiAudienceDB.release()
        })
    })
})
module.exports = router