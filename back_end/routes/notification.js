const express = require('express')
const router = express.Router();
const notification_controller = require('../Controllers/NotificationController')

// router.get('/autorite/non_valide',(req,res)=>{
//     res.json(notification_controller.getNotifications())
// })

router.post('/autorite/non_valide',(req,res)=>{
    const subscription = {
        endpoint:'http://127.0.0.1:5173/demande-audience/autorite/1',
        nom : req.body.nom,
        prenom: req.body.prenom
    }
    const email = req.body.email
    const payload = JSON.stringify({title: 'Section.io Push Notification' });

    //send status 201
    res.status(201).json({})

//    res.json(notification_controller.generateKeys())
   res.json(notification_controller.getNotifications(subscription,payload,email))
})


module.exports = router