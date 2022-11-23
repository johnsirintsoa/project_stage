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

module.exports = {entretien_valide,entretien_reporte,entretien_supprimer}
    