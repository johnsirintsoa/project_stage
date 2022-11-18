CREATE SCHEMA stage;

CREATE TABLE stage.autorite_parent ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	intitule             VARCHAR(200)  NOT NULL    
 ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

CREATE TABLE stage.domaine ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nom_domaine          VARCHAR(30)  NOT NULL    
 ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

CREATE TABLE stage.jour_ferie ( 
	nom_evenement        VARCHAR(30)      ,
	numero_du_jour       VARCHAR(20)      ,
	mois_du_jour         VARCHAR(20)      ,
	time_event_debut     TIME  NOT NULL    ,
	time_event_fin       TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY
 ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

CREATE TABLE stage.autorite_enfant ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	intitule             VARCHAR(200)  NOT NULL    ,
	intitule_code        VARCHAR(10)  NOT NULL    ,
	id_autorite_parent   INT  NOT NULL    ,
	CONSTRAINT fk_autorite_enfant_autorite_parent FOREIGN KEY ( id_autorite_parent ) REFERENCES stage.autorite_parent( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE stage.demande_audience_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	date_debut           DATE  NOT NULL    ,
	date_fin             DATE  NOT NULL    ,
	time_debut           TIME  NOT NULL    ,
	time_fin             TIME  NOT NULL    ,
	id_autorite_enfant_sender INT  NOT NULL    ,
	id_autorite_enfant_receiver INT  NOT NULL    ,
	motif                VARCHAR(200)  NOT NULL    ,
	action               INT  NOT NULL DEFAULT ('0')   ,
	CONSTRAINT fk_demande_audience_autorite_autorite_receiver FOREIGN KEY ( id_autorite_enfant_receiver ) REFERENCES stage.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_demande_audience_autorite_autorite_sender FOREIGN KEY ( id_autorite_enfant_sender ) REFERENCES stage.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

CREATE TABLE stage.demande_audience_public ( 
	date_event_debut     DATE  NOT NULL    ,
	motif                VARCHAR(200)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	date_event_fin       DATE  NOT NULL    ,
	time_event_debut     TIME  NOT NULL    ,
	time_event_fin       TIME  NOT NULL    ,
	action               INT  NOT NULL DEFAULT ('0')   ,
	id_autorite_enfant   INT  NOT NULL    ,
	cin                  VARCHAR(15)  NOT NULL    ,
	numero_telephone     VARCHAR(10)  NOT NULL    ,
	email                VARCHAR(200)  NOT NULL    ,
	nom                  VARCHAR(30)  NOT NULL    ,
	prenom               VARCHAR(30)  NOT NULL    ,
	session_navigateur   VARCHAR(100)  NOT NULL    ,
	CONSTRAINT fk_demande_audience_public FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

CREATE TABLE stage.demande_stage ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nom                  VARCHAR(30)  NOT NULL    ,
	prenom               VARCHAR(30)  NOT NULL    ,
	telephone            VARCHAR(30)  NOT NULL    ,
	e_mail               VARCHAR(30)      ,
	cin                  VARCHAR(20)      ,
	duree                INT  NOT NULL    ,
	curriculum_vitae     MEDIUMTEXT  NOT NULL    ,
	lettre_motivation    MEDIUMTEXT  NOT NULL    ,
	lettre_introduction  MEDIUMTEXT  NOT NULL    ,
	message              MEDIUMTEXT  NOT NULL    ,
	id_domaine           INT  NOT NULL    ,
	id_autorite_enfant   INT  NOT NULL    ,
	CONSTRAINT fk_demande_stage FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_demande_stage_domaine FOREIGN KEY ( id_domaine ) REFERENCES stage.domaine( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

CREATE TABLE stage.entretien_demande_stage ( 
	date_debut           DATE  NOT NULL    ,
	date_fin             DATE  NOT NULL    ,
	time_debut           TIME  NOT NULL    ,
	time_fin             TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_demande_stage     INT  NOT NULL    ,
	CONSTRAINT fk_entretien_demande_stage FOREIGN KEY ( id_demande_stage ) REFERENCES stage.demande_stage( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE stage.non_disponibilite_autorite_date ( 
	date_non_dispo_debut DATE  NOT NULL    ,
	date_non_dispo_fin   DATE  NOT NULL    ,
	id_autorite_enfant   INT  NOT NULL    ,
	time_debut           TIME  NOT NULL    ,
	time_fin             TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	CONSTRAINT fk_non_disponibilite_autorite_date FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE stage.non_disponibilite_autorite_jour ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	jour                 VARCHAR(15)  NOT NULL    ,
	time_non_dispo_jour_debut TIME  NOT NULL    ,
	time_non_dispo_jour_fin TIME  NOT NULL    ,
	id_autorite_enfant   INT  NOT NULL    ,
	CONSTRAINT fk_non_disponibilite_autorite_jour_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE stage.profil ( 
	mot_de_passe         VARCHAR(255)  NOT NULL    ,
	nom_utilisateur      VARCHAR(30)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	est_administrateur   SMALLINT  NOT NULL DEFAULT ('0')   ,
	id_autorite_enfant   INT  NOT NULL    ,
	CONSTRAINT fk_profil_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE INDEX fk_autorite_enfant_autorite_parent ON stage.autorite_enfant ( id_autorite_parent );

CREATE INDEX fk_demande_audience_autorite_autorite_sender ON stage.demande_audience_autorite ( id_autorite_enfant_sender );

CREATE INDEX fk_demande_audience_autorite_autorite_receiver ON stage.demande_audience_autorite ( id_autorite_enfant_receiver );

CREATE INDEX fk_demande_audience_public ON stage.demande_audience_public ( id_autorite_enfant );

CREATE INDEX fk_demande_stage_domaine ON stage.demande_stage ( id_domaine );

CREATE INDEX fk_demande_stage ON stage.demande_stage ( id_autorite_enfant );

CREATE INDEX fk_entretien_demande_stage ON stage.entretien_demande_stage ( id_demande_stage );

CREATE INDEX fk_non_disponibilite_autorite_date ON stage.non_disponibilite_autorite_date ( id_autorite_enfant );

CREATE INDEX fk_non_disponibilite_autorite_jour ON stage.non_disponibilite_autorite_jour ( id_autorite_enfant );

CREATE INDEX fk_profil_autorite_enfant ON stage.profil ( id_autorite_enfant );

CREATE  FUNCTION `FIRST_DATE_OF_MONTH`(day DATE) RETURNS date
    DETERMINISTIC
BEGIN
  RETURN DATE_SUB(day, INTERVAL DAYOFMONTH(day)-1 DAY);
END

CREATE  FUNCTION `FIRST_DAY_OF_WEEK`(day DATE) RETURNS date
    DETERMINISTIC
BEGIN
  RETURN SUBDATE(day, WEEKDAY(day));
END

CREATE  FUNCTION `LAST_DAY_OF_WEEK`(day DATE) RETURNS date
    DETERMINISTIC
BEGIN
  RETURN DATE(day + INTERVAL (8 - DAYOFWEEK(day)) DAY);
END

CREATE  FUNCTION `NBR_ROWS_EVENEMENTS`(dd date,df date,td time,tf time,id_autorite int) RETURNS int(11)
    DETERMINISTIC
BEGIN    
	DECLARE isa_rows int;
    DECLARE time_debut time;
    DECLARE time_fin time;
    SET @time_debut = SUBTIME(td,"-00:01:00");
    SET @time_fin = SUBTIME(tf,"00:01:00");
    -- select @si_ferie;
	SELECT SUM(nbr_rows) FROM (	   
	SELECT 
		COUNT(*) as nbr_rows 
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
		COUNT(*) as nbr_rows
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
		COUNT(*) as nbr_rows
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
		COUNT(*) as nbr_rows		
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
		COUNT(*) as nbr_rows
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
		COUNT(*) as nbr_rows
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
		and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin)`x` into @nbr_rows;
		-- select @nbr_rows;	
		RETURN @nbr_rows;	
END

CREATE  FUNCTION `NBR_ROWS_EVENEMENTS_BY_DAY`(jour_date VARCHAR(15),td time,tf time,id_autorite int) RETURNS int(11)
    DETERMINISTIC
BEGIN    
    DECLARE time_debut time;
    DECLARE time_fin time;
    SET @time_debut = SUBTIME(td,"-00:01:00");
    SET @time_fin = SUBTIME(tf,"00:01:00");
	set @jour_UTF8 = CONVERT(jour_date USING utf8);
    -- select @si_ferie;
	SELECT SUM(nbr_rows) FROM (	   
	SELECT 
		COUNT(*) as nbr_rows 
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
		and @time_fin between time_event_debut and time_event_fin
	UNION
	SELECT
		COUNT(*) as nbr_rows
	FROM
		stage.demande_audience_autorite daa
	JOIN stage.autorite_enfant ae on  daa.id_autorite_enfant_sender =ae.id
	where
		-- Si disponible sur l'autorite  
		daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
		and CONVERT(dayname(daa.date_debut) USING utf8) = @jour_UTF8
		and CONVERT(dayname(daa.date_fin) USING utf8) = @jour_UTF8
		and daa.time_debut between @time_debut and @time_fin
		and daa.time_fin between @time_debut and @time_fin
		or
		daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
        and CONVERT(dayname(daa.date_debut) USING utf8) = @jour_UTF8
		and CONVERT(dayname(daa.date_fin) USING utf8) = @jour_UTF8
		and @time_debut between daa.time_debut and daa.time_fin
		and @time_fin between daa.time_debut and daa.time_fin
		or
		daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
        and CONVERT(dayname(daa.date_debut) USING utf8) = @jour_UTF8
		and CONVERT(dayname(daa.date_fin) USING utf8) = @jour_UTF8
		and @time_debut between daa.time_debut and daa.time_fin
		or
		daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
        and CONVERT(dayname(daa.date_debut) USING utf8) = @jour_UTF8
		and CONVERT(dayname(daa.date_fin) USING utf8) = @jour_UTF8
		and @time_fin between daa.time_debut and daa.time_fin
	UNION
	SELECT
		COUNT(*) as nbr_rows
	FROM
		stage.non_disponibilite_autorite_date ndad
    where
		-- Si pas disponible sur autorite date 
		ndad.id_autorite_enfant = id_autorite
        and CONVERT(dayname(ndad.date_non_dispo_debut) USING utf8) = @jour_UTF8
		and CONVERT(dayname(ndad.date_non_dispo_fin) USING utf8) = @jour_UTF8
		and ndad.time_debut between @time_debut and @time_fin
		and ndad.time_fin between @time_debut and @time_fin
		or
		ndad.id_autorite_enfant = id_autorite
        and CONVERT(dayname(ndad.date_non_dispo_debut) USING utf8) = @jour_UTF8
		and CONVERT(dayname(ndad.date_non_dispo_fin) USING utf8) = @jour_UTF8
		and @time_debut between ndad.time_debut and ndad.time_fin
		and @time_fin between ndad.time_debut and ndad.time_fin
		or
		ndad.id_autorite_enfant = id_autorite
        and CONVERT(dayname(ndad.date_non_dispo_debut) USING utf8) = @jour_UTF8
		and CONVERT(dayname(ndad.date_non_dispo_fin) USING utf8) = @jour_UTF8
		and @time_debut between ndad.time_debut and ndad.time_fin
		or
		ndad.id_autorite_enfant = id_autorite
        and CONVERT(dayname(ndad.date_non_dispo_debut) USING utf8) = @jour_UTF8
		and CONVERT(dayname(ndad.date_non_dispo_fin) USING utf8) = @jour_UTF8
		and @time_fin between ndad.time_debut and ndad.time_fin
	UNION
    SELECT
		COUNT(*) as nbr_rows		
	FROM
		stage.entretien_demande_stage eds
	JOIN demande_stage ds on eds.id_demande_stage = ds.id
    where 
		-- Si disponible entretien
		ds.id_autorite_enfant = id_autorite
        and CONVERT(dayname(eds.date_debut) USING utf8) = @jour_UTF8
		and CONVERT(dayname(eds.date_fin) USING utf8) = @jour_UTF8
		and eds.time_debut between @time_debut and @time_fin
		and eds.time_fin between @time_debut and @time_fin
		or
		ds.id_autorite_enfant = id_autorite
        and CONVERT(dayname(eds.date_debut) USING utf8) = @jour_UTF8
		and CONVERT(dayname(eds.date_fin) USING utf8) = @jour_UTF8
		and @time_debut between eds.time_debut and eds.time_fin
		and @time_fin between eds.time_debut and eds.time_fin
		or
		ds.id_autorite_enfant = id_autorite
        and CONVERT(dayname(eds.date_debut) USING utf8) = @jour_UTF8
		and CONVERT(dayname(eds.date_fin) USING utf8) = @jour_UTF8
		and @time_debut between eds.time_debut and eds.time_fin
		or
		ds.id_autorite_enfant = id_autorite
        and CONVERT(dayname(eds.date_debut) USING utf8) = @jour_UTF8
		and CONVERT(dayname(eds.date_fin) USING utf8) = @jour_UTF8
		and @time_fin between eds.time_debut and eds.time_fin
	
	UNION
	SELECT 
		COUNT(*) as nbr_rows
	FROM stage.jour_ferie 
    WHERE 
		CONVERT((select dayname(concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour))) USING utf8) = @jour_UTF8
		and time_event_debut BETWEEN  @time_debut and @time_fin 
		and time_event_fin BETWEEN @time_debut and @time_fin 
        or 
		CONVERT((select dayname(concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour))) USING utf8) = @jour_UTF8
		and @time_debut BETWEEN  time_event_debut and time_event_fin 
		and @time_fin BETWEEN time_event_debut and time_event_fin 
        or 
		CONVERT((select dayname(concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour))) USING utf8) = @jour_UTF8
		and @time_debut BETWEEN  time_event_debut and time_event_fin 
		and time_event_fin BETWEEN time_event_debut and @time_fin 
        or 
		CONVERT((select dayname(concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour))) USING utf8) = @jour_UTF8 
		and time_event_debut  BETWEEN  @time_debut and time_event_fin 
		and @time_fin  BETWEEN time_event_debut and time_event_fin
	UNION
	SELECT
		COUNT(*) as nbr_rows
	FROM
		non_disponibilite_autorite_jour 
	WHERE 	
		-- Si disponible sur disponible jour
		non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
		and  CONVERT( non_disponibilite_autorite_jour.jour USING utf8) = @jour_UTF8
		and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin 
		and non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin 
		OR
		non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
		and CONVERT( non_disponibilite_autorite_jour.jour USING utf8) = @jour_UTF8
		AND @time_debut BETWEEN non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
		and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
		or
		non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
		and CONVERT( non_disponibilite_autorite_jour.jour USING utf8) = @jour_UTF8
		and @time_debut between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
		OR 
		non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
		and CONVERT( non_disponibilite_autorite_jour.jour USING utf8) = @jour_UTF8
		and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin)`x` into @nbr_rows;
		-- select @nbr_rows;	
		RETURN @nbr_rows;	
END

CREATE  FUNCTION `si_jour_ferie`(dd date,df date,td time,tf time) RETURNS int(11)
    DETERMINISTIC
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
END

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
		CONCAT(dap.nom,' ',dap.prenom) as nom_complet,
		dap.cin as cin,
		dap.numero_telephone as numero_telephone,
		dap.email as email,
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
        'Public' type_audience,
		CASE 
			when dap.action = 0 THEN "Non validé"
			When dap.action = 1 THEN "Validé"
			When dap.action = 2 THEN "Reporté"
		END AS status_audience
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
		'' nom_complet,
		'' cin,
		'' as numero_telephone,
		'' as email,
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
        'Autorite' type_audience,
		CASE 
			when daa.action = 0 THEN "Non validé"
			When daa.action = 1 THEN "Validé"
			When daa.action = 2 THEN "Reporté"
		END AS status_audience
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
        CONCAT('Entretien ',ds.nom,' ',ds.prenom) as motif,
		'' nom_complet,
		'' cin,
		'' numero_telephone,
		'' email,
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
        'Entretien' type_audience,
		'' status_audience
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
		'' nom_complet,
		'' cin,
		'' numero_telephone,
		'' email,
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
        'Pas disponible date' type_audience,
		'' status_audience
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
		'' nom_complet,
		'' cin,
		'' numero_telephone,
		'' email,
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
        'Jour ferie' type_audience,
		'' status_audience
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
		'' nom_complet,
		'' cin,
		'' numero_telephone,
		'' email,
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
        'Pas disponible jour' type_audience,
		'' status_audience

    FROM 
        stage.autorite_enfant as ae
            INNER JOIN stage.non_disponibilite_autorite_jour as ndaj on ae.id = ndaj.id_autorite_enfant
            where ndaj.id_autorite_enfant = id_autorite;    
END

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
			and CONVERT(dayname(daa.date_debut) USING utf8) = @jour_UTF8
			and CONVERT(dayname(daa.date_fin) USING utf8) = @jour_UTF8
			and daa.time_debut between @time_debut and @time_fin
			and daa.time_fin between @time_debut and @time_fin
			or
			daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
	        and CONVERT(dayname(daa.date_debut) USING utf8) = @jour_UTF8
			and CONVERT(dayname(daa.date_fin) USING utf8) = @jour_UTF8
			and @time_debut between daa.time_debut and daa.time_fin
			and @time_fin between daa.time_debut and daa.time_fin
			or
			daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
	        and CONVERT(dayname(daa.date_debut) USING utf8) = @jour_UTF8
			and CONVERT(dayname(daa.date_fin) USING utf8) = @jour_UTF8
			and @time_debut between daa.time_debut and daa.time_fin
			or
			daa.id_autorite_enfant_receiver = id_autorite AND daa.action >= 0 and daa.action <= 1        
	        and CONVERT(dayname(daa.date_debut) USING utf8) = @jour_UTF8
			and CONVERT(dayname(daa.date_fin) USING utf8) = @jour_UTF8
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
	        and CONVERT(dayname(ndad.date_non_dispo_debut) USING utf8) = @jour_UTF8
			and CONVERT(dayname(ndad.date_non_dispo_fin) USING utf8) = @jour_UTF8
			and ndad.time_debut between @time_debut and @time_fin
			and ndad.time_fin between @time_debut and @time_fin
			or
			ndad.id_autorite_enfant = id_autorite
	        and CONVERT(dayname(ndad.date_non_dispo_debut) USING utf8) = @jour_UTF8
			and CONVERT(dayname(ndad.date_non_dispo_fin) USING utf8) = @jour_UTF8
			and @time_debut between ndad.time_debut and ndad.time_fin
			and @time_fin between ndad.time_debut and ndad.time_fin
			or
			ndad.id_autorite_enfant = id_autorite
	        and CONVERT(dayname(ndad.date_non_dispo_debut) USING utf8) = @jour_UTF8
			and CONVERT(dayname(ndad.date_non_dispo_fin) USING utf8) = @jour_UTF8
			and @time_debut between ndad.time_debut and ndad.time_fin
			or
			ndad.id_autorite_enfant = id_autorite
	        and CONVERT(dayname(ndad.date_non_dispo_debut) USING utf8) = @jour_UTF8
			and CONVERT(dayname(ndad.date_non_dispo_fin) USING utf8) = @jour_UTF8
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
	        and CONVERT(dayname(eds.date_debut) USING utf8) = @jour_UTF8
			and CONVERT(dayname(eds.date_fin) USING utf8) = @jour_UTF8
			and eds.time_debut between @time_debut and @time_fin
			and eds.time_fin between @time_debut and @time_fin
			or
			ds.id_autorite_enfant = id_autorite
	        and CONVERT(dayname(eds.date_debut) USING utf8) = @jour_UTF8
			and CONVERT(dayname(eds.date_fin) USING utf8) = @jour_UTF8
			and @time_debut between eds.time_debut and eds.time_fin
			and @time_fin between eds.time_debut and eds.time_fin
			or
			ds.id_autorite_enfant = id_autorite
	        and CONVERT(dayname(eds.date_debut) USING utf8) = @jour_UTF8
			and CONVERT(dayname(eds.date_fin) USING utf8) = @jour_UTF8
			and @time_debut between eds.time_debut and eds.time_fin
			or
			ds.id_autorite_enfant = id_autorite
	        and CONVERT(dayname(eds.date_debut) USING utf8) = @jour_UTF8
			and CONVERT(dayname(eds.date_fin) USING utf8) = @jour_UTF8
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
			CONVERT((select dayname(concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour))) USING utf8) = @jour_UTF8
			and time_event_debut BETWEEN  @time_debut and @time_fin 
			and time_event_fin BETWEEN @time_debut and @time_fin 
	        or 
			CONVERT((select dayname(concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour))) USING utf8) = @jour_UTF8
			and @time_debut BETWEEN  time_event_debut and time_event_fin 
			and @time_fin BETWEEN time_event_debut and time_event_fin 
	        or 
			CONVERT((select dayname(concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour))) USING utf8) = @jour_UTF8
			and @time_debut BETWEEN  time_event_debut and time_event_fin 
			and time_event_fin BETWEEN time_event_debut and @time_fin 
	        or 
			CONVERT((select dayname(concat(YEAR(CURDATE()),'-',mois_du_jour,'-',numero_du_jour))) USING utf8) = @jour_UTF8 
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
			and  CONVERT( non_disponibilite_autorite_jour.jour USING utf8) = @jour_UTF8
			and non_disponibilite_autorite_jour.time_non_dispo_jour_debut BETWEEN @time_debut and @time_fin 
			and non_disponibilite_autorite_jour.time_non_dispo_jour_fin BETWEEN @time_debut and @time_fin 
			OR
			non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
			and CONVERT( non_disponibilite_autorite_jour.jour USING utf8) = @jour_UTF8
			AND @time_debut BETWEEN non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
			and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut AND non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
			or
			non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
			and CONVERT( non_disponibilite_autorite_jour.jour USING utf8) = @jour_UTF8
			and @time_debut between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin 
			OR 
			non_disponibilite_autorite_jour.id_autorite_enfant = id_autorite 
			and CONVERT( non_disponibilite_autorite_jour.jour USING utf8) = @jour_UTF8
			and @time_fin between non_disponibilite_autorite_jour.time_non_dispo_jour_debut and non_disponibilite_autorite_jour.time_non_dispo_jour_fin;	
END

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

CREATE  PROCEDURE `LISTE_PUBLIC_PAR_JOUR`(id_autorite int,date_du_jour date)
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
        'Occupé' motif,
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
            WHERE dap.id_autorite_enfant = id_autorite and dap.action >=0 and dap.action<= 1 and date_event_debut = date_du_jour and date_event_fin = date_du_jour
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
        'Occupé' motif,
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
            where daa.id_autorite_enfant_receiver = id_autorite and daa.action >=0 and daa.action<= 1 and date_debut = date_du_jour and date_fin = date_du_jour
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
            where ndad.id_autorite_enfant = id_autorite  and date_non_dispo_debut = date_du_jour and date_non_dispo_fin = date_du_jour
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
        CONCAT(YEAR(date_du_jour),'-',jf.mois_du_jour,'-',jf.numero_du_jour) as date_ferie,
        time_event_debut as td_ferie,
        time_event_fin as tf_ferie,
        'Jour ferie' type_audience
    FROM 
        stage.jour_ferie as jf where jf.mois_du_jour = MONTH(date_du_jour) and jf.numero_du_jour = DAY(date_du_jour)
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
            where ndaj.id_autorite_enfant = id_autorite and ndaj.jour = DAYNAME(date_du_jour);
END

CREATE  PROCEDURE `LISTE_PUBLIC_PAR_MOIS`(id_autorite int,_date date)
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
        'Occupé'motif,
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
        'Occupé' motif,
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

CREATE  PROCEDURE `LISTE_PUBLIC_PAR_MOIS_V2`(id_autorite int,_date date)
BEGIN
    SELECT
        dap.id as id,
        'Occupé' title,
        CONCAT(dap.date_event_debut,'T',dap.time_event_debut) as start,
        CONCAT(dap.date_event_fin,'T',dap.time_event_fin) as end,
        '#ff9f89' color,
		'Public' type_audience,
		'' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour
    FROM 
		stage.demande_audience_public dap
        WHERE 
			dap.id_autorite_enfant = id_autorite 
			and dap.action >=0 and dap.action <= 1 
			and dap.date_event_debut BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date) 
			and dap.date_event_fin BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)
    UNION 
    SELECT 
		daa.id as id,
        'Occupé' title,
		CONCAT(daa.date_debut,'T',daa.time_debut) as start,
		CONCAT(daa.date_fin,'T',daa.time_fin) as end,
		'#ff9f89' color,
        'Autorité' type_audience,
		'' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour
    FROM 
        stage.demande_audience_autorite daa
        where 
			daa.id_autorite_enfant_receiver = id_autorite 
			and daa.action >=0 and daa.action <= 1 
			and daa.date_debut BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date) 
			and daa.date_fin BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)
    UNION
    SELECT 
        ndad.id as id,
        'Pas disponible' title,
		CONCAT(ndad.date_non_dispo_debut,'T',ndad.time_debut) as start,
		CONCAT(ndad.date_non_dispo_fin,'T',ndad.time_fin) as end,
		'#2B2B2B' color,
        'Pas disponible date' type_audience,
		'' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour
    FROM 
		stage.non_disponibilite_autorite_date ndad
        where 
			ndad.id_autorite_enfant = id_autorite  
			and ndad.date_non_dispo_debut BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date) 
			and ndad.date_non_dispo_fin BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)
    UNION
    SELECT
		eds.id as id,
		'Occupé' title,
		CONCAT(eds.date_debut,'T',eds.time_debut) as start,
		CONCAT(eds.date_fin,'T',eds.time_fin) as end,
		'#ff9f89' color,
		'Entretien' type_audience,
		'' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour
		
	FROM
		stage.entretien_demande_stage eds
		JOIN demande_stage ds on eds.id_demande_stage = ds.id
	    where 
			-- Si disponible entretien
			ds.id_autorite_enfant = id_autorite
	        and eds.date_debut BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)
			and eds.date_fin BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)
	UNION
    SELECT
        jf.id as id,
        jf.nom_evenement as title,
        CONCAT(YEAR(_date),'-',jf.mois_du_jour,'-',jf.numero_du_jour,'T',jf.time_event_debut) as start,
        CONCAT(YEAR(_date),'-',jf.mois_du_jour,'-',jf.numero_du_jour,'T',jf.time_event_fin) as end,
		'#EFEC27' as color,
        'Jour ferie' type_audience,
		'' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour
    FROM 
        stage.jour_ferie jf 
		where 
			jf.mois_du_jour =  MONTH(FIRST_DATE_OF_MONTH(_date)) 
			and jf.mois_du_jour = MONTH(LAST_DAY(_date)) 
			and jf.numero_du_jour BETWEEN DAY(FIRST_DATE_OF_MONTH(_date)) AND DAY(LAST_DAY(_date))
    UNION
    SELECT 
        ndaj.id as id,
        'Pas disponible' title,
		'' start,
		'' end,
        '#2B2B2B' color,
        'Pas disponible jour' type_audience,
        ndaj.jour as jour_non_dispo_jour,
        ndaj.time_non_dispo_jour_debut as td_non_dispo_jour,
        ndaj.time_non_dispo_jour_fin as tf_non_dispo_jour

    FROM 
		stage.non_disponibilite_autorite_jour ndaj 
        where 
			ndaj.id_autorite_enfant = id_autorite;    
