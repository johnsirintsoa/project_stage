
import DemandeAudience from '../api/demande_audience'
import Jour_ferie from '../api/jour_ferie'

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


// Actual events public
export const actual_events_public = async (id_autorite_enfant) => {
  const audiences =  DemandeAudience.audiences_byId_autorite(id_autorite_enfant)
  const actual_events = []
  try {
    const results = await audiences
    results.forEach(element => {
      // console.log(element)
      let event = {}
      if(element.dd_aud_public !=''){
        const date_time_start = String(element.dd_aud_public).concat('T',element.td_aud_public)
        const date_time_fin = String(element.df_aud_public).concat('T',element.tf_aud_public)
        event = {
          id: String(element.id),
          title: element.status_audience,
          start: date_time_start,
          end: date_time_fin,
          color:'#ff9f89',
          status_audience: element.status_audience
        }
      }
      else if(element.dd_aud_autorite !=''){
        const date_time_start = String(element.dd_aud_autorite).concat('T',element.td_aud_autorite)
        const date_time_fin = String(element.df_aud_autorite).concat('T',element.tf_aud_autorite)
        event = {
          id: String(element.id),
          title: element.status_audience,
          start: date_time_start,
          end: date_time_fin,
          color:'#ff9f89',
          status_audience: element.status_audience
        }
      }
      else if(element.dd_non_dispo_date !=''){
        const date_time_start = String(element.dd_non_dispo_date).concat('T',element.td_non_dispo_date)
        const date_time_fin = String(element.df_non_dispo_date).concat('T',element.tf_non_dispo_date)
        event = {
          id: String(element.id),
          title: element.status_audience,
          start: date_time_start,
          end: date_time_fin,
          color:'#2B2B2B',
          status_audience: element.status_audience
        }
      }
      else if(element.date_ferie !=''){
        const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
        const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
        event = {
          id: String(element.id),
          title: element.motif,
          start: date_ferie_debut,
          end: date_ferie_fin,
          color:'#EFEC27',
          status_audience: element.status_audience
        }
      }
      else if(element.jour_non_dispo_jour !=''){
        const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
        const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
        if(element.jour_non_dispo_jour == 'Sunday'){
          event = {
            title: element.status_audience,
            daysOfWeek: [ '0' ], // these recurrent events move separately
            startTime: element.td_non_dispo_jour,
            endTime: element.tf_non_dispo_jour,
            status_audience: element.status_audience,
            color: '#2B2B2B'
          }
        }
        else if(element.jour_non_dispo_jour == 'Monday'){
          event = {
            title: element.status_audience,
            daysOfWeek: [ '1' ], // these recurrent events move separately
            startTime: element.td_non_dispo_jour,
            endTime: element.tf_non_dispo_jour,
            status_audience: element.status_audience,
            color: '#2B2B2B'
          }
        }
        else if(element.jour_non_dispo_jour == 'Tuesday'){
          event = {
            title: element.status_audience,
            daysOfWeek: [ '2' ], // these recurrent events move separately
            startTime: element.td_non_dispo_jour,
            endTime: element.tf_non_dispo_jour,
            status_audience: element.status_audience,
            color: '#2B2B2B'
          }
        }
        else if(element.jour_non_dispo_jour == 'Wednesday'){
          event = {
            title: element.status_audience,
            daysOfWeek: [ '3' ], // these recurrent events move separately
            startTime: element.td_non_dispo_jour,
            endTime: element.tf_non_dispo_jour,
            status_audience: element.status_audience,
            color: '#2B2B2B'
          }
        }
        else if(element.jour_non_dispo_jour == 'Thursday'){
          event = {
            title: element.status_audience,
            daysOfWeek: [ '4' ], // these recurrent events move separately
            startTime: element.td_non_dispo_jour,
            endTime: element.tf_non_dispo_jour,
            status_audience: element.status_audience,
            color: '#2B2B2B'
          }
        }
        else if(element.jour_non_dispo_jour == 'Friday'){
          event = {
            title: element.status_audience,
            daysOfWeek: [ '5' ], // these recurrent events move separately
            startTime: element.td_non_dispo_jour,
            endTime: element.tf_non_dispo_jour,
            status_audience: element.status_audience,
            color: '#2B2B2B'
          }
        }
        else if(element.jour_non_dispo_jour == 'Saturday'){
          event = {
            title: element.status_audience,
            daysOfWeek: [ '6' ], // these recurrent events move separately
            startTime: element.td_non_dispo_jour,
            endTime: element.tf_non_dispo_jour,
            status_audience: element.status_audience,
            color: '#2B2B2B'
          }
        }
      }
      actual_events.push(event)
    })
    // console.log(actual_events)
    return actual_events
  } catch (error) {
    console.log('Acutal events '+error)
  }
}

