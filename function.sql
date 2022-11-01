-- si_Disponible public v1
CREATE  PROCEDURE `si_disponible_public`(dd date,df date,td time,tf time,id_autorite_enfant int,motif VARCHAR(200))
BEGIN    
    DECLARE time_debut time;
    DECLARE time_fin time;
    DECLARE si_ferie INT;
    set @si_ferie = si_jour_ferie(dd ,df ,td ,tf );
    SET @time_debut = SUBTIME(td,"-00:01:00");
    SET @time_fin = SUBTIME(tf,"00:01:00");
    -- select @si_ferie;
    SELECT 
	    count(autorite_enfant.id) as nbr_rows
    FROM
        stage.autorite_enfant 
            LEFT JOIN stage.demande_audience_public on stage.autorite_enfant.id = stage.demande_audience_public.id_autorite_enfant
            LEFT JOIN stage.demande_audience_autorite on stage.autorite_enfant.id = stage.demande_audience_autorite.id_autorite_enfant_receiver
            LEFT JOIN stage.non_disponibilite_autorite_date on stage.autorite_enfant.id = stage.non_disponibilite_autorite_date.id_autorite_enfant
    where autorite_enfant.id = 1 and stage.demande_audience_public.date_event_debut = dd and stage.demande_audience_public.date_event_fin = df and stage.demande_audience_public.time_event_debut BETWEEN @time_debut and @time_fin and stage.demande_audience_public.time_event_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.date_event_debut = dd and stage.demande_audience_public.date_event_fin = df and stage.demande_audience_public.time_event_debut BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.time_event_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.date_event_debut = dd and stage.demande_audience_public.date_event_fin = df and @time_debut BETWEEN stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin and @time_fin BETWEEN stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin OR 
    autorite_enfant.id = 1 and stage.demande_audience_autorite.date_debut = dd and stage.demande_audience_autorite.date_fin = df and stage.demande_audience_autorite.time_debut BETWEEN @time_debut and @time_fin and stage.demande_audience_autorite.time_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.date_debut = dd and stage.demande_audience_autorite.date_fin = df and stage.demande_audience_autorite.time_debut BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.time_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.date_debut = dd and stage.demande_audience_autorite.date_fin = df and @time_debut BETWEEN stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin and @time_fin BETWEEN stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin OR 
    autorite_enfant.id = 1 and non_disponibilite_autorite_date.date_non_dispo_debut = dd and non_disponibilite_autorite_date.date_non_dispo_fin = df and stage.non_disponibilite_autorite_date.time_debut BETWEEN @time_debut and @time_fin and stage.non_disponibilite_autorite_date.time_fin BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_date.date_non_dispo_debut = dd and non_disponibilite_autorite_date.date_non_dispo_fin = df and stage.non_disponibilite_autorite_date.time_debut BETWEEN @time_debut and @time_fin OR stage.non_disponibilite_autorite_date.time_fin BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_date.date_non_dispo_debut = dd and non_disponibilite_autorite_date.date_non_dispo_fin = df and @time_debut BETWEEN stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin and @time_fin BETWEEN stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin INTO @nbr_rows; 
    -- SELECT @nbr_rows;
    IF @si_ferie = 0 AND @nbr_rows = 0 THEN   
        INSERT INTO stage.demande_audience_public( date_event_debut,  date_event_fin, time_event_debut, time_event_fin, id_autorite_enfant,motif) VALUES (dd,df,td,tf,id_autorite_enfant,motif);
    ELSEIF @nbr_rows > 0 and @si_ferie = 0 THEN  
        SELECT 'pas disponible' as message;
    ELSEIF @si_ferie > 0 and @nbr_rows = 0 THEN  
        SELECT 'Jour férié' as message;
    ELSE 
        SELECT 'Jour férié et pas disponible' as message;
    END IF;
END

