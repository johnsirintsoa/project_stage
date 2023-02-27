const nodemailer = require('nodemailer')

const userMail = 'DRH.project.stage@gmail.com'
const mdp = 'dpirzakygtjdqrnl'

// user: 'mefstage2022@gmail.com',
// pass: 'wswrgxbntbumffqs'

const notification_audience_public = async (envoyeur,receiver) => {

    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure:false,
        auth: {
            user: userMail,
            pass: mdp
        }
    });
    
    let data = ''
    await transporter.sendMail({
        from: userMail,
        to: receiver.email,
        subject: `Demande d'audience`,
        html: `<p>Bonjour ${receiver.intitule_code}.</p> 
                <p>Vous avez une nouvelle audience. Un(e) certain(e) nommé(e)
                ${envoyeur.nom} ${envoyeur.prenom} au sujet de <strong>"${envoyeur.motif}"</strong>. Veuillez voir dans le site.</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const notification_demande_stage = async (envoyeur,receiver) => {

    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure:false,
        auth: {
            user: userMail,
            pass: mdp
        }
    });
    
    let data = ''
    await transporter.sendMail({
        from: userMail,
        to: receiver.email,
        subject: `Demande de stage`,
        html: `<p>Bonjour ${receiver.intitule_code}.</p> 
                <p>Un(e) certain(e) nommé(e)
                ${envoyeur.nom} ${envoyeur.prenom} a récemment déposé une demande de stage auprès de la sécretariat. 
                Si vous voulez plus de détails veuillez voir dans le site.</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const notification_audience_autorite = async(subject,envoyeur,receiver) =>{
    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure:false,
        auth: {
            user: userMail,
            pass: mdp
        }
    });

    let data = ''
    await transporter.sendMail({
        from: userMail,
        to: receiver.email,
        subject: `${subject}`,
        html: `<p>Bonjour ${receiver.sigle}.</p> 
                <p>La structure ${envoyeur.child_libelle} (${envoyeur.sigle}) a demandé à vous voir à propos d'un sujet: "<strong>${subject}</strong>". 
                Si vous voulez plus de détails veuillez voir dans le site.</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

module.exports = {
    notification_audience_public,
    notification_demande_stage,
    notification_audience_autorite
}