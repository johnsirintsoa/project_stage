const express = require('express')
const router = express.Router();
const rohiPool = require('../database').rohi
const rohiAudiencePool = require('../database').rohiAudience

require('dotenv/config')

router.post('/login', async(req,res) =>{

    const email = `select
    c.id as id_candidat
    FROM ${process.env.DB_AUTORITE}.candidat c 
    JOIN ${process.env.DB_AUTORITE}.t_structure ts on c.structureId = ts.child_id
    JOIN ${process.env.DB_AUTORITE}.user u on c.user_id = u.id
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
    FROM ${process.env.DB_AUTORITE}.candidat c 
    JOIN ${process.env.DB_AUTORITE}.t_structure ts on c.structureId = ts.child_id
    JOIN ${process.env.DB_AUTORITE}.user u on c.user_id = u.id
    where 
    ts.niveau NOT IN ('MIN', 'DG', 'DIR', 'SCE') 
    AND
    u.login = '${req.body.nom_utilisateur}'
    and 
    u.password = (SELECT AES_ENCRYPT('${req.body.mot_de_passe}','lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau'));
    `
    rohiPool.getConnection(function(err, rohiDb) {
        if (err) {
            rohiDb.release();
            throw err
        } // not connected!

        rohiDb.query(email, function(err,result){
            if(err){
                return res.send({err})
            }
            else if(result.length == 0){
                // console.log(result.length)
                return res.json({message:`Votre nom d'utilisateur est incorrect ou vous n'avez\npas droit d'accès à cette fonctionnalité `})
            }
            else {
                // return res.json(result)
                rohiDb.query(sql, function(err,result){
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
            rohiDb.release()
        })
      });




    // console.log(sql)
    // // res.send(sql)
})

module.exports = router