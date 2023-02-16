import axios from 'axios'
import dom  from './config'
const route1 = 'profil'

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