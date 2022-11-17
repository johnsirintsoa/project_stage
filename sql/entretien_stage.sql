-- Detail demande de stage par autorite
SELECT 
	e.id,
	e.nom,
	e.prenom, 
	e.telephone, 
	e.e_mail, 
	e.cin, 
	e.duree,
	e.curriculum_vitae, 
	e.lettre_motivation,
	e.lettre_introduction,
	e.message, 
	d.id, 
	d.nom_domaine,
	e.id_autorite_enfant
FROM
	stage.demande_stage e 
		JOIN domaine d on e.id_domaine = d.id	
		where id_autorite_enfant = 1 and e.id = 4;

-- Liste demande de stage par autorite
SELECT 
	e.id as id_demande_stage,
	e.nom, 
	e.prenom,
	e.telephone, 
	e.e_mail,
	e.cin,
	e.duree, 
	e.curriculum_vitae, 
	e.lettre_motivation, 
	e.lettre_introduction, 
	e.message, 
	d.id as id_domaine,
	d.nom_domaine,
	eds.id as id_entretien_demande_stage,
	eds.date_debut,
	eds.date_fin,
	eds.time_debut,
	eds.time_fin,
	CASE 
		WHEN eds.id IS NULL THEN 'en attente' 
		ELSE 'validé' END as demande_status
FROM
	stage.demande_stage e 
	JOIN domaine d on e.id_domaine = d.id
	LEFT JOIN entretien_demande_stage eds on e.id = eds.id_demande_stage where e.id_autorite_enfant = 1;

-- Ajouter un entretien
CREATE  PROCEDURE `add_entretien_stage`(dd date,df date,td time,tf time,id_autorite_enfant int,id_demande_stage int)
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
		stage.autorite_enfant.id = id_autorite_enfant
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and stage.demande_audience_public.time_event_debut between @time_debut and @time_fin
		and stage.demande_audience_public.time_event_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and @time_debut between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		and @time_fin between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant
        and stage.demande_audience_public.date_event_debut between dd and df
		and stage.demande_audience_public.date_event_fin between dd and df
		and @time_debut between stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant
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
		stage.autorite_enfant.id = id_autorite_enfant
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and stage.demande_audience_autorite.time_debut between @time_debut and @time_fin
		and stage.demande_audience_autorite.time_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and @time_debut between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		and @time_fin between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant
        and stage.demande_audience_autorite.date_debut between dd and df
		and stage.demande_audience_autorite.date_fin between dd and df
		and @time_debut between stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant
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
		stage.autorite_enfant.id = id_autorite_enfant
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and stage.non_disponibilite_autorite_date.time_debut between @time_debut and @time_fin
		and stage.non_disponibilite_autorite_date.time_fin between @time_debut and @time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and @time_debut between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		and @time_fin between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant
        and stage.non_disponibilite_autorite_date.date_non_dispo_debut between dd and df
		and stage.non_disponibilite_autorite_date.date_non_dispo_fin between dd and df
		and @time_debut between stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
		or
		stage.autorite_enfant.id = id_autorite_enfant
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
				stage.autorite_enfant.id = id_autorite_enfant
				and  non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin 
				and non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin 
				OR
				stage.autorite_enfant.id = id_autorite_enfant 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				AND @time_debut BETWEEN non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				or
				stage.autorite_enfant.id = id_autorite_enfant 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and @time_debut between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
				OR 
				stage.autorite_enfant.id = id_autorite_enfant 
				and non_disponibilite_autorite_jour.jour = dayname(dd) 
				and non_disponibilite_autorite_jour.jour =  dayname(df) 
				and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin)`x` into @nbr_rows;
		
	-- select @nbr_rows;   
	IF dd != '' AND df != '' AND td != '' AND tf != '' AND @si_ferie = 0 AND @nbr_rows = 0 and df = dd and td < tf  THEN   
		INSERT INTO stage.entretien_demande_stage( date_debut, date_fin, time_debut, time_fin, id_demande_stage) VALUES (dd,df,td,tf,id_demande_stage);
	ELSEIF dd = '' or df = '' or td = '' or tf = '' THEN 
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

-- Prolonger duree de stage
CREATE  PROCEDURE `prolonger_duree_stage`(duree_de_stage int,id_entretien_stage int)
BEGIN
	SELECT  
        ds.duree,
		es.id_demande_stage
    FROM
        stage.entretien_demande_stage es 
            INNER JOIN demande_stage ds on es.id_demande_stage = ds.id	
            	where es.id = id_entretien_stage into @duree_initial,@id_demande_stage;  
	IF duree_de_stage <= 0 THEN
		SELECT 'duree de stage invalid' as message;
	ELSE 
		set @duree_final = @duree_initial + duree_de_stage;	
		UPDATE stage.demande_stage SET stage.demande_stage.duree = @duree_final where stage.demande_stage.id = @id_demande_stage;
	END IF;
END
CALL `add_entretien_stage`('2022-11-09','2022-11-09','05:00:00','06:30:00',1,6)