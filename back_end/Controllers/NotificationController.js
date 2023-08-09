const notification = require('../models/Notification')

const notification_audience_public = async (envoyeur,receiver) =>{
    return await notification.notification_audience_public(envoyeur,receiver)
}

const notification_demande_stage = async (envoyeur,receiver) =>{
    return await notification.notification_demande_stage(envoyeur,receiver)
}

const notification_audience_autorite = async (subject,envoyeur,receiver) =>{
    return await notification.notification_audience_autorite(subject,envoyeur,receiver)
}

const notification_audience_agent = async (envoyeur,receiver) =>{
    return await notification.notification_audience_agent(envoyeur,receiver)
}
module.exports = {
    notification_audience_public,
    notification_demande_stage,
    notification_audience_autorite,
    notification_audience_agent
}