END

CREATE  PROCEDURE `LISTE_PUBLIC_PAR_MOIS_V3`(id_autorite int,_date date,session_navigateur varchar(100))
BEGIN
    SELECT
        dap.id as id,
		CASE 
			WHEN dap.session_navigateur = session_navigateur THEN dap.motif
			ELSE "Occupé"
		END as title,
        CONCAT(dap.date_event_debut,'T',dap.time_event_debut) as start,
        CONCAT(dap.date_event_fin,'T',dap.time_event_fin) as end,
		CASE 
			WHEN dap.session_navigateur = session_navigateur THEN "#0d6efd"
			ELSE "#ff9f89"
		END as color,	
		'Public' type_audience,
		'' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour,
		dap.nom as nom,
		dap.prenom as prenom,
		dap.numero_telephone as numero_telephone,
		dap.email as email,
		dap.cin as cin,
		CASE 
			WHEN dap.session_navigateur = session_navigateur and dap.action = 0 THEN "#25af1a"
			WHEN dap.session_navigateur = session_navigateur and dap.action = 1 THEN "#ff0018"
		END as color_status,
		CASE 
			WHEN dap.session_navigateur = session_navigateur and dap.action = 0 THEN "Non validé"
			WHEN dap.session_navigateur = session_navigateur and dap.action = 1 THEN "Validé"
		END as status_audience,
		dap.session_navigateur as session_navigateur
    FROM 
		stage.demande_audience_public dap
        WHERE 
			dap.id_autorite_enfant = id_autorite 
			and dap.action >=0 and dap.action <= 1 
			and dap.date_event_debut BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date) 
			and dap.date_event_fin BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)
    UNION 
    SELECT 
		daa.id as id,
        'Occupé' title,
		CONCAT(daa.date_debut,'T',daa.time_debut) as start,
		CONCAT(daa.date_fin,'T',daa.time_fin) as end,
		'#ff9f89' color,
        'Autorité' type_audience,
		'' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour,
		'' nom,
		'' prenom,
		'' numero_telephone,
		'' email,
		'' cin,
		'' color_status,
		'' status_audience,
		'' session_navigateur
    FROM 
        stage.demande_audience_autorite daa
        where 
			daa.id_autorite_enfant_receiver = id_autorite 
			and daa.action >=0 and daa.action <= 1 
			and daa.date_debut BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date) 
			and daa.date_fin BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)
    UNION
    SELECT 
        ndad.id as id,
        'Pas disponible' title,
		CONCAT(ndad.date_non_dispo_debut,'T',ndad.time_debut) as start,
		CONCAT(ndad.date_non_dispo_fin,'T',ndad.time_fin) as end,
		'#2B2B2B' color,
        'Pas disponible date' type_audience,
		'' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour,
		'' nom,
		'' prenom,
		'' numero_telephone,
		'' email,
		'' cin,
		'' color_status,
		'' status_audience,
		'' session_navigateur
    FROM 
		stage.non_disponibilite_autorite_date ndad
        where 
			ndad.id_autorite_enfant = id_autorite  
			and ndad.date_non_dispo_debut BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date) 
			and ndad.date_non_dispo_fin BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)
    UNION
    SELECT
		eds.id as id,
		'Occupé' title,
		CONCAT(eds.date_debut,'T',eds.time_debut) as start,
		CONCAT(eds.date_fin,'T',eds.time_fin) as end,
		'#ff9f89' color,
		'Entretien' type_audience,
		'' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour,
		'' nom,
		'' prenom,
		'' numero_telephone,
		'' email,
		'' cin,
		'' color_status,
		'' status_audience,
		'' session_navigateur
		
	FROM
		stage.entretien_demande_stage eds
		JOIN demande_stage ds on eds.id_demande_stage = ds.id
	    where 
			-- Si disponible entretien
			ds.id_autorite_enfant = id_autorite
	        and eds.date_debut BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)
			and eds.date_fin BETWEEN FIRST_DATE_OF_MONTH(_date) and LAST_DAY(_date)
	UNION
    SELECT
        jf.id as id,
        jf.nom_evenement as title,
        CONCAT(YEAR(_date),'-',jf.mois_du_jour,'-',jf.numero_du_jour,'T',jf.time_event_debut) as start,
        CONCAT(YEAR(_date),'-',jf.mois_du_jour,'-',jf.numero_du_jour,'T',jf.time_event_fin) as end,
		'#EFEC27' as color,
        'Jour ferie' type_audience,
		'' jour_non_dispo_jour,
        '' td_non_dispo_jour,
        '' tf_non_dispo_jour,
		'' nom,
		'' prenom,
		'' numero_telephone,
		'' email,
		'' cin,
		'' color_status,
		'' status_audience,
		'' session_navigateur
    FROM 
        stage.jour_ferie jf 
		where 
			jf.mois_du_jour =  MONTH(FIRST_DATE_OF_MONTH(_date)) 
			and jf.mois_du_jour = MONTH(LAST_DAY(_date)) 
			and jf.numero_du_jour BETWEEN DAY(FIRST_DATE_OF_MONTH(_date)) AND DAY(LAST_DAY(_date))
    UNION
    SELECT 
        ndaj.id as id,
        'Pas disponible' title,
		'' start,
		'' end,
        '#2B2B2B' color,
        'Pas disponible jour' type_audience,
        ndaj.jour as jour_non_dispo_jour,
        ndaj.time_non_dispo_jour_debut as td_non_dispo_jour,
        ndaj.time_non_dispo_jour_fin as tf_non_dispo_jour,
		'' nom,
		'' prenom,
		'' numero_telephone,
		'' email,
		'' cin,
		'' color_status,
		'' status_audience,
		'' session_navigateur

    FROM 
		stage.non_disponibilite_autorite_jour ndaj 
        where 
			ndaj.id_autorite_enfant = id_autorite;    
