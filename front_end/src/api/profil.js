import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/profil")

export default class ProfilAPI{
    // login
    static async login(log){
        try {
            const response = await axios.post(url.concat('/login'),log);
            // console.log(response);
            return response.data
        }
        catch (error) {
            console.log(error);
        }
    }

    static async inscription(infos){
        try {
            const response = await axios.post(url.concat('/inscription'),infos);
            // console.log(response);
            return response.data
        }
        catch (error) {
            console.log(error);
        }
    }

}