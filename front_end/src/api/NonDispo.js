import axios from 'axios'
import dom  from './config'
const route1 = 'nonDispo'
// const domaine = "http://localhost:3000"
// const url = domaine.concat("/api/nonDispo")
import authHeader from './auth-header'


export default class NonDispoAPI{
    static async ajouter_non_disponible(arg){
        const url = dom.domaineBackEnd(route1,'/ajouter_non_disponible')
        const res = await axios.post(url,arg,{headers: authHeader()})
        // const res = await axios.post(url.concat('/ajouter_non_disponible'),arg)
        return res.data       
    }

    static async modifier_non_disponible(arg){
        const url = dom.domaineBackEnd(route1,'/modifier_non_disponible')
        const res = await axios.post(url,arg,{headers: authHeader()})
        // const res = await axios.post(url.concat('/modifier_non_disponible'),arg)
        return res.data       
    }

    static async supprimer_non_disponible(arg){
        const url = dom.domaineBackEnd(route1,'/supprimer_non_disponible')
        const res = await axios.post(url,arg,{headers: authHeader()})
        // const res = await axios.post(url.concat('/supprimer_non_disponible'),arg)
        return res.data       
    }
}