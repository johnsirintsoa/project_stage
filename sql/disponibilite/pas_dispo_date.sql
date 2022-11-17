-- v2
CREATE  PROCEDURE `add_non_disponibilite_autorite_date_v2`(dd date,df date,td time,tf time,id_autorite int)
BEGIN    
	    DECLARE time_debut time;
	    DECLARE time_fin time;
	    DECLARE si_ferie INT;
		DECLARE nbr_rows_events int;
	    set @si_ferie = si_jour_ferie(dd ,df ,td ,tf );
	    -- SET @time_debut = SUBTIME(td,"-00:01:00");
	    -- SET @time_fin = SUBTIME(tf,"00:01:00");
	    -- select @si_ferie;	   
		SET @nbr_rows_events = NBR_ROWS_EVENEMENTS(dd,df,td,tf,id_autorite);
		IF @nbr_rows_events > 0 THEN 
			CALL LISTE_EVENEMENTS(dd,df,td,tf,id_autorite);
		ELSE 
			select 'Aucun évenement' as message;
		END IF;
END

-- Liste evenements
CREATE  PROCEDURE `LISTE_EVENEMENTS`(in dd date,in df date,in td time,in tf time,in id_autorite int)
BEGIN    
	DECLARE time_debut time;
	DECLARE time_fin time;
	SET @time_debut = SUBTIME(td,"-00:01:00");
	SET @time_fin = SUBTIME(tf,"00:01:00");
	-- select @si_ferie;	   
	SELECT 
		'' jour,
		'' time_non_dispo_jour_debut,
		'' time_non_dispo_jour_fin,
		CONCAT(date_event_debut,'T',time_event_debut) as start,
		CONCAT(date_event_fin,'T',time_event_fin) as end,
		id,
		Motif as title,
		cin,
		numero_telephone,
		email,
		nom,
		prenom,
		'' id_autorite_enfant_sender,
		'' intitule,
		'' intitule_code,
		CASE 
			WHEN action = 0 THEN 'Non validé'
			WHEN action = 1 THEN 'Validé'
			WHEN action = 2 THEN 'Reporté'
		END as status_evenement,
		'Public' type_evenement
	FROM 
		stage.demande_audience_public 
	where 
		-- Si disponible sur l'audience public
		id_autorite_enfant = id_autorite
		AND action >= 0 and action <= 1
		and date_event_debut between dd and df
		and date_event_fin between dd and df
		and time_event_debut between @time_debut and @time_fin
		and time_event_fin between @time_debut and @time_fin
		or
		id_autorite_enfant = id_autorite
		AND action >= 0 and action <= 1
		and date_event_debut between dd and df
		and date_event_fin between dd and df
		and @time_debut between time_event_debut and time_event_fin
		and @time_fin between time_event_debut and time_event_fin
		or
		id_autorite_enfant = id_autorite
		AND action >= 0 and action <= 1
		and date_event_debut between dd and df
		and date_event_fin between dd and df
		and @time_debut between time_event_debut and time_event_fin
		or
		id_autorite_enfant = id_autorite
		AND action >= 0 and action <= 1
		and date_event_debut between dd and df
		and date_event_fin between dd and df
		and @time_fin between time_event_debut and time_event_fin
	UNION
	SELECT
		'' jour,
		'' time_non_dispo_jour_debut,
		'' time_non_dispo_jour_fin,
		CONCAT(daa.date_debut,'T',daa.time_debut) as start,
		CONCAT(daa.date_fin,'T',daa.time_fin) as end,	
		daa.id,
		daa.motif as title,
		'' cin,
		'' numero_telephone,
		'' email,
		'' nom,
		'' prenom,
		daa.id_autorite_enfant_sender,
		ae.intitule,
		ae.intitule_code,
		CASE 
			WHEN action = 0 THEN 'Non validé'
			WHEN action = 1 THEN 'Validé'
			WHEN action = 2 THEN 'Reporté'
		END as status_evenement,
		'Autorité' type_evenement
	FROM
		stage.demande_audience_autorite daa
	JOIN stage.autorite_enfant ae on  daa.id_autorite_enfant_sender =ae.id
	where
		-- Si disponible sur l'autorite  
		daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
		and daa.date_debut between dd and df
		and daa.date_fin between dd and df
		and daa.time_debut between @time_debut and @time_fin
		and daa.time_fin between @time_debut and @time_fin
		or
		daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
		and daa.date_debut between dd and df
		and daa.date_fin between dd and df
		and @time_debut between daa.time_debut and daa.time_fin
		and @time_fin between daa.time_debut and daa.time_fin
		or
		daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
		and daa.date_debut between dd and df
		and daa.date_fin between dd and df
		and @time_debut between daa.time_debut and daa.time_fin
		or
		daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
		and daa.date_debut between dd and df
		and daa.date_fin between dd and df
		and @time_fin between daa.time_debut and daa.time_fin
	UNION
	SELECT
		'' jour,
		'' time_non_dispo_jour_debut,
		'' time_non_dispo_jour_fin,
		CONCAT(date_non_dispo_debut,'T',time_debut) as start,
		CONCAT(date_non_dispo_fin,'T',time_fin) as end,	
		id,
		'Pas disponible' as title,
		'' cin,
		'' numero_telephone,
		'' email,
		'' nom,
		'' prenom,
		'' id_autorite_enfant_sender,
		'' intitule,
		'' intitule_code,
		'Pas disponible' status_evenement,
		'Pas disponible date' type_evenement
	FROM
		stage.non_disponibilite_autorite_date ndad
	where
		-- Si pas disponible sur autorite date 
		ndad.id_autorite_enfant = id_autorite
		and ndad.date_non_dispo_debut between dd and df
		and ndad.date_non_dispo_fin between dd and df
		and ndad.time_debut between @time_debut and @time_fin
		and ndad.time_fin between @time_debut and @time_fin
		or
		ndad.id_autorite_enfant = id_autorite
		and ndad.date_non_dispo_debut between dd and df
		and ndad.date_non_dispo_fin between dd and df
		and @time_debut between ndad.time_debut and ndad.time_fin
		and @time_fin between ndad.time_debut and ndad.time_fin
		or
		ndad.id_autorite_enfant = id_autorite
		and ndad.date_non_dispo_debut between dd and df
		and ndad.date_non_dispo_fin between dd and df
		and @time_debut between ndad.time_debut and ndad.time_fin
		or
		ndad.id_autorite_enfant = id_autorite
		and ndad.date_non_dispo_debut between dd and df
		and ndad.date_non_dispo_fin between dd and df
		and @time_fin between ndad.time_debut and ndad.time_fin
	UNION
	SELECT
		'' jour,
		'' time_non_dispo_jour_debut,
		'' time_non_dispo_jour_fin,
		CONCAT(eds.date_debut,'T',eds.time_debut) as start,
		CONCAT(eds.date_fin,'T',eds.time_fin) as end,	
		eds.id,
		CONCAT('Entretien ',ds.nom,' ',ds.prenom) as title,
		ds.cin,
		ds.telephone,
		ds.e_mail,
		ds.nom,
		ds.prenom,
		'' id_autorite_enfant_sender,
		'' intitule,
		'' intitule_code,
		'Stage' status_evenement,
		'Entretien' type_evenement
		
	FROM
		stage.entretien_demande_stage eds
	JOIN demande_stage ds on eds.id_demande_stage = ds.id
	where 
		-- Si disponible entretien
		ds.id_autorite_enfant = id_autorite
		and eds.date_debut between dd and df
		and eds.date_fin between dd and df
		and eds.time_debut between @time_debut and @time_fin
		and eds.time_fin between @time_debut and @time_fin
		or
		ds.id_autorite_enfant = id_autorite
		and eds.date_debut between dd and df
		and eds.date_fin between dd and df
		and @time_debut between eds.time_debut and eds.time_fin
		and @time_fin between eds.time_debut and eds.time_fin
		or
		ds.id_autorite_enfant = id_autorite
		and eds.date_debut between dd and df
		and eds.date_fin between dd and df
		and @time_debut between eds.time_debut and eds.time_fin
		or
		ds.id_autorite_enfant = id_autorite
		and eds.date_debut between dd and df
		and eds.date_fin between dd and df
		and @time_fin between eds.time_debut and eds.time_fin

	UNION
	SELECT 
		'' jour,
		'' time_non_dispo_jour_debut,
		'' time_non_dispo_jour_fin,
		concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour,'T',time_event_debut) start,
		concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour,'T',time_event_fin) end,	
		id,
		nom_evenement as title,
		'' cin,
		'' numero_telephone,
		'' e_mail,
		'' nom,
		'' prenom,
		'' id_autorite_enfant_sender,
		'' intitule,
		'' intitule_code,
		'Jour férié' status_evenement,
		'Jour férié' type_evenement
	FROM stage.jour_ferie 
	WHERE 
		numero_du_jour = day(dd) and mois_du_jour = month(dd) 
		and numero_du_jour = day(df) and mois_du_jour = month(df) 
		and time_event_debut BETWEEN  @time_debut and @time_fin 
		and time_event_fin BETWEEN @time_debut and @time_fin 
		or 
		numero_du_jour = day(dd) and mois_du_jour = month(dd) 
		and numero_du_jour = day(df) and mois_du_jour = month(df) 
		and @time_debut BETWEEN  time_event_debut and time_event_fin 
		and @time_fin BETWEEN time_event_debut and time_event_fin 
		or 
		numero_du_jour = day(dd) and mois_du_jour = month(dd) 
		and numero_du_jour = day(df) and mois_du_jour = month(df) 
		and @time_debut BETWEEN  time_event_debut and time_event_fin 
		and time_event_fin BETWEEN time_event_debut and @time_fin 
		or 
		numero_du_jour = day(dd) and mois_du_jour = month(dd) 
		and numero_du_jour = day(df) and mois_du_jour = month(df) 
		and time_event_debut  BETWEEN  @time_debut and time_event_fin 
		and @time_fin  BETWEEN time_event_debut and time_event_fin
	UNION
	SELECT
		jour,
		time_non_dispo_jour_debut,
		time_non_dispo_jour_fin,
		'' start,
		'' end,	
		id,
		'' title,
		'' cin,
		'' numero_telephone,
		'' e_mail,
		'' nom,
		'' prenom,
		'' id_autorite_enfant_sender,
		'' intitule,
		'' intitule_code,
		'Pas disponible' status_evenement,
		'Pas disponible jour' type_evenement
	FROM
		non_disponibilite_autorite_jour 
	WHERE 	
		-- Si disponible sur disponible jour
		non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
		and  non_disponibilite_autorite_jour.jour = dayname(dd) 
		and non_disponibilite_autorite_jour.jour =  dayname(df) 
		and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin 
		and non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin 
		OR
		non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
		and non_disponibilite_autorite_jour.jour = dayname(dd) 
		and non_disponibilite_autorite_jour.jour =  dayname(df) 
		AND @time_debut BETWEEN non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
		and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
		or
		non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
		and non_disponibilite_autorite_jour.jour = dayname(dd) 
		and non_disponibilite_autorite_jour.jour =  dayname(df) 
		and @time_debut between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
		OR 
		non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
		and non_disponibilite_autorite_jour.jour = dayname(dd) 
		and non_disponibilite_autorite_jour.jour =  dayname(df) 
		and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin;	
