import axios from 'axios'
const domaine = "http://192.168.100.160:3000"
const url = domaine.concat("/api/direction")

export default class DirectionAPI{
    // all doleance
    static async getAllDirection(){
        const res = await axios.get(url.concat('/all'))
        return res.data
    }

    static async getMysqlDirections(){
        const res = await axios.get(url.concat('/mysql/all'))
        return res.data
    }

}
