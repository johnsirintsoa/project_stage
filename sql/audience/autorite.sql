CREATE  PROCEDURE `si_disponible_autorite`(dd date,df date,td time,tf time,id_autorite_enfant_sender int,id_autorite_enfant_receiver int,motif VARCHAR(200))
BEGIN    
    DECLARE time_debut time;
    DECLARE time_fin time;
    DECLARE si_ferie INT;
    set @si_ferie = si_jour_ferie(dd ,df ,td ,tf );
    SET @time_debut = SUBTIME(td,"-00:01:00");
    SET @time_fin = SUBTIME(tf,"00:01:00");
	select @si_ferie;
    SELECT SUM(nbr_rows) FROM (	   
	SELECT 
	    count(*) as nbr_rows
    FROM 
        stage.autorite_enfant 
            LEFT JOIN stage.demande_audience_public on stage.autorite_enfant.id = stage.demande_audience_public.id_autorite_enfant
    where 
		-- Si disponible sur l'audience public
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and stage.demande_audience_public.time_event_debut between @time_debut and @time_fin
		and stage.demande_audience_public.time_event_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and @time_debut between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		and @time_fin between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and @time_debut between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
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
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and stage.demande_audience_autorite.time_debut between @time_debut and @time_fin
		and stage.demande_audience_autorite.time_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and @time_debut between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		and @time_fin between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and @time_debut between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
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
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and stage.non_disponibilite_autorite_date.time_debut between @time_debut and @time_fin
		and stage.non_disponibilite_autorite_date.time_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and @time_debut between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		and @time_fin between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and @time_debut between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
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
				stage.autorite_enfant.id = id_autorite_enfant_receiver
				and  non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin 
				and non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin 
				OR
				stage.autorite_enfant.id = id_autorite_enfant_receiver 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				AND @time_debut BETWEEN non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				or
				stage.autorite_enfant.id = id_autorite_enfant_receiver 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and @time_debut between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				OR 
				stage.autorite_enfant.id = id_autorite_enfant_receiver 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin)`x` into @nbr_rows;
 	-- select @nbr_rows;   
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

-- Add audience autorite
CREATE  PROCEDURE `add_audience_autorite`(dd date,df date,td time,tf time,id_autorite_enfant_sender int,id_autorite_enfant_receiver int,motif VARCHAR(200))
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
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and stage.demande_audience_public.time_event_debut between @time_debut and @time_fin
		and stage.demande_audience_public.time_event_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and @time_debut between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		and @time_fin between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and @time_debut between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
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
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and stage.demande_audience_autorite.time_debut between @time_debut and @time_fin
		and stage.demande_audience_autorite.time_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and @time_debut between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		and @time_fin between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and @time_debut between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
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
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and stage.non_disponibilite_autorite_date.time_debut between @time_debut and @time_fin
		and stage.non_disponibilite_autorite_date.time_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and @time_debut between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		and @time_fin between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and @time_debut between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
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
		ds.id_autorite_enfant = id_autorite_enfant_receiver
        and eds.date_debut between dd and df
		and eds.date_fin between dd and df
		and eds.time_debut between @time_debut and @time_fin
		and eds.time_fin between @time_debut and @time_fin
		or
		ds.id_autorite_enfant = id_autorite_enfant_receiver
        and eds.date_debut between dd and df
		and eds.date_fin between dd and df
		and @time_debut between eds.time_debut and eds.time_fin
		and @time_fin between eds.time_debut and eds.time_fin
		or
		ds.id_autorite_enfant = id_autorite_enfant_receiver
        and eds.date_debut between dd and df
		and eds.date_fin between dd and df
		and @time_debut between eds.time_debut and eds.time_fin
		or
		ds.id_autorite_enfant = id_autorite_enfant_receiver
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
				stage.autorite_enfant.id = id_autorite_enfant_receiver
				and  non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin 
				and non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin 
				OR
				stage.autorite_enfant.id = id_autorite_enfant_receiver 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				AND @time_debut BETWEEN non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				or
				stage.autorite_enfant.id = id_autorite_enfant_receiver 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and @time_debut between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				OR 
				stage.autorite_enfant.id = id_autorite_enfant_receiver 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin)`x` into @nbr_rows;
 	
	-- select @nbr_rows;   
	IF dd != '' AND df != '' AND td != '' AND tf != '' AND motif != '' AND @si_ferie = 0 AND @nbr_rows = 0 and df = dd and td < tf  THEN   
		INSERT INTO stage.demande_audience_autorite( date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, id_autorite_enfant_receiver, motif) VALUES (dd,df,td,tf,id_autorite_enfant_sender,id_autorite_enfant_receiver,motif);
	ELSEIF dd = '' or df = '' or td = '' or tf = '' or motif ='' THEN 
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

