const express = require('express')
const router = express.Router();
const rohi = require('../database').rohi
const db = require('../database').conn
const db_name = require('../database').db_name
const mailing = require('../Controllers/MailingController')


router.post('/structure', async(req,res) =>{
    // const con = connection.connectionBDD('rohi')
    const sql = `SELECT 
    e.child_id ,
    e.child_libelle,
    e.sigle, 
    e.path, 
    e.autorite_id, 
    e.premier_responsable_id, 
    e.niveau,
    c.email,
    c.phone
    FROM
        rohi.t_structure e
        LEFT join rohi.user u on e.premier_responsable_id = u.id
        LEFT join rohi.candidat c on u.id = c.user_id
        where
        (e.niveau = 'MIN'
        or e.niveau = 'DG'
        or e.niveau = 'DIR'
        or e.niveau = 'SCE')
        and
		(e.path LIKE UPPER('%${req.body.path}%')
        or e.child_libelle LIKE UPPER('%${req.body.path}%')
		or e.sigle LIKE UPPER('%${req.body.path}%')
        or e.parent_libelle LIKE UPPER('%${req.body.path}%')
		or e.sigle_parent LIKE UPPER('%${req.body.path}%')
		or e.direction_libelle LIKE UPPER('%${req.body.path}%')
		or e.structure_entete LIKE UPPER('%${req.body.path}%')
		or e.service_libele LIKE UPPER('%${req.body.path}%')) limit 10`
    // console.log(sql)
    rohi.query(sql, function(err,result){
        if(err){
            return res.send({ err });
        }
        else{
            return res.json(result)    
        }       
    })
})

router.post('/backOffice/structure', async(req,res) =>{
    // const con = connection.connectionBDD('rohi')
    const sql = `SELECT 
    e.child_id ,
    e.child_libelle,
    e.sigle, 
    e.path, 
    e.autorite_id, 
    e.premier_responsable_id, 
    e.niveau,
    c.email,
    c.phone
    FROM
        rohi.t_structure e
        LEFT join rohi.user u on e.premier_responsable_id = u.id
        LEFT join rohi.candidat c on u.id = c.user_id
        where
        (e.niveau = 'MIN'
        or e.niveau = 'DG'
        or e.niveau = 'DIR'
        or e.niveau = 'SCE')
        and e.child_id != ${req.body.id_autorite}
        and (e.path LIKE UPPER('%${req.body.path}%')
        or e.child_libelle LIKE UPPER('%${req.body.path}%')
		or e.sigle LIKE UPPER('%${req.body.path}%')
        or e.parent_libelle LIKE UPPER('%${req.body.path}%')
		or e.sigle_parent LIKE UPPER('%${req.body.path}%')
		or e.direction_libelle LIKE UPPER('%${req.body.path}%')
		or e.structure_entete LIKE UPPER('%${req.body.path}%')
		or e.service_libele LIKE UPPER('%${req.body.path}%')) limit 10`
    // console.log(sql)
    rohi.query(sql, function(err,result){
        if(err){
            return res.send({ err });
        }
        else{
            return res.json(result)    
        }       
    })
})

router.post('/login', async(req,res) =>{

    const email = `select 
    ts.child_id,
    ts.premier_responsable_id,
    ts.autorite_id,
    ts.child_libelle,
    ts.sigle,
    ts.niveau,
    c.email,
    c.phone
    from rohi.t_structure ts 
    LEFT join rohi.user u on ts.premier_responsable_id = u.id
    LEFT join rohi.candidat c on u.id = c.user_id
    where
    (ts.niveau = 'MIN'
    or ts.niveau = 'DG'
    or ts.niveau = 'DIR'
    or ts.niveau = 'SCE')
    and u.login = '${req.body.nom_utilisateur}'`

    const sql = `select 
    ts.child_id,
    ts.premier_responsable_id,
    ts.autorite_id,
    ts.child_libelle,
    ts.sigle,
    ts.niveau,
    c.email,
    c.phone
    from rohi.t_structure ts 
    LEFT join rohi.user u on ts.premier_responsable_id = u.id
    LEFT join rohi.candidat c on u.id = c.user_id
    where
    (ts.niveau = 'MIN'
    or ts.niveau = 'DG'
    or ts.niveau = 'DIR'
    or ts.niveau = 'SCE')
    and u.login = '${req.body.nom_utilisateur}'
    and ts.premier_responsable_id = (select 
    u.id
    from rohi.user u 
    where 
    u.password = (SELECT AES_ENCRYPT('${req.body.mot_de_passe}','lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau')));
    `
    
    rohi.query(email, function(err,result){
        if(err){
            return res.send({err})
        }
        else if(result.length == 0){
            // console.log(result.length)
            return res.json({message:`Votre nom d'utilisateur est incorrect`})
        }
        else {
            // return res.json(result)
            rohi.query(sql, function(err,result){
                if(err){
                    return res.send({err})
                }
                else if(result.length == 0){
                    // console.log(result.length)
                    return res.json({message:`Votre mot de passe est incorrect`})
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

router.post('/calendrier', async (req,res) =>{
    // const sql = `CALL calendrier_autorite(${req.body.id_autorite},${req.body.est_admin})`
    const sql = `CALL calendrier_autorite(${req.body.id_autorite})`
    db.query(sql,function(err,result){
        if(err){
            return res.send({ err });
        }
        else{
            return res.json(result[0])    
        }
    })
})

router.post('/filtre_calendrier', async (req,res) =>{
    // res.json(req.body)
    const autorite = req.body.autorite
    const sql = `CALL filtre_calendrier_evenement(
                '${req.body.date_debut}',
                '${req.body.date_fin}',
                '${req.body.type_evenement}',
                ${req.body.status},
                ${autorite.id_autorite_enfant}
            )`
    // res.json(sql)
    db.query(sql,function(err,result){
        if(err){
            return res.send({ err });
        }
        else{
            return res.json(result[0])    
        }
    })
})

router.post('/place_disponible', async (req,res) =>{
    const sql = `CALL places_disponible(${req.body.id_date_heure_disponible_autorite},${req.body.id_autorite})`
    // console.log(sql)
    // res.json(sql)
    db.query(sql,function(err,result){
        // console.log(result)
        if(err){
            return res.send({ err });
        }
        else{
            return res.json(result[0] )    
        }
    })
})

router.get('/liste',async(req,res)=>{
    let sql = `SELECT
    ae.id ,
    ae.intitule ,
    ae.intitule_code
    FROM
    ${db_name}.autorite_enfant ae`
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.send({ err });
        }
        else{
            return res.json(result)
        }
    });
})

router.get('/enfant/all/:id_autorite_enfant',async (req,res)=>{
    let sql = `SELECT id, intitule, intitule_code, id_autorite_parent
    FROM
        stage.autorite_enfant t where id != ${req.params.id_autorite_enfant}`
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.send({ err });
        }else{
            return res.json(result);
        }
    });
})

router.get('/enfant/all',async (req,res)=>{
    let sql = `SELECT id, intitule, intitule_code, id_autorite_parent
    FROM
        stage.autorite_enfant t`
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.send({ err });
        }else{
            return res.json(result);
        }
    });
})

router.get('/enfant/:id',async (req,res)=>{
    db.query(`SELECT id, intitule, intitule_code, id_autorite_parent
    FROM
        stage.autorite_enfant t where id =  ?`, [req.params.id], (err, results) => {             
        if(err) {
            console.log(err);
            res.send({message: err})
            // results(err, null);
        } else {
            res.json(results[0]);
        }
    });   
})

module.exports = router