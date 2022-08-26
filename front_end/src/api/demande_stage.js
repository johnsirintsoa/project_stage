import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/stage")

export default class DemandeStageAPI{
    static async addDemandeStage(demande_stage){
        const res = await axios.post(url.concat('/add'),demande_stage)
        console.log(res.data)
        return res.data
    }
}