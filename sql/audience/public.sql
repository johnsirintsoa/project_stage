-- si_disponible_public 09/11/2022
CREATE  PROCEDURE `si_disponible_public`(dd date,df date,td time,tf time,motif VARCHAR(200),id_autorite int)
BEGIN    
    DECLARE time_debut time;
    DECLARE time_fin time;
    DECLARE si_ferie INT;
    set @si_ferie = si_jour_ferie(dd ,df ,td ,tf );
    SET @time_debut = SUBTIME(td,"-00:01:00");
    SET @time_fin = SUBTIME(tf,"00:01:00");
    -- select @si_ferie;
 	SELECT SUM(nbr_rows) FROM (	   
	SELECT 
	    count(*) as nbr_rows
    FROM 
        stage.autorite_enfant 
            LEFT JOIN stage.demande_audience_public on stage.autorite_enfant.id = stage.demande_audience_public.id_autorite_enfant
    where 
		-- Si disponible sur l'audience public
		stage.autorite_enfant.id = id_autorite
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and stage.demande_audience_public.time_event_debut between @time_debut and @time_fin
		and stage.demande_audience_public.time_event_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and @time_debut between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		and @time_fin between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and @time_debut between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and @time_fin between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
	UNION
	SELECT
		count(*) as nbr_rows
	FROM
		stage.autorite_enfant
			LEFT JOIN stage.demande_audience_autorite on stage.autorite_enfant.id = stage.demande_audience_autorite.id_autorite_enfant_receiver
    where 
		stage.autorite_enfant.id = id_autorite
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and stage.demande_audience_autorite.time_debut between @time_debut and @time_fin
		and stage.demande_audience_autorite.time_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and @time_debut between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		and @time_fin between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and @time_debut between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and @time_fin between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
	UNION
	SELECT
		count(*) as nbr_rows
	FROM
		stage.autorite_enfant
			LEFT JOIN stage.non_disponibilite_autorite_date on stage.autorite_enfant.id = stage.non_disponibilite_autorite_date.id_autorite_enfant
    where 
		stage.autorite_enfant.id = id_autorite
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and stage.non_disponibilite_autorite_date.time_debut between @time_debut and @time_fin
		and stage.non_disponibilite_autorite_date.time_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and @time_debut between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		and @time_fin between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and @time_debut between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and @time_fin between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
	UNION
	SELECT
		count(*) as nbr_rows 
	FROM
		stage.autorite_enfant
			LEFT JOIN stage.non_disponibilite_autorite_jour on stage.autorite_enfant.id = stage.non_disponibilite_autorite_jour.id_autorite_enfant
				WHERE 	
				stage.autorite_enfant.id = id_autorite 
				and  non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin 
				and non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin 
				OR
				stage.autorite_enfant.id = id_autorite 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				AND @time_debut BETWEEN non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				or
				stage.autorite_enfant.id = id_autorite 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and @time_debut between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				OR 
				stage.autorite_enfant.id = id_autorite 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin)`x` into @nbr_rows;
	IF @si_ferie = 0 AND @nbr_rows = 0 and df = dd and td < tf  THEN   
		INSERT INTO stage.demande_audience_autorite( date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, id_autorite_enfant_receiver, motif) VALUES (dd,df,td,tf,id_autorite_enfant_sender,id_autorite_enfant_receiver,motif);
	ELSEIF @nbr_rows > 0 and @si_ferie = 0 THEN  
		SELECT 'pas disponible' as message;
	ELSEIF dd != df then 
		SELECT 'date fin invalid' as message;
	ELSEIF tf <= td  then 
		SELECT 'time fin invalid' as message;
	ELSEIF @si_ferie > 0 and @nbr_rows = 0 THEN  
		SELECT 'Jour férié' as message;
	ELSE 
		SELECT 'Jour férié et pas disponible' as message;
	END IF;	
END

