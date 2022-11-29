INSERT INTO jour_ouvrable (jour, time_debut_matin, time_fin_matin, time_debut_apres_midi, time_fin_apres_midi, id_autorite)
    SELECT 
        'Monday' as jour,
        '08:00:00' as time_debut_matin,
        '12:00:00' as time_fin_matin,
        '13:00:00' as time_debut_apres_midi,
        '16:00:00' as time_fin_apres_midi,
        id as id_autorite
    FROM autorite_enfant
    UNION
    SELECT 
        'Tuesday' as jour,
        '08:00:00' as time_debut_matin,
        '12:00:00' as time_fin_matin,
        '13:00:00' as time_debut_apres_midi,
        '16:00:00' as time_fin_apres_midi,
        id as id_autorite
    FROM autorite_enfant
    UNION
    SELECT 
        'Wednesday' as jour,
        '08:00:00' as time_debut_matin,
        '12:00:00' as time_fin_matin,
        '13:00:00' as time_debut_apres_midi,
        '16:00:00' as time_fin_apres_midi,
        id as id_autorite
    FROM autorite_enfant
    UNION
    SELECT 
        'Thursday' as jour,
        '08:00:00' as time_debut_matin,
        '12:00:00' as time_fin_matin,
        '13:00:00' as time_debut_apres_midi,
        '16:00:00' as time_fin_apres_midi,
        id as id_autorite
    FROM autorite_enfant
    UNION
    SELECT 
        'Friday' as jour,
        '08:00:00' as time_debut_matin,
        '12:00:00' as time_fin_matin,
        '13:00:00' as time_debut_apres_midi,
        '16:00:00' as time_fin_apres_midi,
        id as id_autorite
    FROM autorite_enfant


CREATE  PROCEDURE `ajouter_heure_place_autorite`(heure_debut time,heure_fin time,duree_audience time,tous_les_jours INT,jour_place varchar(15),id_autorite int)
BEGIN
	DECLARE hds,hfs,das INT;
	DECLARE tmp_hfs int DEFAULT 0;
	set @hds = time_to_sec(heure_debut);
	set @hfs = time_to_sec(heure_fin);
	set @das = time_to_sec(duree_audience);
	
    IF tous_les_jours = 1 THEN 
		DELETE FROM stage.heure_place_autorite WHERE stage.heure_place_autorite.id_autorite = id_autorite;
		WHILE @hds <= @hfs DO
			set @tmp_hfs = @hds + @das;
            INSERT INTO stage.heure_place_autorite(heure_debut, heure_fin, jour, id_autorite) VALUES (sec_to_time(@hds),sec_to_time(@tmp_hfs),'Monday',id_autorite);
			INSERT INTO stage.heure_place_autorite(heure_debut, heure_fin, jour, id_autorite) VALUES (sec_to_time(@hds),sec_to_time(@tmp_hfs),'Tuesday',id_autorite);
			INSERT INTO stage.heure_place_autorite(heure_debut, heure_fin, jour, id_autorite) VALUES (sec_to_time(@hds),sec_to_time(@tmp_hfs),'Wednesday',id_autorite);
			INSERT INTO stage.heure_place_autorite(heure_debut, heure_fin, jour, id_autorite) VALUES (sec_to_time(@hds),sec_to_time(@tmp_hfs),'Thursday',id_autorite);
			INSERT INTO stage.heure_place_autorite(heure_debut, heure_fin, jour, id_autorite) VALUES (sec_to_time(@hds),sec_to_time(@tmp_hfs),'Friday',id_autorite);
        	set @hds = @tmp_hfs;
		END WHILE;
		SELECT 'Place évenement ajouté' as message;
    ELSE
		WHILE @hds <= @hfs DO
			set @tmp_hfs = @hds + @das;
			INSERT INTO stage.heure_place_autorite(heure_debut, heure_fin, jour, id_autorite) VALUES (sec_to_time(@hds),sec_to_time(@tmp_hfs),jour_place,id_autorite);
			set @hds = @tmp_hfs;
		END WHILE;
		SELECT 'Place évenement ajouté' as message;
    END IF;
END