END

CREATE  PROCEDURE `LISTE_PUBLIC_PAR_SEMAINE`(id_autorite int,_date date)
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
        'Occupé' motif,
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
            WHERE dap.id_autorite_enfant = id_autorite and dap.action >=0 and dap.action <= 1 and dap.date_event_debut BETWEEN FIRST_DAY_OF_WEEK(_date) and LAST_DAY_OF_WEEK(_date) and dap.date_event_fin BETWEEN FIRST_DAY_OF_WEEK(_date) and LAST_DAY_OF_WEEK(_date)
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
        'Occupé' motif,
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
            where daa.id_autorite_enfant_receiver = id_autorite and daa.action >= 0 and daa.action <= 1 and daa.date_debut BETWEEN FIRST_DAY_OF_WEEK(_date) and LAST_DAY_OF_WEEK(_date) and daa.date_fin BETWEEN FIRST_DAY_OF_WEEK(_date) and LAST_DAY_OF_WEEK(_date)
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
            where ndad.id_autorite_enfant = id_autorite  and ndad.date_non_dispo_debut BETWEEN FIRST_DAY_OF_WEEK(_date) and LAST_DAY_OF_WEEK(_date) and ndad.date_non_dispo_fin BETWEEN FIRST_DAY_OF_WEEK(_date) and LAST_DAY_OF_WEEK(_date)
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
        stage.jour_ferie as jf where jf.mois_du_jour =  MONTH(FIRST_DAY_OF_WEEK(_date)) and jf.mois_du_jour = MONTH(LAST_DAY_OF_WEEK(_date)) and jf.numero_du_jour BETWEEN DAY(FIRST_DAY_OF_WEEK(_date)) AND DAY(LAST_DAY_OF_WEEK(_date))
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

