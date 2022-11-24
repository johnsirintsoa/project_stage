const FUNC = require('../func/function')
const nodemailer = require('nodemailer')

/**
 * Mailing entretien
 * Mailing audience public (valider,reporter_maintenant,reporter_plus_tard)
 * Mailing audience autorite (valider,reporter_maintenant,reporter_plus_tard)
 *
 */
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
                <p>En raison de certains évenements au sein de l'organisation, la ${autorite.intitule}(${autorite.intitule_code}) a du reporté votre entretien le ${date_entretien}.</p>
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

const audience_public_valide = async (autorite,sender,entretien_date_time) =>{
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
        to: sender.email,
        subject: 'Audience validé',
        html: `<p>Bonjour ${sender.nom} ${sender.prenom}.</p> 
                <p>Votre audience auprès de la ${autorite.intitule}(${autorite.intitule_code}) a été validée, vous pouvez venir le ${date_entretien} 
                Porte <strong>${autorite.porte}</strong></p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const audience_public_revalide = async (autorite,sender,entretien_date_time) =>{
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
        to: sender.addresse_electronique,
        subject: 'Audience validé',
        html: `<p>Bonjour ${sender.nom} ${sender.prenom}.</p> 
                <p>Votre audience auprès de la ${autorite.intitule}(${autorite.intitule_code}) a été revalidée, vous pouvez venir le ${date_entretien} 
                Porte <strong>${autorite.porte}</strong></p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const audience_public_reporte = async (autorite,sender,entretien_date_time) =>{
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
        to: sender.email,
        subject: 'Audience reporté',
        html: `<p>Bonjour ${sender.nom} ${sender.prenom}.</p> 
                <p>En raison de certains évenements au sein de l'organisation, la ${autorite.intitule}(${autorite.intitule_code}) a du reporté votre audience le ${date_entretien}.</p>
                <p>Merci pour votre compréhension</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const audience_public_reporte_plus_tard = async (autorite,sender) =>{
    const autorite_mail = {
        user: autorite.addresse_electronique,
        pass: autorite.mot_de_passe_mailing
    }
    // const date_entretien = FUNC.date_in_string(entretien_date_time)
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
        to: sender.email,
        subject: 'Audience reporté',
        html: `<p>Bonjour ${sender.nom} ${sender.prenom}.</p> 
                <p>En raison de certains évenements au sein de l'organisation, la ${autorite.intitule}(${autorite.intitule_code}) a du reporté votre audience.
                Nous vous informerons une suite à votre audience</p>
                <p>Merci pour votre compréhension</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const audience_autorite_valide = async (autorite,sender,entretien_date_time) =>{
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
        to: sender.addresse_electronique,
        subject: 'Audience validé',
        html: `<p>Bonjour Monsieur ou Madame le ${sender.intitule_code}</p> 
                <p>Votre audience auprès de la ${autorite.intitule}(${autorite.intitule_code}) a été validée, vous pouvez venir le ${date_entretien} 
                Porte <strong>${autorite.porte}</strong></p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const audience_autorite_reporte = async (autorite,sender,entretien_date_time) =>{
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
        to: sender.addresse_electronique,
        subject: 'Audience reporté',
        html: `<p>Bonjour Monsieur ou Madame le ${sender.intitule_code}</p> 
                <p>En raison de certains évenements au sein de l'organisation, la ${autorite.intitule}(${autorite.intitule_code}) a du reporté votre audience le ${date_entretien}.</p>
                <p>Merci pour votre compréhension</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const audience_autorite_reporte_plus_tard = async (autorite,sender) =>{
    const autorite_mail = {
        user: autorite.addresse_electronique,
        pass: autorite.mot_de_passe_mailing
    }
    // const date_entretien = FUNC.date_in_string(entretien_date_time)
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
        to: sender.addresse_electronique,
        subject: 'Audience reporté',
        html:   `<p>Bonjour Monsieur ou Madame le ${sender.intitule_code}</p> 
                <p>En raison de certains évenements au sein de l'organisation, la ${autorite.intitule}(${autorite.intitule_code}) a du reporté votre audience.
                Nous vous informerons une suite à votre audience</p>
                <p>Merci pour votre compréhension</p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

const audience_autorite_revalide = async (autorite,sender,entretien_date_time) =>{
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
        to: sender.email,
        subject: 'Audience validé',
        html: `<p>Bonjour Monsieur ou Madame le ${sender.intitule_code}</p> 
                <p>Votre audience auprès de la ${autorite.intitule}(${autorite.intitule_code}) a été revalidée, vous pouvez venir le ${date_entretien} 
                Porte <strong>${autorite.porte}</strong></p>`
    }).then((result) => {
        data = result
    }).catch((err) => {
        data = err
    });
    return data
}

module.exports = {
    entretien_valide,
    entretien_reporte,
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