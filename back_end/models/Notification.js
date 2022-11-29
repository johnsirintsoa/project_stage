const webpush = require('web-push');

const publicKey = 'BKzekbNOwWpdkh0yo4yyponMzZ1hXlvjt0fY7cOzjn5VJ0mYBWjQ4JCp80ElRjgBkUGXFYWtaESCDnxjmVBi4c0'
const privateKey = 'zTfAuXgbMohXuoksVpiAi5j70AwJw1qLrW-brRvDRpg'

const gmcKey = 'AIzaSyBMD1yAkoeJKarkdgxXPtNCY2x-V3d8sAQ'


// VAPID keys should be generated only once.

const generateKeys = () =>{
    const vapidKeys = webpush.generateVAPIDKeys();

    return vapidKeys
}

const sendNotifications = (subscription,payload,email_autorite) => {

    webpush.setGCMAPIKey(gmcKey);
    webpush.setVapidDetails(`mailto:${email_autorite}`, publicKey,privateKey);

    //pass the object into sendNotification
    let data = ''
    webpush.sendNotification(subscription, payload)
        .then(result =>{
            data = result
            console.log(result)
        })
        .catch(err=> {
            data = err
            console.log(err)
        });
    return data
}

module.exports = {
    generateKeys,
    sendNotifications
}