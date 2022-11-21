import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/audience/autorite")

export default class DemandeAudienceAutorite{

    static async audience_autorite_all(audience_mois){
        const res = await axios.post(url.concat('/all/mois'),audience_mois)
        return res.data
    }

    static async faire_audience_mois(audience){
        const res = await axios.post(url.concat('/all/faire_audience'),audience)
        return res.data
    }

    static async add_audience_autorite(audience){
        const res = await axios.post(url.concat('/add'),audience)
        return res.data
    }

    static async update_audience_autorite(audience_event){
        const res = await axios.post(url.concat('/update'), audience_event)
        return res.data
    }

    static async delete_audience_autorite(id){
        const res = await axios.post(url.concat('/delete'),id)
        return res.data
    }

    static async notifications(id){
        const res =  await axios.get(url.concat('/notification/',id))
        return res.data
    }
}