-- Liste place disponible public par jour 
-- Version 1
CREATE  PROCEDURE `LISTE_PLACE_DISPONIBLE_PUBLIC_BY_DAY`(IN date_du_jour date,in id_autorite int)
BEGIN
	set @date_du_jour = date_du_jour;
	set @jour_UTF8 = CONVERT(DAYNAME(@date_du_jour) USING utf8);
	set @id_autorite = id_autorite;

	SELECT 
	jo.*
	FROM
	stage.jour_ouvrable jo
	WHERE 
	jo.id_autorite  = @id_autorite
	and jo.jour = @jour_UTF8
	and jo.id NOT IN (
		SELECT 
			jo.id
		FROM
			stage.jour_ouvrable jo
		JOIN autorite_enfant ae on jo.id_autorite = ae.id
		JOIN demande_audience_public dap on dap.id_autorite_enfant = ae.id
		JOIN demande_audience_autorite daa on daa.id_autorite_enfant_receiver = ae.id
		JOIN non_disponibilite_autorite_date ndap on ndap.id_autorite_enfant = ae.id
		JOIN non_disponibilite_autorite_jour ndaj on ndaj.id_autorite_enfant = ae.id
		JOIN demande_stage ds on ds.id_autorite_enfant = ae.id
		JOIN entretien_demande_stage eds on eds.id_demande_stage  = ds.id
		WHERE
			-- Demande Audience autorite
			jo.id_autorite  = @id_autorite
			AND daa.action >= 0 and daa.action <= 1
			and daa.date_debut = @date_du_jour
			and daa.date_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and jo.time_debut between SUBTIME(daa.time_debut,"-00:01:00") and SUBTIME(daa.time_fin,"00:01:00")
			and jo.time_fin between SUBTIME(daa.time_debut,"-00:01:00") and SUBTIME(daa.time_fin,"00:01:00")
			or
			jo.id_autorite  = @id_autorite
			AND daa.action >= 0 and daa.action <= 1
			and daa.date_debut = @date_du_jour
			and daa.date_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(daa.time_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			and SUBTIME(daa.time_fin,"00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite  = @id_autorite
			AND daa.action >= 0 and daa.action <= 1
			and daa.date_debut = @date_du_jour
			and daa.date_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(daa.time_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite  = @id_autorite
			AND daa.action >= 0 and daa.action <= 1
			and daa.date_debut = @date_du_jour
			and daa.date_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(daa.time_fin,"00:01:00") between jo.time_debut and jo.time_fin

			-- Demande Audience public
			or 
			jo.id_autorite = @id_autorite	
			AND dap.action >=0 and dap.action <= 1
			and dap.date_event_debut = @date_du_jour
			and dap.date_event_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and jo.time_debut between SUBTIME(dap.time_event_debut,"-00:01:00") and SUBTIME(dap.time_event_fin,"00:01:00")
			and jo.time_fin between SUBTIME(dap.time_event_debut,"-00:01:00") and SUBTIME(dap.time_event_fin,"00:01:00")
			or
			jo.id_autorite  = @id_autorite
			AND dap.action >=0 and dap.action <= 1
			and dap.date_event_debut = @date_du_jour
			and dap.date_event_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(dap.time_event_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			and SUBTIME(dap.time_event_fin,"00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite  = @id_autorite
			AND dap.action >=0 and dap.action <= 1
			and dap.date_event_debut = @date_du_jour
			and dap.date_event_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(dap.time_event_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite  = @id_autorite
			AND dap.action >=0 and dap.action <= 1
			and dap.date_event_debut = @date_du_jour
			and dap.date_event_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(dap.time_event_fin,"00:01:00") between jo.time_debut and jo.time_fin

			-- Non disponibilite date
			or 
			jo.id_autorite = @id_autorite	
			and ndap.date_non_dispo_debut = @date_du_jour
			and ndap.date_non_dispo_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and jo.time_debut between SUBTIME(ndap.time_debut,"-00:01:00") and SUBTIME(ndap.time_fin,"00:01:00")
			and jo.time_fin between SUBTIME(ndap.time_debut,"-00:01:00") and SUBTIME(ndap.time_fin,"00:01:00")
			or
			jo.id_autorite = @id_autorite	
			and ndap.date_non_dispo_debut = @date_du_jour
			and ndap.date_non_dispo_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(ndap.time_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			and SUBTIME(ndap.time_fin,"00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite = @id_autorite	
			and ndap.date_non_dispo_debut = @date_du_jour
			and ndap.date_non_dispo_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(ndap.time_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite = @id_autorite	
			and ndap.date_non_dispo_debut = @date_du_jour
			and ndap.date_non_dispo_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(ndap.time_fin,"00:01:00") between jo.time_debut and jo.time_fin
			
			-- Date non disponible Jour
			or 
			jo.id_autorite = @id_autorite	
			and ndaj.jour  = @jour_UTF8
			and jo.jour = @jour_UTF8
			and jo.time_debut between SUBTIME(ndaj.time_non_dispo_jour_debut,"-00:01:00") and SUBTIME(ndaj.time_non_dispo_jour_fin,"00:01:00")
			and jo.time_fin between SUBTIME(ndaj.time_non_dispo_jour_debut,"-00:01:00") and SUBTIME(ndaj.time_non_dispo_jour_fin,"00:01:00")
			or
			jo.id_autorite = @id_autorite	
			and ndaj.jour  = @jour_UTF8
			and jo.jour = @jour_UTF8
			and SUBTIME(ndaj.time_non_dispo_jour_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			and SUBTIME(ndaj.time_non_dispo_jour_fin,"-00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite = @id_autorite	
			and ndaj.jour  = @jour_UTF8
			and jo.jour = @jour_UTF8
			and SUBTIME(ndaj.time_non_dispo_jour_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite = @id_autorite	
			and ndaj.jour  = @jour_UTF8
			and jo.jour = @jour_UTF8
			and SUBTIME(ndaj.time_non_dispo_jour_fin,"00:01:00") between jo.time_debut and jo.time_fin

			-- Entretien demande_stage
			or 
			jo.id_autorite = @id_autorite
			and ds.id_autorite_enfant = @id_autorite	
			and eds.date_debut = @date_du_jour
			and eds.date_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and jo.time_debut between SUBTIME(eds.time_debut,"-00:01:00") and SUBTIME(eds.time_fin,"00:01:00")
			and jo.time_fin between SUBTIME(eds.time_debut,"-00:01:00") and SUBTIME(eds.time_fin,"00:01:00")
			or
			jo.id_autorite = @id_autorite
			and ds.id_autorite_enfant = @id_autorite	
			and eds.date_debut = @date_du_jour
			and eds.date_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(eds.time_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			and SUBTIME(eds.time_fin,"00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite = @id_autorite
			and ds.id_autorite_enfant = @id_autorite	
			and eds.date_debut = @date_du_jour
			and eds.date_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(eds.time_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite = @id_autorite
			and ds.id_autorite_enfant = @id_autorite	
			and eds.date_debut = @date_du_jour
			and eds.date_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(eds.time_fin,"00:01:00") between jo.time_debut and jo.time_fin
			GROUP BY jo.id
		UNION
		SELECT
		jo.id
		FROM jour_ouvrable jo,jour_ferie jf
		WHERE 
		jo.id_autorite = @id_autorite
		and jo.jour = @jour_UTF8
		and CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = @date_du_jour
		and CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8
		and jo.time_debut between SUBTIME(jf.time_event_debut,"-00:01:00") and SUBTIME(jf.time_event_fin,"00:01:00")
		and jo.time_fin between SUBTIME(jf.time_event_debut,"-00:01:00") and SUBTIME(jf.time_event_fin,"00:01:00")
		or
		jo.id_autorite = @id_autorite
		and jo.jour = @jour_UTF8
		and CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = @date_du_jour
		and CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8
		and SUBTIME(jf.time_event_debut,"-00:01:00") between jo.time_debut and jo.time_fin
		and SUBTIME(jf.time_event_fin,"00:01:00") between jo.time_debut and jo.time_fin
		or
		jo.id_autorite = @id_autorite
		and jo.jour = @jour_UTF8
		and CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = @date_du_jour
		and CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8
		and SUBTIME(jf.time_event_debut,"-00:01:00") between jo.time_debut and jo.time_fin
		or
		jo.id_autorite = @id_autorite
		and jo.jour = @jour_UTF8
		and CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = @date_du_jour
		and CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8
		and SUBTIME(jf.time_event_fin,"00:01:00") between jo.time_debut and jo.time_fin
		GROUP BY jo.id
	);
END

-- Version 2
CREATE  PROCEDURE `LISTE_PLACE_DISPONIBLE_PUBLIC_BY_DAY_V2`(IN date_du_jour date,in id_autorite int)
BEGIN
	set @date_du_jour = date_du_jour;
	set @jour_UTF8 = CONVERT(DAYNAME(@date_du_jour) USING utf8);
	set @id_autorite = id_autorite;

	SELECT 
	jo.*,
	dap.*
	FROM
	stage.jour_ouvrable jo
	JOIN stage.autorite_enfant ae on jo.id_autorite = ae.id
	RIGHT JOIN stage.demande_audience_public dap on jo.id_autorite = dap.id_autorite_enfant
	WHERE 
	jo.id_autorite  = @id_autorite
	and jo.jour = @jour_UTF8
	and jo.id NOT IN (
		SELECT 
			jo.id
		FROM
			stage.jour_ouvrable jo
		JOIN autorite_enfant ae on jo.id_autorite = ae.id
		JOIN demande_audience_public dap on dap.id_autorite_enfant = ae.id
		JOIN demande_audience_autorite daa on daa.id_autorite_enfant_receiver = ae.id
		JOIN non_disponibilite_autorite_date ndap on ndap.id_autorite_enfant = ae.id
		JOIN non_disponibilite_autorite_jour ndaj on ndaj.id_autorite_enfant = ae.id
		JOIN demande_stage ds on ds.id_autorite_enfant = ae.id
		JOIN entretien_demande_stage eds on eds.id_demande_stage  = ds.id
		WHERE
			-- Demande Audience autorite
			jo.id_autorite  = @id_autorite
			AND daa.action >= 0 and daa.action <= 1
			and daa.date_debut = @date_du_jour
			and daa.date_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and jo.time_debut between SUBTIME(daa.time_debut,"-00:01:00") and SUBTIME(daa.time_fin,"00:01:00")
			and jo.time_fin between SUBTIME(daa.time_debut,"-00:01:00") and SUBTIME(daa.time_fin,"00:01:00")
			or
			jo.id_autorite  = @id_autorite
			AND daa.action >= 0 and daa.action <= 1
			and daa.date_debut = @date_du_jour
			and daa.date_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(daa.time_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			and SUBTIME(daa.time_fin,"00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite  = @id_autorite
			AND daa.action >= 0 and daa.action <= 1
			and daa.date_debut = @date_du_jour
			and daa.date_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(daa.time_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite  = @id_autorite
			AND daa.action >= 0 and daa.action <= 1
			and daa.date_debut = @date_du_jour
			and daa.date_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(daa.time_fin,"00:01:00") between jo.time_debut and jo.time_fin

			-- Demande Audience public
			or 
			jo.id_autorite = @id_autorite	
			AND dap.action >=0 and dap.action <= 1
			and dap.date_event_debut = @date_du_jour
			and dap.date_event_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and jo.time_debut between SUBTIME(dap.time_event_debut,"-00:01:00") and SUBTIME(dap.time_event_fin,"00:01:00")
			and jo.time_fin between SUBTIME(dap.time_event_debut,"-00:01:00") and SUBTIME(dap.time_event_fin,"00:01:00")
			or
			jo.id_autorite  = @id_autorite
			AND dap.action >=0 and dap.action <= 1
			and dap.date_event_debut = @date_du_jour
			and dap.date_event_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(dap.time_event_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			and SUBTIME(dap.time_event_fin,"00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite  = @id_autorite
			AND dap.action >=0 and dap.action <= 1
			and dap.date_event_debut = @date_du_jour
			and dap.date_event_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(dap.time_event_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite  = @id_autorite
			AND dap.action >=0 and dap.action <= 1
			and dap.date_event_debut = @date_du_jour
			and dap.date_event_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(dap.time_event_fin,"00:01:00") between jo.time_debut and jo.time_fin

			-- Non disponibilite date
			or 
			jo.id_autorite = @id_autorite	
			and ndap.date_non_dispo_debut = @date_du_jour
			and ndap.date_non_dispo_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and jo.time_debut between SUBTIME(ndap.time_debut,"-00:01:00") and SUBTIME(ndap.time_fin,"00:01:00")
			and jo.time_fin between SUBTIME(ndap.time_debut,"-00:01:00") and SUBTIME(ndap.time_fin,"00:01:00")
			or
			jo.id_autorite = @id_autorite	
			and ndap.date_non_dispo_debut = @date_du_jour
			and ndap.date_non_dispo_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(ndap.time_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			and SUBTIME(ndap.time_fin,"-00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite = @id_autorite	
			and ndap.date_non_dispo_debut = @date_du_jour
			and ndap.date_non_dispo_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(ndap.time_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite = @id_autorite	
			and ndap.date_non_dispo_debut = @date_du_jour
			and ndap.date_non_dispo_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(ndap.time_fin,"00:01:00") between jo.time_debut and jo.time_fin
			
			-- Date non disponible Jour
			or 
			jo.id_autorite = @id_autorite	
			and ndaj.jour  = @jour_UTF8
			and jo.jour = @jour_UTF8
			and jo.time_debut between SUBTIME(ndaj.time_non_dispo_jour_debut,"-00:01:00") and SUBTIME(ndaj.time_non_dispo_jour_fin,"00:01:00")
			and jo.time_fin between SUBTIME(ndaj.time_non_dispo_jour_debut,"-00:01:00") and SUBTIME(ndaj.time_non_dispo_jour_fin,"00:01:00")
			or
			jo.id_autorite = @id_autorite	
			and ndaj.jour  = @jour_UTF8
			and jo.jour = @jour_UTF8
			and SUBTIME(ndaj.time_non_dispo_jour_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			and SUBTIME(ndaj.time_non_dispo_jour_fin,"-00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite = @id_autorite	
			and ndaj.jour  = @jour_UTF8
			and jo.jour = @jour_UTF8
			and SUBTIME(ndaj.time_non_dispo_jour_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite = @id_autorite	
			and ndaj.jour  = @jour_UTF8
			and jo.jour = @jour_UTF8
			and SUBTIME(ndaj.time_non_dispo_jour_fin,"00:01:00") between jo.time_debut and jo.time_fin

			-- Entretien demande_stage
			or 
			jo.id_autorite = @id_autorite
			and ds.id_autorite_enfant = @id_autorite	
			and eds.date_debut = @date_du_jour
			and eds.date_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and jo.time_debut between SUBTIME(eds.time_debut,"-00:01:00") and SUBTIME(eds.time_fin,"00:01:00")
			and jo.time_fin between SUBTIME(eds.time_debut,"-00:01:00") and SUBTIME(eds.time_fin,"00:01:00")
			or
			jo.id_autorite = @id_autorite
			and ds.id_autorite_enfant = @id_autorite	
			and eds.date_debut = @date_du_jour
			and eds.date_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(eds.time_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			and SUBTIME(eds.time_fin,"-00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite = @id_autorite
			and ds.id_autorite_enfant = @id_autorite	
			and eds.date_debut = @date_du_jour
			and eds.date_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(eds.time_debut,"-00:01:00") between jo.time_debut and jo.time_fin
			or
			jo.id_autorite = @id_autorite
			and ds.id_autorite_enfant = @id_autorite	
			and eds.date_debut = @date_du_jour
			and eds.date_fin = @date_du_jour
			and jo.jour = @jour_UTF8
			and SUBTIME(eds.time_fin,"00:01:00") between jo.time_debut and jo.time_fin
			GROUP BY jo.id
		UNION
		SELECT
		jo.id
		FROM jour_ouvrable jo,jour_ferie jf
		WHERE 
		jo.id_autorite = @id_autorite
		and jo.jour = @jour_UTF8
		and CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = @date_du_jour
		and CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8
		and jo.time_debut between SUBTIME(jf.time_event_debut,"-00:01:00") and SUBTIME(jf.time_event_fin,"00:01:00")
		and jo.time_fin between SUBTIME(jf.time_event_debut,"-00:01:00") and SUBTIME(jf.time_event_fin,"00:01:00")
		or
		jo.id_autorite = @id_autorite
		and jo.jour = @jour_UTF8
		and CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = @date_du_jour
		and CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8
		and SUBTIME(jf.time_event_debut,"-00:01:00") between jo.time_debut and jo.time_fin
		and SUBTIME(jf.time_event_fin,"-00:01:00") between jo.time_debut and jo.time_fin
		or
		jo.id_autorite = @id_autorite
		and jo.jour = @jour_UTF8
		and CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = @date_du_jour
		and CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8
		and SUBTIME(jf.time_event_debut,"-00:01:00") between jo.time_debut and jo.time_fin
		or
		jo.id_autorite = @id_autorite
		and jo.jour = @jour_UTF8
		and CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = @date_du_jour
		and CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8
		and SUBTIME(jf.time_event_fin,"00:01:00") between jo.time_debut and jo.time_fin
		GROUP BY jo.id
	);
END

CALL LISTE_PLACE_DISPONIBLE_PUBLIC_BY_DAY('2022-11-07',1)


CALL LISTE_PLACE_DISPONIBLE_PUBLIC_BY_DAY_V2 ('2022-11-07',1)


CALL LISTE_PUBLIC_PAR_MOIS_V3(1,'2022-11-25','TJKHTKJRWJR');
