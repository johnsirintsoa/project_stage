import StageApi from '../api/demande_stage'

export default class Stage {

    static async liste(filtre){
        const res = await StageApi.liste(filtre)
        return res
    }    
}