import EntretienModel from '../models/Entretien'
export default class EntretienController{

    static async ajouter(infos_stage){
        const res = await EntretienModel.ajouter(infos_stage)
        return res
    }

    static async modifier(infos_stage){
        const res = await EntretienModel.modifier(infos_stage)
        return res
    }

    static async supprimer(infos_stage){
        const res = await EntretienModel.supprimer(infos_stage)
        return res
    }

    static async modifier_calendrier(infos_stage){
        const res = await EntretienModel.modifier_calendrier(infos_stage)
        return res        
    }
}