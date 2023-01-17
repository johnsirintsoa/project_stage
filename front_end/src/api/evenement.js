import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/evenement")

export default class EvenementApi{

    static async valider(arg){
        const res = await axios.post(url.concat('/valider'),arg)
        return res.data       
    }

    static async revalider(arg){
        const res = await axios.post(url.concat('/revalider'),arg)
        return res.data       
    }

}