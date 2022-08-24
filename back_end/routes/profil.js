const express = require('express')
const router = express.Router();
const db = require('../database')
const sha1 = require('sha1')

// router.get('/all',async (req,res)=>{
//     res.send('Hello world')
// })


// get all doleance
router.post('/login/:nom_utilisateur/:mot_de_passe',async (req,res)=>{
    const username = req.params.nom_utilisateur
    const pwd = req.params.mot_de_passe
    // console.log(username+' '+pwd)
    try {
        let sql = "SELECT id from profil where nom_utilisateur ='"+username+"' and mot_de_passe ='"+sha1(pwd)+"'"
        // console.log(sql)
        const profil = await db.promise().query(sql)
        res.json(profil[0])
    } catch (err) {
        res.json({message: err})
    }
})
/**SELECT nom_utilisateur, mot_de_passe, id
FROM
	stage.profil l where nom_utilisateur = 'administrateur@gmail.com' and mot_de_passe = '21232f297a57a5a743894a0e4a801fc3'; */
module.exports = router