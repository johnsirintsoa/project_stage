const mail = require('../models/Mailing')

const entretien_valide = async (autorite,stagiare,entretien_datetime) =>{
    return mail.entretien_valide(autorite,stagiare,entretien_datetime)
}

const entretien_reporte = async (autorite,stagiare,entretien_datetime) =>{
    return mail.entretien_reporte(autorite,stagiare,entretien_datetime)
}

const entretien_supprimer = async (autorite,stagiare,entretien_datetime) =>{
    return mail.entretien_supprimer(autorite,stagiare,entretien_datetime)
}

const audience_public_valide = async (autorite,sender,audience_datetime) =>{
    return mail.audience_public_valide(autorite,sender,audience_datetime)
}

const audience_public_revalide = async (autorite,sender,audience_datetime) =>{
    return mail.audience_public_revalide(autorite,sender,audience_datetime)
}

const audience_public_reporte = async (autorite,sender,audience_datetime) =>{
    return mail.audience_public_reporte(autorite,sender,audience_datetime)
}

const audience_public_reporte_plus_tard = async (autorite,sender,audience_datetime) =>{
    return mail.audience_public_reporte_plus_tard(autorite,sender,audience_datetime)
}

const audience_autorite_valide = async (autorite,sender,audience_datetime) =>{
    return mail.audience_autorite_valide(autorite,sender,audience_datetime)
}

const audience_autorite_reporte = async (autorite,sender,audience_datetime) =>{
    return mail.audience_autorite_reporte(autorite,sender,audience_datetime)
}

const audience_autorite_reporte_plus_tard = async (autorite,sender,audience_datetime) =>{
    return mail.audience_autorite_reporte_plus_tard(autorite,sender,audience_datetime)
}

const audience_autorite_revalide = async (autorite,sender,audience_datetime) =>{
    return mail.audience_autorite_revalide(autorite,sender,audience_datetime)
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
    