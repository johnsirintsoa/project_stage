
import DemandeAudience from '../api/demande_audience'
import Jour_ferie from '../api/jour_ferie'

let eventGuid = 0
let todayStr = new Date().toISOString().replace(/T.*$/, '') // YYYY-MM-DD of today

// export const INITIAL_EVENTS = [
//   {
//     id: createEventId(),
//     title: 'All-day event',
//     start: todayStr,
//   },
//   {
//     id: createEventId(),
//     title: 'Timed event',
//     start: todayStr + 'T12:00:00',
//     end: todayStr + 'T13:00:00'

//   },
//   {
//     id: createEventId(),
//     title: 'Test 1',
//     start: todayStr + 'T15:00:00',
//     end: todayStr + 'T16:00:00'

//   }
// ]

// Actual events v1
// export const actual_events = async () => {
//   const audiences =  DemandeAudience.all_audience()
//   const actual_events = []
//   try {
//     const results = await audiences
//     results.forEach(element => {
//       // console.log(element)
//       const date_time_start = String(element.date_event_debut).concat('T',element.time_event_debut)
//       const date_time_fin = String(element.date_event_fin).concat('T',element.time_event_fin)
//       let event = {
//         id: String(element.id),
//         title: element.motif,
//         start: date_time_start,
//         end: date_time_fin,
//         intitule: String(element.intitule),
//         id_autorite_enfant: String(element.id_autorite_enfant)
//       }
//       actual_events.push(event)
//     })
//     // console.log(actual_events)
//     return actual_events
//   } catch (error) {
//     console.log(error)
//   }
// }

// Actual events v2
export const actual_events = async (id_autorite_enfant) => {
  const audiences =  DemandeAudience.audiences_byId_autorite(id_autorite_enfant)
  const actual_events = []
  try {
    const results = await audiences
    results.forEach(element => {
      // console.log(element)
      const date_time_start = String(element.date_event_debut).concat('T',element.time_event_debut)
      const date_time_fin = String(element.date_event_fin).concat('T',element.time_event_fin)
      let event = {}
      if(element.status_audience == 'Occupé'){
        event = {
          id: String(element.id),
          title: element.motif,
          start: date_time_start,
          end: date_time_fin,
          intitule: String(element.intitule),
          id_autorite_enfant: String(element.id_autorite_enfant),
          display:'backgroung',
          color:'#ff9f89'
        }
      }else if (element.status_audience == 'Pas disponible'){
        event = {
          id: String(element.id),
          title: element.motif,
          start: date_time_start,
          end: date_time_fin,
          intitule: String(element.intitule),
          id_autorite_enfant: String(element.id_autorite_enfant),
          display:'backgroung',
          color:'#2B2B2B'
        }
      }
      actual_events.push(event)
    })
    // console.log(actual_events)
    return actual_events
  } catch (error) {
    console.log(error)
  }
}

// export const actual_events_TEST = async () => {
//   const audiences =  DemandeAudience.all_audience_test()
//   const actual_events = []
//   try {
//     const results = await audiences
//     results.forEach(element => {
//       // console.log(element)
//       const date_time_start = String(element.date_x_debut).concat('T',element.time_x_debut)
//       const date_time_fin = String(element.date_x_fin).concat('T',element.time_x_fin)
//       let event = {
//         title: 'TEST',
//         start: date_time_start,
//         end: date_time_fin
//       }
//       actual_events.push(event)
//     })
//     // console.log(actual_events)
//     return actual_events
//   } catch (error) {
//     console.log(error)
//   }
// }

export function createEventId() {
  return String(eventGuid++)
}

export function setDateEnd(date,duree){
  let millsec = 3600*1000*duree
  let date_end = new Date(date).getTime()
  return new Date(date_end+millsec)
  // return date_end+millsec
}

export const jour_ferie = async () => {
  const jour_ferie = Jour_ferie.all_jour_ferie()
  return jour_ferie
}