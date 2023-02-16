import axios from 'axios'
import dom  from './config'
const route1 = 'doleance'

// const domaine = "http://localhost:3000"
// const url = domaine.concat("/api/doleance")

export default class DoleanceAPI{

    // filtrer doleance

    static async liste_public(arg){
        const url = dom.domaineBackEnd(route1,'/liste/public')
        const res = await axios.post(url,arg)
        // const res = await axios.post(url.concat('/liste/public'), arg)
        return res.data
    }


    static async ajouter_anonyme(arg){
        const url = dom.domaineBackEnd(route1,'/ajouter/anonyme')
        const res = await axios.post(url,arg)
        // const res = await axios.post(url.concat('/ajouter/anonyme'), arg)
        return res.data
    }

    static async filtre(arg){
        const url = dom.domaineBackEnd(route1,'/filtre')
        const res = await axios.post(url,arg)
        // const res = await axios.post(url.concat('/filtre'), arg)
        return res.data
    }

    static async ajouter_non_anonyme(arg){
        const url = dom.domaineBackEnd(route1,'/ajouter/non_anonyme')
        const res = await axios.post(url,arg)
        // const res = await axios.post(url.concat('/ajouter/non_anonyme'), arg)
        return res.data
    }

    static async modifier(arg){
        const url = dom.domaineBackEnd(route1,'/modifier')
        const res = await axios.post(url,arg)
        // const res = await axios.post(url.concat('/modifier'), arg)
        return res.data
    }
    static async supprimer(id){
        const url = dom.domaineBackEnd(route1,'/supprimer/')
        const res = await axios.get(url.concat(id))
        // const res = await axios.get(url.concat('/supprimer/',id))
        return res.data
    }

}
