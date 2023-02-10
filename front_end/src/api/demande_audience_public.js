import axios from 'axios'
const domaine = "http://192.168.100.160:3000"
const url = domaine.concat("/api/audience/public")

export default class DemandeAudience{

    static async liste(arg){
        const res = await axios.post(url.concat('/all'),arg)
        return res.data
    }

    static async audience_public_jour(arg){
        const res = await axios.post(url.concat('/heure_disponible_autorite/jour'),arg)
        return res.data        
    }

    static async add_event(audience_event){
        const res = await axios.post(url.concat('/add'), audience_event)
        return res.data
    }

    static async ajouter(audience_event){
        const res = await axios.post(url.concat('/ajouter'), audience_event)
        return res.data
    }

    static async supprimer(id){
        const res = await axios.post(url.concat('/supprimer/',id))
        return res.data
    }

    static async modifier(audience){
        const res = await axios.post(url.concat('/modifier'),audience)
        return res.data
    }

    static async update(audience_event){
        const res = await axios.post(url.concat('/update'), audience_event)
        return res.data
    }

    static async delete(audience_event){
        const res = await axios.post(url.concat('/delete'), audience_event)
        return res.data
    }

    static async valider_public(dm_aud_public){
        const res = await axios.post(url.concat('/valider'),dm_aud_public)
        return res.data
    }

    static async revalider_public(dm_aud_public){
        const res = await axios.post(url.concat('/revalider'),dm_aud_public)
        return res.data
    }

    static async reporter_public_maintenant(audience_event){
        const res = await axios.post(url.concat('/reporter/now'),audience_event)
        return res.data       
    }

    static async reporter_public_plus_tard(audience_event){
        const res = await axios.post(url.concat('/reporter/later'),audience_event)
        return res.data       
    }
}