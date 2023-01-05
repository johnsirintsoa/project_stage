import AutoriteApi from '../api/autorite'

export default class Autorite {

    static async calendrier(id_autorite){
        const res = await AutoriteApi.calendrier(id_autorite)
        return res
    }

    static async liste(){
        const res = await AutoriteApi.liste()
        return res
    }    
}