END


-- Liste evenements by day
CALL LISTE_EVENEMENTS_BY_DAY('Wednesday','03:00:00','17:10:00',1)

-- v1
CREATE  PROCEDURE `LISTE_EVENEMENTS_BY_DAY`(IN jour_date VARCHAR(15),in td time,in tf time,in id_autorite int)
BEGIN    
	    DECLARE time_debut time;
	    DECLARE time_fin time;
	    SET @time_debut = SUBTIME(td,"-00:01:00");
	    SET @time_fin = SUBTIME(tf,"00:01:00");
		set @jour_UTF8 = CONVERT(jour_date USING utf8);	
	    -- select @si_ferie;	   
		SELECT 
			'' jour,
			'' time_non_dispo_jour_debut,
			'' time_non_dispo_jour_fin,
			CONCAT(date_event_debut,'T',time_event_debut) as start,
			CONCAT(date_event_fin,'T',time_event_fin) as end,
			id,
			Motif as title,
			cin,
			numero_telephone,
			email,
			nom,
			prenom,
			'' id_autorite_enfant_sender,
			'' intitule,
			'' intitule_code,
			CASE 
				WHEN action = 0 THEN 'Non validé'
				WHEN action = 1 THEN 'Validé'
				WHEN action = 2 THEN 'Reporté'
			END as status_evenement,
			'Public' type_evenement
		FROM 
			stage.demande_audience_public 
	    where 
			-- Si disponible sur l'audience public
			id_autorite_enfant = id_autorite
			AND action >= 0 and action <= 1
	        and dayname(date_event_debut) = jour
			and dayname(date_event_fin) = jour
			and time_event_debut between @time_debut and @time_fin
			and time_event_fin between @time_debut and @time_fin
			or
			id_autorite_enfant = id_autorite
			AND action >= 0 and action <= 1
	        and dayname(date_event_debut) = jour
			and dayname(date_event_fin) = jour
			and @time_debut between time_event_debut and time_event_fin
			and @time_fin between time_event_debut and time_event_fin
			or
			id_autorite_enfant = id_autorite
			AND action >= 0 and action <= 1
	        and dayname(date_event_debut) = jour
			and dayname(date_event_fin) = jour
			and @time_debut between time_event_debut and time_event_fin
			or
			id_autorite_enfant = id_autorite
			AND action >= 0 and action <= 1
	        and dayname(date_event_debut) = jour
			and dayname(date_event_fin) = jour
			and @time_fin between time_event_debut and time_event_fin
		UNION
		SELECT
			'' jour,
			'' time_non_dispo_jour_debut,
			'' time_non_dispo_jour_fin,
			CONCAT(daa.date_debut,'T',daa.time_debut) as start,
			CONCAT(daa.date_fin,'T',daa.time_fin) as end,	
			daa.id,
			daa.motif as title,
			'' cin,
			'' numero_telephone,
			'' email,
			'' nom,
			'' prenom,
			daa.id_autorite_enfant_sender,
			ae.intitule,
			ae.intitule_code,
			CASE 
				WHEN action = 0 THEN 'Non validé'
				WHEN action = 1 THEN 'Validé'
				WHEN action = 2 THEN 'Reporté'
			END as status_evenement,
			'Autorité' type_evenement
		FROM
			stage.demande_audience_autorite daa
		JOIN stage.autorite_enfant ae on  daa.id_autorite_enfant_sender =ae.id
		where
			-- Si disponible sur l'autorite  
			daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
			and dayname(daa.date_debut) = jour
			and dayname(daa.date_fin) = jour
			and daa.time_debut between @time_debut and @time_fin
			and daa.time_fin between @time_debut and @time_fin
			or
			daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
	        and dayname(daa.date_debut) = jour
			and dayname(daa.date_fin) = jour
			and @time_debut between daa.time_debut and daa.time_fin
			and @time_fin between daa.time_debut and daa.time_fin
			or
			daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
	        and dayname(daa.date_debut) = jour
			and dayname(daa.date_fin) = jour
			and @time_debut between daa.time_debut and daa.time_fin
			or
			daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
	        and dayname(daa.date_debut) = jour
			and dayname(daa.date_fin) = jour
			and @time_fin between daa.time_debut and daa.time_fin
		UNION
		SELECT
			'' jour,
			'' time_non_dispo_jour_debut,
			'' time_non_dispo_jour_fin,
			CONCAT(ndad.date_non_dispo_debut,'T',ndad.time_debut) as start,
			CONCAT(ndad.date_non_dispo_fin,'T',ndad.time_fin) as end,	
			id,
			'Pas disponible' as title,
			'' cin,
			'' numero_telephone,
			'' email,
			'' nom,
			'' prenom,
			'' id_autorite_enfant_sender,
			'' intitule,
			'' intitule_code,
			'Pas disponible' status_evenement,
			'Pas disponible date' type_evenement
		FROM
			stage.non_disponibilite_autorite_date ndad
	    where
			-- Si pas disponible sur autorite date 
			ndad.id_autorite_enfant = id_autorite
	        and dayname(ndad.date_non_dispo_debut) = jour
			and dayname(ndad.date_non_dispo_fin) = jour
			and ndad.time_debut between @time_debut and @time_fin
			and ndad.time_fin between @time_debut and @time_fin
			or
			ndad.id_autorite_enfant = id_autorite
	        and dayname(ndad.date_non_dispo_debut) = jour
			and dayname(ndad.date_non_dispo_fin) = jour
			and @time_debut between ndad.time_debut and ndad.time_fin
			and @time_fin between ndad.time_debut and ndad.time_fin
			or
			ndad.id_autorite_enfant = id_autorite
	        and dayname(ndad.date_non_dispo_debut) = jour
			and dayname(ndad.date_non_dispo_fin) = jour
			and @time_debut between ndad.time_debut and ndad.time_fin
			or
			ndad.id_autorite_enfant = id_autorite
	        and dayname(ndad.date_non_dispo_debut) = jour
			and dayname(ndad.date_non_dispo_fin) = jour
			and @time_fin between ndad.time_debut and ndad.time_fin
		UNION
	    SELECT
			'' jour,
			'' time_non_dispo_jour_debut,
			'' time_non_dispo_jour_fin,
			CONCAT(eds.date_debut,'T',eds.time_debut) as start,
			CONCAT(eds.date_fin,'T',eds.time_fin) as end,	
			eds.id,
			CONCAT('Entretien ',ds.nom,' ',ds.prenom) as title,
			ds.cin,
			ds.telephone,
			ds.e_mail,
			ds.nom,
			ds.prenom,
			'' id_autorite_enfant_sender,
			'' intitule,
			'' intitule_code,
			'Stage' status_evenement,
			'Entretien' type_evenement
			
		FROM
			stage.entretien_demande_stage eds
		JOIN demande_stage ds on eds.id_demande_stage = ds.id
	    where 
			-- Si disponible entretien
			ds.id_autorite_enfant = id_autorite
	        and dayname(eds.date_debut) = jour
			and dayname(eds.date_fin) = jour
			and eds.time_debut between @time_debut and @time_fin
			and eds.time_fin between @time_debut and @time_fin
			or
			ds.id_autorite_enfant = id_autorite
	        and dayname(eds.date_debut) = jour
			and dayname(eds.date_fin) = jour
			and @time_debut between eds.time_debut and eds.time_fin
			and @time_fin between eds.time_debut and eds.time_fin
			or
			ds.id_autorite_enfant = id_autorite
	        and dayname(eds.date_debut) = jour
			and dayname(eds.date_fin) = jour
			and @time_debut between eds.time_debut and eds.time_fin
			or
			ds.id_autorite_enfant = id_autorite
	        and dayname(eds.date_debut) = jour
			and dayname(eds.date_fin) = jour
			and @time_fin between eds.time_debut and eds.time_fin
		
		UNION
		SELECT 
			'' jour,
			'' time_non_dispo_jour_debut,
			'' time_non_dispo_jour_fin,
			concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour,'T',time_event_debut) start,
			concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour,'T',time_event_fin) end,	
			id,
			nom_evenement as title,
			'' cin,
			'' numero_telephone,
			'' e_mail,
			'' nom,
			'' prenom,
			'' id_autorite_enfant_sender,
			'' intitule,
			'' intitule_code,
			'Jour férié' status_evenement,
			'Jour férié' type_evenement
		FROM stage.jour_ferie 
	    WHERE 
			(select dayname(concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour))) = jour
			and time_event_debut BETWEEN  @time_debut and @time_fin 
			and time_event_fin BETWEEN @time_debut and @time_fin 
	        or 
			(select dayname(concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour))) = jour
			and @time_debut BETWEEN  time_event_debut and time_event_fin 
			and @time_fin BETWEEN time_event_debut and time_event_fin 
	        or 
			(select dayname(concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour))) = jour
			and @time_debut BETWEEN  time_event_debut and time_event_fin 
			and time_event_fin BETWEEN time_event_debut and @time_fin 
	        or 
			(select dayname(concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour))) = jour 
			and time_event_debut  BETWEEN  @time_debut and time_event_fin 
			and @time_fin  BETWEEN time_event_debut and time_event_fin
		UNION
		SELECT
			jour,
			time_non_dispo_jour_debut,
			time_non_dispo_jour_fin,
			'' start,
			'' end,	
			id,
			'' title,
			'' cin,
			'' numero_telephone,
			'' e_mail,
			'' nom,
			'' prenom,
			'' id_autorite_enfant_sender,
			'' intitule,
			'' intitule_code,
			'Pas disponible' status_evenement,
			'Pas disponible jour' type_evenement
		FROM
			non_disponibilite_autorite_jour 
		WHERE 	
			-- Si disponible sur disponible jour
			non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
			and  non_disponibilite_autorite_jour.jour = jour 
			and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin 
			and non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin 
			OR
			non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
			and non_disponibilite_autorite_jour.jour = jour 
			AND @time_debut BETWEEN non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
			and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
			or
			non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
			and non_disponibilite_autorite_jour.jour = jour 
			and @time_debut between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
			OR 
			non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
			and non_disponibilite_autorite_jour.jour = jour 
			and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin;	
