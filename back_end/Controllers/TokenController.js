const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const func = require('../func/function')
/**
 * Generate an initial token 
 * store the token generated into a cache or sessionStorage 
*/


const generateToken = (req,res)=>{
    const nbr = func.genererNbr()
    // const token = nbr
    const token =  {
        id:Date.now(),
        userEmail:'example@gmail.com',
        password:'123'
    }
    const token_generer = jwt.sign(token,'secretkey')
    jwt.verify(token_generer, 'secretkey', (err,token) => {
        if(err){
            console.log(err)
            return res.json(err)
        }
        else if(token){
            return res.json(token)
        }
    })
}

// const verifierToken = (token) =>{
//     jwt.verify(token, 'secret-token', (err,token) => {
//         if(err){
//             console.log(err)
//             return false
//         }
//         else if(token){
//             return true
//         }
//     })
// }

function verifyToken(req,res,next){
    //Auth header value = > send token into header

    const bearerHeader = req.headers['authorization'];
    //check if bearer is undefined
    if(typeof bearerHeader !== 'undefined'){

        //split the space at the bearer
        const bearer = bearerHeader.split(' ');
        //Get token from string
        const bearerToken = bearer[1];

        //set the token
        req.token = bearerToken;

        //next middleweare
        next();

    }else{
        //Fobidden
        res.sendStatus(403);
    }

}
module.exports = {
    verifyToken,
    generateToken
}