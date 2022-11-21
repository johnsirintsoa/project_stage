import Public from '../../api/demande_audience_public'
export default class DemandeAudiencePublic {
    
    static async audience_public_mois(id_autorite){
        const res = await Public.audience_public_mois(id_autorite)
        return res        
    }

    static async add(audience_event){
        const res = await Public.add_event(audience_event)
        return res
    }

    static async update(audience_event){
        const res = await Public.update(audience_event)
        return res
    }

    static async delete(audience_event){
        const res = await this.delete(audience_event)
        return res
    }
}