CREATE  PROCEDURE `add_audience_public`(session_navigateur VARCHAR(100),nom varchar(30),prenom varchar(30),cin varchar(15),numero_telephone varchar(10),email varchar(30),dd date,df date,td time,tf time,motif VARCHAR(200),id_autorite int)
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
		INSERT INTO stage.demande_audience_public( date_event_debut,  date_event_fin, time_event_debut, time_event_fin, id_autorite_enfant,motif, cin, numero_telephone, email, nom, prenom, session_navigateur) 
		VALUES (dd,df,td,tf,id_autorite,motif,cin, numero_telephone, email, nom, prenom, session_navigateur);
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

CREATE  PROCEDURE `add_non_disponibilite_autorite_date`(dd date,df date,td time,tf time,id_autorite int)
BEGIN    
    DECLARE time_debut time;
    DECLARE time_fin time;
    DECLARE si_ferie INT;
	DECLARE nbr_rows_events int;
    set @si_ferie = si_jour_ferie(dd ,df ,td ,tf ); 
	SET @nbr_rows_events = NBR_ROWS_EVENEMENTS(dd,df,td,tf,id_autorite);
	IF @nbr_rows_events > 0 THEN 
		CALL LISTE_EVENEMENTS(dd,df,td,tf,id_autorite);
	ELSE 
		IF dd != df OR tf <= td then 
			SELECT 'date time invalid' as message;
		ELSEIF @si_ferie > 0  THEN  
			SELECT 'Jour férié' as message;
		ELSE 
			SELECT 'Aucun évenement' as message;
			INSERT INTO stage.non_disponibilite_autorite_date ( date_non_dispo_debut, date_non_dispo_fin, id_autorite_enfant, time_debut, time_fin) VALUES (dd,df,id_autorite,td,tf);			
		END IF;
	END IF;
