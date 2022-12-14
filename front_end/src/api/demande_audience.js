import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/audience")

export default class DemandeAudience{
    static async all_audience(){
        const res = await axios.get(url.concat('/public/all'))
        return res.data
    }

    static async audiences_valider(id_autorite_enfant){
        const res = await axios.get(url.concat('/valider/all/',id_autorite_enfant))
        return res.data
    }

    static async audiences_reporter(id_autorite_enfant){
        const res = await axios.get(url.concat('/reporter/all/',id_autorite_enfant))
        return res.data
    }


    // static async all_audience_test(){
    //     const res = await axios.get(url.concat('/public/test/all'))
    //     return res.data
    // }

    static async delete_event(audience_id){
        const res = await axios.delete(url.concat('/public/delete/',audience_id))
        return res.data
    }
    static async add_event(audience_event){
        const res = await axios.post(url.concat('/public/add'), audience_event)
        return res.data
    }

    static async add_event_autorite(audience_event){
        const res = await axios.post(url.concat('/autorite/add'), audience_event)
        return res.data
    }
    
    // static async add_event_test(audience_event){
    //     const res = await axios.post(url.concat('/public/test/add'), audience_event)
    //     return res.data
    // }

    static async update_event(audience_event){
        const res = await axios.post(url.concat('/public/update'), audience_event)
        return res.data
    }

    static async audiences_byId_autorite(id_autorite_enfant){
        const res = await axios.get(url.concat('/demande_audiences/all/',id_autorite_enfant))
        return res.data
    }

    static async valider_public(dm_aud_public){
        const res = await axios.post(url.concat('/public/valider'),dm_aud_public)
        return res.data
    }

    static async valider_autorite(dm_aud_autorite){
        const res = await axios.post(url.concat('/autorite/valider'),dm_aud_autorite)
        return res.data
    }

    static async reporter_autorite_maintenant(audience_event){
        const res = await axios.post(url.concat('/autorite/reporter/now'),audience_event)
        return res.data       
    }
    static async reporter_autorite_plus_tard(audience_event){
        const res = await axios.post(url.concat('/autorite/reporter/later'),audience_event)
        return res.data       
    }

    static async reporter_public_maintenant(audience_event){
        const res = await axios.post(url.concat('/public/reporter/now'),audience_event)
        return res.data       
    }
    static async reporter_public_plus_tard(audience_event){
        const res = await axios.post(url.concat('/public/reporter/later'),audience_event)
        return res.data       
    }
}