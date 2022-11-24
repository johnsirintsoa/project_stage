import Autorite from '../../api/demande_audience_autorite'
export default class DemandeAudienceAutorite {

    static async valider(audience){
        const res = await Autorite.valider(audience)
        return res
    }

    static async revalider(audience){
        const res = await Autorite.revalider(audience)
        return res
    }

    static async reporter_maintenant(audience){
        const res = await Autorite.reporter_maintenant(audience)
        return res
    }

    static async reporter_plus_tard(audience){
        const res = await Autorite.reporter_plus_tard(audience)
        return res
    }

    static async liste_audiences_reportes(id_autorite){
        const res = await Autorite.audiences_reporter(id_autorite)
        return res
    }

    static async liste_audience_validees (id_autorite_enfant) {
        const audience = await Autorite.audiences_valider(id_autorite_enfant)
        return audience
      }
    
}