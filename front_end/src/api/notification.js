import axios from 'axios'
const domaine = "http://192.168.100.160:3000"
const url = domaine.concat("/api/notification")

export default class NotificationAPI{

    static async notifications(infos){
        const res = await axios.post(url.concat('/autorite/non_valide'),infos)
        return res.data
    }
}