import DemandeAudienceAutorite from '../../models/DemandeAudience/Autorite';
import NotificationsModels from '../../models/BackOffice/Notification';

export default class DemandeAudienceAutoriteController{

    static async notifications(id){
        const response = await NotificationsModels.notifications(id)
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
}