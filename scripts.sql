/** 
    * Start
    * Liste des demandes de stages aucun entretien
*/
SELECT demande_stage.id,CONCAT(demande_stage.nom,' ',demande_stage.prenom)as fullName,domaine.nom_domaine,demande_stage.duree,
CASE
    WHEN rendez_vous_directeur.id_demande_stage IS NULL THEN "en attente"
    ELSE "valide"
END as demande_status
FROM demande_stage 
    inner join domaine on demande_stage.id_domaine = domaine.id
    left join rendez_vous_directeur 
    on demande_stage.id = rendez_vous_directeur.id_demande_stage

/**
    * End
*/
/** 
    * Start
    * detail demande stage
*/
SELECT demande_stage.id,demande_stage.nom,demande_stage.prenom,demande_stage.telephone,demande_stage.e_mail,demande_stage.cin,demande_stage.duree,demande_stage.curriculum_vitae ,demande_stage.lettre_motivation ,demande_stage.lettre_introduction ,demande_stage.message,domaine.nom_domaine from demande_stage 
    inner join domaine on demande_stage.id_domaine = domaine.id
    where demande_stage.id = 1