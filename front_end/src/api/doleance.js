import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/doleance")

export default class DoleanceAPI{

    // filtrer doleance

    static async liste_public(arg){
        const res = await axios.post(url.concat('/liste/public'), arg)
        return res.data
    }


    static async ajouter_anonyme(arg){
        const res = await axios.post(url.concat('/ajouter/anonyme'), arg)
        return res.data
    }

    static async filtre(arg){
        const res = await axios.post(url.concat('/filtre'), arg)
        return res.data
    }

    static async ajouter_non_anonyme(arg){
        const res = await axios.post(url.concat('/ajouter/non_anonyme'), arg)
        return res.data
    }

    static async modifier_anonyme(arg){
        const res = await axios.post(url.concat('/modifier/anonyme'), arg)
        return res.data
    }

    static async filter_doleance(date_1,date_2,direction){
        const res = await axios.get(url.concat('/filter/',date_1,'/',date_2,'/',direction))
        return res.data
    }

    // all doleance
    static async getAllDoleance(){
        const res = await axios.get(url.concat('/all'))
        return res.data
    }

    // all doleance
    static async getDoleanceBySession(){
        const session = JSON.parse(sessionStorage.getItem('session_navigateur')).value
        const res = await axios.get(url.concat('/my_doleances/',session))
        return res.data
    }

    // doleance by id
    static async getDoleanceById(doleance_id){
        const res = await axios.get(url.concat('/detail/',doleance_id))
        return res.data
    }
    // add doleance
    static async addDoleance(doleance){
        const res = await axios.post(url.concat('/add'),doleance)
        return res.data
    }
    // update doleance
    static async updateDoleance(doleance_id,doleance){
        const res = await axios.patch(url.concat('/update/',doleance_id),doleance)
        return res.data
    }
    // delete doleance 
    static async deleteDoleance(doleance_id){
        const res = await axios.delete(url.concat('/delete/',doleance_id))
        return res.data
    }

}
