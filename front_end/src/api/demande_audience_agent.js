import axios from 'axios'
import dom  from './config'

// const domaine = "http://localhost:3000"
// const url = domaine.concat("/api/audience/public")
const route1 = 'audience/agent'


export default class DemandeAudienceAgent{

    static async ajouter(audience_event){
        const url = dom.domaineBackEnd(route1,'/ajouter')
        const res = await axios.post(url,audience_event)    
        // const res = await axios.post(url.concat('/ajouter'), audience_event)
        return res.data
    }

    
    static async modifier(audience){
        const url = dom.domaineBackEnd(route1,'/modifier')
        const res = await axios.post(url,audience)
        // const res = await axios.post(url.concat('/modifier'),audience)
        return res.data
    }

}