-- si_disponible_public v2
CREATE  PROCEDURE `si_disponible_public`(dd date,df date,td time,tf time,id_autorite_enfant int,motif VARCHAR(200))
BEGIN    
    DECLARE time_debut time;
    DECLARE time_fin time;
    DECLARE si_ferie INT;
    set @si_ferie = si_jour_ferie(dd ,df ,td ,tf );
    SET @time_debut = SUBTIME(td,"-00:01:00");
    SET @time_fin = SUBTIME(tf,"00:01:00");
    -- select @si_ferie;
    SELECT 
	    count(autorite_enfant.id) as nbr_rows
    FROM
        stage.autorite_enfant 
            LEFT JOIN stage.demande_audience_public on stage.autorite_enfant.id = stage.demande_audience_public.id_autorite_enfant
            LEFT JOIN stage.demande_audience_autorite on stage.autorite_enfant.id = stage.demande_audience_autorite.id_autorite_enfant_receiver
            LEFT JOIN stage.non_disponibilite_autorite_date on stage.autorite_enfant.id = stage.non_disponibilite_autorite_date.id_autorite_enfant
            LEFT JOIN stage.non_disponibilite_autorite_jour on stage.autorite_enfant.id = stage.non_disponibilite_autorite_jour.id_autorite_enfant
    where autorite_enfant.id = 1 and stage.demande_audience_public.date_event_debut = dd and stage.demande_audience_public.date_event_fin = df and stage.demande_audience_public.time_event_debut BETWEEN @time_debut and @time_fin and stage.demande_audience_public.time_event_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.date_event_debut = dd and stage.demande_audience_public.date_event_fin = df and stage.demande_audience_public.time_event_debut BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.time_event_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.date_event_debut = dd and stage.demande_audience_public.date_event_fin = df and @time_debut BETWEEN stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin and @time_fin BETWEEN stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin OR 
    autorite_enfant.id = 1 and stage.demande_audience_autorite.date_debut = dd and stage.demande_audience_autorite.date_fin = df and stage.demande_audience_autorite.time_debut BETWEEN @time_debut and @time_fin and stage.demande_audience_autorite.time_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.date_debut = dd and stage.demande_audience_autorite.date_fin = df and stage.demande_audience_autorite.time_debut BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.time_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.date_debut = dd and stage.demande_audience_autorite.date_fin = df and @time_debut BETWEEN stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin and @time_fin BETWEEN stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin OR 
    autorite_enfant.id = 1 and non_disponibilite_autorite_date.date_non_dispo_debut = dd and non_disponibilite_autorite_date.date_non_dispo_fin = df and stage.non_disponibilite_autorite_date.time_debut BETWEEN @time_debut and @time_fin and stage.non_disponibilite_autorite_date.time_fin BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_date.date_non_dispo_debut = dd and non_disponibilite_autorite_date.date_non_dispo_fin = df and stage.non_disponibilite_autorite_date.time_debut BETWEEN @time_debut and @time_fin OR stage.non_disponibilite_autorite_date.time_fin BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_date.date_non_dispo_debut = dd and non_disponibilite_autorite_date.date_non_dispo_fin = df and @time_debut BETWEEN stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin and @time_fin BETWEEN stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin OR 
    autorite_enfant.id = 1 and non_disponibilite_autorite_jour.jour = dayname(dd) and non_disponibilite_autorite_jour.jour =  dayname(df) Or non_disponibilite_autorite_jour.jour = dayname(dd) OR non_disponibilite_autorite_jour.jour =  dayname(df) OR non_disponibilite_autorite_jour.jour = dayname(dd) and non_disponibilite_autorite_jour.jour =  dayname(df) and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin and non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_jour.jour = dayname(dd) and non_disponibilite_autorite_jour.jour =  dayname(df) AND  @time_debut BETWEEN non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin or non_disponibilite_autorite_jour.jour = dayname(dd) and non_disponibilite_autorite_jour.jour =  dayname(df) and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin OR
    non_disponibilite_autorite_jour.jour = dayname(dd) OR non_disponibilite_autorite_jour.jour =  dayname(df) and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin and non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_jour.jour = dayname(dd) OR non_disponibilite_autorite_jour.jour =  dayname(df) AND  @time_debut BETWEEN non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin or non_disponibilite_autorite_jour.jour = dayname(dd) OR non_disponibilite_autorite_jour.jour =  dayname(df) and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin INTO @nbr_rows; 
    
    -- SELECT @nbr_rows;
    IF @si_ferie = 0 AND @nbr_rows = 0 THEN   
        INSERT INTO stage.demande_audience_public( date_event_debut,  date_event_fin, time_event_debut, time_event_fin, id_autorite_enfant,motif) VALUES (dd,df,td,tf,id_autorite_enfant,motif);
    ELSEIF @nbr_rows > 0 and @si_ferie = 0 THEN  
        SELECT 'pas disponible' as message;
    ELSEIF @si_ferie > 0 and @nbr_rows = 0 THEN  
        SELECT 'Jour férié' as message;
    ELSE 
        SELECT 'Jour férié et pas disponible' as message;
    END IF;