END

CREATE  PROCEDURE `add_non_disponibilite_autorite_jour`(jour_date VARCHAR(15),td time,tf time,id_autorite int)
BEGIN    
    DECLARE time_debut time;
    DECLARE time_fin time;
    DECLARE si_ferie INT;
	DECLARE nbr_rows_events int;
	SET @nbr_rows_events = NBR_ROWS_EVENEMENTS_BY_DAY(jour_date,td,tf,id_autorite);
	IF @nbr_rows_events > 0 THEN 
		CALL LISTE_EVENEMENTS_BY_DAY(jour_date,td,tf,id_autorite);
	ELSE 
		IF dd != df OR tf <= td then 
			SELECT 'date time invalid' as message;
		ELSE 
			SELECT 'Aucun évenement' as message;
			INSERT INTO stage.non_disponibilite_autorite_jour (jour, id_autorite_enfant, time_debut, time_fin) VALUES (jour_date,id_autorite,td,tf);			
		END IF;
	END IF;
END

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
		SELECT 'Durée en plus non validé' as message;
	ELSE 
		set @duree_final = @duree_initial + duree_de_stage;	
		UPDATE stage.demande_stage SET stage.demande_stage.duree = @duree_final where stage.demande_stage.id = @id_demande_stage;
	END IF;
