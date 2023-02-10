import axios from 'axios'
const domaine = "http://192.168.100.160:3000"
const url = domaine.concat("/api/nonDispo")

export default class NonDispoAPI{
    static async ajouter_non_disponible(arg){
        const res = await axios.post(url.concat('/ajouter_non_disponible'),arg)
        return res.data       
    }

    static async modifier_non_disponible(arg){
        const res = await axios.post(url.concat('/modifier_non_disponible'),arg)
        return res.data       
    }

    static async supprimer_non_disponible(arg){
        const res = await axios.post(url.concat('/supprimer_non_disponible'),arg)
        return res.data       
    }
}