import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/stage")

export default class DemandeStageAPI{
    static async addDemandeStage(demande_stage){
        const res = await axios.post(url.concat('/add'),demande_stage)
        return res.data
    }
    // liste stages avec status
    static async all_status(){
        const res = await axios.get(url.concat('/all_status'))
        return res.data
    }
    // detail stage
    static async detail(id){
        const res = await axios.get(url.concat('/detail/',id))
        return res.data
    }
}