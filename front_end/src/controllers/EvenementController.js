import EvenementModel from '../models/evenements'
export default class EvenemnentController{

    static async valider(arg){
        const res = await EvenementModel.valider(arg)
        return res
    }
    static async revalider(arg){
        const res = await EvenementModel.revalider(arg)
        return res
    }
}