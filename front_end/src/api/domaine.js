import axios from 'axios'
const domaine = "http://192.168.100.160:3000"
const url = domaine.concat("/api/domaine")

export default class DomaineAPI{
    // all doleance
    static async allDomaine(){
        const res = await axios.get(url.concat('/all'))
        return res.data
    }

}
