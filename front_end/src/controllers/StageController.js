import StageModel from '../models/Stage';

export default class StageController{

    static async liste(filtre){
        const res = await StageModel.liste(filtre)
        return res
    }

    static async detail(id){
        const res = await StageModel.detail(id)
        return res
    }

    static async filtre(filtre){
        const res = await StageModel.filtre(filtre)
        return res
    }
}