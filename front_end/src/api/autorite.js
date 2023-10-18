// import axios from 'axios'
import axios from 'axios'
import dom  from './config'
import Function from '../func/function';

// const domaine = "http://localhost:3000"
// const url = domaine.concat("/api/autorite")
const route1 = 'autorite'

export default class AutoriteAPI{

    static async getStructure(path){
        const url = dom.domaineBackEnd(route1,'/structure')
        // const res = await axios.post(url.concat('/structure'),path)
        const res = await axios.post(url,path)
        return res.data
    }

    static async structureBackOffice(path){
        const url = dom.domaineBackEnd(route1,'/backOffice/structure')
        // const res = await axios.post(url.concat('/backOffice/structure'),path)
        const res = await axios.post(url,path)
        return res.data
    }

    static async login(arg){
        const url = dom.domaineBackEnd(route1,'/login')
        const res = await axios.post(url,arg)
        // const res = await axios.post(url.concat('/login'),arg)
        return res.data.db
    }

    static async calendrier(arg){
        const url = dom.domaineBackEnd(route1,'/calendrier')
        const res = await axios.post(url,arg)
        // console.log(res.data)
        const dateTime = Function.dateIso(new Date())
        // console.log(dateTime)
        res.data.push({
            start: '1970-01-01T00:00:00',
            end: dateTime,
            overlap: false,
            display: 'background',
            color: '#c8cacb9c'
        })

        return res.data       
    }

    static async place_disponible(id_autorite){
        const url = dom.domaineBackEnd(route1,'/place_disponible')
        const res = await axios.post(url,id_autorite)
        // const res = await axios.post(url.concat('/place_disponible'),id_autorite)
        return res.data       
    }

    static async filtre_calendrier(arg) {
        const url = dom.domaineBackEnd(route1,'/filtre_calendrier')
        const res = await axios.post(url,arg)
        // const res = await axios.post(url.concat('/filtre_calendrier'),arg)
        return res.data       
    }

    // static async liste(){
    //     const url = dom.domaineBackEnd(route1,'/liste')
    //     const res = await axios.get(url)
    //     // const res = await axios.get(url.concat('/liste'))
    //     return res.data
    // }

    // all doleance
    // static async autorite_enfant(){
    //     const url = dom.domaineBackEnd(route1,'/enfant/all')
    //     const res = await axios.get(url)
    //     // const res = await axios.get(url.concat('/enfant/all'))
    //     return res.data
    // }

    // static async autorite_enfant_autorite(id_autorite_enfant){
    //     const url = dom.domaineBackEnd(route1,'/enfant/all')
    //     const res = await axios.get(url.concat('/',id_autorite_enfant))
    //     // const res = await axios.get(url.concat('/enfant/all/',id_autorite_enfant))
    //     return res.data
    // }
}