END

-- v2
CALL LISTE_EVENEMENTS_BY_DAY('Wednesday','03:00:00','17:10:00',1)

CREATE  PROCEDURE `LISTE_EVENEMENTS_BY_DAY`(IN jour_date VARCHAR(15),in td time,in tf time,in id_autorite int)
BEGIN    
	DECLARE time_debut time;
	DECLARE time_fin time;
	SET @time_debut = SUBTIME(td,"-00:01:00");
	SET @time_fin = SUBTIME(tf,"00:01:00");
	SELECT 
		'' jour,
		'' time_non_dispo_jour_debut,
		'' time_non_dispo_jour_fin,
		CONCAT(date_event_debut,'T',time_event_debut) as start,
		CONCAT(date_event_fin,'T',time_event_fin) as end,
		id,
		Motif as title,
		cin,
		numero_telephone,
		email,
		nom,
		prenom,
		'' id_autorite_enfant_sender,
		'' intitule,
		'' intitule_code,
		CASE 
			WHEN action = 0 THEN 'Non validé'
			WHEN action = 1 THEN 'Validé'
			WHEN action = 2 THEN 'Reporté'
		END as status_evenement,
		'Public' type_evenement
	FROM 
		stage.demande_audience_public 
	where 
		-- Si disponible sur l'audience public
		id_autorite_enfant = id_autorite
		AND action >= 0 and action <= 1
		and dayname(date_event_debut) =TRIM( jour_date)
		and dayname(date_event_fin) =TRIM( jour_date)
		and time_event_debut between @time_debut and @time_fin
		and time_event_fin between @time_debut and @time_fin
		or
		id_autorite_enfant = id_autorite
		AND action >= 0 and action <= 1
		and dayname(date_event_debut) =TRIM( jour_date)
		and dayname(date_event_fin) =TRIM( jour_date)
		and @time_debut between time_event_debut and time_event_fin
		and @time_fin between time_event_debut and time_event_fin
		or
		id_autorite_enfant = id_autorite
		AND action >= 0 and action <= 1
		and dayname(date_event_debut) =TRIM( jour_date)
		and dayname(date_event_fin) =TRIM( jour_date)
		and @time_debut between time_event_debut and time_event_fin
		or
		id_autorite_enfant = id_autorite
		AND action >= 0 and action <= 1
		and dayname(date_event_debut) =TRIM( jour_date)
		and dayname(date_event_fin) =TRIM( jour_date)
		and @time_fin between time_event_debut and time_event_fin
	UNION
	SELECT
		'' jour,
		'' time_non_dispo_jour_debut,
		'' time_non_dispo_jour_fin,
		CONCAT(daa.date_debut,'T',daa.time_debut) as start,
		CONCAT(daa.date_fin,'T',daa.time_fin) as end,	
		daa.id,
		daa.motif as title,
		'' cin,
		'' numero_telephone,
		'' email,
		'' nom,
		'' prenom,
		daa.id_autorite_enfant_sender,
		ae.intitule,
		ae.intitule_code,
		CASE 
			WHEN action = 0 THEN 'Non validé'
			WHEN action = 1 THEN 'Validé'
			WHEN action = 2 THEN 'Reporté'
		END as status_evenement,
		'Autorité' type_evenement
	FROM
		stage.demande_audience_autorite daa
	JOIN stage.autorite_enfant ae on  daa.id_autorite_enfant_sender =ae.id
	where
		-- Si disponible sur l'autorite  
		daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
		and dayname(daa.date_debut) =TRIM( jour_date)
		and dayname(daa.date_fin) =TRIM( jour_date)
		and daa.time_debut between @time_debut and @time_fin
		and daa.time_fin between @time_debut and @time_fin
		or
		daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
		and dayname(daa.date_debut) =TRIM( jour_date)
		and dayname(daa.date_fin) =TRIM( jour_date)
		and @time_debut between daa.time_debut and daa.time_fin
		and @time_fin between daa.time_debut and daa.time_fin
		or
		daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
		and dayname(daa.date_debut) =TRIM( jour_date)
		and dayname(daa.date_fin) =TRIM( jour_date)
		and @time_debut between daa.time_debut and daa.time_fin
		or
		daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
		and dayname(daa.date_debut) =TRIM( jour_date)
		and dayname(daa.date_fin) =TRIM( jour_date)
		and @time_fin between daa.time_debut and daa.time_fin
	UNION
	SELECT
		'' jour,
		'' time_non_dispo_jour_debut,
		'' time_non_dispo_jour_fin,
		CONCAT(ndad.date_non_dispo_debut,'T',ndad.time_debut) as start,
		CONCAT(ndad.date_non_dispo_fin,'T',ndad.time_fin) as end,	
		id,
		'Pas disponible' as title,
		'' cin,
		'' numero_telephone,
		'' email,
		'' nom,
		'' prenom,
		'' id_autorite_enfant_sender,
		'' intitule,
		'' intitule_code,
		'Pas disponible' status_evenement,
		'Pas disponible date' type_evenement
	FROM
		stage.non_disponibilite_autorite_date ndad
	where
		-- Si pas disponible sur autorite date 
		ndad.id_autorite_enfant = id_autorite
		and dayname(ndad.date_non_dispo_debut) =TRIM( jour_date)
		and dayname(ndad.date_non_dispo_fin) =TRIM( jour_date)
		and ndad.time_debut between @time_debut and @time_fin
		and ndad.time_fin between @time_debut and @time_fin
		or
		ndad.id_autorite_enfant = id_autorite
		and dayname(ndad.date_non_dispo_debut) =TRIM( jour_date)
		and dayname(ndad.date_non_dispo_fin) =TRIM( jour_date)
		and @time_debut between ndad.time_debut and ndad.time_fin
		and @time_fin between ndad.time_debut and ndad.time_fin
		or
		ndad.id_autorite_enfant = id_autorite
		and dayname(ndad.date_non_dispo_debut) =TRIM( jour_date)
		and dayname(ndad.date_non_dispo_fin) =TRIM( jour_date)
		and @time_debut between ndad.time_debut and ndad.time_fin
		or
		ndad.id_autorite_enfant = id_autorite
		and dayname(ndad.date_non_dispo_debut) =TRIM( jour_date)
		and dayname(ndad.date_non_dispo_fin) =TRIM( jour_date)
		and @time_fin between ndad.time_debut and ndad.time_fin
	UNION
	SELECT
		'' jour,
		'' time_non_dispo_jour_debut,
		'' time_non_dispo_jour_fin,
		CONCAT(eds.date_debut,'T',eds.time_debut) as start,
		CONCAT(eds.date_fin,'T',eds.time_fin) as end,	
		eds.id,
		CONCAT('Entretien ',ds.nom,' ',ds.prenom) as title,
		ds.cin,
		ds.telephone,
		ds.e_mail,
		ds.nom,
		ds.prenom,
		'' id_autorite_enfant_sender,
		'' intitule,
		'' intitule_code,
		'Stage' status_evenement,
		'Entretien' type_evenement
		
	FROM
		stage.entretien_demande_stage eds
	JOIN demande_stage ds on eds.id_demande_stage = ds.id
	where 
		-- Si disponible entretien
		ds.id_autorite_enfant = id_autorite
		and dayname(eds.date_debut) =TRIM( jour_date)
		and dayname(eds.date_fin) =TRIM( jour_date)
		and eds.time_debut between @time_debut and @time_fin
		and eds.time_fin between @time_debut and @time_fin
		or
		ds.id_autorite_enfant = id_autorite
		and dayname(eds.date_debut) =TRIM( jour_date)
		and dayname(eds.date_fin) =TRIM( jour_date)
		and @time_debut between eds.time_debut and eds.time_fin
		and @time_fin between eds.time_debut and eds.time_fin
		or
		ds.id_autorite_enfant = id_autorite
		and dayname(eds.date_debut) =TRIM( jour_date)
		and dayname(eds.date_fin) =TRIM( jour_date)
		and @time_debut between eds.time_debut and eds.time_fin
		or
		ds.id_autorite_enfant = id_autorite
		and dayname(eds.date_debut) =TRIM( jour_date)
		and dayname(eds.date_fin) =TRIM( jour_date)
		and @time_fin between eds.time_debut and eds.time_fin
	
	UNION
	SELECT 
		'' jour,
		'' time_non_dispo_jour_debut,
		'' time_non_dispo_jour_fin,
		concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour,'T',time_event_debut) start,
		concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour,'T',time_event_fin) end,	
		id,
		nom_evenement as title,
		'' cin,
		'' numero_telephone,
		'' e_mail,
		'' nom,
		'' prenom,
		'' id_autorite_enfant_sender,
		'' intitule,
		'' intitule_code,
		'Jour férié' status_evenement,
		'Jour férié' type_evenement
	FROM stage.jour_ferie 
	WHERE 
		(select dayname(concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour))) =TRIM( jour_date)
		and time_event_debut BETWEEN  @time_debut and @time_fin 
		and time_event_fin BETWEEN @time_debut and @time_fin 
		or 
		(select dayname(concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour))) =TRIM( jour_date)
		and @time_debut BETWEEN  time_event_debut and time_event_fin 
		and @time_fin BETWEEN time_event_debut and time_event_fin 
		or 
		(select dayname(concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour))) =TRIM( jour_date)
		and @time_debut BETWEEN  time_event_debut and time_event_fin 
		and time_event_fin BETWEEN time_event_debut and @time_fin 
		or 
		(select dayname(concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour))) =TRIM( jour_date) 
		and time_event_debut  BETWEEN  @time_debut and time_event_fin 
		and @time_fin  BETWEEN time_event_debut and time_event_fin
	UNION
	SELECT
		jour,
		time_non_dispo_jour_debut,
		time_non_dispo_jour_fin,
		'' start,
		'' end,	
		id,
		'' title,
		'' cin,
		'' numero_telephone,
		'' e_mail,
		'' nom,
		'' prenom,
		'' id_autorite_enfant_sender,
		'' intitule,
		'' intitule_code,
		'Pas disponible' status_evenement,
		'Pas disponible jour' type_evenement
	FROM
		non_disponibilite_autorite_jour 
	WHERE 	
		-- Si disponible sur disponible jour
		non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
		and  non_disponibilite_autorite_jour.jour =TRIM( jour_date) 
		and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin 
		and non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin 
		OR
		non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
		and non_disponibilite_autorite_jour.jour =TRIM( jour_date) 
		AND @time_debut BETWEEN non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
		and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
		or
		non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
		and non_disponibilite_autorite_jour.jour =TRIM( jour_date) 
		and @time_debut between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
		OR 
		non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
		and non_disponibilite_autorite_jour.jour =TRIM( jour_date) 
		and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin;	

