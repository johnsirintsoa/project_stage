import Notification from "../../models/BackOffice/Notification";

export default class NotificationController{
    static async notification_autorite(infos){
        const res = await Notification.notifications_autorite(infos)
        return res        
    }

    static async notification_back_end(){
        // const res = await Notification.notification_back_end()
        const res = await Notification.showNotification()
        return res        
    }

} 