// Actual events autorite v1
// export const actual_events_autorite = async (id_autorite_enfant) => {
//   const audiences =  DemandeAudience.audiences_byId_autorite(id_autorite_enfant)
//   const actual_events = []
//   // console.log(audiences)
//   try {
//     const results = await audiences
//     results.forEach(element => {
//       // console.log(element)
//       let event = {}
//       if(element.dd_aud_public !=''){
//         const date_time_start = String(element.dd_aud_public).concat('T',element.td_aud_public)
//         const date_time_fin = String(element.df_aud_public).concat('T',element.tf_aud_public)
//         event = {
//           id: String(element.id),
//           title: element.status_audience,
//           start: date_time_start,
//           end: date_time_fin,
//           color:'#ff9f89',
//           status_audience: element.status_audience
//         }
//       }
//       else if(element.dd_aud_autorite !=''){
//         const date_time_start = String(element.dd_aud_autorite).concat('T',element.td_aud_autorite)
//         const date_time_fin = String(element.df_aud_autorite).concat('T',element.tf_aud_autorite)
//         event = {
//           id: String(element.id),
//           title: element.status_audience,
//           start: date_time_start,
//           end: date_time_fin,
//           color:'#ff9f89',
//           status_audience: element.status_audience
//         }
//       }
//       else if(element.dd_non_dispo_date !=''){
//         const date_time_start = String(element.dd_non_dispo_date).concat('T',element.td_non_dispo_date)
//         const date_time_fin = String(element.df_non_dispo_date).concat('T',element.tf_non_dispo_date)
//         event = {
//           id: String(element.id),
//           title: element.status_audience,
//           start: date_time_start,
//           end: date_time_fin,
//           color:'#2B2B2B',
//           status_audience: element.status_audience
//         }
//       }
//       else if(element.date_ferie !=''){
//         const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
//         const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
//         event = {
//           id: String(element.id),
//           title: element.motif,
//           start: date_ferie_debut,
//           end: date_ferie_fin,
//           color:'#EFEC27',
//           status_audience: element.status_audience
//         }
//       }
//       else if(element.jour_non_dispo_jour !=''){
//         const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
//         const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
//         if(element.jour_non_dispo_jour == 'Sunday'){
//           event = {
//             title: element.status_audience,
//             daysOfWeek: [ '0' ], // these recurrent events move separately
//             startTime: element.td_non_dispo_jour,
//             endTime: element.tf_non_dispo_jour,
//             status_audience: element.status_audience,
//             color: '#2B2B2B'
//           }
//         }
//         else if(element.jour_non_dispo_jour == 'Monday'){
//           event = {
//             title: element.status_audience,
//             daysOfWeek: [ '1' ], // these recurrent events move separately
//             startTime: element.td_non_dispo_jour,
//             endTime: element.tf_non_dispo_jour,
//             status_audience: element.status_audience,
//             color: '#2B2B2B'
//           }
//         }
//         else if(element.jour_non_dispo_jour == 'Tuesday'){
//           event = {
//             title: element.status_audience,
//             daysOfWeek: [ '2' ], // these recurrent events move separately
//             startTime: element.td_non_dispo_jour,
//             endTime: element.tf_non_dispo_jour,
//             status_audience: element.status_audience,
//             color: '#2B2B2B'
//           }
//         }
//         else if(element.jour_non_dispo_jour == 'Wednesday'){
//           event = {
//             title: element.status_audience,
//             daysOfWeek: [ '3' ], // these recurrent events move separately
//             startTime: element.td_non_dispo_jour,
//             endTime: element.tf_non_dispo_jour,
//             status_audience: element.status_audience,
//             color: '#2B2B2B'
//           }
//         }
//         else if(element.jour_non_dispo_jour == 'Thursday'){
//           event = {
//             title: element.status_audience,
//             daysOfWeek: [ '4' ], // these recurrent events move separately
//             startTime: element.td_non_dispo_jour,
//             endTime: element.tf_non_dispo_jour,
//             status_audience: element.status_audience,
//             color: '#2B2B2B'
//           }
//         }
//         else if(element.jour_non_dispo_jour == 'Friday'){
//           event = {
//             title: element.status_audience,
//             daysOfWeek: [ '5' ], // these recurrent events move separately
//             startTime: element.td_non_dispo_jour,
//             endTime: element.tf_non_dispo_jour,
//             status_audience: element.status_audience,
//             color: '#2B2B2B'
//           }
//         }
//         else if(element.jour_non_dispo_jour == 'Saturday'){
//           event = {
//             title: element.status_audience,
//             daysOfWeek: [ '6' ], // these recurrent events move separately
//             startTime: element.td_non_dispo_jour,
//             endTime: element.tf_non_dispo_jour,
//             status_audience: element.status_audience,
//             color: '#2B2B2B'
//           }
//         }
//       }
//       actual_events.push(event)
//     })
//     // console.log(actual_events)
//     return actual_events
//   } catch (error) {
//     console.log('Acutal events '+error)
//   }
// }

