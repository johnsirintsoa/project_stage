import axios from 'axios'
const domaine = "http://192.168.100.160:3000"
const url = domaine.concat("/api/entretien")

export default class EntretienStage{

  static async ajouter(infos_stage){
    const res = await axios.post(url.concat('/add'),infos_stage)
    return res.data
  }

  static async modifier(infos_stage){
    const res = await axios.post(url.concat('/update'),infos_stage)
    return res.data
  }

  static async supprimer(stage){
    const res = await axios.post(url.concat('/delete'),stage)
    return res.data
  }

  static async modifier_calendrier(stage){
    const res = await axios.post(url.concat('/updateCalendar'),stage)
    return res.data
  }

}