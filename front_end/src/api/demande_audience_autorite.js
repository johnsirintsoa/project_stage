import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/audience")

export default class DemandeAudience{

    static async audience_autorite_all(audience_mois){
        const res = await axios.post(url.concat('/autorite/all/mois'),audience_mois)
        return res.data
    }
}