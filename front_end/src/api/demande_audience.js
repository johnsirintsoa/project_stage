import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/audience")

export default class DemandeAudience{
    static async all_audience(){
        const res = await axios.get(url.concat('/all'))
        return res.data
    }
    static async delete_event(audience_id){
        const res = await axios.delete(url.concat('/delete/',audience_id))
        return res.data
    }
    static async add_event(audience_event){
        const res = await axios.post(url.concat('/add'), audience_event)
        return res.data
    }
    static async update_event(audience_event){
        const res = await axios.post(url.concat('/update'), audience_event)
        return res.data
    }
}