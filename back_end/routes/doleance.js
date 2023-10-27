const express = require('express')
const router = express.Router();
const db = require('../database').conn
const db_name = require('../database').db_name
const Function = require('../func/function')
const { authJwt } = require('../middleware');

require('dotenv/config')


// const Doleance = require('../models/Doleance')


router.post('/ajouter/anonyme', async(req,res) =>{
    const sql = `INSERT INTO doleance
        ( session_navigateur,titre,message,date_publication, id_autorite, sigle,child_libelle,heure_publication) 
        VALUES 
        ('${req.body.session_navigateur}','${req.body.titre}','${req.body.message}',(select curdate()) ,${req.body.id_autorite},'${req.body.sigle}','${req.body.autorite}',(SELECT SUBTIME(curtime(), "-3:0:0"))`
    db.query(sql,async (error,result) => {
        
        // db.release();

        // console.log(pool._freeConnections.indexOf(db)); 
        if(error) {
            res.send(error)
        }
        else if(result ){
            return res.json({message:'Doléance envoyé',result})
        }
    })
    // res.json(sql)
})

router.post('/ajouter/non_anonyme', async(req,res) =>{
    const nomFormated = req.body.nom.toUpperCase()
    const prenomFormated = Function.upSetFirstLetter(req.body.prenom)
    const sql = `INSERT INTO doleance
        ( session_navigateur,titre,message,date_publication, id_autorite, sigle,child_libelle,heure_publication,e_mail, cin, numero_telephone, nom, prenom) 
        VALUES 
        ('${req.body.session_navigateur}','${req.body.titre}','${req.body.message}',(select curdate()) ,${req.body.id_autorite},'${req.body.sigle}','${req.body.autorite}',(SELECT SUBTIME(curtime(), "-3:0:0"),'${req.body.e_mail}', '${req.body.cin}', '${req.body.numero_telephone}', '${nomFormated}', '${prenomFormated}')`
    db.query(sql,async (error,result) => {
        // db.release();

        if(error) {
            res.send(error)
        }
        else if(result ){
            return res.json({message:'Votre doléance a bien été enregistrée',result})
        }
    })
    // res.json(sql)
})

router.post('/modifier', async(req,res) =>{
    // console.log(req.body)
    const nomFormated = req.body.nom.toUpperCase()
    const prenomFormated = Function.upSetFirstLetter(req.body.prenom)
    let sql = ''
    if(req.body.type_doleance === 'Anonyme'){
        sql = `UPDATE doleance SET titre = '${req.body.titre}',message = '${req.body.message}',id_autorite = ${req.body.id_autorite}, nom = NULL, prenom = NULL, numero_telephone = NULL, cin = NULL, e_mail = NULL, child_libelle = '${req.body.child_libelle}' ,sigle ='${req.body.sigle}' where id = ${req.body.id};`
    } 
    else if (req.body.type_doleance === 'Non anonyme'){
        sql = `UPDATE doleance SET titre = '${req.body.titre}',message = '${req.body.message}',id_autorite = ${req.body.id_autorite}, nom = '${nomFormated}',prenom = '${prenomFormated}',numero_telephone = '${req.body.numero_telephone}',cin = '${req.body.cin}', e_mail = '${req.body.e_mail}', child_libelle = '${req.body.child_libelle}' ,sigle ='${req.body.sigle}' where id = ${req.body.id};`
    }
    // const sql = `UPDATE doleance SET titre = '${req.body.titre}',message = '${req.body.message}',id_autorite = ${req.body.id_autorite}, nom = '${req.body.nom}',prenom = '${req.body.prenom}',numero_telephone = '${req.body.numero_telephone}',cin = '${req.body.cin}', e_mail = '${req.body.e_mail}', child_libelle = '${req.body.child_libelle}' ,sigle ='${req.body.sigle}' where id = ${req.body.id};`
    // res.json(sql)
    db.query(sql,async (error,result) => {
        // db.release();

        if(error) {
            res.send(error)
        }
        else if(result ){
            return res.json({message:'Votre doléance a bien été modifiée',result})
        }
    })
    // res.json(sql)
})

router.get('/supprimer/:id', async(req,res) =>{
    const sql = `delete from ${db_name}.doleance where id = ${req.params.id};`
    // res.json(sql)
    db.query(sql,async (error,result) => {
        // db.release();

        if(error) {
            res.send(error)
        }
        else if(result ){
            return res.json({message:'Votre doléance a bien été supprimée',result})
        }
    })
})

router.post('/filtre', [authJwt.verifyToken] ,async(req,res)=>{
    const sql = `CALL filtre_doleance('${req.body.date1}','${req.body.date2}',${req.body.type_doleance},${req.body.nbr_filtre},${req.body.id_autorite})`
    // console.log(sql)
    var query = db.query(sql, function(err, result) {
        // db.release();

        if(err){
            return res.json({err});
        }
        else{
            res.json(result[0])
        }
    })
})


router.post('/liste/public',async (req,res)=>{
    // const sql = `call liste_doleances_public ('${req.body.session_navigateur}')`
    const sql = `	select
	d.id as id,
	d.titre as titre,
	d.message as message,
	concat(d.date_publication,' ',d.heure_publication) as date_heure_publication,
	d.nom as nom,
	d.prenom as prenom,
	d.cin as cin,
	d.numero_telephone as numero_telephone,
	d.e_mail as addresse_electronique,
	CASE 
		WHEN d.nom IS NULL or d.prenom IS NULL or d.cin IS NULL or d.e_mail IS NULL or d.numero_telephone IS NULL THEN 'Anonyme'
		ELSE 'Non anonyme' 
	END as type_doleance,
	d.id_autorite as t_structure_id,
	d.child_libelle,
	d.sigle 
	from doleance d 
	where 
	d.session_navigateur = '${req.body.session_navigateur}'
	and d.date_publication = (select curdate())`
    var query = db.query(sql, function(err, result) {
        // db.release();

        if(err){
            return res.json({err});
        }
        else{
            res.json(result)
        }
    })
})

module.exports = router