CREATE  PROCEDURE `add_audience_public`(nom varchar(30),prenom varchar(30),cin varchar(15),numero_telephone varchar(10),email varchar(30),dd date,df date,td time,tf time,motif VARCHAR(200),id_autorite int)
BEGIN    
    DECLARE time_debut time;
    DECLARE time_fin time;
    DECLARE si_ferie INT;
    set @si_ferie = si_jour_ferie(dd ,df ,td ,tf );
    SET @time_debut = SUBTIME(td,"-00:01:00");
    SET @time_fin = SUBTIME(tf,"00:01:00");
    -- select @si_ferie;
 	SELECT SUM(nbr_rows) FROM (	   
	SELECT 
	    count(*) as nbr_rows
    FROM 
        stage.autorite_enfant 
            LEFT JOIN stage.demande_audience_public on stage.autorite_enfant.id = stage.demande_audience_public.id_autorite_enfant
    where 
		-- Si disponible sur l'audience public
		stage.autorite_enfant.id = id_autorite
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and stage.demande_audience_public.time_event_debut between @time_debut and @time_fin
		and stage.demande_audience_public.time_event_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and @time_debut between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		and @time_fin between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and @time_debut between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and @time_fin between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
	UNION
	SELECT
		count(*) as nbr_rows
	FROM
		stage.autorite_enfant
			LEFT JOIN stage.demande_audience_autorite on stage.autorite_enfant.id = stage.demande_audience_autorite.id_autorite_enfant_receiver
    where 
		stage.autorite_enfant.id = id_autorite
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and stage.demande_audience_autorite.time_debut between @time_debut and @time_fin
		and stage.demande_audience_autorite.time_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and @time_debut between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		and @time_fin between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and @time_debut between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and @time_fin between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
	UNION
	SELECT
		count(*) as nbr_rows
	FROM
		stage.autorite_enfant
			LEFT JOIN stage.non_disponibilite_autorite_date on stage.autorite_enfant.id = stage.non_disponibilite_autorite_date.id_autorite_enfant
    where 
		stage.autorite_enfant.id = id_autorite
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and stage.non_disponibilite_autorite_date.time_debut between @time_debut and @time_fin
		and stage.non_disponibilite_autorite_date.time_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and @time_debut between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		and @time_fin between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and @time_debut between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		or
		stage.autorite_enfant.id = id_autorite
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and @time_fin between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
	
		UNION
	
    SELECT
		count(*) as nbr_rows
	FROM
		stage.entretien_demande_stage eds
	JOIN demande_stage ds on eds.id_demande_stage = ds.id
    where 
		ds.id_autorite_enfant = id_autorite_enfant
        and eds.date_debut between dd and df
		and eds.date_fin between dd and df
		and eds.time_debut between @time_debut and @time_fin
		and eds.time_fin between @time_debut and @time_fin
		or
		ds.id_autorite_enfant = id_autorite_enfant
        and eds.date_debut between dd and df
		and eds.date_fin between dd and df
		and @time_debut between eds.time_debut and eds.time_fin
		and @time_fin between eds.time_debut and eds.time_fin
		or
		ds.id_autorite_enfant = id_autorite_enfant
        and eds.date_debut between dd and df
		and eds.date_fin between dd and df
		and @time_debut between eds.time_debut and eds.time_fin
		or
		ds.id_autorite_enfant = id_autorite_enfant
        and eds.date_debut between dd and df
		and eds.date_fin between dd and df
		and @time_fin between eds.time_debut and eds.time_fin
	
	UNION
	SELECT
		count(*) as nbr_rows 
	FROM
		stage.autorite_enfant
			LEFT JOIN stage.non_disponibilite_autorite_jour on stage.autorite_enfant.id = stage.non_disponibilite_autorite_jour.id_autorite_enfant
				WHERE 	
				stage.autorite_enfant.id = id_autorite 
				and  non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin 
				and non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin 
				OR
				stage.autorite_enfant.id = id_autorite 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				AND @time_debut BETWEEN non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				or
				stage.autorite_enfant.id = id_autorite 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and @time_debut between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				OR 
				stage.autorite_enfant.id = id_autorite 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin)`x` into @nbr_rows;
	IF  nom != '' and prenom != '' and cin != '' and numero_telephone != '' and email !='' AND motif!='' AND @si_ferie = 0 AND @nbr_rows = 0 and df = dd and td < tf  THEN   
		INSERT INTO stage.demande_audience_autorite( date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, id_autorite_enfant_receiver, motif) VALUES (dd,df,td,tf,id_autorite_enfant_sender,id_autorite_enfant_receiver,motif);
	ELSEIF nom = '' or prenom = '' or cin = '' OR numero_telephone = '' OR email='' OR motif='' THEN 
		SELECT 'formulaire vide' as message;
	ELSEIF @nbr_rows > 0 and @si_ferie = 0 THEN  
		SELECT 'pas disponible' as message;
	ELSEIF dd != df then 
		SELECT 'date fin invalid' as message;
	ELSEIF tf <= td  then 
		SELECT 'time fin invalid' as message;
	ELSEIF @si_ferie > 0 and @nbr_rows = 0 THEN  
		SELECT 'Jour férié' as message;
	ELSE 
		SELECT 'Jour férié et pas disponible' as message;
	END IF;	
END

CALL si_disponible_public_temp('2022-11-09','2022-11-09','06:00:00','07:45:00','TEST',1)
-- SET @nbr_rows = si_disponible(1,'2022-10-21','2022-10-21','06:00:00','07:00:00');
CALL si_disponible_public('2022-11-09','2022-11-09','07:40:00','08:40:00','TEST',1)
CALL si_disponible_public_tmp('2022-11-09','2022-11-09','07:40:00','08:40:00','TEST',1)	

