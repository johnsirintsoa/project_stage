const FUNC = require('../func/function')
const nodemailer = require('nodemailer')

// const userMail = 'mefstage2022@gmail.com'
// const mdp = 'wswrgxbntbumffqs'

const userMail = 'DRH.project.stage@gmail.com'
const mdp = 'dpirzakygtjdqrnl'

/**
 * Mailing entretien
 * Mailing audience public (valider,reporter_maintenant,reporter_plus_tard)
 * Mailing audience autorite (valider,reporter_maintenant,reporter_plus_tard)
 *
 */
const entretien_valide = async (autorite,stagiaire,entretien_date_time) =>{

    const date_entretien = FUNC.date_in_string(entretien_date_time)
    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure:false,
        auth: {
            user: userMail,
            pass: mdp
            // user: 'mefstage2022@gmail.com',
            // pass: 'wswrgxbntbumffqs'
        }
    });
    
    let data = ''
    // send email
    await transporter.sendMail({
        from: userMail,
        to: stagiaire.addresse_electronique,
        subject: 'Demande de stage approuvé et lu',
        html: `<p>Bonjour ${stagiaire.nom} ${stagiaire.prenom}.</p> 
                <p>Vous avez un entretien avec la ${autorite.intitule}(${autorite.intitule_code}) le ${date_entretien}</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const entretien_reporte = async (autorite,stagiaire,entretien_date_time) =>{

    const date_entretien = FUNC.date_in_string(entretien_date_time)
    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure:false,
        auth: {
            user: userMail,
            pass: mdp
            // user: 'mefstage2022@gmail.com',
            // pass: 'wswrgxbntbumffqs'
        }
    });
    
    let data = ''
    // send email
    await transporter.sendMail({
        from: userMail,
        to: stagiaire.addresse_electronique,
        subject: 'Demande de stage reporté ',
        html: `<p>Bonjour ${stagiaire.nom} ${stagiaire.prenom}.</p> 
                <p>En raison de certains évenements au sein de l'organisation, la ${autorite.intitule}(${autorite.intitule_code}) a du reporté votre entretien le ${date_entretien}.</p>
                <p>Merci pour votre compréhension</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const entretien_reporte_plus_tard = async (autorite,stagiaire) =>{

    // const date_entretien = FUNC.date_in_string(entretien_date_time)
    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure:false,
        auth: {
            user: userMail,
            pass: mdp
            // user: 'mefstage2022@gmail.com',
            // pass: 'wswrgxbntbumffqs'
        }
    });
    
    let data = ''
    // send email
    await transporter.sendMail({
        from: userMail,
        to: stagiaire.addresse_electronique,
        subject: 'Demande de stage reporté ',
        html: `<p>Bonjour ${stagiaire.nom} ${stagiaire.prenom}.</p> 
                <p>En raison de certains évenements au sein de l'organisation, la ${autorite.intitule}(${autorite.intitule_code}) a du reporté votre entretien.
                Nous vous informerons une suite à votre demande</p>
                <p>Merci pour votre compréhension</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const entretien_supprimer = async (autorite,stagiaire) =>{

    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure:false,
        auth: {
            user: userMail,
            pass: mdp
            // user: 'mefstage2022@gmail.com',
            // pass: 'wswrgxbntbumffqs'
        }
    });
    
    let data = ''
    // send email
    await transporter.sendMail({
        from: userMail,
        to: stagiaire.addresse_electronique,
        subject: 'Demande de stage reporté ',
        html: `<p>Bonjour ${stagiaire.nom} ${stagiaire.prenom}.</p> 
                <p>En raison de certains évenements au sein de l'organisation, la ${autorite.intitule}(${autorite.intitule_code}) a du reporté votre entretien. 
                Nous vous informerons une suite à votre demande</p>
                <p>Merci pour votre compréhension</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const audience_public_valide = async (autorite,envoyeur,entretien_date_time) =>{
    const date_entretien = FUNC.date_in_string(entretien_date_time)
    const transporter = nodemailer.createTransport({
        // service: 'gmail',
        host: 'smtp.gmail.com',
        port: 587,
        secure: false,
        auth: {
            user: userMail,
            pass: mdp
        }
    });
    
    let data = ''
    // send email
    await transporter.sendMail({
        from: userMail,
        to: envoyeur.addresse_electronique,
        subject: 'Audience validé',
        html: `<p>Bonjour ${envoyeur.nom} ${envoyeur.prenom}.</p> 
                <p>Votre audience auprès de la ${autorite.intitule}(${autorite.intitule_code}) au sujet de:<strong>"${envoyeur.motif}"</strong>  a été validée.<br/>vous pouvez venir le ${date_entretien}.<br/> 
                Veuillez vous addresser à la porte correspondante.`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const audience_public_revalide = async (autorite,envoyeur,entretien_date_time) =>{

    const date_entretien = FUNC.date_in_string(entretien_date_time)
    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure:false,
        auth: {
            user: userMail,
            pass: mdp
            // user: 'mefstage2022@gmail.com',
            // pass: 'wswrgxbntbumffqs'
        }
    });
    
    let data = ''
    // send email
    await transporter.sendMail({
        from: userMail,
        to: envoyeur.addresse_electronique,
        subject: 'Audience validé',
        html: `<p>Bonjour ${envoyeur.nom} ${envoyeur.prenom}.</p> 
                <p>Votre audience auprès de la ${autorite.intitule}(${autorite.intitule_code}) au sujet de <strong>"${envoyeur.motif}"</strong> a été revalidée, vous pouvez venir le ${date_entretien} 
                Veuillez vous addresser à la porte correspondante.</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const audience_public_reporte = async (autorite,envoyeur,entretien_date_time) =>{
    const date_entretien = FUNC.date_in_string(entretien_date_time)
    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure:false,
        auth: {
            user: userMail,
            pass: mdp
            // user: 'mefstage2022@gmail.com',
            // pass: 'wswrgxbntbumffqs'
        }
    });
    
    let data = ''
    // send email
    await transporter.sendMail({
        from: userMail,
        to: envoyeur.addresse_electronique,
        subject: 'Audience reporté',
        html: `<p>Bonjour ${envoyeur.nom} ${envoyeur.prenom}.</p> 
                <p>En raison de certains évenements au sein de l'organisation, la ${autorite.intitule}(${autorite.intitule_code}) a du reporté <br/>votre audience au sujet de :<strong>"${envoyeur.motif}"</strong>le ${date_entretien}.</p>
                <p>Merci pour votre compréhension</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const audience_public_reporte_plus_tard = async (autorite,evenement) =>{
    // const date_entretien = FUNC.date_in_string(entretien_date_time)
    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure:false,
        auth: {
            user: userMail,
            pass: mdp
            // user: 'mefstage2022@gmail.com',
            // pass: 'wswrgxbntbumffqs'
        }
    });
    
    let data = ''
    // send email
    await transporter.sendMail({
        from: userMail,
        to: evenement.addresse_electronique,
        subject: 'Audience reporté',
        html: `<p>Bonjour ${evenement.nom} ${evenement.prenom}.</p> 
                <p>En raison de certains évenements au sein de l'organisation, la ${autorite.intitule}(${autorite.intitule_code}) a du reporté, votre audience au
                sujet de <strong>"${evenement.motif}"</strong>.
                <br/>Nous vous informerons une suite à votre audience</p>
                <p>Merci pour votre compréhension</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const audience_autorite_valide = async (autorite,envoyeur,entretien_date_time) =>{
    const sender = envoyeur

    const date_entretien = FUNC.date_in_string(entretien_date_time)
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
        to: sender.addresse_electronique,
        subject: 'Audience validé',
        html: `<p>Bonjour Monsieur ou Madame le ${sender.intitule_code}</p> 
                <p>Votre audience auprès de la ${autorite.intitule}(${autorite.intitule_code}) a été validée,<br/>vous pouvez venir le ${date_entretien}</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const audience_autorite_reporte = async (autorite,envoyeur,entretien_date_time) =>{

    const sender = envoyeur


    const date_entretien = FUNC.date_in_string(entretien_date_time)
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
    // send email
    await transporter.sendMail({
        from: userMail,
        to: sender.addresse_electronique,
        subject: 'Audience reporté',
        html: `<p>Bonjour Monsieur ou Madame le ${sender.intitule_code}</p> 
                <p>En raison de certains évenements au sein de l'organisation, la ${autorite.intitule}(${autorite.intitule_code}) a du reporté <br/>votre audience le ${date_entretien}.</p>
                <p>Merci pour votre compréhension</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const audience_autorite_reporte_plus_tard = async (autorite,sender) =>{

    // const date_entretien = FUNC.date_in_string(entretien_date_time)
    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure:false,
        auth: {
            user: userMail,
            pass: mdp
            // user: 'mefstage2022@gmail.com',
            // pass: 'wswrgxbntbumffqs'
        }
    });
    
    let data = ''
    // send email
    await transporter.sendMail({
        from: userMail,
        to: sender.addresse_electronique,
        subject: 'Audience reporté',
        html:   `<p>Bonjour Monsieur ou Madame le ${sender.intitule_code}</p> 
                <p>En raison de certains évenements au sein de l'organisation, la ${autorite.intitule}(${autorite.intitule_code}) a du reporté votre audience.
                <br/>Nous vous informerons une suite à votre audience</p>
                <p>Merci pour votre compréhension</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const audience_autorite_revalide = async (autorite,envoyeur,entretien_date_time) =>{

    const date_entretien = FUNC.date_in_string(entretien_date_time)
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
    // send email
    await transporter.sendMail({
        from: userMail,
        to: envoyeur.addresse_electronique,
        subject: 'Audience validé',
        html: `<p>Bonjour Monsieur ou Madame le ${envoyeur.intitule_code}</p> 
                <p>Votre audience auprès de la ${autorite.intitule}(${autorite.intitule_code}) a été revalidée, <br/>vous pouvez venir le ${date_entretien} </p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}


const reporter_evenement = async (autorite,sender) =>{

    

    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure:false,
        auth: {
            user: userMail,
            pass: mdp
            // user: 'mefstage2022@gmail.com',
            // pass: 'wswrgxbntbumffqs'
        }
    });
    
    let data = ''
    // send email
    await transporter.sendMail({
        from: userMail,
        to: sender.addresse_electronique,
        subject: 'Audience reporté',
        html: `<p>Bonjour Monsieur ou Madame ${sender.nom} ${sender.prenom}</p> 
                <p>En raison de certains évenements au sein de l'organisation, la ${autorite.intitule}(${autorite.intitule_code}) a du reporté votre demande.</p>
                <p>Merci pour votre compréhension</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

module.exports = {
    reporter_evenement,
    entretien_valide,
    entretien_reporte,
    entretien_reporte_plus_tard,
    entretien_supprimer,
    audience_public_valide,
    audience_public_revalide,
    audience_public_reporte,
    audience_public_reporte_plus_tard,
    audience_autorite_valide,
    audience_autorite_reporte,
    audience_autorite_reporte_plus_tard,
    audience_autorite_revalide
}