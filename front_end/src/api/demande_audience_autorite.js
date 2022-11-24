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

    static async valider(dm_aud_autorite){
        const res = await axios.post(url.concat('/valider'),dm_aud_autorite)
        return res.data
    }

    static async reporter_maintenant(audience_event){
        const res = await axios.post(url.concat('/reporter/now'),audience_event)
        return res.data       
    }
    static async reporter_plus_tard(audience_event){
        const res = await axios.post(url.concat('/reporter/later'),audience_event)
        return res.data       
    }

    // Liste audiences reportées
    static async audiences_reporter(id_autorite_enfant){
        const res = await axios.get(url.concat('/reporter/all/',id_autorite_enfant))
        return res.data
    }

    static async audiences_valider(id_autorite_enfant){
        const res = await axios.get(url.concat('/valider/all/',id_autorite_enfant))
        return res.data
    }

    static async revalider(dm_aud_autorite){
        const res = await axios.post(url.concat('/revalider'),dm_aud_autorite)
        return res.data
    }
}