--- Procedure pour supprimer les foreign keys null
CREATE  PROCEDURE `supprimer_columns_null`()
BEGIN 
	DELETE FROM dm_aud_public_heure_dispo WHERE id_aud_public IS NULL;
	DELETE FROM heure_dispo_dm_aud_autorite where id_dm_aud_autorite IS NULL;
	DELETE FROM heure_disponible where id_jour_ouvrable IS NULL;
	DELETE FROM entretien_demande_stage WHERE entretien_demande_stage.id_demande_stage is null;
	DELETE FROM demande_stage where id_autorite_enfant is null;
	DELETE FROM demande_audience_autorite where id_autorite_enfant_sender is null;
END


--- Liste des places disponibles 
--- V1
CREATE  PROCEDURE `liste_disponible_public`(IN session_navigateur varchar(100), IN id_autorite int)
BEGIN
	SET @session_navigateur = session_navigateur;
	set @id_autorite = id_autorite;

	(SELECT 
	dhd.id as id_date_heure_disponible,
	dhda.id as id_date_heure_disponible_autorite,
	CONCAT(dapdhd.date_debut,'T', dapdhd.heure_debut) as start, 
	CONCAT(dapdhd.date_fin,'T', dapdhd.heure_fin) as end, 
	dhd.heure_debut as hd,
	dhd.heure_fin as hf,
	dap.id as id, 
	dapdhd.id as id_dm_aud_public_heure_dispo,
	dhd.date_disponible,
	dapdhd.heure_debut, 
	dapdhd.heure_fin, 
	dap.motif as title, 
	dap.nom, 
	dap.prenom, 
	dap.cin, 
	dap.numero_telephone, 
	dap.email, 
	CASE 
	    WHEN dap.action = 0 THEN 'Non validé' 
	    WHEN dap.action = 1 THEN 'Validé' 
	    WHEN dap.action = 2 THEN 'Reporté' 
	    ELSE 'Aucune' 
	END as status_audience,
	CASE 
	    WHEN dap.session_navigateur = @session_navigateur and dap.action = 0 THEN "#407DFF" 
	    WHEN dap.session_navigateur = @session_navigateur and dap.action = 1 THEN "#FF0018" 
	    ELSE '#FF0018' 
	END as color, 
	CASE 
	    WHEN dap.session_navigateur = @session_navigateur and dap.action = 0 THEN "#407DFF" 
	    WHEN dap.session_navigateur = @session_navigateur and dap.action = 1 THEN "#FF0018" 
	    ELSE '#FF0018'
	END as color_status, 
	false editable 
	FROM date_heure_disponible_autorite dhda
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	JOIN dm_aud_public_date_heure_dispo dapdhd on dhda.id = dapdhd.id_date_heure_disponible_autorite
	JOIN demande_audience_public dap on dapdhd.id_aud_public = dap.id
	WHERE 
	dhda.id_autorite = @id_autorite
	and dhd.date_disponible >= CURDATE()
	and dhda.est_disponible is true
	and dap.session_navigateur = @session_navigateur
	and dap.action >=0 and dap.action <=1
	GROUP BY dapdhd.id_aud_public)
	
	UNION
	(SELECT 
	dhd.id as id_date_heure_disponible,
	dhda.id as id_date_heure_disponible_autorite,
	CONCAT(dhd.date_disponible,'T', dhd.heure_debut) as start, 
	CONCAT(dhd.date_disponible,'T', dhd.heure_fin) as end, 
	dhd.heure_debut as hd,
	dhd.heure_fin as hf,
	'' id, 
	dapdhd.id as id_dm_aud_public_heure_dispo,
	dhd.date_disponible,
	dapdhd.heure_debut, 
	dapdhd.heure_fin, 
	'Disponible' title, 
	'' nom, 
	'' prenom, 
	'' cin, 
	'' numero_telephone, 
	'' email, 
	'' status_audience, 
	'#0AA913' color, 
	'' color_status, 
	false editable  
	FROM stage5.date_heure_disponible_autorite dhda 
	join date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id 
	LEFT JOIN dm_aud_autorite_date_heure_dispo daadhd on dhda.id = daadhd.id_date_heure_disponible_autorite
	LEFT JOIN demande_audience_autorite daa on daa.id = daadhd.id_dm_aud_autorite
	LEFT JOIN dm_aud_public_date_heure_dispo dapdhd on dhda.id = dapdhd.id_date_heure_disponible_autorite 
	LEFT JOIN demande_audience_public dap on dap.id = dapdhd.id_aud_public
	LEFT JOIN entretien_demande_stage eds on dhda.id = eds.id_date_heure_disponible_autorite 
	where 
	dhda.id_autorite = @id_autorite 
	and dhd.date_disponible >= CURDATE()
	and dhda.est_disponible is true 
	and eds.id is null 
	and daadhd.id is null 
	and dapdhd.id is null
	or
	dhda.id_autorite = @id_autorite 
	and dhd.date_disponible >= CURDATE()
	and dap.action = 2);

