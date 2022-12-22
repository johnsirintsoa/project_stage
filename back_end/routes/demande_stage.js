const express = require('express')
const router = express.Router();
const db = require('../database')
const multer = require("multer")
const FUNC = require('../func/function')
// const FUNC = require('../func/function')
// const fs = require('fs')
// const candymail = require('candymail')
const nodemailer = require('nodemailer');
const path = require('path')
require('./.env')


// add form demande stage
const storage = multer.diskStorage({
    destination: function(req,file,cb){
        cb(null, "./uploads/demande_stage");
    },
    filename: function(req,file,cb){
        cb(null, file.fieldname+"_"+Date.now()+"_"+file.originalname)
    }
});

var upload = multer({
    storage: storage
});

// Add demande de stage
router.post('/add',upload.fields([{name: 'curriculum_vitae'},{name: 'lettre_motivation'},{name: 'lettre_introduction'}]),async(req,res)=>{
    const all_file = req.files;
    if (!all_file) {
        return res.status(400).send({ message: 'Please upload a data.' });
    }else{
        // return res.status(200).send({ message: 'Nice we got it...' });
        // let sql = "INSERT INTO demande_stage(nom,prenom,e_mail,cin,telephone,duree,curriculum_vitae,lettre_motivation,lettre_introduction,message,id_domaine) VALUES ('"+req.body.nom+"','"+req.body.prenom+"','"+req.body.e_mail+"','"+req.body.cin+"','"+req.body.telephone+"','"+req.body.duree+"','"+req.files['curriculum_vitae'][0].filename+"','"+req.files['lettre_motivation'][0].filename+"','"+req.files['lettre_introduction'][0].filename+"','"+req.body.message+"','"+req.body.id_domaine+"')"
        let sql = `INSERT INTO demande_stage(nom,prenom,e_mail,cin,telephone,duree,curriculum_vitae,lettre_motivation,lettre_introduction,message,id_domaine,id_autorite_enfant) VALUES ('${req.body.nom}','${req.body.prenom}','${req.body.e_mail}','${req.body.cin}','${req.body.telephone}','${req.body.duree}','${req.files['curriculum_vitae'][0].filename}','${req.files['lettre_motivation'][0].filename}','${req.files['lettre_introduction'][0].filename}','${req.body.message}',${req.body.id_domaine},${req.body.id_autorite_enfant})`
        var query = db.query(sql, function(err, result) {
            if(err){
                return res.json(err);
            }else{
                return res.json(result);
            }
        });
    }
})

router.post('/liste',async(req,res)=>{
    let sql = `SELECT
    ds.id,
    ds.nom,
    ds.prenom,
    ds.duree, 
    d.nom_domaine,
    CASE 
        when eds.id IS NULL THEN 'Non validé'
        ELSE 'Validé'
    END as demande_status,
    eds.id as id_entretien_stage
    FROM
    stage5.demande_stage ds
    JOIN stage5.domaine d on ds.id_domaine = d.id
    LEFT JOIN stage5.entretien_demande_stage eds on ds.id = eds.id_demande_stage
    WHERE ds.id_autorite_enfant = ${req.body.id_autorite_enfant}`
    
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.json(err);
        }
        res.json(result)
        // else if(result.length > 0 ){
        //     res.json(result[0][0])
        // }else{
        //     res.json(result)
        // }
    })
})


// liste des demandes stages status
router.get('/all_status/:id_autorite_enfant',async(req,res)=>{
    let sql = `
    SELECT 
        e.id as id_demande_stage,
        e.nom, 
        e.prenom,
        e.telephone, 
        e.e_mail,
        e.cin,
        e.duree, 
        e.curriculum_vitae, 
        e.lettre_motivation, 
        e.lettre_introduction, 
        e.message, 
        d.id as id_domaine,
        d.nom_domaine,
        eds.id as id_entretien_demande_stage,
        eds.date_debut,
        eds.date_fin,
        eds.time_debut,
        eds.time_fin,
        e.id_autorite_enfant,
        ae.intitule,
        ae.addresse_electronique,
        ae.mot_de_passe_mailing,
        ae.intitule_code,
        ae.porte,
        CASE 
            WHEN eds.id IS NULL THEN 'en attente' 
            ELSE 'validé' END as demande_status
    FROM
        stage.demande_stage e 
        JOIN autorite_enfant ae on e.id_autorite_enfant = ae.id
        JOIN domaine d on e.id_domaine = d.id
        LEFT JOIN entretien_demande_stage eds on e.id = eds.id_demande_stage where e.id_autorite_enfant = ${req.params.id_autorite_enfant}`
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.json(err);
        }else{
            const array_result = []
            result.forEach(element => {
                if(element.id_entretien_demande_stage != null){
                    array_result.push({
                        id_demande_stage: element.id_demande_stage,
                        nom: element.nom,
                        prenom: element.prenom,
                        telephone: element.telephone,
                        e_mail: element.e_mail,
                        cin: element.cin,
                        duree: element.duree,
                        curriculum_vitae: element.curriculum_vitae,
                        lettre_motivation: element.lettre_motivation,
                        lettre_introduction: element.lettre_introduction,
                        message: element.message,
                        autorite:{
                            id_autorite: element.id_autorite_enfant,
                            intitule: element.intitule,
                            intitule_code: element.intitule_code,
                            addresse_electronique: element.addresse_electronique,
                            mot_de_passe_mailing: element.mot_de_passe_mailing,
                            porte: element.porte
                        },
                        id_domaine: element.id_domaine,
                        nom_domaine: element.nom_domaine,
                        date_debut: element.date_debut,
                        date_fin: element.date_fin,
                        time_debut: element.time_debut,
                        time_fin: element.time_fin,
                        id_entretien_demande_stage: element.id_entretien_demande_stage,
                        demande_status: element.demande_status
                    })
                }
                else if(element.id_entretien_demande_stage == null){
                    array_result.push({
                        id_demande_stage: element.id_demande_stage,
                        nom: element.nom,
                        prenom: element.prenom,
                        telephone: element.telephone,
                        e_mail: element.e_mail,
                        cin: element.cin,
                        duree: element.duree,
                        curriculum_vitae: element.curriculum_vitae,
                        lettre_motivation: element.lettre_motivation,
                        lettre_introduction: element.lettre_introduction,
                        message: element.message,
                        autorite:{
                            id_autorite: element.id_autorite_enfant,
                            intitule: element.intitule,
                            intitule_code: element.intitule_code,
                            addresse_electronique: element.addresse_electronique,
                            mot_de_passe_mailing: element.mot_de_passe_mailing,
                            porte: element.porte
                        },
                        id_domaine: element.id_domaine,
                        nom_domaine: element.nom_domaine,
                        demande_status: element.demande_status
                    })                    
                }
            });
            return res.json(array_result);
        }
    });
})

