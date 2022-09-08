const express = require('express')
const router = express.Router();
const db = require('../database')
const multer = require("multer")
const mail = require('mail')
const FUNC = require('../func/function')
// const FUNC = require('../func/function')
// const fs = require('fs')
// const candymail = require('candymail')
const nodemailer = require('nodemailer');
const path = require('path')
require('./.env')

/** config vonage */
const Vonage = require('@vonage/server-sdk');
const { date } = require('mail/lib/util');
const { default: Function } = require('../func/function');

const vonage = new Vonage({
  apiKey: "895a4ee2",
  apiSecret: "4CE7jeUCH8td8UcX"
})
/** config vonage */


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
        let sql = "INSERT INTO demande_stage(nom,prenom,e_mail,cin,telephone,duree,curriculum_vitae,lettre_motivation,lettre_introduction,message,id_domaine) VALUES ('"+req.body.nom+"','"+req.body.prenom+"','"+req.body.e_mail+"','"+req.body.cin+"','"+req.body.telephone+"','"+req.body.duree+"','"+req.files['curriculum_vitae'][0].filename+"','"+req.files['lettre_motivation'][0].filename+"','"+req.files['lettre_introduction'][0].filename+"','"+req.body.message+"','"+req.body.id_domaine+"')"
        var query = db.query(sql, function(err, result) {
            if(err){
                return res.json(err);
            }else{
                return res.json(result);
            }
        });
    }
})

// liste des demandes stages status
router.get('/all_status',async(req,res)=>{
    let sql = "SELECT demande_stage.id,CONCAT(demande_stage.nom,' ',demande_stage.prenom)as fullName,demande_stage.e_mail,domaine.nom_domaine,demande_stage.duree,demande_stage.curriculum_vitae,demande_stage.lettre_motivation,demande_stage.lettre_introduction,CASE WHEN rendez_vous_directeur.id_demande_stage IS NULL THEN 'en attente' ELSE 'valide' END as demande_status FROM demande_stage inner join domaine on demande_stage.id_domaine = domaine.id left join rendez_vous_directeur on demande_stage.id = rendez_vous_directeur.id_demande_stage";
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.json(err);
        }else{
            return res.json(result);
        }
    });
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
  
// envoie mail
router.post('/sendMail' , async(req,res)=>{
    const username = req.body.username
    const usermail = req.body.usermail
    const date_entretien = FUNC.date_in_string(req.body.date_entretien)

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

module.exports = router