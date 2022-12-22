import axios from 'axios'
const domaine = "http://localhost:3000"
const url = domaine.concat("/api/stage")


export default class DemandeStageAPI{
    // static addDemandeStage(demande_stage){
    //     const res = await axios.post(url.concat('/add'),demande_stage)
    //     return res.data
    // }
    static async addDemandeStage(demande_stage){
        await axios.post(url.concat('/add'), demande_stage, {
          }).then((response) => {
            console.log(response)
          })
    }

    static async sendSms(sms_option){
      await axios.post(url.concat('/sendSms'), sms_option, {
      }).then((response) => {
        console.log(response)
      })
    }

    static async getFile(file_name){
      await axios
      .get(url.concat('/file/',file_name),{
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
        const res = await axios.get(url.concat('/all_status/',id_autorite_enfant))
        return res.data
    }

    static async liste(filtre){
      const res = await axios.post(url.concat('/liste'),filtre)
      return res.data
    }

    // detail stage
    static async detail(id_autorite_enfant,id_demande_stage){
      const arg = {
        id_autorite_enfant:id_autorite_enfant,
        id_demande_stage:id_demande_stage
      }
      const res = await axios.post(url.concat('/detail'),arg)
      return res.data
    }

    static async prolonger(arg){
      const res = await axios.post(url.concat('/prolonger'),arg)
      return res.data
    }

    // send mail
    static async sendMail(sendMail){
      await axios.post(url.concat('/sendMail'),sendMail, {
      }).then((response) => {
        console.log(response)
      })
    }


}