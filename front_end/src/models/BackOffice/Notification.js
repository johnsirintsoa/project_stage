import Audiences from '../../api/demande_audience_autorite';
import Notifications from '../../api/notification';


export default class notificationModel {
    
    static async notifications(id){
        const res = await Audiences.notifications(id)
        return res        
    }

    static async notifications_autorite(infos){
        const res = await Notifications.notifications(infos)
        return res
    }

    static async showNotification(){
        const res = this.askPermission()
        return res
    }

    static async askPermission() {
        const permission = await Notification.requestPermission();
        if (permission === "granted") {
          // registerServiceWorker();
        }
    }
    static async registerServiceWorker() {
        const registration = await navigator.serviceWorker.register("/sw.js");
        let subscription = await registration.pushManager.getSubscription();
        // L'utilisateur n'est pas déjà abonné, on l'abonne au notification push
        if (!subscription) {
          subscription = await registration.pushManager.subscribe({
            userVisibleOnly: true,
            applicationServerKey: await getPublicKey(),
          });
        }
      
        await saveSubscription(subscription);
      }


}