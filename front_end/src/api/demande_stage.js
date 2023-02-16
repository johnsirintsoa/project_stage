import axios from 'axios'
import dom  from './config'
// const domaine = "http://localhost:3000"
// const url = domaine.concat("/api/stage")

const route1 = 'stage'


export default class DemandeStageAPI{
    // static addDemandeStage(demande_stage){
    //     const res = await axios.post(url.concat('/add'),demande_stage)
    //     return res.data
    // }
    static async addDemandeStage(demande_stage){
      const url = dom.domaineBackEnd(route1,'/add')
      // const res = await axios.post(url,audience_mois)
        await axios.post(url, demande_stage, {
          }).then((response) => {
            console.log(response)
          })
    }

    static async sendSms(sms_option){
      const url = dom.domaineBackEnd(route1,'/sendSms')
      await axios.post(url, sms_option, {
      }).then((response) => {
        console.log(response)
      })
    }

    static async getFile(file_name){
      const url = dom.domaineBackEnd(route1,'/file/')
      await axios
      .get(url.concat(file_name),{
        headers: {
          Accept: 'application/pdf',
          'Content-Type': 'application/pdf',
          mode: 'no-cors'
        },
        responseType: 'blob'
      })
      .then(response => {
        console.log(response)
      })
      .catch(error => console.log(error))
    }

    // liste stages avec status
    static async all_status(id_autorite_enfant){
      const url = dom.domaineBackEnd(route1,'/all_status/')
      const res = await axios.post(url,id_autorite_enfant)
      // const res = await axios.get(url.concat('/all_status/',id_autorite_enfant))
      return res.data
    }

    static async liste(filtre){
      const url = dom.domaineBackEnd(route1,'/liste')
      const res = await axios.post(url,filtre)
      // const res = await axios.post(url.concat('/liste'),filtre)
      return res.data
    }

    static async filtre(filtre){
      const url = dom.domaineBackEnd(route1,'/filtre')
      const res = await axios.post(url,filtre)
      // const res = await axios.post(url.concat('/filtre'),filtre)
      return res.data
    }

    // detail stage
    static async detail(id_demande_stage){
      const url = dom.domaineBackEnd(route1,'/detail')
      const res = await axios.post(url,id_demande_stage)
      // const res = await axios.post(url.concat('/detail'),id_demande_stage)
      return res.data
    }

    static async prolonger(arg){
      const url = dom.domaineBackEnd(route1,'/prolonger')
      const res = await axios.post(url,arg)
      // const res = await axios.post(url.concat('/prolonger'),arg)
      return res.data
    }

    // send mail
    static async sendMail(sendMail){
      const url = dom.domaineBackEnd(route1,'/sendMail')
      // const res = await axios.post(url,arg)
      await axios.post(url,sendMail, {
      }).then((response) => {
        console.log(response)
      })
    }


}