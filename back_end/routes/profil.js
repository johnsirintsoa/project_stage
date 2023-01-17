const express = require('express')
const router = express.Router();
const db = require('../database').conn
const db_name = require('../database').db_name
const sha1 = require('sha1')

// login administrateur
router.post('/login',async (req,res)=>{
    const username = req.body.nom_utilisateur
    const pwd = req.body.mot_de_passe
    // let sql = "SELECT id from profil where nom_utilisateur ='"+username+"' and mot_de_passe ='"+sha1(pwd)+"'"
    // let sql = "SELECT id from profil where nom_utilisateur ='"+username+"' and mot_de_passe ='"+pwd+"'"
    let sql = `SELECT 
        l.id,
        l.id_autorite_enfant,
        ae.intitule,
        ae.intitule_code,
        ae.addresse_electronique,
        ae.mot_de_passe_mailing,
        ae.porte,
        l.est_administrateur
    FROM
        profil l JOIN autorite_enfant ae on l.id_autorite_enfant = ae.id where l.nom_utilisateur ='${username}' and l.mot_de_passe ='${pwd}'`
    var query = db.query(sql, function(err, result) {
        return res.json(result[0]);
    });
})

router.post('/inscription', async(req, res) =>{
    let sql = `INSERT INTO ${db_name}.profil( mot_de_passe, nom_utilisateur, est_administrateur, id_autorite_enfant) 
    VALUES ( '${req.body.mot_de_passe}', '${req.body.nom_utilisateur}',${req.body.est_administrateur}, ${req.body.id_autorite_enfant} )`
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.json(err);
        }
        else{
            if(result){
                res.json({message:'Vous avez bien été inscrit(e)'})
            }
            else{
                res.json(result)
            }
        } 
    })
})


module.exports = router