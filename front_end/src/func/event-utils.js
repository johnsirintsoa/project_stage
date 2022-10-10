
import DemandeAudience from '../api/demande_audience'

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

export const actual_events = async () => {
  const audiences =  DemandeAudience.all_audience()
  const actual_events = []
  try {
    const results = await audiences
    results.forEach(element => {
      // console.log(element)
      let event = {
        id: String(element.id),
        title: element.motif,
        start: String(element.date_time_debut).split('.')[0],
        end: String(element.date_time_fin).split('.')[0],
        intitule: String(element.intitule),
        id_direction: String(element.id_direction),
        type_audience: String(element.type_audience),
      }
      actual_events.push(event)
    })
    // console.log(actual_events)
    return actual_events
  } catch (error) {
    console.log(error)
  }
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