// detail demande de stages
router.post('/detail',async(req,res)=>{
    let sql = `
    SELECT 
        e.id,
        e.nom,
        e.prenom, 
        e.telephone, 
        e.e_mail, 
        e.cin, 
        e.duree,
        e.curriculum_vitae, 
        e.lettre_motivation,
        e.lettre_introduction,
        e.message, 
        d.id, 
        d.nom_domaine,
        e.id_autorite_enfant,
        IFNULL(eds.id,'0') as id_entretien_stage
    FROM
        stage.demande_stage e 
            JOIN domaine d on e.id_domaine = d.id	
            LEFT JOIN entretien_demande_stage eds on  e.id = eds.id_demande_stage
            where id_autorite_enfant = ${req.body.id_autorite_enfant} and e.id = ${req.body.id_demande_stage}`
    
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.json(err);
        }else{
            return res.json(result[0]);
        }
    })
})
  
// envoie mail
router.post('/sendMail' , async(req,res)=>{
    // const username = req.body.username
    // const usermail = req.body.usermail
    // const date_entretien = FUNC.date_in_string(req.body.date_entretien)
    const username = 'RANDRIANARISON Johns'
    const usermail = 'johnsirintsoa18@gmail.com'
    const date_entretien = FUNC.date_in_string('2022-11-22T11:00:00')

    // const FUNC.date_in_string(date_entretien)
    try {
        const transporter = nodemailer.createTransport({
            host: 'smtp.gmail.com',
            port: 587,
            secure:false,
            auth: {
                user: 'mefstage2022@gmail.com',
                pass: 'wswrgxbntbumffqs'
            }
        });
        
        // send email
        await transporter.sendMail({
            from: 'mefstage2022@gmail.com',
            to: usermail,
            subject: 'Demande approuvé et lu',
            text: `Bonjour ${username}. Entretien ${date_entretien}`
        });
        res.send({message:'success'})
    } catch (error) {
        res.send(error)
    }

})

// send SMS
router.post('/sendSms', async(req,res)=>{
    const from = "MEF"
    const to = "261".concat(req.body.numero_telephone)
    const text = 'Bonjour '.concat(req.body.fullName,'. Après avoir lu et analysé votre demande, nous voulons entretenir avec vous le ',req.body.date_entretien.replace('T',' '),' au sein de notre organisation.')

    // res.send({message:text})
    vonage.message.sendSms(from, to, text, (err, responseData) => {
        if (err) {
            console.log(err);
        } else {
            if(responseData.messages[0]['status'] === "0") {
                res.send({message:"success"});
                console.log("Message sent successfully.")
            } else {
                res.send({message:"failed"})
                console.log(`Message failed with error: ${responseData.messages[0]['error-text']}`);
            }
        }
    })
})

// get file 
router.get('/file/:file_name',async(req,res)=>{
    let file = req.params.file_name;
    // console.log(file)
    try {
        let fileLocation = path.join('./uploads/demande_stage/',file);
        res.download(fileLocation, file);
    } catch (error) {
        res.send(error)
    }
})

// Prolonger demande stage
router.post('/prolonger',async(req,res)=>{
    let sql = `call prolonger_duree_stage(${req.body.duree_en_plus},${req.body.id_entretien_stage})`
    
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.json(err);
        }
        else if(result.length > 0 ){
            res.json(result[0][0])
        }else{
            res.json(result)
        }
    })
})

module.exports = router