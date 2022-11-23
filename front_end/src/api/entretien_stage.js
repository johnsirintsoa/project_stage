import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/entretien")

export default class EntretienStage{
  static async add_entretien_stage(infos_stage){
    const res = await axios.post(url.concat('/add'),infos_stage)
    return res.data
  }

  static async update_entretien_stage(infos_stage){
    const res = await axios.post(url.concat('/update'),infos_stage)
    return res.data
  }

  static async delete_entretien_stage(stage){
    const res = await axios.post(url.concat('/delete'),stage)
    return res.data
  }

}