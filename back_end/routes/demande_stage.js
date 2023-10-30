const express = require('express')
const router = express.Router();
// const db = require('../database').conn
// const db_name = require('../database').db_name

const rohiPool = require('../database').rohi
const rohiAudiencePool = require('../database').rohiAudience

const multer = require("multer")
const FUNC = require('../func/function')
// const FUNC = require('../func/function')
// const fs = require('fs')
// const candymail = require('candymail')
const nodemailer = require('nodemailer');
const path = require('path')
const fs = require('fs')
const { authJwt } = require("../middleware");


const notification_mailing = require('../Controllers/NotificationController')

require('dotenv/config')


// require('./.env')
// const baseURL = HOSTING_URL
// const env  = require('./.env')


// add form demande stage

// const maxSize = 2 * 1024 * 1024;
const storage = multer.diskStorage({
    destination: function(req,file,cb){
        // cb(null, baseURL+"/uploads/demande_stage");
        // cb(null, "./uploads/demande_stage");
        cb(null, "./home/rohiAudience.cyberpanel.net/demande_stage_files");


    },
    filename: function(req,file,cb){
        // console.log(file.originalname)
        cb(null, file.fieldname+"_"+Date.now()+"_"+file.originalname)
    }
});

// var upload = multer({
//     storage: storage,
//     limits: { fileSize: maxSize },
// });

var upload = multer({
    storage: storage
});


// Add demande de stage
router.post('/add',upload.fields([{name: 'curriculum_vitae'},{name: 'lettre_motivation'},{name: 'lettre_introduction'}]),async(req,res)=>{
    const prenomFormated = FUNC.upSetFirstLetter(req.body.prenom)
    const nomFormated = req.body.nom.toUpperCase()
    const all_file = req.files;
    if (!all_file) {
        return res.status(400).send({ message: 'Please upload a data.' });
    }else{
        // return res.status(200).send({ message: 'Nice we got it...' });
        // let sql = "INSERT INTO demande_stage(nom,prenom,e_mail,cin,telephone,duree,curriculum_vitae,lettre_motivation,lettre_introduction,message,id_domaine) VALUES ('"+req.body.nom+"','"+req.body.prenom+"','"+req.body.e_mail+"','"+req.body.cin+"','"+req.body.telephone+"','"+req.body.duree+"','"+req.files['curriculum_vitae'][0].filename+"','"+req.files['lettre_motivation'][0].filename+"','"+req.files['lettre_introduction'][0].filename+"','"+req.body.message+"','"+req.body.id_domaine+"')"
        // console.log(req.body)
        // console.log('Hahahaha')
        let sql = `INSERT INTO demande_stage(nom,prenom,etablissement,e_mail,cin,telephone,duree,curriculum_vitae,lettre_motivation,lettre_introduction,message,id_domaine,id_autorite_enfant,date_creation) VALUES ('${req.body.nom}','${prenomFormated}','${req.body.etablissement}','${req.body.e_mail}','${req.body.cin}','${req.body.telephone}','${req.body.duree}','${req.files['curriculum_vitae'][0].filename}','${req.files['lettre_motivation'][0].filename}','${req.files['lettre_introduction'][0].filename}','${req.body.message}',${req.body.id_domaine},${req.body.id_autorite_enfant},(SELECT CURDATE()))`
        
        rohiAudiencePool.then((rohiAudienceDB) => {
            rohiAudience.query(sql, async (err, result) =>{
                if(err){
                    // console.log('Hahahaha')
                    return res.json(err);
                }
                else{
                    const envoyeur = {
                        nom: nomFormated,
                        prenom: prenomFormated
                    }
                    const receiver = {
                        email: req.body.autoriteEmail,
                        intitule_code: req.body.autoriteSigle,
                        intitule: req.body.autorite,
                    }
                    const mail = await notification_mailing.notification_demande_stage(envoyeur,receiver)
                    return res.json(result);
                }
                rohiAudienceDB.release()
            });
        }).catch((err) => {
            throw err 
         });
    }
})

router.post('/liste',async(req,res)=>{
        let sql = `SELECT
        ds.id,
        ds.nom,
        ds.prenom,
        ds.duree, 
        ds.e_mail as addresse_electronique,
        d.nom_domaine,
        CASE 
            when eds.id IS NULL THEN 'Non validé'
            ELSE 'Validé'
        END as demande_status,
        eds.id as id_entretien_stage,
        dhda.id as id_date_heure_disponible_autorite
        FROM
        ${process.env.DB_APP}.demande_stage ds
        JOIN ${process.env.DB_APP}.domaine d on ds.id_domaine = d.id
        LEFT JOIN ${process.env.DB_APP}.entretien_demande_stage eds on ds.id = eds.id_demande_stage
        LEFT JOIN ${process.env.DB_APP}.date_heure_disponible_autorite dhda on eds.id_date_heure_disponible_autorite = dhda.id
        WHERE ds.id_autorite_enfant = ${req.body.id_autorite_enfant}
        GROUP BY ds.id`
    
    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql, function(err, result) {
            if(err){
                return res.json(err);
            }
            res.json(result)
            rohiAudienceDB.release()
        })
    }).catch((err) => {
        throw err 
     });


})

