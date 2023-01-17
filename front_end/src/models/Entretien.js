import EntretienApi from '../api/entretien_stage'

export default class Entretien {

    static async ajouter(infos_stage){
        const res = await EntretienApi.ajouter(infos_stage)
        return res
    }    

    static async modifier(infos_stage){
        const res = await EntretienApi.modifier(infos_stage)
        return res
    }

    static async supprimer(infos_stage){
        const res = await EntretienApi.supprimer(infos_stage)
        return res
    }

    static async modifier_calendrier(infos_stage){
        const res = await EntretienApi.modifier_calendrier(infos_stage)
        return res        
    }
}