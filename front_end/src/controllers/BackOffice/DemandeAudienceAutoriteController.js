import DemandeAudienceAutorite from '../../models/DemandeAudience/Autorite';

export default class DemandeAudienceAutoriteController{

    static async faire_audience(audience){
        const res = await DemandeAudienceAutorite.faire_audience(audience)
        return res
    }

    static async ajouter(audience){
        const res = await DemandeAudienceAutorite.ajouter(audience)
        return res
    }

    static async modifier(audience){
        const res = await DemandeAudienceAutorite.modifier(audience)
        return res
    }

    static async supprimer(audience){
        const response = await DemandeAudienceAutorite.supprimer(audience)
        return response
    }

    static async valider(audience){
        const response = await DemandeAudienceAutorite.valider(audience)
        return response
    }

    static async reporter_maintenant(audience){
        const response = await DemandeAudienceAutorite.reporter_maintenant(audience)
        return response
    }
    
    static async reporter_plus_tard(audience){
        const response = await DemandeAudienceAutorite.reporter_plus_tard(audience)
        return response
    }

    static async liste_audiences_reportes(id_autorite){
        const response = await DemandeAudienceAutorite.liste_audiences_reportes(id_autorite)
        return response
    }

    static async liste_audiences_validees(id_autorite){
        const response = await DemandeAudienceAutorite.liste_audience_validees(id_autorite)
        return response
    }

    static async revalider(audience){
        const response = await DemandeAudienceAutorite.revalider(audience)
        return response
    }
}