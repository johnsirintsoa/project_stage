const express = require('express')
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const tokenController = require('../Controllers/TokenController')

router.get('/generer', async(req,res) =>{
   return res.json(tokenController.generateToken(req,res))
})

router.get('/profile',tokenController.verifyToken,(req,res)=>{

   jwt.verify(req.token,'secretkey',(err,authData)=>{
       if(err)
           res.sendStatus(403);
       else{
           res.json({
               message:"Welcome to Profile",
               userData:authData
           })
          
       }
   })
 
});
module.exports = router