END

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
		INSERT INTO stage.demande_audience_public( date_event_debut, date_event_fin, time_event_debut, time_event_fin, id_autorite_enfant, motif) VALUES (dd,df,td,tf,id_autorite,motif);
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

CREATE  PROCEDURE `update_audience_public`(session_navigateur varchar(100),nom varchar(30),prenom varchar(30),cin varchar(15),numero_telephone varchar(10),email varchar(30),dd date,df date,td time,tf time,motif VARCHAR(200),id_autorite int,id int)
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
		and stage.demande_audience_public.session_navigateur != session_navigateur
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
	
	SELECT 
		count(id)
	FROM 
		stage.demande_audience_public  dap
		WHERE 
			dap.session_navigateur = session_navigateur into @nbr_sn_existed;
	IF @nbr_sn_existed >0 and nom != '' and prenom != '' and cin != '' and numero_telephone != '' and email !='' AND motif!='' AND @si_ferie = 0 AND @nbr_rows = 0 and df = dd and td < tf  THEN   
		UPDATE stage.demande_audience_public dap SET dap.date_event_debut = dd, dap.date_event_fin = df, dap.time_event_debut = td, dap.time_event_fin = tf , dap.nom = nom, dap.prenom = prenom, dap.cin = cin, dap.numero_telephone = numero_telephone, dap.email = email WHERE dap.id = id;
	ELSEIF @nbr_sn_existed = 0 THEN
		select 'Session expirée';
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

