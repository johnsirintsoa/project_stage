const FUNC = require('../func/function')
const nodemailer = require('nodemailer')

// const entretien_valide = async (autorite,stagiaire,entretien_date_time) =>{
//     const autorite_mail = {
//         user: autorite.addresse_electronique,
//         pass: autorite.mot_de_passe_mailing
//     }
//     const date_entretien = FUNC.date_in_string(entretien_date_time)
//     try {
//         const transporter = nodemailer.createTransport({
//             host: 'smtp.gmail.com',
//             port: 587,
//             secure:false,
//             auth: {
//                 user: autorite_mail.user,
//                 pass: autorite_mail.pass
//                 // user: 'mefstage2022@gmail.com',
//                 // pass: 'wswrgxbntbumffqs'
//             }
//         });
        
//         // send email
//         await transporter.sendMail({
//             from: autorite_mail.user,
//             to: stagiaire.e_mail,
//             subject: 'Demande de stage approuvé et lu',
//             html: `<p>Bonjour ${stagiaire.nom} ${stagiaire.prenom}.</p> 
//                     <p>Vous avez un entretien avec le ${autorite.intitule}(${autorite.intitule_code}) le ${date_entretien} 
//                     Porte <strong>${autorite.porte}</strong></p>`
//         });
//         return {message:'success'}
//     } catch (error) {
//         return error
//     }
// }

const entretien_valide = async (autorite,stagiaire,entretien_date_time) =>{
    const autorite_mail = {
        user: autorite.addresse_electronique,
        pass: autorite.mot_de_passe_mailing
    }
    const date_entretien = FUNC.date_in_string(entretien_date_time)
    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure:false,
        auth: {
            user: autorite_mail.user,
            pass: autorite_mail.pass
            // user: 'mefstage2022@gmail.com',
            // pass: 'wswrgxbntbumffqs'
        }
    });
    
    let data = ''
    // send email
    await transporter.sendMail({
        from: autorite_mail.user,
        to: stagiaire.e_mail,
        subject: 'Demande de stage approuvé et lu',
        html: `<p>Bonjour ${stagiaire.nom} ${stagiaire.prenom}.</p> 
                <p>Vous avez un entretien avec le ${autorite.intitule}(${autorite.intitule_code}) le ${date_entretien} 
                Porte <strong>${autorite.porte}</strong></p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const entretien_reporte = async (autorite,stagiaire,entretien_date_time) =>{
    const autorite_mail = {
        user: autorite.addresse_electronique,
        pass: autorite.mot_de_passe_mailing
    }
    const date_entretien = FUNC.date_in_string(entretien_date_time)
    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure:false,
        auth: {
            user: autorite_mail.user,
            pass: autorite_mail.pass
            // user: 'mefstage2022@gmail.com',
            // pass: 'wswrgxbntbumffqs'
        }
    });
    
    let data = ''
    // send email
    await transporter.sendMail({
        from: autorite_mail.user,
        to: stagiaire.e_mail,
        subject: 'Demande de stage reporté ',
        html: `<p>Bonjour ${stagiaire.nom} ${stagiaire.prenom}.</p> 
                <p>Nous tenons à nous excuser en raison de certaines évenements au sein de l'organisation, la ${autorite.intitule}(${autorite.intitule_code}) a du reporté votre entretien le ${date_entretien}.</p>
                <p>Merci pour votre compréhension</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const entretien_supprimer = async (autorite,stagiaire) =>{
    const autorite_mail = {
        user: autorite.addresse_electronique,
        pass: autorite.mot_de_passe_mailing
    }
    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure:false,
        auth: {
            user: autorite_mail.user,
            pass: autorite_mail.pass
            // user: 'mefstage2022@gmail.com',
            // pass: 'wswrgxbntbumffqs'
        }
    });
    
    let data = ''
    // send email
    await transporter.sendMail({
        from: autorite_mail.user,
        to: stagiaire.e_mail,
        subject: 'Demande de stage reporté ',
        html: `<p>Bonjour ${stagiaire.nom} ${stagiaire.prenom}.</p> 
                <p>Nous tenons à nous excuser en raison de certaines évenements au sein de l'organisation, la ${autorite.intitule}(${autorite.intitule_code}) a du reporté votre entretien. 
                Nous vous informons une suite à votre demande</p>
                <p>Merci pour votre compréhension</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

module.exports = {entretien_valide,entretien_reporte,entretien_supprimer}