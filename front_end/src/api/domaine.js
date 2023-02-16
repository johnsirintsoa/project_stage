import axios from 'axios'
import dom  from './config'

// const domaine = "http://localhost:3000"
// const url = domaine.concat("/api/domaine")

export default class DomaineAPI{
    // all doleance
    static async allDomaine(){
        const url = dom.domaineBackEnd('domaine','/all')
        const res = await axios.get(url)
        return res.data
    }

}