CREATE  PROCEDURE `update_entretien_stage`(dd date,df date,td time,tf time,id_entretien_stage int,id_autorite_enfant_receiver int)
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
		stage.entretien_demande_stage eds
	JOIN demande_stage ds on eds.id_demande_stage = ds.id
    where 
		ds.id_autorite_enfant = id_autorite_enfant_receiver
		and eds.id != id_entretien_stage
        and eds.date_debut between dd and df
		and eds.date_fin between dd and df
		and eds.time_debut between @time_debut and @time_fin
		and eds.time_fin between @time_debut and @time_fin
		or
		ds.id_autorite_enfant = id_autorite_enfant_receiver
		and eds.id != id_entretien_stage
        and eds.date_debut between dd and df
		and eds.date_fin between dd and df
		and @time_debut between eds.time_debut and eds.time_fin
		and @time_fin between eds.time_debut and eds.time_fin
		or
		ds.id_autorite_enfant = id_autorite_enfant_receiver
		and eds.id != id_entretien_stage
        and eds.date_debut between dd and df
		and eds.date_fin between dd and df
		and @time_debut between eds.time_debut and eds.time_fin
		or
		ds.id_autorite_enfant = id_autorite_enfant_receiver
		and eds.id != id_entretien_stage
        and eds.date_debut between dd and df
		and eds.date_fin between dd and df
		and @time_fin between eds.time_debut and eds.time_fin		
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
	IF dd != '' AND df != '' AND td != '' AND tf != '' AND @si_ferie = 0 AND @nbr_rows = 0 and df = dd and td < tf  THEN   
		-- INSERT INTO stage.demande_audience_autorite( date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, id_autorite_enfant_receiver, motif) VALUES (dd,df,td,tf,id_autorite_enfant_sender,id_autorite_enfant_receiver,motif);
        UPDATE stage.entretien_demande_stage SET date_debut = dd, date_fin = df, time_debut = td, time_fin = tf WHERE stage.entretien_demande_stage.id = id_entretien_stage;
    ELSEIF dd = '' or df = '' or td = '' or tf = ''  THEN 
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

INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 1, 'Chef de service');
INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 2, 'Directeurs');
INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 3, 'Directeurs Généreaux');
INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 4, 'Sécrétaire Général');
INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 5, 'Ministère');
INSERT INTO stage.domaine( id, nom_domaine ) VALUES ( 1, 'Informatique');
INSERT INTO stage.domaine( id, nom_domaine ) VALUES ( 2, 'Marketing');
INSERT INTO stage.domaine( id, nom_domaine ) VALUES ( 3, 'Finances et comptabilité');
INSERT INTO stage.domaine( id, nom_domaine ) VALUES ( 4, 'Communication Marketing');
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin, id ) VALUES ( 'Toussaint', '11', '11', '00:00:01', '23:59:00', 1);
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin, id ) VALUES ( 'Noel', '25', '12', '08:00:00', '12:00:00', 2);
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin, id ) VALUES ( 'Fin d''année', '31', '12', '14:00:00', '16:00:00', 3);
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin, id ) VALUES ( 'Nouvel an', '11', '1', '08:00:00', '12:00:00', 4);
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin, id ) VALUES ( 'TEST 16/11/2022', '09', '11', '14:00:00', '15:00:00', 5);
INSERT INTO stage.autorite_enfant( id, intitule, intitule_code, id_autorite_parent ) VALUES ( 1, 'Directeurs des Ressources Humaines', 'DRH', 2);
INSERT INTO stage.autorite_enfant( id, intitule, intitule_code, id_autorite_parent ) VALUES ( 2, 'Directeurs des Systèmes d''Informations', 'DSI', 2);
INSERT INTO stage.autorite_enfant( id, intitule, intitule_code, id_autorite_parent ) VALUES ( 3, 'Directeurs des Impots', 'DI', 2);
INSERT INTO stage.demande_audience_autorite( id, date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, id_autorite_enfant_receiver, motif, action ) VALUES ( 19, '2022-11-09', '2022-11-09', '03:30:00', '06:30:00', 1, 2, 'Hello world', 0);
INSERT INTO stage.demande_audience_autorite( id, date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, id_autorite_enfant_receiver, motif, action ) VALUES ( 21, '2022-11-09', '2022-11-09', '10:30:00', '11:30:00', 2, 1, 'TEST', 1);
INSERT INTO stage.demande_audience_autorite( id, date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, id_autorite_enfant_receiver, motif, action ) VALUES ( 26, '2022-11-09', '2022-11-09', '12:30:00', '13:30:00', 3, 2, 'TAEST', 1);
INSERT INTO stage.demande_audience_autorite( id, date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, id_autorite_enfant_receiver, motif, action ) VALUES ( 27, '2022-11-09', '2022-11-09', '07:30:00', '08:30:00', 3, 1, 'TEAWST', 0);
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-10-21', 'TEST 2510', 4, '2022-10-21', '08:30:00', '10:00:00', 1, 1, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'johns', '');
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-10-21', 'Test 21', 5, '2022-10-21', '00:00:00', '09:00:00', 1, 1, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'johns', '');
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-11-09', 'TEST 9 Novembre', 7, '2022-11-09', '03:30:00', '05:00:00', 1, 1, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'johns', '');
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-11-15', 'TEST 15 Novembre', 8, '2022-11-15', '05:00:00', '06:00:00', 0, 1, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'johns', 'session615.4606553657551session615.4606553657551');
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-11-09', 'TEST HELLO WORLD', 16, '2022-11-09', '04:30:00', '05:00:00', 0, 1, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'johns', '');
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-11-08', 'rwr', 17, '2022-11-08', '05:00:00', '06:00:00', 0, 1, '112121211', '0341752875', 'teo@gmail.com', 'RAKOTONIRINA', 'Fy', 'session615.4606553657551');
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ( 4, 'RANDRIANARISON', 'Johns', '341777887', 'johnsirintsoa18@gmail.com', '112112112', 4, 'curriculum_vitae_1668365659799_decret_782_96.pdf', 'lettre_motivation_1668365659804_decret_782_96.pdf', 'lettre_introduction_1668365659808_decret_782_96.pdf', 'Je suis un étudiant en première année', 2, 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ( 5, 'RAKOTONIRINA', 'Teo', '348899966', 'teo@gmail.com', '112112112', 5, 'curriculum_vitae_1668366150840_Les nombres rationnels.pdf', 'lettre_motivation_1668366150968_Les nombres rationnels.pdf', 'lettre_introduction_1668366150973_Les nombres rationnels.pdf', 'Je suis désolé', 3, 3);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ( 6, 'RANAIVOSOA', 'Tiana', '348899966', 'teo@gmail.com', '112112112', 5, 'curriculum_vitae_1668366340054_Les nombres rationnels.pdf', 'lettre_motivation_1668366340061_Les nombres rationnels.pdf', 'lettre_introduction_1668366340067_Les nombres rationnels.pdf', 'Je suis désolé', 3, 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ( 7, 'NAIVOSOA', 'Nirina', '345677889', 'naivosoa@gmail.com', '112112112', 3, 'curriculum_vitae_1668400143631_Les nombres rationnels.pdf', 'lettre_motivation_1668400143714_Les nombres rationnels.pdf', 'lettre_introduction_1668400143721_Les nombres rationnels.pdf', 'Je suis la ', 1, 2);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ( 8, 'FIFIDIA', 'Fy', '345677889', 'fifidia@gmail.com', '112112112', 4, 'curriculum_vitae_1668402706992_Les nombres rationnels.pdf', 'lettre_motivation_1668402707078_Les nombres rationnels.pdf', 'lettre_introduction_1668402707083_Les nombres rationnels.pdf', 'bring it on', 4, 1);
INSERT INTO stage.non_disponibilite_autorite_date( date_non_dispo_debut, date_non_dispo_fin, id_autorite_enfant, time_debut, time_fin, id ) VALUES ( '2022-11-09', '2022-11-09', 1, '03:00:00', '03:30:00', 1);
INSERT INTO stage.non_disponibilite_autorite_jour( id, jour, time_non_dispo_jour_debut, time_non_dispo_jour_fin, id_autorite_enfant ) VALUES ( 1, 'Wednesday', '06:00:00', '07:00:00', 1);
INSERT INTO stage.non_disponibilite_autorite_jour( id, jour, time_non_dispo_jour_debut, time_non_dispo_jour_fin, id_autorite_enfant ) VALUES ( 2, 'Monday', '08:00:00', '16:00:00', 1);
INSERT INTO stage.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'porte356', 'porte356@gmail.com', 1, 1, 1);
INSERT INTO stage.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'tale356', 'tale356@gmail.com', 2, 0, 1);