// import axios from 'axios'
import axios from 'axios'
import dom  from './config'
import Function from '../func/function';

// const domaine = "http://localhost:3000"
// const url = domaine.concat("/api/autorite")
const route1 = 'chart'

export default class chartAPI{


    static async dashboard_doleance(arg){
        const url = dom.domaineBackEnd(route1,'/barre/doleance')
        const res = await axios.post(url,arg)
        // const res = await axios.post(url.concat('/login'),arg)
        return res.data
    }

    static async dashboard_stage(arg){
        const url = dom.domaineBackEnd(route1,'/barre/stage')
        const res = await axios.post(url,arg)
        // const res = await axios.post(url.concat('/login'),arg)
        return res.data
    }


}