const express = require('express')
const router = express.Router();
const db = require('../database')
const multer = require("multer")
const mailing = require('nodemailer')
// const fs = require('fs')
const path = require('path')


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

// send mail
router.post('/sendMail',async(req,res)=>{

    // console.log('Send mail...')
    // console.log(req.body)
    const template ={
        from: "mefstage2022@gmail.com",
        to : req.body.e_mail,
        subject: "Demande d'entretien",
        text: "Bonjour "+req.body.fullName+". Après avoir lu et analysé votre demande, notre organisation souhaite entretenir avec vous le "+req.body.date_entretien,
        html: "<p>Bonjour "+req.body.fullName+". Après avoir lu et analysé votre demande, notre organisation souhaite entretenir avec vous le "+req.body.date_entretien+"</p>"
    }

    const transporter = mailing.createTransport({
        host: "smtp.mailtrap.io",
        port: 2525,
        auth: {
          user: "277137be14334d",
          pass: "da8abd5d092b46"
        }
      });
    // const transporter = mailing.createTransport({
    //     service: 'gmail',
    //     auth: {
    //         user: 'mefstage2022@gmail.com',
    //         pass: '123mefstage'
    //     }
    // });

    transporter.sendMail(template,function(err,info){
        if(err){
            reponseObj = {
                "status":"error",
                "message":err,
                "body":{}
            }
            res.send(reponseObj)
        }else{
            reponseObj = {
                "status":"succes",
                "message":info,
                "body":{}
            }
            res.send(reponseObj)
        }
    })
    // console.log(transporter)
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