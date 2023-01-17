import AutoriteModel from '../models/Autorite'
export default class AutoriteController{

    static async liste(){
        const res = await AutoriteModel.liste()
        return res
    }

    static async place_disponible(id_autorite){
        const res = await AutoriteModel.place_disponible(id_autorite)
        return res
    }

    static async non_disponible(arg){
        const res = await AutoriteModel.non_disponible(arg)
        return res
    }

    static async calendrier(id_autorite){
        const res = await AutoriteModel.calendrier(id_autorite)
        return res
    }

    static async filtre_calendrier(arg){
        const res = await AutoriteModel.filtre_calendrier(arg)
        return res
    }
}