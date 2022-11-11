import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/audience/public")

export default class DemandeAudience{

    static async audience_public_all(id_autorite_enfant){
        const res = await axios.get(url.concat('/all/',id_autorite_enfant))
        return res.data
    }

    static async audience_public_mois(id_autorite){
        const res = await axios.post(url.concat('/all/mois'),id_autorite)
        return res.data        
    }

    static async audience_public_semaine(id_autorite){
        const res = await axios.post(url.concat('/all/semaine'),id_autorite)
        return res.data        
    }

    static async audience_public_jour(id_autorite){
        const res = await axios.post(url.concat('/all/jour'),id_autorite)
        return res.data        
    }
}