-- Update audience autorite
CREATE  PROCEDURE `update_audience_autorite`(id int,dd date,df date,td time,tf time,id_autorite_enfant_sender int,id_autorite_enfant_receiver int,motif VARCHAR(200))
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
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and stage.demande_audience_public.time_event_debut between @time_debut and @time_fin
		and stage.demande_audience_public.time_event_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and @time_debut between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		and @time_fin between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and @time_debut between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
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
		stage.autorite_enfant.id = id_autorite_enfant_receiver
		and stage.demande_audience_autorite.id != id
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and stage.demande_audience_autorite.time_debut between @time_debut and @time_fin
		and stage.demande_audience_autorite.time_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
		and stage.demande_audience_autorite.id != id
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and @time_debut between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		and @time_fin between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
		and stage.demande_audience_autorite.id != id
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and @time_debut between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
		and stage.demande_audience_autorite.id != id
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
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and stage.non_disponibilite_autorite_date.time_debut between @time_debut and @time_fin
		and stage.non_disponibilite_autorite_date.time_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and @time_debut between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		and @time_fin between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and @time_debut between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant_receiver
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
				stage.autorite_enfant.id = id_autorite_enfant_receiver
				and  non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin 
				and non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin 
				OR
				stage.autorite_enfant.id = id_autorite_enfant_receiver 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				AND @time_debut BETWEEN non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				or
				stage.autorite_enfant.id = id_autorite_enfant_receiver 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and @time_debut between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				OR 
				stage.autorite_enfant.id = id_autorite_enfant_receiver 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin)`x` into @nbr_rows;
 	
	-- select @nbr_rows;   
	IF dd != '' AND df != '' AND td != '' AND tf != '' AND motif != '' AND @si_ferie = 0 AND @nbr_rows = 0 and df = dd and td < tf  THEN   
		-- INSERT INTO stage.demande_audience_autorite( date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, id_autorite_enfant_receiver, motif) VALUES (dd,df,td,tf,id_autorite_enfant_sender,id_autorite_enfant_receiver,motif);
        UPDATE stage.demande_audience_autorite SET date_debut = dd, date_fin = df, time_debut = td, time_fin = tf, id_autorite_enfant_sender = id_autorite_enfant_sender , id_autorite_enfant_receiver = id_autorite_enfant_receiver , motif = motif WHERE stage.demande_audience_autorite.id = id;
    ELSEIF dd = '' or df = '' or td = '' or tf = '' or motif ='' THEN 
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

-- Liste faire audience autorite 
CREATE  PROCEDURE `LISTE_FAIRE_AUDIENCE_AUTORITE`(id_autorite_sender int,id_autorite_receiver int,_date date)
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
        'Occupé' as motif,
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
            WHERE dap.id_autorite_enfant = id_autorite_receiver and dap.action >=0 and dap.action <= 1 and dap.date_event_debut BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date) and dap.date_event_fin BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)
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
		IF(aes.id = id_autorite_sender, daa.motif, "Occupé") as motif,
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
            where daa.id_autorite_enfant_receiver = id_autorite_receiver and daa.action >=0 and daa.action <= 1 and daa.date_debut BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date) and daa.date_fin BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)
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
            where ndad.id_autorite_enfant = id_autorite_receiver  and ndad.date_non_dispo_debut BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date) and ndad.date_non_dispo_fin BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)
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
            where ndaj.id_autorite_enfant = id_autorite_receiver;    
END

-- Liste autorite par mois
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
		'' id_demande_entretien,
		'' date_debut_entretien,
		'' date_fin_entretien,
		'' time_debut_entretien,
		'' time_fin_entretien,
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
		'' id_demande_entretien,
		'' date_debut_entretien,
		'' date_fin_entretien,
		'' time_debut_entretien,
		'' time_fin_entretien,
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
        eds.action as action_entretien,
        CONCAT('Entretien ',ds.nom,' ',ds.prenom) as motif,
		eds.id as id_demande_entretien,
		eds.date_debut as date_debut_entretien,
		eds.date_fin as date_fin_entretien,
		eds.time_debut as time_debut_entretien,
		eds.time_fin as time_fin_entretien,
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
        'Entretien' type_audience
    FROM
		stage.entretien_demande_stage eds
		JOIN demande_stage ds on eds.id_demande_stage = ds.id
		JOIN autorite_enfant ae on ds.id_autorite_enfant = ae.id 
            WHERE ds.id_autorite_enfant = id_autorite and eds.date_debut BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date) and eds.date_fin BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)     

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
		'' id_demande_entretien,
		'' date_debut_entretien,
		'' date_fin_entretien,
		'' time_debut_entretien,
		'' time_fin_entretien,
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
		'' id_demande_entretien,
		'' date_debut_entretien,
		'' date_fin_entretien,
		'' time_debut_entretien,
		'' time_fin_entretien,
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
		'' id_demande_entretien,
		'' date_debut_entretien,
		'' date_fin_entretien,
		'' time_debut_entretien,
		'' time_fin_entretien,
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

