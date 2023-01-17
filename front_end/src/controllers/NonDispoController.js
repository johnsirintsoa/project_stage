import NonDispoModel from '../models/NonDispo'

export default class NonDispoController {
    static async ajouter_non_disponible(arg){
        const res = await NonDispoModel.ajouter_non_disponible(arg)
        return res
    }
    static async modifier_non_disponible(arg){
        const res = await NonDispoModel.modifier_non_disponible(arg)
        return res
    }
    static async supprimer_non_disponible(arg){
        const res = await NonDispoModel.supprimer_non_disponible(arg)
        return res
    }
}