END

--- v2
CREATE  PROCEDURE `liste_disponible_public`(IN session_navigateur varchar(100), IN id_autorite int)
BEGIN
	SET @session_navigateur = session_navigateur;
	set @id_autorite = id_autorite;

	(SELECT 
	dhd.id as id_date_heure_disponible,
	dhda.id as id_date_heure_disponible_autorite,
	CONCAT(dapdhd.date_debut,'T', dapdhd.heure_debut) as start, 
	CONCAT(dapdhd.date_fin,'T', dapdhd.heure_fin) as end, 
	dhd.heure_debut as hd,
	dhd.heure_fin as hf,
	dap.id as id, 
	dapdhd.id as id_dm_aud_public_heure_dispo,
	dhd.date_disponible,
	dapdhd.heure_debut, 
	dapdhd.heure_fin, 
	dap.motif as title, 
	dap.nom, 
	dap.prenom, 
	dap.cin, 
	dap.numero_telephone, 
	dap.email, 
	CASE 
	    WHEN dap.action = 0 THEN 'Non validé' 
	    WHEN dap.action = 1 THEN 'Validé' 
	    WHEN dap.action = 2 THEN 'Reporté' 
	    ELSE 'Aucune' 
	END as status_audience,
	CASE 
	    WHEN dap.session_navigateur = @session_navigateur and dap.action = 0 THEN "#407DFF" 
	    WHEN dap.session_navigateur = @session_navigateur and dap.action = 1 THEN "#FF0018" 
	    ELSE '#FF0018' 
	END as color, 
	CASE 
	    WHEN dap.session_navigateur = @session_navigateur and dap.action = 0 THEN "#407DFF" 
	    WHEN dap.session_navigateur = @session_navigateur and dap.action = 1 THEN "#FF0018" 
	    ELSE '#FF0018'
	END as color_status, 
	false editable 
	FROM date_heure_disponible_autorite dhda
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	JOIN dm_aud_public_date_heure_dispo dapdhd on dhda.id = dapdhd.id_date_heure_disponible_autorite
	JOIN demande_audience_public dap on dapdhd.id_aud_public = dap.id
	WHERE 
	dhda.id_autorite = @id_autorite
	and dhd.date_disponible >= CURDATE()
	and dhda.est_disponible is true
	and dap.session_navigateur = @session_navigateur
	and dap.action >=0 and dap.action <=1
	GROUP BY dapdhd.id_aud_public)
	
	UNION
	(SELECT 
	dhd.id as id_date_heure_disponible,
	dhda.id as id_date_heure_disponible_autorite,
	CONCAT(dhd.date_disponible,'T', dhd.heure_debut) as start, 
	CONCAT(dhd.date_disponible,'T', dhd.heure_fin) as end, 
	dhd.heure_debut as hd,
	dhd.heure_fin as hf,
	'' id, 
	dapdhd.id as id_dm_aud_public_heure_dispo,
	dhd.date_disponible,
	dapdhd.heure_debut, 
	dapdhd.heure_fin, 
	'Disponible' title, 
	'' nom, 
	'' prenom, 
	'' cin, 
	'' numero_telephone, 
	'' email, 
	'' status_audience, 
	'#0AA913' color, 
	'' color_status, 
	false editable  
	FROM date_heure_disponible_autorite dhda
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id 
	LEFT JOIN pas_disponible pd on dhda.id = pd.id_date_heure_disponible_autorite
	LEFT JOIN dm_aud_autorite_date_heure_dispo daadhd on dhda.id = daadhd.id_date_heure_disponible_autorite
	LEFT JOIN demande_audience_autorite daa on daa.id = daadhd.id_dm_aud_autorite
	LEFT JOIN dm_aud_public_date_heure_dispo dapdhd on dhda.id = dapdhd.id_date_heure_disponible_autorite 
	LEFT JOIN demande_audience_public dap on dap.id = dapdhd.id_aud_public
	LEFT JOIN entretien_demande_stage eds on dhda.id = eds.id_date_heure_disponible_autorite 
	WHERE 
	dhda.id_autorite = @id_autorite
	and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) >= (select CURRENT_TIMESTAMP())
	and eds.id is null 
	and daadhd.id is null 
	and dapdhd.id is null
	and pd.id is NULL
	or
	dhda.id_autorite = @id_autorite
	and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) >= (select CURRENT_TIMESTAMP())
	and dap.action = 2);

END