END;


-- si_disponible_public v3
CREATE  PROCEDURE `si_disponible_public`(dd date,df date,td time,tf time,id_autorite_enfant int,motif VARCHAR(200))
BEGIN    
    DECLARE time_debut time;
    DECLARE time_fin time;
    DECLARE si_ferie INT;
    set @si_ferie = si_jour_ferie(dd ,df ,td ,tf );
    SET @time_debut = SUBTIME(td,"-00:01:00");
    SET @time_fin = SUBTIME(tf,"00:01:00");
    -- select @si_ferie;
    SELECT 
	    count(autorite_enfant.id) as nbr_rows
    FROM
        stage.autorite_enfant 
            LEFT JOIN stage.demande_audience_public on stage.autorite_enfant.id = stage.demande_audience_public.id_autorite_enfant
            LEFT JOIN stage.demande_audience_autorite on stage.autorite_enfant.id = stage.demande_audience_autorite.id_autorite_enfant_receiver
            LEFT JOIN stage.non_disponibilite_autorite_date on stage.autorite_enfant.id = stage.non_disponibilite_autorite_date.id_autorite_enfant
            LEFT JOIN stage.non_disponibilite_autorite_jour on stage.autorite_enfant.id = stage.non_disponibilite_autorite_jour.id_autorite_enfant
    where autorite_enfant.id = 1 and stage.demande_audience_public.date_event_debut = dd and stage.demande_audience_public.date_event_fin = df and stage.demande_audience_public.time_event_debut BETWEEN @time_debut and @time_fin and stage.demande_audience_public.time_event_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.date_event_debut = dd and stage.demande_audience_public.date_event_fin = df and stage.demande_audience_public.time_event_debut BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.time_event_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.date_event_debut = dd and stage.demande_audience_public.date_event_fin = df and @time_debut BETWEEN stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin and @time_fin BETWEEN stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin OR 
    autorite_enfant.id = 1 and stage.demande_audience_autorite.date_debut = dd and stage.demande_audience_autorite.date_fin = df and stage.demande_audience_autorite.time_debut BETWEEN @time_debut and @time_fin and stage.demande_audience_autorite.time_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.date_debut = dd and stage.demande_audience_autorite.date_fin = df and stage.demande_audience_autorite.time_debut BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.time_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.date_debut = dd and stage.demande_audience_autorite.date_fin = df and @time_debut BETWEEN stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin and @time_fin BETWEEN stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin OR 
    autorite_enfant.id = 1 and non_disponibilite_autorite_date.date_non_dispo_debut = dd and non_disponibilite_autorite_date.date_non_dispo_fin = df and stage.non_disponibilite_autorite_date.time_debut BETWEEN @time_debut and @time_fin and stage.non_disponibilite_autorite_date.time_fin BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_date.date_non_dispo_debut = dd and non_disponibilite_autorite_date.date_non_dispo_fin = df and stage.non_disponibilite_autorite_date.time_debut BETWEEN @time_debut and @time_fin OR stage.non_disponibilite_autorite_date.time_fin BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_date.date_non_dispo_debut = dd and non_disponibilite_autorite_date.date_non_dispo_fin = df and @time_debut BETWEEN stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin and @time_fin BETWEEN stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin OR 
    autorite_enfant.id = 1 and  non_disponibilite_autorite_jour.jour = dayname(dd) and non_disponibilite_autorite_jour.jour =  dayname(df) and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin and non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_jour.jour = dayname(dd) and non_disponibilite_autorite_jour.jour =  dayname(df) AND  @time_debut BETWEEN non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin or non_disponibilite_autorite_jour.jour = dayname(dd) and non_disponibilite_autorite_jour.jour =  dayname(df) and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin INTO @nbr_rows; 
    
    -- SELECT @nbr_rows;
    IF @si_ferie = 0 AND @nbr_rows = 0 THEN   
        INSERT INTO stage.demande_audience_public( date_event_debut,  date_event_fin, time_event_debut, time_event_fin, id_autorite_enfant,motif) VALUES (dd,df,td,tf,id_autorite_enfant,motif);
    ELSEIF @nbr_rows > 0 and @si_ferie = 0 THEN  
        SELECT 'pas disponible' as message;
    ELSEIF @si_ferie > 0 and @nbr_rows = 0 THEN  
        SELECT 'Jour férié' as message;
    ELSE 
        SELECT 'Jour férié et pas disponible' as message;
    END IF;
