import NonDispoAPI from '../api/NonDispo'

export default class NonDispo {
    
    static async ajouter_non_disponible(arg){
        const res = await NonDispoAPI.ajouter_non_disponible(arg)
        return res
    }

    static async modifier_non_disponible(arg){
        const res = await NonDispoAPI.modifier_non_disponible(arg)
        return res
    }

    static async supprimer_non_disponible(arg){
        const res = await NonDispoAPI.supprimer_non_disponible(arg)
        return res
    }
}