CREATE  PROCEDURE `liste_disponible_autorite`(IN id_autorite_sender int,in id_autorite int)
BEGIN

	set @sender = id_autorite_sender;
	set @id_autorite = id_autorite;
	
	SELECT 
	ae.id as id_autorite_receiver,
	ae.intitule as intitule_receiver,
	ae.intitule_code as intitule_code_receiver,
	ae.addresse_electronique as addresse_electronique_receiver,
	dhd.id as id_date_heure_disponible,
	dhda.id as id_date_heure_disponible_autorite,
	CONCAT(daadhd.date_debut,'T', daadhd.heure_debut) as start, 
	CONCAT(daadhd.date_fin,'T', daadhd.heure_fin) as end, 
	dhd.heure_debut as hd,
	dhd.heure_fin as hf,
	daa.id as id,
	daadhd.id as id_dm_aud_autorite_date_heure_dispo,
	dhd.date_disponible,
	daadhd.heure_debut,
	daadhd.heure_fin,
	aes.id as id_autorite_sender,
	aes.intitule as intitule_sender,
	aes.intitule_code as intitule_code_sender,
	aes.addresse_electronique as addresse_electronique_sender,
	daa.motif as title,
	CASE 
	    WHEN daa.action = 0 THEN 'Non validé' 
	    WHEN daa.action = 1 THEN 'Validé' 
	    WHEN daa.action = 2 THEN 'Reporté' 
	    ELSE 'Aucune' 
	END as status_audience,
	CASE 
	    WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 0 THEN "#407DFF" 
	    WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 1 THEN "#FF0018" 
		WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 2 THEN "#1F1F1F"
	    ELSE '#FF0018' 
	END as color,
	CASE 
	    WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 0 THEN "#407DFF" 
	    WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 1 THEN "#FF0018"
		WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 2 THEN "#1F1F1F" 
	    ELSE '#FF0018'
	END as color_status,
	false editable
	FROM
	stage5.dm_aud_autorite_date_heure_dispo daadhd
	JOIN demande_audience_autorite daa on daadhd.id_dm_aud_autorite = daa.id
	JOIN autorite_enfant aes on daa.id_autorite_enfant_sender = aes.id 
	JOIN date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
	JOIN autorite_enfant ae on dhda.id_autorite = ae.id
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	WHERE 
	daa.id_autorite_enfant_sender = @sender
	and dhda.id_autorite = @id_autorite
	and (daa.action >= 0 and daa.action <=2)
	and dhd.date_disponible >= CURDATE()
	group by daadhd.id_dm_aud_autorite
	
	UNION
	
	(SELECT
	'' id_autorite_receiver,
	'' intitule_receiver,
	'' intitule_code_receiver,
	'' addresse_electronique_receiver,
	dhd.id as id_date_heure_disponible,
	dhda.id as id_date_heure_disponible_autorite,
	CONCAT(dhd.date_disponible,'T', dhd.heure_debut) as start, 
	CONCAT(dhd.date_disponible,'T', dhd.heure_fin) as end,
	dhd.heure_debut as hd,
	dhd.heure_fin as hf,
	'' id, 
	daadhd.id as id_dm_aud_autorite_date_heure_dispo,
	dhd.date_disponible,
	dapdhd.heure_debut, 
	dapdhd.heure_fin, 
	'' id_autorite_sender,
	'' intitule_sender,
	'' intitule_code_sender,
	'' addresse_electronique_sender,
	'Disponible' title,
	'' status_audience, 
	'#0AA913' color, 
	'' color_status, 
	false editable  
	FROM
	stage5.date_heure_disponible_autorite dhda
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
	and dapdhd.id is null);
END

CALL si_disponible_autorite('2022-11-09','2022-11-09','14:30:00','15:00:00',2,1,'Test 09 Night')
















