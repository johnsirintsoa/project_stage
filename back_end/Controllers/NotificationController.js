const notification = require('../models/Notification')

const getNotifications = (subscription,payload,email_autorite) =>{
    return notification.sendNotifications(subscription,payload,email_autorite)
}

const generateKeys = (subscription,email_autorite) =>{
    return notification.generateKeys()
}


module.exports = {
    getNotifications,
    generateKeys
}