// Actual events autorite v2
export const actual_events_autorite = async (id_autorite_enfant) => {
  const audiences =  DemandeAudience.audiences_byId_autorite(id_autorite_enfant)
  const actual_events = []
  // console.log(audiences)
  try {
    const results = await audiences
    results.forEach(element => {
      let event = {}
      if(element.dd_aud_public !=''){
        const date_time_start = String(element.dd_aud_public).concat('T',element.td_aud_public)
        const date_time_fin = String(element.df_aud_public).concat('T',element.tf_aud_public)
        if(element.action_public == 1){
          event = {
            id: element.id_aud_public,
            title: element.motif,
            start: date_time_start,
            end: date_time_fin,
            color:'#ff9f89',
            status_audience: element.status_audience,
            type_audience: element.type_audience,
            action: element.action_public,
            editable: false
          
          }
        }else{
          event = {
            id: element.id_aud_public,
            title: element.motif,
            start: date_time_start,
            end: date_time_fin,
            color:'#25AF1A',
            status_audience: element.status_audience,
            type_audience: element.type_audience,
            action: element.action_public,
            editable: true
          }
        }
      }
      else if(element.dd_aud_autorite !=''){
        const date_time_start = String(element.dd_aud_autorite).concat('T',element.td_aud_autorite)
        const date_time_fin = String(element.df_aud_autorite).concat('T',element.tf_aud_autorite)
        // console.log(element.action_autorite)
        if(element.action_autorite == 1){
          event = {
            id: element.id_aud_autorite,
            sender:{
              id: element.id_autorite_sender,
              intitule: element.sender_intitule,
              intitule_code: element.sender_intitule_code
            },
            title: element.motif,
            start: date_time_start,
            end: date_time_fin,
            color:'#ff9f89',
            status_audience: element.status_audience,
            type_audience: element.type_audience,
            action: element.action_autorite,
            editable: false
          
          }
        }else{
          event = {
            id: element.id_aud_autorite,
            sender:{
              id: element.id_autorite_sender,
              intitule: element.sender_intitule,
              intitule_code: element.sender_intitule_code
            },
            title: element.motif,
            start: date_time_start,
            end: date_time_fin,
            color:'#25AF1A',
            status_audience: element.status_audience,
            type_audience: element.type_audience,
            action: element.action_autorite,
            editable: true
          }
        }
      }
      else if(element.dd_non_dispo_date !=''){
        const date_time_start = String(element.dd_non_dispo_date).concat('T',element.td_non_dispo_date)
        const date_time_fin = String(element.df_non_dispo_date).concat('T',element.tf_non_dispo_date)
        event = {
          id: String(element.id),
          title: element.status_audience,
          start: date_time_start,
          end: date_time_fin,
          color:'#2B2B2B',
          status_audience: element.status_audience,
          type_audience: element.type_audience,
          editable: false
        
        }
      }
      else if(element.date_ferie !=''){
        const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
        const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
        event = {
          id: String(element.id),
          title: element.motif,
          start: date_ferie_debut,
          end: date_ferie_fin,
          color:'#EFEC27',
          status_audience: element.status_audience,
          type_audience: element.type_audience,
          editable: false
        
        }
      }
      else if(element.jour_non_dispo_jour !=''){
        const date_ferie_debut = String(element.date_ferie).concat('T',element.td_ferie)
        const date_ferie_fin = String(element.date_ferie).concat('T',element.tf_ferie)
        if(element.jour_non_dispo_jour == 'Sunday'){
          event = {
            title: element.status_audience,
            daysOfWeek: [ '0' ], // these recurrent events move separately
            startTime: element.td_non_dispo_jour,
            endTime: element.tf_non_dispo_jour,
            status_audience: element.status_audience,
            type_audience: element.type_audience,
            color: '#2B2B2B',
            editable: false
          
          }
        }
        else if(element.jour_non_dispo_jour == 'Monday'){
          event = {
            title: element.status_audience,
            daysOfWeek: [ '1' ], // these recurrent events move separately
            startTime: element.td_non_dispo_jour,
            endTime: element.tf_non_dispo_jour,
            status_audience: element.status_audience,
            type_audience: element.type_audience,
            color: '#2B2B2B',
            editable: false
          
          }
        }
        else if(element.jour_non_dispo_jour == 'Tuesday'){
          event = {
            title: element.status_audience,
            daysOfWeek: [ '2' ], // these recurrent events move separately
            startTime: element.td_non_dispo_jour,
            endTime: element.tf_non_dispo_jour,
            status_audience: element.status_audience,
            type_audience: element.type_audience,
            color: '#2B2B2B',
            editable: false
          
          }
        }
        else if(element.jour_non_dispo_jour == 'Wednesday'){
          event = {
            title: element.status_audience,
            daysOfWeek: [ '3' ], // these recurrent events move separately
            startTime: element.td_non_dispo_jour,
            endTime: element.tf_non_dispo_jour,
            status_audience: element.status_audience,
            type_audience: element.type_audience,
            color: '#2B2B2B',
            editable: false
          
          }
        }
        else if(element.jour_non_dispo_jour == 'Thursday'){
          event = {
            title: element.status_audience,
            daysOfWeek: [ '4' ], // these recurrent events move separately
            startTime: element.td_non_dispo_jour,
            endTime: element.tf_non_dispo_jour,
            status_audience: element.status_audience,
            type_audience: element.type_audience,
            color: '#2B2B2B',
            editable: false
          
          }
        }
        else if(element.jour_non_dispo_jour == 'Friday'){
          event = {
            title: element.status_audience,
            daysOfWeek: [ '5' ], // these recurrent events move separately
            startTime: element.td_non_dispo_jour,
            endTime: element.tf_non_dispo_jour,
            status_audience: element.status_audience,
            type_audience: element.type_audience,
            color: '#2B2B2B',
            editable: false
          
          }
        }
        else if(element.jour_non_dispo_jour == 'Saturday'){
          event = {
            title: element.status_audience,
            daysOfWeek: [ '6' ], // these recurrent events move separately
            startTime: element.td_non_dispo_jour,
            endTime: element.tf_non_dispo_jour,
            status_audience: element.status_audience,
            type_audience: element.type_audience,
            color: '#2B2B2B',
            editable: false
          
          }
        }
      }
      actual_events.push(event)
    })
    // console.log(actual_events)
    return actual_events
  } catch (error) {
    console.log('Acutal events '+error)
  }
}

export const audience_valider = async(id_autorite_enfant) => {
  const audience = DemandeAudience.audiences_valider(id_autorite_enfant)
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