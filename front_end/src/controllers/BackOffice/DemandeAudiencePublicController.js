import DemandeAudiencePublic from "../../models/DemandeAudience/Public"

export default class DemandeAudiencePublicController{

    static async valider(audience){
        const response = await DemandeAudiencePublic.valider(audience)
        return response
    }

    static async reporter_maintenant(audience){
        const response = await DemandeAudiencePublic.reporter_maintenant(audience)
        return response
    }

    static async reporter_plus_tard(audience){
        const response = await DemandeAudiencePublic.reporter_plus_tard(audience)
        return response
    }

}