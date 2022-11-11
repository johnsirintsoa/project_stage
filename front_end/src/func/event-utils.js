
import DemandeAudience from '../api/demande_audience'
import DemandeAudienceAutorite from '../api/demande_audience_autorite'
import DemandeAudiencePublic from '../api/demande_audience_public'
import func from './function'
// import Jour_ferie from '../api/jour_ferie'

let eventGuid = 0
let todayStr = new Date().toISOString().replace(/T.*$/, '') // YYYY-MM-DD of today

export const INITIAL_EVENTS = [
  {
    id: createEventId(),
    title: 'All-day event',
    start: todayStr,
  },
  {
    id: createEventId(),
    title: 'Timed event',
    start: todayStr + 'T12:00:00',
    end: todayStr + 'T13:00:00'

  },
  {
    id: createEventId(),
    title: 'Test 1',
    start: todayStr + 'T15:00:00',
    end: todayStr + 'T16:00:00'

  }
]

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
  const date_actu = new Date().getFullYear()+"-"+new Date().getMonth()+"-"+new Date().getDate()
  const audience_public_mois = {
    id_autorite: id_autorite_enfant,
    date_du_jour: date_actu
  }
  const audience = DemandeAudiencePublic.audience_public_mois(audience_public_mois)
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
  const audience = DemandeAudience.audiences_reporter(id_autorite_enfant)
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

// export const jour_ferie = async () => {
//   const jour_ferie = Jour_ferie.all_jour_ferie()
//   const array_jour_ferie = []
//   try {
//     jour_ferie.forEach(element => {
//       // const date_ferie = String(new Date().getFullYear()).concat('-') String(element.dd_aud_autorite).concat('T',element.td_aud_autorite)
//       const date_ferie = String(new Date().getFullYear()).concat('-') 
//       console.log(date_ferie)
//       array_jour_ferie.push({
//         title: element.nom_evenement,
//         start: date_time_start,
//         end: date_time_fin,
//         color:'#2B2B2B',
//         status_audience: element.status_audience
//       })
//     });
//   } catch (error) {
    
//   }
//   return jour_ferie
// }