router.post('/filtre',[authJwt.verifyToken], async(req,res)=>{
    const sql = `CALL filtre_stage ('${req.body.date1}','${req.body.date2}','${req.body.nom}','${req.body.etablissement}',${req.body.id_domaine},${req.body.id_autorite})`
    // console.log(req.body)

    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql, function(err, result) {
            if(err){
                return res.json(err);
            }
            // console.log(sql)
            res.json(result[0])
            rohiAudienceDB.release()
        })
    }).catch((err) => {
        throw err 
     });
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
        demande_stage e 
        JOIN autorite_enfant ae on e.id_autorite_enfant = ae.id
        JOIN domaine d on e.id_domaine = d.id
        LEFT JOIN entretien_demande_stage eds on e.id = eds.id_demande_stage where e.id_autorite_enfant = ${req.params.id_autorite_enfant}`
    
    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql, function(err, result) {
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
            rohiAudienceDB.release()
        });
    }).catch((err) => {
        throw err 
     });
    

})

// detail demande de stages
router.post('/detail', [authJwt.verifyToken],async(req,res)=>{
    let sql = `
    SELECT 
        e.id,
        e.nom,
        e.prenom,
        e.etablissement,
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
        demande_stage e 
        JOIN domaine d on e.id_domaine = d.id	
        LEFT JOIN entretien_demande_stage eds on  e.id = eds.id_demande_stage
        WHERE e.id = ${req.body.id_demande_stage}`

    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql, function(err, result) {
            if(err){
                return res.json(err);
            }else{
                return res.json(result[0]);
            }
            rohiAudienceDB.release()
        })
    }).catch((err) => {
        throw err 
     });

})
  
// envoie mail
// router.post('/sendMail' , async(req,res)=>{
//     // const username = req.body.username
//     // const usermail = req.body.usermail
//     // const date_entretien = FUNC.date_in_string(req.body.date_entretien)
//     const username = 'RANDRIANARISON Johns'
//     const usermail = 'johnsirintsoa18@gmail.com'
//     const date_entretien = FUNC.date_in_string('2022-11-22T11:00:00')

//     // const FUNC.date_in_string(date_entretien)
//     try {
//         const transporter = nodemailer.createTransport({
//             host: 'smtp.gmail.com',
//             port: 587,
//             secure:false,
//             auth: {
//                 user: 'mefstage2022@gmail.com',
//                 pass: 'wswrgxbntbumffqs'
//             }
//         });
        
//         // send email
//         await transporter.sendMail({
//             from: 'mefstage2022@gmail.com',
//             to: usermail,
//             subject: 'Demande approuvé et lu',
//             text: `Bonjour ${username}. Entretien ${date_entretien}`
//         });
//         res.send({message:'success'})
//     } catch (error) {
//         res.send(error)
//     }

// })

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


router.get('/file/:file_name',async(req,res)=>{

    // const directoryPath = HOSTING_URL + "/uploads/demande_stage";
    // fs.readdir(directoryPath, function (err, files) {
    //     if (err) {
    //         res.status(500).send({
    //             message: "Unable to scan files!",
    //         });
    //     }
    
    //     let fileInfos = [];
    
    //     files.forEach((file) => {
    //         fileInfos.push({
    //             name: file,
    //             url: baseUrl + file,
    //         });
    //     });
    
    //     res.status(200).send(fileInfos);
    // })
    // console.log(fs)
    
    
    // res.download(fileLocation, file);
    // console.log(HOSTING_URL)

    const file = req.params.file_name
    try {
        let fileLocation = path.join('./uploads/demande_stage/',file);
        // let fileLocation = path.join('./home/rohiAudience.cyberpanel.net/demande_stage_files/',file);
        res.download(fileLocation, file)
    } catch (error) {
        res.send(error)
    }
    
})

// Prolonger demande stage
router.post('/prolonger',[authJwt.verifyToken],async(req,res)=>{
    let sql = `call prolonger_duree_stage(${req.body.duree_en_plus},${req.body.id_entretien_stage})`
    
    rohiAudiencePool.then((rohiAudienceDB) => {
        rohiAudienceDB.query(sql, function(err, result) {
            if(err){
                return res.json(err);
            }
            else if(result.length > 0 ){
                res.json(result[0][0])
            }else{
                res.json(result)
            }
            rohiAudienceDB.release()
        })
    }).catch((err) => {
        throw err 
    });
})

module.exports = router