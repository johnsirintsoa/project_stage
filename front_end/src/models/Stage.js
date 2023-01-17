import StageApi from '../api/demande_stage'

export default class Stage {

    static async liste(filtre){
        const res = await StageApi.liste(filtre)
        return res
    }    

    static async detail(id){
        const res = await StageApi.detail(id)
        return res
    } 
    
    static async filtre(filtre){
        const res = await StageApi.filtre(filtre)
        return res
    } 
}