const express = require('express')
const router = express.Router();
// const db = require('../database').conn
// const db_name = require('../database').db_name

const rohiPool = require('../database').rohi
const rohiAudiencePool = require('../database').rohiAudience

router.get('/all',async (req,res)=>{
    let sql = "SELECT * FROM domaine"

    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql, function(err, result) {
            if(err){
                return res.send({ err });
            }else{
                return res.json(result);
            }
            rohiAudienceDB.release()
        });
    }).catch((err) => {
        throw err 
     });
})

module.exports = router