END;


-- si_disponible_public v4
CREATE  PROCEDURE `si_disponible_public`(dd date,df date,td time,tf time,id_autorite_enfant int,motif VARCHAR(200))
BEGIN    
    DECLARE time_debut time;
    DECLARE time_fin time;
    DECLARE si_ferie INT;
    set @si_ferie = si_jour_ferie(dd ,df ,td ,tf );
    SET @time_debut = SUBTIME(td,"-00:01:00");
    SET @time_fin = SUBTIME(tf,"00:01:00");
    -- select @si_ferie;
    SELECT 
	    count(autorite_enfant.id) as nbr_rows
    FROM
        stage.autorite_enfant 
            LEFT JOIN stage.demande_audience_public on stage.autorite_enfant.id = stage.demande_audience_public.id_autorite_enfant
            LEFT JOIN stage.demande_audience_autorite on stage.autorite_enfant.id = stage.demande_audience_autorite.id_autorite_enfant_receiver
            LEFT JOIN stage.non_disponibilite_autorite_date on stage.autorite_enfant.id = stage.non_disponibilite_autorite_date.id_autorite_enfant
            LEFT JOIN stage.non_disponibilite_autorite_jour on stage.autorite_enfant.id = stage.non_disponibilite_autorite_jour.id_autorite_enfant
    where autorite_enfant.id = 1 and stage.demande_audience_public.action = 1 and stage.demande_audience_public.date_event_debut = dd and stage.demande_audience_public.date_event_fin = df and stage.demande_audience_public.time_event_debut BETWEEN @time_debut and @time_fin and stage.demande_audience_public.time_event_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.date_event_debut = dd and stage.demande_audience_public.date_event_fin = df and stage.demande_audience_public.time_event_debut BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.time_event_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.date_event_debut = dd and stage.demande_audience_public.date_event_fin = df and @time_debut BETWEEN stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin and @time_fin BETWEEN stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin OR 
    autorite_enfant.id = 1 and stage.demande_audience_public.action = 1 and stage.demande_audience_autorite.date_debut = dd and stage.demande_audience_autorite.date_fin = df and stage.demande_audience_autorite.time_debut BETWEEN @time_debut and @time_fin and stage.demande_audience_autorite.time_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.date_debut = dd and stage.demande_audience_autorite.date_fin = df and stage.demande_audience_autorite.time_debut BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.time_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.date_debut = dd and stage.demande_audience_autorite.date_fin = df and @time_debut BETWEEN stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin and @time_fin BETWEEN stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin OR 
    autorite_enfant.id = 1 and stage.demande_audience_public.action = 1 and non_disponibilite_autorite_date.date_non_dispo_debut = dd and non_disponibilite_autorite_date.date_non_dispo_fin = df and stage.non_disponibilite_autorite_date.time_debut BETWEEN @time_debut and @time_fin and stage.non_disponibilite_autorite_date.time_fin BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_date.date_non_dispo_debut = dd and non_disponibilite_autorite_date.date_non_dispo_fin = df and stage.non_disponibilite_autorite_date.time_debut BETWEEN @time_debut and @time_fin OR stage.non_disponibilite_autorite_date.time_fin BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_date.date_non_dispo_debut = dd and non_disponibilite_autorite_date.date_non_dispo_fin = df and @time_debut BETWEEN stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin and @time_fin BETWEEN stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin OR 
    autorite_enfant.id = 1 and stage.demande_audience_public.action = 1 and  non_disponibilite_autorite_jour.jour = dayname(dd) and non_disponibilite_autorite_jour.jour =  dayname(df) and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin and non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_jour.jour = dayname(dd) and non_disponibilite_autorite_jour.jour =  dayname(df) AND  @time_debut BETWEEN non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin or non_disponibilite_autorite_jour.jour = dayname(dd) and non_disponibilite_autorite_jour.jour =  dayname(df) and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin INTO @nbr_rows; 
    
    -- SELECT @nbr_rows;
    IF @si_ferie = 0 AND @nbr_rows = 0 THEN   
        INSERT INTO stage.demande_audience_public( date_event_debut,  date_event_fin, time_event_debut, time_event_fin, id_autorite_enfant,motif) VALUES (dd,df,td,tf,id_autorite_enfant,motif);
    ELSEIF @nbr_rows > 0 and @si_ferie = 0 THEN  
        SELECT 'pas disponible' as message;
    ELSEIF @si_ferie > 0 and @nbr_rows = 0 THEN  
        SELECT 'Jour férié' as message;
    ELSE 
        SELECT 'Jour férié et pas disponible' as message;
    END IF;
