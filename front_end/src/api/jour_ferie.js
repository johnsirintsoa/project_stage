import axios from 'axios'
const domaine = "http://192.168.100.160:3000"
const url = domaine.concat("/api/jour_ferie")

export default class Jour_ferie{
    static async all_jour_ferie(){
        const res = await axios.get(url.concat('/all'))
        return res.data
    }
}