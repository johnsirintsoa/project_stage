const express = require('express')
const router = express.Router();
const rohi = require('../database').rohi
const db = require('../database').conn

router.post('/barre/doleance', async(req,res) =>{
    let annee = ''
    if(req.body.annee == '')
    {
        annee = '(SELECT YEAR(CURRENT_TIME()))'
    }
    else {
        annee = req.body.annee
    }

    const sql = `select 
    'Janvier' as x,  count(IF(MONTH(d.date_publication) = 1,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = 2961 and year(d.date_publication) = ${annee} 
    
    UNION
    select 
    'Février' as x,  count(IF(MONTH(d.date_publication) = 2,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = 2961 and year(d.date_publication) = ${annee} 
    
    UNION
    select
    'Mars' as x,  count(IF(MONTH(d.date_publication) = 3,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = 2961 and year(d.date_publication) = ${annee} 
    
    UNION 
    select 
    'Avril' as x,  count(IF(MONTH(d.date_publication) = 4,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = 2961 and year(d.date_publication) = ${annee} 
    
    UNION
    select 
    'Mai' as x,  count(IF(MONTH(d.date_publication) = 5,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = 2961 and year(d.date_publication) = ${annee} 
    
    UNION
    select 
    'Juin' as x,  count(IF(MONTH(d.date_publication) = 6,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = 2961 and year(d.date_publication) = ${annee}
    
    UNION 
    select 
    'Juillet' as x,  count(IF(MONTH(d.date_publication) = 7,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = 2961 and year(d.date_publication) = ${annee} 
    
    UNION
    select 
    'Aout' as x,  count(IF(MONTH(d.date_publication) = 8,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = 2961 and year(d.date_publication) = ${annee} 
    
    UNION
    select 
    'Septembre' as x,  count(IF(MONTH(d.date_publication) = 9,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = 2961 and year(d.date_publication) = ${annee} 
    
    UNION 
    select
    'Octobre' as x,  count(IF(MONTH(d.date_publication) = 10,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = 2961 and year(d.date_publication) = ${annee} 
    
    UNION
    select
    'Novembre' as x,  count(IF(MONTH(d.date_publication) = 11,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = 2961 and year(d.date_publication) = ${annee} 
    
    UNION 
    select
    'Décembre' as x,  count(IF(MONTH(d.date_publication) = 12,1,NULL)) 'y'
    from 
    stage5.doleance d 
    where d.id_autorite = 2961 and year(d.date_publication) = ${annee} `
    
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
module.exports = router