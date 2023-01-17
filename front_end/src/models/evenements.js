import EvenementApi from '../api/evenement'

export default class Evenemnent {

    static async valider(arg){
        const res = await EvenementApi.valider(arg)
        return res
    }

    static async revalider(arg){
        const res = await EvenementApi.revalider(arg)
        return res
    }

}