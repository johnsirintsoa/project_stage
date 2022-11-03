import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/autorite")

export default class AutoriteAPI{
    // all doleance
    static async autorite_enfant(){
        const res = await axios.get(url.concat('/enfant/all'))
        return res.data
    }

    static async autorite_enfant_autorite(id_autorite_enfant){
        const res = await axios.get(url.concat('/enfant/all/',id_autorite_enfant))
        return res.data
    }
}