END;

SET @nbr_rows = si_disponible(1,'2022-10-21','2022-10-21','06:00:00','07:00:00');
CALL si_disponible(1,'2022-10-21','2022-10-21','05:00:00','07:40:00')


-- format_date_jour_ferie
CREATE FUNCTION format_date_jour_ferie(numero_du_jour CHAR(5),numero_du_mois char(5)) RETURNS DATE 
BEGIN
    SET @current_year = '';
    SELECT YEAR(CURDATE()) into @current_year;
    RETURN CONCAT(@current_year,'-',numero_du_mois,'-',numero_du_jour);
END;

-- Si jour ferie
CREATE  PROCEDURE `si_jour_ferie`(dd date,df date,td time,tf time)
BEGIN    
    DECLARE time_debut time;
    DECLARE time_fin time;
    SET @date_event = '';
    SET @time_debut = SUBTIME(td,"-00:01:00");
    SET @time_fin = SUBTIME(tf,"00:01:00");
    SELECT count(*) FROM stage.jour_ferie 
        WHERE numero_du_jour = day(dd) and mois_du_jour = month(dd) and numero_du_jour = day(df) and mois_du_jour = month(df) and @time_debut BETWEEN  time_event_debut and time_event_fin and @time_fin BETWEEN time_event_debut and time_event_fin 
        or numero_du_jour = day(dd) and mois_du_jour = month(dd) and numero_du_jour = day(df) and mois_du_jour = month(df) and @time_debut BETWEEN  time_event_debut and time_event_fin and time_event_fin BETWEEN time_event_debut and @time_fin 
        or numero_du_jour = day(dd) and mois_du_jour = month(dd) and numero_du_jour = day(df) and mois_du_jour = month(df) and time_event_debut  BETWEEN  @time_debut and time_event_fin and @time_fin  BETWEEN time_event_debut and time_event_fin ;
END;

-- Si jour ferie 2
CREATE  FUNCTION `si_jour_ferie`(dd date,df date,td time,tf time) RETURNS INT DETERMINISTIC
BEGIN    
    DECLARE time_debut time;
    DECLARE time_fin time;
    SET @nbr_jour_ferie = 0;
    SET @time_debut = SUBTIME(td,"-00:01:00");
    SET @time_fin = SUBTIME(tf,"00:01:00");
    SELECT count(*) into @nbr_jour_ferie FROM stage.jour_ferie 
        WHERE numero_du_jour = day(dd) and mois_du_jour = month(dd) and numero_du_jour = day(df) and mois_du_jour = month(df) and @time_debut BETWEEN  time_event_debut and time_event_fin and @time_fin BETWEEN time_event_debut and time_event_fin 
        or numero_du_jour = day(dd) and mois_du_jour = month(dd) and numero_du_jour = day(df) and mois_du_jour = month(df) and @time_debut BETWEEN  time_event_debut and time_event_fin and time_event_fin BETWEEN time_event_debut and @time_fin 
        or numero_du_jour = day(dd) and mois_du_jour = month(dd) and numero_du_jour = day(df) and mois_du_jour = month(df) and time_event_debut  BETWEEN  @time_debut and time_event_fin and @time_fin  BETWEEN time_event_debut and time_event_fin ;
    RETURN @nbr_jour_ferie;
END;

CALL si_jour_ferie('2022-10-21','2022-10-21','05:00:00','07:40:00',1,'Test 21')
CALL si_disponible_public('2022-10-21','2022-10-21','05:00:00','07:40:00',1,'Test 21')


-- Liste des audences pas libre cote public
    SELECT 
	    *
    FROM
        stage.autorite_enfant 
            LEFT JOIN stage.demande_audience_public on stage.autorite_enfant.id = stage.demande_audience_public.id_autorite_enfant
            LEFT JOIN stage.demande_audience_autorite on stage.autorite_enfant.id = stage.demande_audience_autorite.id_autorite_enfant_receiver
            LEFT JOIN stage.non_disponibilite_autorite_date on stage.autorite_enfant.id = stage.non_disponibilite_autorite_date.id_autorite_enfant
            LEFT JOIN stage.non_disponibilite_autorite_jour on stage.autorite_enfant.id = stage.non_disponibilite_autorite_jour.id_autorite_enfant
    where autorite_enfant.id = 1;

