import axios from 'axios'
import dom  from './config'
const route1 = 'evenement'
// const domaine = "http://localhost:3000"
// const url = domaine.concat("/api/evenement")

export default class EvenementApi{

    static async valider(arg){
        const url = dom.domaineBackEnd(route1,'/valider')
        const res = await axios.post(url,arg)
        // const res = await axios.post(url.concat('/valider'),arg)
        return res.data       
    }

    static async revalider(arg){
        const url = dom.domaineBackEnd(route1,'/revalider')
        const res = await axios.post(url,arg)
        // const res = await axios.post(url.concat('/revalider'),arg)
        return res.data       
    }

    static async setTerminer(arg){
        const url = dom.domaineBackEnd(route1,'/terminer')
        const res = await axios.post(url,arg)
        // const res = await axios.post(url.concat('/revalider'),arg)
        return res.data       
    }

}