import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/token")

export default class TokenApi{
    static async generer(){
        const response = await axios.get(url.concat('/generer'))
        return response.data
    }
}
