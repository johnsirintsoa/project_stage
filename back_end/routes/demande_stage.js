const express = require('express')
const router = express.Router();
const db = require('../database')
const multer = require("multer")

let storage = multer.diskStorage({
    destination: function(req,file,cb){
        cb(null, "./uploads/demande_stage");
    },
    filename: function(req,file,cb){
        cb(null, file.fieldname+"_"+Date.now()+"_"+file.originalname)
    }
})

let upload_pdf_stage = multer({
    storage: storage
}).fields([{name: 'curriculum_vitae'},{name: 'lettre_motivation'},{name: 'lettre_introduction'}])


router.post('/add',upload_pdf_stage,async (req,res)=>{
    // console.log(req.body)
    // console.log(req.files)
    console.log('All files here...')
    // console.log(upload_pdf_stage.length)
    // let demande_stage = {
    //     nom: req.body.nom,
    //     prenom: req.body.prenom,
    //     e_mail: req.body.e_mail,
    //     cin: req.body.cin,
    //     telephone:req.body.telephone,
    //     duree: req.body.duree,
    //     curriculum_vitae: req.files['curriculum_vitae'][0].filename,
    //     lettre_motivation: req.files['lettre_motivation'][0].filename,
    //     lettre_introduction: req.files['lettre_introduction'][0].filename,
    //     message: req.body.message,
    //     id_domaine: req.body.id_domaine
    // }
    // console.log(req)
    let sql = "INSERT INTO demande_stage(nom,prenom,e_mail,cin,telephone,duree,curriculum_vitae,lettre_motivation,lettre_introduction,message,id_domaine) VALUES ('"+req.body.nom+"','"+req.body.prenom+"','"+req.body.e_mail+"','"+req.body.cin+"','"+req.body.telephone+"','"+req.body.duree+"','"+req.files['curriculum_vitae'][0].filename+"','"+req.files['lettre_motivation'][0].filename+"','"+req.files['lettre_introduction'][0].filename+"','"+req.body.message+"','"+req.body.id_domaine+"')"

    // console.log(sql)
    // console.log(demande_stage)

    try {
        // let sql = "INSERT INTO demande_stage(nom,prenom,e_mail,cin,telephone,duree,curriculum_vitae,lettre_motivation,lettre_introduction,message,id_domaine) VALUES ('"+demande_stage.nom+"','"+demande_stage.prenom+"','"+demande_stage.e_mail+"','"+demande_stage.cin+"','"+demande_stage.telephone+"','"+demande_stage.duree+"','"+demande_stage.curriculum_vitae+"','"+demande_stage.lettre_motivation+"','"+demande_stage.lettre_introduction+"','"+demande_stage.message+"','"+demande_stage.id_domaine+"')"
        const stage = await db.promise().query(sql)
        res.json(stage)
    } catch (err) {
        res.json({message: err})
    }
})

// liste des demandes stages status
router.get('/all_status',async(req,res)=>{
    let sql = "SELECT demande_stage.id,CONCAT(demande_stage.nom,' ',demande_stage.prenom)as fullName,domaine.nom_domaine,demande_stage.duree,CASE WHEN rendez_vous_directeur.id_demande_stage IS NULL THEN 'en attente' ELSE 'valide' END as demande_status FROM demande_stage inner join domaine on demande_stage.id_domaine = domaine.id left join rendez_vous_directeur on demande_stage.id = rendez_vous_directeur.id_demande_stage";
    try {
        const stage = await db.promise().query(sql)
        res.json(stage[0])
    } catch (err) {
        res.json({message: err})
    }
})

// detail demande de stages
router.get('/detail/:id',async(req,res)=>{
    let sql = "SELECT demande_stage.id,demande_stage.nom,demande_stage.prenom,demande_stage.telephone,demande_stage.e_mail,demande_stage.cin,demande_stage.duree,demande_stage.curriculum_vitae ,demande_stage.lettre_motivation ,demande_stage.lettre_introduction ,demande_stage.message,domaine.nom_domaine from demande_stage inner join domaine on demande_stage.id_domaine = domaine.id where demande_stage.id ='".concat(req.params.id,"'");
    try {
        const stage = await db.promise().query(sql)
        res.json(stage[0])
    } catch (err) {
        res.json({message: err})
    }
})

module.exports = router