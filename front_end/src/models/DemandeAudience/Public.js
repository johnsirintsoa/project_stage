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
        const res = await Public.delete(audience_event)
        return res
    }

    static async valider(audience){
        const res = await Public.valider_public(audience)
        return res
    }

    static async reporter_maintenant(audience){
        const res = await Public.reporter_public_maintenant(audience)
        return res
    }

    static async reporter_plus_tard(audience){
        const res = await Public.reporter_public_plus_tard(audience)
        return res
    }
}