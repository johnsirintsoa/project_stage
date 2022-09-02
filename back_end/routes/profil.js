const express = require('express')
const router = express.Router();
const db = require('../database')
const sha1 = require('sha1')

// login
router.post('/login/:nom_utilisateur/:mot_de_passe',async (req,res)=>{
    const username = req.params.nom_utilisateur
    const pwd = req.params.mot_de_passe
    let sql = "SELECT id from profil where nom_utilisateur ='"+username+"' and mot_de_passe ='"+sha1(pwd)+"'"
    var query = db.query(sql, function(err, result) {
        return res.json(result[0]);
    });
})
module.exports = router