import Audiences from '../../api/demande_audience_autorite';

export default class Notification {
    
    static async notifications(id){
        const res = await Audiences.notifications(id)
        return res        
    }

}