import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/profil")

export default class ProfilAPI{
    // login
    static async login(username,pwd){
        try {
            const response = await axios.post(url.concat('/login/',username,'/',pwd));
            // console.log(response);
            return response.data
        }
        catch (error) {
            console.log(error);
        }
    }

}