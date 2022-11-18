import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/audience/non_disponible_autorite_date")
export default class non_disponible_autorite_date {

    static async add_non_disponible_date(audience){
        const res = await axios.post(url.concat('/add'),audience)
        return res.data
    }

    static async insert(audience){
        const res = await axios.post(url.concat('/insert/add'),audience)
        return res.data
    }
}