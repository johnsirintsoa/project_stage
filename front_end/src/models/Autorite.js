import AutoriteApi from '../api/autorite'

export default class Autorite {

    static async calendrier(id_autorite){
        const res = await AutoriteApi.calendrier(id_autorite)
        return res
    }

    static async place_disponible(id_autorite){
        const res = await AutoriteApi.place_disponible(id_autorite)
        return res
    }

    static async filtre_calendrier(arg){
        const res = await AutoriteApi.filtre_calendrier(arg)
        return res
    }


    static async liste(){
        const res = await AutoriteApi.liste()
        return res
    }    
}