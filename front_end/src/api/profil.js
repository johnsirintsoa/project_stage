import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/profil")

export default class ProfilAPI{
    // login
    static async login(username,pwd){
        const res = await axios.post(url.concat('/login/',username,'/',pwd))
        return res.data
    }

}