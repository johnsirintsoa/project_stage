const autorite = require('../models/Autorite')
const bcrypt = require('bcrypt')

const login = async function (req,res){
    try {
        const {nom_utilisateur, mot_de_passe} = req.body
        if(!nom_utilisateur ||  !mot_de_passe){
            return res.json({message: "Nom d'utilisateur ou mot de passe vide"})
        }
        else {
            let user = await autorite.login(nom_utilisateur,mot_de_passe)
            return res.send(user)
        }          
    } catch (error) {
        throw error
    }
 
}

module.exports = {
    login
}