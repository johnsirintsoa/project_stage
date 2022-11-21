import NotificationsModels from '../../models/BackOffice/Notification';

export default class DemandeAudienceAutoriteController{

    static async notifications(id){
        const response = await NotificationsModels.notifications(id)
        return response
    }
}