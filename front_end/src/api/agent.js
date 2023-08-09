// import axios from 'axios'
import axios from 'axios'
import dom  from './config'
import Function from '../func/function';

// const domaine = "http://localhost:3000"
// const url = domaine.concat("/api/autorite")
const route1 = 'agent'

export default class AgentAPI{


    static async login(arg){
        const url = dom.domaineBackEnd(route1,'/login')
        const res = await axios.post(url,arg)
        // const res = await axios.post(url.concat('/login'),arg)
        return res.data
    }


}