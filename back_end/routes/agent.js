const express = require('express')
const router = express.Router();
const rohi = require('../database').rohi
const db = require('../database').conn

router.post('/login', async(req,res) =>{

    const email = `select
    c.id as id_candidat
    FROM rohi.candidat c 
    JOIN rohi.t_structure ts on c.structureId = ts.child_id
    JOIN rohi.user u on c.user_id = u.id
    where 
    ts.niveau NOT IN ('MIN', 'DG', 'DIR', 'SCE') 
    AND
    u.login = '${req.body.nom_utilisateur}'`

    const sql = `select
    c.id as id_candidat,
    ts.premier_responsable_id,
    c.nom,
    c.prenom,
    IFNULL(c.poste,'Agent') as poste,
    c.fonction_actuel,
    u.id as id_user,
    u.login,
    u.password,
    c.structureId,
    ts.child_id,
    ts.child_libelle,
    ts.path,
    ts.niveau,
    ts.rang
    FROM rohi.candidat c 
    JOIN rohi.t_structure ts on c.structureId = ts.child_id
    JOIN rohi.user u on c.user_id = u.id
    where 
    ts.niveau NOT IN ('MIN', 'DG', 'DIR', 'SCE') 
    AND
    u.login = '${req.body.nom_utilisateur}'
    and 
    u.password = (SELECT AES_ENCRYPT('${req.body.mot_de_passe}','lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau'));
    `
    
    rohi.query(email, function(err,result){
        if(err){
            return res.send({err})
        }
        else if(result.length == 0){
            // console.log(result.length)
            return res.json({message:`Votre nom d'utilisateur est incorrect ou vous n'avez\npas droit d'accès à cette fonctionnalité `})
        }
        else {
            // return res.json(result)
            rohi.query(sql, function(err,result){
                if(err){
                    return res.send({err})
                }
                else if(result.length == 0){
                    // console.log(sql)
                    // console.log(result.length)
                    return res.json({message:`Votre mot de passe est incorrect ou vous n'avez\npas droit d'accès à cette fonctionnalité`})
                }
                else{
                    return res.json(result[0])
                }
            })
        }
    })


    // console.log(sql)
    // // res.send(sql)
})
module.exports = router