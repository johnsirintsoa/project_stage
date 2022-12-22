import StageModel from '../models/Stage';

export default class StageController{

    static async liste(filtre){
        const res = await StageModel.liste(filtre)
        return res
    }
}