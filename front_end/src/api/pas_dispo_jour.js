import axios from 'axios'
const domaine = "http://192.168.100.160:3000"
const url = domaine.concat("/api/audience/non_disponible_autorite_jour")
export default class non_disponible_autorite_date {

    static async add_non_disponible_jour(audience){
        const res = await axios.post(url.concat('/add'),audience)
        return res.data
    }

    static async insert(audience){
        const res = await axios.post(url.concat('/insert/add'),audience)
        return res.data
    }
    
}