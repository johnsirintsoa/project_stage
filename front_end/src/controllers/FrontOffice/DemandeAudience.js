import DemandeAudiencePublic from '../../models/DemandeAudience/Public'

export const actual_events_public_MOIS = async (id_autorite_enfant) => {
    const mois = parseInt(new Date().getMonth())+1
    const date_actu = new Date().getFullYear()+"-"+mois+"-"+new Date().getDate()
    const audience_public_mois = {
      id_autorite: id_autorite_enfant,
      date_du_jour: date_actu,
      session_navigateur: JSON.parse(sessionStorage.getItem('session_navigateur')).value
      // session_navigateur: 'TEST123456789'
    }
    const audience = DemandeAudiencePublic.audience_public_mois(audience_public_mois)
    try {
      return await audience
    } catch (error) {
      console.log(error)
    }
    return audience
}

export default class DemandeAudiencePublicController{
    
    static async add(audience_event){
        const response = await DemandeAudiencePublic.add(audience_event)
        return response
    }

    static async update(audience) {
        const response = await DemandeAudiencePublic.update(audience)
        return response
    }
}

