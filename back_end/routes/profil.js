const express = require('express')
const router = express.Router();
const db = require('../database')
const sha1 = require('sha1')

// login administrateur
router.post('/administrateur/login/:nom_utilisateur/:mot_de_passe',async (req,res)=>{
    const username = req.params.nom_utilisateur
    const pwd = req.params.mot_de_passe
    // let sql = "SELECT id from profil where nom_utilisateur ='"+username+"' and mot_de_passe ='"+sha1(pwd)+"'"
    // let sql = "SELECT id from profil where nom_utilisateur ='"+username+"' and mot_de_passe ='"+pwd+"'"
    let sql = `SELECT 
        l.id,
        l.id_autorite_enfant,
        ae.intitule,
        ae.intitule_code,
        ae.addresse_electronique
    FROM
        profil l JOIN autorite_enfant ae on l.id_autorite_enfant = ae.id where l.nom_utilisateur ='${username}' and l.mot_de_passe ='${pwd}' and est_administrateur = 1`
    var query = db.query(sql, function(err, result) {
        return res.json(result[0]);
    });
})

// login autorite
router.post('/autorite/login/:nom_utilisateur/:mot_de_passe',async (req,res)=>{
    const username = req.params.nom_utilisateur
    const pwd = req.params.mot_de_passe
    // let sql = "SELECT id from profil where nom_utilisateur ='"+username+"' and mot_de_passe ='"+sha1(pwd)+"'"
    // let sql = "SELECT id from profil where nom_utilisateur ='"+username+"' and mot_de_passe ='"+pwd+"'"
    let sql = `SELECT 
        l.id,
        l.id_autorite_enfant,
        ae.intitule,
        ae.intitule_code
    FROM
        profil l JOIN autorite_enfant ae on l.id_autorite_enfant = ae.id where l.nom_utilisateur ='${username}' and l.mot_de_passe ='${pwd}' and est_administrateur = 0`
    var query = db.query(sql, function(err, result) {
        return res.json(result[0]);
    });
})
module.exports = router