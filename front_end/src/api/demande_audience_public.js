import axios from 'axios'
import dom  from './config'

// const domaine = "http://localhost:3000"
// const url = domaine.concat("/api/audience/public")
const route1 = 'audience/public'


export default class DemandeAudience{

    static async liste(arg){
        const url = dom.domaineBackEnd(route1,'/all')
        const res = await axios.post(url,arg)
        // const res = await axios.post(url.concat('/all'),arg)
        return res.data
    }

    static async audience_public_jour(arg){
        const url = dom.domaineBackEnd(route1,'/heure_disponible_autorite/jour')
        const res = await axios.post(url,arg)
        // const res = await axios.post(url.concat('/heure_disponible_autorite/jour'),arg)
        return res.data        
    }

    static async add_event(audience_event){
        const url = dom.domaineBackEnd(route1,'/add')
        const res = await axios.post(url,audience_event)        
        // const res = await axios.post(url.concat('/add'), audience_event)
        return res.data
    }

    static async ajouter(audience_event){
        const url = dom.domaineBackEnd(route1,'/ajouter')
        const res = await axios.post(url,audience_event)    
        // const res = await axios.post(url.concat('/ajouter'), audience_event)
        return res.data
    }

    static async supprimer(id){
        const url = dom.domaineBackEnd(route1,'/supprimer/')
        const res = await axios.post(url.concat(id))
        // const res = await axios.post(url.concat('/supprimer/',id))
        return res.data
    }

    static async modifier(audience){
        const url = dom.domaineBackEnd(route1,'/modifier')
        const res = await axios.post(url,audience)
        // const res = await axios.post(url.concat('/modifier'),audience)
        return res.data
    }

    static async update(audience_event){
        const url = dom.domaineBackEnd(route1,'/update')
        const res = await axios.post(url,audience_event)
        // const res = await axios.post(url.concat('/update'), audience_event)
        return res.data
    }

    static async delete(audience_event){
        const url = dom.domaineBackEnd(route1,'/delete')
        const res = await axios.post(url,audience_event)
        // const res = await axios.post(url.concat('/delete'), audience_event)
        return res.data
    }

    static async valider_public(dm_aud_public){
        const url = dom.domaineBackEnd(route1,'/valider')
        const res = await axios.post(url,dm_aud_public)
        // const res = await axios.post(url.concat('/valider'),dm_aud_public)
        return res.data
    }

    static async revalider_public(dm_aud_public){
        const url = dom.domaineBackEnd(route1,'/revalider')
        const res = await axios.post(url,dm_aud_public)
        // const res = await axios.post(url.concat('/revalider'),dm_aud_public)
        return res.data
    }

    static async reporter_public_maintenant(audience_event){
        const url = dom.domaineBackEnd(route1,'/reporter/now')
        const res = await axios.post(url,audience_event)
        // const res = await axios.post(url.concat('/reporter/now'),audience_event)
        return res.data       
    }

    static async reporter_public_plus_tard(audience_event){
        const url = dom.domaineBackEnd(route1,'/reporter/later')
        const res = await axios.post(url,audience_event)
        // const res = await axios.post(url.concat('/reporter/later'),audience_event)
        return res.data       
    }
}