SELECT a.id,
a.intitule,
a.intitule_code,
'' date_debut,
'' date_fin,
'' time_debut,
'' time_fin
FROM stage.autorite_enfant as a
UNION
SELECT '' as id,
'' intitule,
'' intitule_code,
date_debut,
date_fin,
time_debut,
time_fin
FROM stage.demande_audience_autorite



SELECT 
    ae.id,
    ae.intitule,
    ae.intitule_code,
    dap.date_event_debut as dd_aud_public,
    dap.date_event_fin as df_aud_public,
    dap.time_event_debut as td_aud_public,
    dap.time_event_fin as tf_aud_public,
    dap.motif,
	'' dd_aud_autorite,
    '' df_aud_autorite,
    '' td_aud_autorite,
    '' tf_aud_autorite,
    '' dd_non_dispo_date,
    '' df_non_dispo_date,
    '' td_non_dispo_date,
    '' tf_non_dispo_date,
    '' jour_non_dispo_jour,
    '' td_non_dispo_jour,
    '' tf_non_dispo_jour,
    'Occupé' status_audience
FROM 
    stage.autorite_enfant AS ae
        INNER JOIN stage.demande_audience_public as dap on ae.id = dap.id_autorite_enfant
        WHERE dap.id_autorite_enfant = 1
UNION
SELECT 
    ae.id,
    ae.intitule,
    ae.intitule_code,
    '' dd_aud_public,
    '' df_aud_public,
    '' td_aud_public,
    '' tf_aud_public,
    daa.motif,
    daa.date_debut as dd_aud_autorite,             
    daa.date_fin as df_aud_autorite,
    daa.time_debut as td_aud_autorite,
    daa.time_fin as tf_aud_autorite,
    '' dd_non_dispo_date,
    '' df_non_dispo_date,
    '' td_non_dispo_date,
    '' tf_non_dispo_date,
    '' jour_non_dispo_jour,
    '' td_non_dispo_jour,
    '' tf_non_dispo_jour,
    'Occupé' status_audience
    
FROM 
    stage.autorite_enfant AS ae
        INNER JOIN stage.demande_audience_autorite as daa on ae.id = daa.id_autorite_enfant_receiver
        where daa.id_autorite_enfant_receiver = 1
UNION
SELECT 
    ae.id,
    ae.intitule,
    ae.intitule_code,
    '' dd_aud_public,
    '' df_aud_public,
    '' td_aud_public,
    '' tf_aud_public,
    'Pas disponible' motif,
    '' dd_aud_autorite,             
    '' df_aud_autorite,
    '' td_aud_autorite,
    '' tf_aud_autorite,
    ndad.date_non_dispo_debut as dd_non_dispo_date,
    ndad.date_non_dispo_fin as df_non_dispo_date,
    ndad.time_debut as td_non_dispo_date,
    ndad.time_fin as tf_non_dispo_date,
    '' jour_non_dispo_jour,
    '' td_non_dispo_jour,
    '' tf_non_dispo_jour,
    'Pas disponible' status_audience
FROM 
    stage.autorite_enfant AS ae
        INNER JOIN stage.non_disponibilite_autorite_date as ndad on ae.id = ndad.id_autorite_enfant
        where ndad.id_autorite_enfant = 1
UNION
SELECT 
    ae.id,
    ae.intitule,
    ae.intitule_code,
    '' dd_aud_public,
    '' df_aud_public,
    '' td_aud_public,
    '' tf_aud_public,
    '' motif,
    '' dd_aud_autorite,             
    '' df_aud_autorite,
    '' td_aud_autorite,
    '' tf_aud_autorite,
    '' dd_non_dispo_date,
    '' df_non_dispo_date,
    '' td_non_dispo_date,
    '' tf_non_dispo_date,
    ndaj.jour as jour_non_dispo_jour,
    ndaj.time_non_dispo_jour_debut as td_non_dispo_jour,
    ndaj.time_non_dispo_jour_fin as tf_non_dispo_jour,
    'Pas disponible'

FROM 
    stage.autorite_enfant as ae
        INNER JOIN stage.non_disponibilite_autorite_jour as ndaj on ae.id = ndaj.id_autorite_enfant
        where ndaj.id_autorite_enfant = 1
;