END


CREATE  PROCEDURE `LISTE_EVENEMENTS_BY_DAY`(IN jour_date VARCHAR(15),in td time,in tf time,in id_autorite int)
BEGIN    
	    DECLARE time_debut time;
	    DECLARE time_fin time;
	    SET @time_debut = SUBTIME(td,"-00:01:00");
	    SET @time_fin = SUBTIME(tf,"00:01:00");
		set @jour_UTF8 = CONVERT(jour_date USING utf8);	
		SELECT 
			'' jour,
			'' time_non_dispo_jour_debut,
			'' time_non_dispo_jour_fin,
			CONCAT(date_event_debut,'T',time_event_debut) as start,
			CONCAT(date_event_fin,'T',time_event_fin) as end,
			id,
			Motif as title,
			cin,
			numero_telephone,
			email,
			nom,
			prenom,
			'' id_autorite_enfant_sender,
			'' intitule,
			'' intitule_code,
			CASE 
				WHEN action = 0 THEN 'Non validé'
				WHEN action = 1 THEN 'Validé'
				WHEN action = 2 THEN 'Reporté'
			END as status_evenement,
			'Public' type_evenement
		FROM 
			stage.demande_audience_public 
	    where 
			-- Si disponible sur l'audience public
			id_autorite_enfant = id_autorite
			AND action >= 0 and action <= 1
	        and CONVERT(dayname(date_event_debut) USING utf8) = @jour_UTF8
			and CONVERT(dayname(date_event_fin) USING utf8) =@jour_UTF8
			and time_event_debut between @time_debut and @time_fin
			and time_event_fin between @time_debut and @time_fin
			or
			id_autorite_enfant = id_autorite
			AND action >= 0 and action <= 1
	        and CONVERT(dayname(date_event_debut) USING utf8) =@jour_UTF8
			and CONVERT(dayname(date_event_fin) USING utf8) =@jour_UTF8
			and @time_debut between time_event_debut and time_event_fin
			and @time_fin between time_event_debut and time_event_fin
			or
			id_autorite_enfant = id_autorite
			AND action >= 0 and action <= 1
	        and CONVERT(dayname(date_event_debut) USING utf8) =@jour_UTF8
			and CONVERT(dayname(date_event_fin) USING utf8) =@jour_UTF8
			and @time_debut between time_event_debut and time_event_fin
			or
			id_autorite_enfant = id_autorite
			AND action >= 0 and action <= 1
	        and CONVERT(dayname(date_event_debut) USING utf8) =@jour_UTF8
			and CONVERT(dayname(date_event_fin) USING utf8) =@jour_UTF8
			and @time_fin between time_event_debut and time_event_fin;
END

CALL LISTE_EVENEMENTS_BY_DAY('Wednesday','03:00:00','17:10:00',1)

CALL add_non_disponibilite_autorite_date_v2('2022-11-09','2022-11-09','02:00:00','17:00:00',1)
CALL add_non_disponibilite_autorite_jour('Wednesday','03:00:00','17:10:00',1)
CALL LISTE_EVENEMENTS('2022-11-09','2022-11-09','02:00:00','17:00:00',1)
CALL NBR_ROWS_EVENEMENTS('2022-11-09','2022-11-09','02:00:00','17:00:00',1)



