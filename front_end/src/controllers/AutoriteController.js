import AutoriteModel from '../models/Autorite'
export default class AutoriteController{

    static async liste(){
        const res = await AutoriteModel.liste()
        return res
    }

    static async calendrier(id_autorite){
        const res = await AutoriteModel.calendrier(id_autorite)
        return res
    }
}