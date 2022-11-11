CREATE  PROCEDURE `LISTE_AUTORITE_PAR_MOIS`(id_autorite int,_date date)
BEGIN
    SELECT 
        ae.id,
        ae.intitule,
        ae.intitule_code,
        dap.id as id_aud_public,
        dap.date_event_debut as dd_aud_public,
        dap.date_event_fin as df_aud_public,
        dap.time_event_debut as td_aud_public,
        dap.time_event_fin as tf_aud_public,
        dap.action as action_public,
        dap.motif as motif,
        '' id_autorite_sender,
        '' sender_intitule,
        '' sender_intitule_code,
        '' id_aud_autorite,
        '' dd_aud_autorite,             
        '' df_aud_autorite,
        '' td_aud_autorite,
        '' tf_aud_autorite,
        '' action_autorite,
        '' dd_non_dispo_date,
        '' df_non_dispo_date,
        '' td_non_dispo_date,
        '' tf_non_dispo_date,
        '' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour,
        '' date_ferie,
        '' td_ferie,
        '' tf_ferie,
        'Public' type_audience
    FROM 
        stage.autorite_enfant AS ae
            INNER JOIN stage.demande_audience_public as dap on ae.id = dap.id_autorite_enfant
            WHERE dap.id_autorite_enfant = id_autorite and dap.action >=0 and dap.action <= 1 and dap.date_event_debut BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date) and dap.date_event_fin BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)
    UNION 
    SELECT 
        aer.id,
        aer.intitule,
        aer.intitule_code,
        '' id_aud_public,
        '' dd_aud_public,
        '' df_aud_public,
        '' td_aud_public,
        '' tf_aud_public,
        '' action_public,
        daa.motif as motif,
        aes.id as id_autorite_sender,
        aes.intitule as sender_intitule,
        aes.intitule_code as sender_intitule_code,
        daa.id as id_aud_autorite,
        daa.date_debut as dd_aud_autorite,             
        daa.date_fin as df_aud_autorite,
        daa.time_debut as td_aud_autorite,
        daa.time_fin as tf_aud_autorite,
        daa.action as action_autorite,
        '' dd_non_dispo_date,
        '' df_non_dispo_date,
        '' td_non_dispo_date,
        '' tf_non_dispo_date,
        '' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour,
        '' date_ferie,
        '' td_ferie,
        '' tf_ferie,
        'Autorite' type_audience
    FROM 
        stage.demande_audience_autorite daa
            INNER JOIN stage.autorite_enfant aer on aer.id = daa.id_autorite_enfant_receiver
            INNER JOIN stage.autorite_enfant aes on aes.id = daa.id_autorite_enfant_sender
            where daa.id_autorite_enfant_receiver = id_autorite and daa.action >=0 and daa.action <= 1 and daa.date_debut BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date) and daa.date_fin BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)
    UNION
    SELECT 
        ae.id,
        ae.intitule,
        ae.intitule_code,
        '' id_aud_public,
        '' dd_aud_public,
        '' df_aud_public,
        '' td_aud_public,
        '' tf_aud_public,
        '' action_public,
        'Pas disponible' motif,
        '' id_autorite_sender,
        '' sender_intitule,
        '' sender_intitule_code,
        '' id_aud_autorite,
        '' dd_aud_autorite,             
        '' df_aud_autorite,
        '' td_aud_autorite,
        '' tf_aud_autorite,
        '' action_autorite,
        ndad.date_non_dispo_debut as dd_non_dispo_date,
        ndad.date_non_dispo_fin as df_non_dispo_date,
        ndad.time_debut as td_non_dispo_date,
        ndad.time_fin as tf_non_dispo_date,
        '' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour,
        '' date_ferie,
        '' td_ferie,
        '' tf_ferie,
        'Pas disponible date' type_audience
    FROM 
        stage.autorite_enfant AS ae
            INNER JOIN stage.non_disponibilite_autorite_date as ndad on ae.id = ndad.id_autorite_enfant
            where ndad.id_autorite_enfant = id_autorite  and ndad.date_non_dispo_debut BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date) and ndad.date_non_dispo_fin BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)
    UNION
    SELECT
        '' id,
        '' intitule,
        '' intitule_code,
        '' id_aud_public,
        '' dd_aud_public,
        '' df_aud_public,
        '' td_aud_public,
        '' tf_aud_public,
        '' action_public,
        jf.nom_evenement as motif,
        '' id_autorite_sender,
        '' sender_intitule,
        '' sender_intitule_code,
        '' id_aud_autorite,
        '' dd_aud_autorite,             
        '' df_aud_autorite,
        '' td_aud_autorite,
        '' tf_aud_autorite,
        '' action_autorite,
        '' dd_non_dispo_date,
        '' df_non_dispo_date,
        '' td_non_dispo_date,
        '' tf_non_dispo_date,
        '' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour,
        CONCAT(YEAR(_date),'-',jf.mois_du_jour,'-',jf.numero_du_jour) as date_ferie,
        time_event_debut as td_ferie,
        time_event_fin as tf_ferie,
        'Jour ferie' type_audience
    FROM 
        stage.jour_ferie as jf where jf.mois_du_jour =  MONTH(FIRST_DATE_OF_MONTH(_date)) and jf.mois_du_jour = MONTH(LAST_DAY(_date)) and jf.numero_du_jour BETWEEN DAY(FIRST_DATE_OF_MONTH(_date)) AND DAY(LAST_DAY(_date))
    UNION
    SELECT 
        ae.id,
        ae.intitule,
        ae.intitule_code,
        '' id_aud_public,
        '' dd_aud_public,
        '' df_aud_public,
        '' td_aud_public,
        '' tf_aud_public,
        '' action_public,
        'Pas disponible' motif,
        '' id_autorite_sender,
        '' sender_intitule,
        '' sender_intitule_code,
        '' id_aud_autorite,
        '' dd_aud_autorite,             
        '' df_aud_autorite,
        '' td_aud_autorite,
        '' tf_aud_autorite,
        '' action_autorite,
        '' dd_non_dispo_date,
        '' df_non_dispo_date,
        '' td_non_dispo_date,
        '' tf_non_dispo_date,
        ndaj.jour as jour_non_dispo_jour,
        ndaj.time_non_dispo_jour_debut as td_non_dispo_jour,
        ndaj.time_non_dispo_jour_fin as tf_non_dispo_jour,
        '' date_ferie,
        '' td_ferie,
        '' tf_ferie,
        'Pas disponible jour' type_audience

    FROM 
        stage.autorite_enfant as ae
            INNER JOIN stage.non_disponibilite_autorite_jour as ndaj on ae.id = ndaj.id_autorite_enfant
            where ndaj.id_autorite_enfant = id_autorite;    
END