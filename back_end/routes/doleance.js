const express = require('express')
const router = express.Router();
const Doleance = require('../models/Doleance')

// router.get('/all',async (req,res)=>{
//     res.send('Hello world')
// })

// filter doleance entre 2 date
router.get('/filter/:first_date/:second_date',async (req,res)=>{
    const first_date =  req.params.first_date.concat('T00:00:00Z')
    const second_date =  req.params.second_date.concat('T00:00:00Z')

    try {
        const doleances = await Doleance.find({date_publication:{
            $gte: first_date, 
            $lte: second_date 
        }}).sort({date_publication: -1})
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
        await Doleance.remove({_id: req.params.doleance_id})
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