
import DemandeAudience from '../api/demande_audience'
import DemandeAudienceAutorite from '../api/demande_audience_autorite'
import DemandeAudiencePublic from '../api/demande_audience_public'
import func from './function'
// import Jour_ferie from '../api/jour_ferie'

let eventGuid = 0
let todayStr = new Date().toISOString().replace(/T.*$/, '') // YYYY-MM-DD of today

// Actual events public v1
export const actual_events_public = async (id_autorite_enfant) => {
  const audience = DemandeAudiencePublic.audience_public_all(id_autorite_enfant)
  try {
    return await audience
  } catch (error) {
    console.log(error)
  }
  return audience
}

export const actual_events_public_MOIS = async (id_autorite_enfant) => {
  const mois = parseInt(new Date().getMonth())+1
  const date_actu = new Date().getFullYear()+"-"+mois+"-"+new Date().getDate()
  if(!sessionStorage.getItem('session_navigateur')){
    window.location.reload()
  }
  else{
    const audience_public_mois = {
      id_autorite: id_autorite_enfant,
      date_du_jour: date_actu,
      session_navigateur: JSON.parse(sessionStorage.getItem('session_navigateur')).value
      // session_navigateur: 'TEST123456789'
    }
    const audience = DemandeAudiencePublic.audience_public_mois(audience_public_mois)
    try {
      return await audience
    } catch (error) {
      console.log(error)
    }
  }
  return audience
}

export const faire_auidence_par_mois = async (id_autorite_sender,id_autorite_receiver) => {
  const mois = parseInt(new Date().getMonth())+1
  const date_actu =  new Date().getFullYear()+"-"+mois+"-"+new Date().getDate()
  const faire_audience = {
    id_autorite_sender: id_autorite_sender,
    id_autorite_receiver: id_autorite_receiver,
    date_du_jour: date_actu
  }
  const audience = DemandeAudienceAutorite.faire_audience_mois(faire_audience)
  try { 
    return await audience
  } catch (error) {
    console.log(error)
  }
  return audience
}

// Actual events autorite v3 
export const actual_events_autorite = async (id_autorite_enfant) =>{
  const mois = parseInt(new Date().getMonth())+1
  const date1 =  new Date().getFullYear()+"-"+mois+"-"+new Date().getDate()
  // console.log(date1)
  const audience_mois = {
    id_autorite: id_autorite_enfant,
    date_du_jour: date1
  }
  const audiences =  DemandeAudienceAutorite.audience_autorite_all(audience_mois)  
  try {
    return await audiences 
  } catch (error) {
    console.log('Acutal events '+error)
  }
}

export const actual_events_public_mois = async (id_autorite_enfant) =>{
  const audiences =  DemandeAudiencePublic.audience_public_mois(id_autorite_enfant)  
  try {
    return await audiences 
  } catch (error) {
    console.log('Acutal events '+error)
  }
}

export const audience_valider = async(id_autorite_enfant) => {
  const audience = DemandeAudience.audiences_valider(id_autorite_enfant)
  return audience
}

export const audience_reporter = async(id_autorite_enfant) => {
  const audience = await DemandeAudience.audiences_reporter(id_autorite_enfant)
  return audience
}

export function createEventId() {
  return String(eventGuid++)
}

export function setDateEnd(date,duree){
  let millsec = 3600*1000*duree
  let date_end = new Date(date).getTime()
  return new Date(date_end+millsec)
  // return date_end+millsec
}
