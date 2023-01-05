const express = require('express')
const router = express.Router();
const Direction = require('../models/Direction')
const db = require('../database').conn
const db_name = require('../database').db_name

// router.get('/all',async (req,res)=>{
//     res.send('Hello world')
// })


// get all doleance direction from mongoDB
router.get('/all',async (req,res)=>{
    try {
        const directions = await Direction.find()
        res.json(directions)
    } catch (err) {
        res.json({message: err})
    }
})

// direction from MySQL
router.get('/mysql/all',async (req,res)=>{
    db.query("SELECT id, intitule,intitule_code FROM stage.direction ", null, (err, results) => {             
        if(err) {
            console.log(err);
            res.send({message: err})
            // results(err, null);
        } else {
            res.json(results);
        }
    });
})

router.get('/mysql/:id',async (req,res)=>{
    db.query("SELECT id, intitule FROM stage.direction n WHERE id = ?", [req.params.id], (err, results) => {             
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