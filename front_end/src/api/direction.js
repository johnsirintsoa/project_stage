import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/direction")

export default class DirectionAPI{
    // all doleance
    static async getAllDirection(){
        const res = await axios.get(url.concat('/all'))
        return res.data
    }

}
