import axios from 'axios'
import dom  from './config'
// const domaine = "http://localhost:3000"
// const url = domaine.concat("/api/audience/autorite")

import authHeader from './auth-header'


const route1 = 'audience/autorite'

export default class DemandeAudienceAutorite {


    static async audience_autorite_all(audience_mois){
        const url = dom.domaineBackEnd(route1,'/all/mois')
        const res = await axios.post(url,audience_mois)
        // const res = await axios.post(url.concat('/all/mois'),audience_mois)
        return res.data
    }

    static async faire_audience(audience){
        const url = dom.domaineBackEnd(route1,'/faire_audience')
        const res = await axios.post(url,audience,{headers: authHeader()})

        // const res = await axios.post(url.concat('/faire_audience'),audience)
        return res.data
    }

    static async ajouter(audience){
        const url = dom.domaineBackEnd(route1,'/ajouter')
        const res = await axios.post(url,audience)
        // const res = await axios.post(url.concat('/ajouter'),audience)
        return res.data
    }

    static async modifier(audience_event){
        const url = dom.domaineBackEnd(route1,'/modifier')
        const res = await axios.post(url,audience_event,{headers: authHeader()})

        // const res = await axios.post(url.concat('/modifier'), audience_event)
        return res.data
    }

    static async supprimer(id){
        const url = dom.domaineBackEnd(route1,'/supprimer')
        const res = await axios.post(url,id,{headers: authHeader()})
        // const res = await axios.post(url.concat('/supprimer'), id)
        return res.data
    }

    static async delete_audience_autorite(id){
        const url = dom.domaineBackEnd(route1,'/delete')
        const res = await axios.post(url,id)
        // const res = await axios.post(url.concat('/delete'),id)
        return res.data
    }

    static async valider(dm_aud_autorite){
        const url = dom.domaineBackEnd(route1,'/valider')
        const res = await axios.post(url,dm_aud_autorite,{headers: authHeader()})
        // const res = await axios.post(url.concat('/valider'),dm_aud_autorite)
        return res.data
    }

    static async reporter_maintenant(audience_event){
        const url = dom.domaineBackEnd(route1,'/reporter/now')
        const res = await axios.post(url,audience_event,{headers: authHeader()})
        // const res = await axios.post(url.concat('/reporter/now'),audience_event)
        return res.data       
    }
    static async reporter_plus_tard(audience_event) {
        const url = dom.domaineBackEnd(route1,'/reporter/later')
        const res = await axios.post(url,audience_event,{headers: authHeader()})
        // const res = await axios.post(url.concat('/reporter/later'),audience_event)
        return res.data       
    }

    static async reporter_by_click(event) {
        const url = dom.domaineBackEnd(route1,'/reporter/click')
        const res = await axios.post(url,event,{headers: authHeader()})
        // const res = await axios.post(url.concat('/reporter/later'),audience_event)
        return res.data       
    }

    // Liste audiences reportées
    static async audiences_reporter(id_autorite_enfant){
        const url = dom.domaineBackEnd(route1,'/reporter/all/')
        const res = await axios.get(url.concat(id_autorite_enfant))
        // const res = await axios.get(url.concat('/reporter/all/',id_autorite_enfant))
        return res.data
    }

    static async audiences_valider(id_autorite_enfant){
        const url = dom.domaineBackEnd(route1,'/valider/all/')
        const res = await axios.get(url.concat(id_autorite_enfant))
        // const res = await axios.get(url.concat('/valider/all/',id_autorite_enfant))
        return res.data
    }

    static async revalider(dm_aud_autorite){
        const url = dom.domaineBackEnd(route1,'/revalider')
        const res = await axios.post(url,dm_aud_autorite,{headers: authHeader()})
        // const res = await axios.post(url.concat('/revalider'),dm_aud_autorite)
        return res.data
    }
}