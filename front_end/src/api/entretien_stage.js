import axios from 'axios'
import dom  from './config'
// const domaine = "http://localhost:3000"
const route1 = 'entretien'
import authHeader from './auth-header'

// const url = domaine.concat("/api/entretien")

export default class EntretienStage{

  static async ajouter(infos_stage){
    const url = dom.domaineBackEnd(route1,'/add')
    const res = await axios.post(url,infos_stage,{headers: authHeader()})
    // const res = await axios.post(url.concat('/add'),infos_stage)
    return res.data
  }

  static async modifier(infos_stage){
    const url = dom.domaineBackEnd(route1,'/update')
    const res = await axios.post(url,infos_stage,{headers: authHeader()})
    // const res = await axios.post(url.concat('/update'),infos_stage)
    return res.data
  }

  static async supprimer(stage){
    const url = dom.domaineBackEnd(route1,'/delete')
    const res = await axios.post(url,stage,{headers: authHeader()})
    // const res = await axios.post(url.concat('/delete'),stage)
    return res.data
  }

  static async modifier_calendrier(stage){
    const url = dom.domaineBackEnd(route1,'/updateCalendar')
    const res = await axios.post(url,stage,{headers: authHeader()})
    // const res = await axios.post(url.concat('/updateCalendar'),stage)
    return res.data
  }

}