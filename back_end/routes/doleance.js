const express = require('express')
const router = express.Router();
const db = require('../database').conn
const db_name = require('../database').db_name
const Doleance = require('../models/Doleance')

// router.get('/all',async (req,res)=>{
//     res.send('Hello world')
// })

router.post('/ajouter/anonyme', async(req,res) =>{
    const sql = `INSERT INTO doleance
        ( session_navigateur,titre,message,date_publication, id_autorite, heure_publication) 
        VALUES 
        ('${req.body.session_navigateur}','${req.body.titre}','${req.body.message}',(select curdate()) ,${req.body.autorite},(SELECT CURTIME()))`
    db.query(sql,async (error,result) => {
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
    const sql = `INSERT INTO doleance
        ( session_navigateur,titre,message,date_publication, id_autorite, heure_publication,e_mail, cin, numero_telephone, nom, prenom) 
        VALUES 
        ('${req.body.session_navigateur}','${req.body.titre}','${req.body.message}',(select curdate()) ,${req.body.autorite},(SELECT CURTIME()),'${req.body.e_mail}', '${req.body.cin}', '${req.body.numero_telephone}', '${req.body.nom}', '${req.body.prenom}')`
    db.query(sql,async (error,result) => {
        if(error) {
            res.send(error)
        }
        else if(result ){
            return res.json({message:'Votre doléance a bien été enregistrée',result})
        }
    })
    // res.json(sql)
})

router.post('/modifier/anonyme', async(req,res) =>{
    const sql = `
    UPDATE doleance SET titre = '${req.body.titre}',message = '${req.body.message}',id_autorite = ${req.body.id_autorite} where id = ${req.body.id};
    `
    // res.json(sql)
    db.query(sql,async (error,result) => {
        if(error) {
            res.send(error)
        }
        else if(result ){
            return res.json({message:'Votre doléance a bien été modifiée',result})
        }
    })
    // res.json(sql)
})

router.post('/filtre',async(req,res)=>{
    const sql = `CALL filtre_doleance('${req.body.date1}','${req.body.date2}',${req.body.type_doleance},${req.body.nbr_filtre},${req.body.id_autorite})`
    // console.log(sql)
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.json({err});
        }
        else{
            res.json(result[0])
        }
    })
})

// filter doleance entre 2 date
router.get('/filter/:first_date/:second_date/:direction',async (req,res)=>{
    const first_date =  req.params.first_date.concat('T00:00:00Z')
    const second_date =  req.params.second_date.concat('T00:00:00Z')
    const direction = req.params.direction
    console.log(first_date)
    console.log(second_date)
    try {
        const doleances = await Doleance.find(
            {
                date_publication:{
                    $gte: first_date, 
                    $lte: second_date 
                },direction: direction
            }).sort({date_publication: -1})
        res.json(doleances)
    } catch (err) {
        res.json({message: err})
    }
})

// get all doleance
router.get('/all',async (req,res)=>{
    try {
        const doleances = await Doleance.find().sort({date_publication: -1})
        res.json(doleances)
    } catch (err) {
        res.json({message: err})
    }
})

router.post('/liste/public',async (req,res)=>{
    const sql = `call liste_doleances_public ('${req.body.session_navigateur}')`
    var query = db.query(sql, function(err, result) {
        if(err){
            return res.json({err});
        }
        else{
            res.json(result[0])
        }
    })
})

// get doleance by session
router.get('/my_doleances/:session',async (req,res)=>{
    // res.json('hello wolrd')
    try {
        const doleances = await Doleance.find({session_navigateur: req.params.session}).sort({date_publication: -1})
        res.json(doleances)
    } catch (err) {
        res.json({message: err})
    }
})

// add doleance
router.post('/add',async (req,res) => {
    const doleance = new Doleance({
        nom: req.body.nom,
        prenom: req.body.prenom,
        e_mail: req.body.e_mail,
        cin: req.body.cin,
        numero_telephone:req.body.numero_telephone,
        titre: req.body.titre,
        message: req.body.message,
        direction: req.body.direction,
        session_navigateur: req.body.session_navigateur
    })
    try {
        const savedDoleance = await doleance.save()
        res.json(savedDoleance)
    } catch (err) {
        res.json({message: err})
    }
})

// detail doleance
router.get('/detail/:doleance_id',async (req,res) => {
    try {
        const doleance = await Doleance.findById(req.params.doleance_id)
        res.json(doleance)
    } catch (err) {
        res.json({message: err})
    }
})

// detail doleance
router.delete('/delete/:doleance_id',async (req,res) => {
    try {
        await Doleance.deleteOne({_id: req.params.doleance_id})
        res.json(doleance)
    } catch (err) {
        res.json({message: err})
    }
})

// Update doleance
router.patch('/update/:doleance_id',async (req,res) => {
    try {
        const updateDoleance = await Doleance.updateOne(
            {_id: req.params.doleance_id},
            {$set:{
                nom: req.body.nom,
                prenom: req.body.prenom,
                e_mail: req.body.e_mail,
                cin: req.body.cin,
                titre: req.body.titre,
                message: req.body.message,
                direction: req.body.direction
            }}
        )
        res.json(updateDoleance)
    } catch (err) {
        res.json({message: err})
    }
})
module.exports = router