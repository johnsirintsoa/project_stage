CREATE SCHEMA stage;

CREATE TABLE stage.autorite_parent ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	intitule             VARCHAR(200)  NOT NULL    
 ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

CREATE TABLE stage.domaine ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nom_domaine          VARCHAR(30)  NOT NULL    
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.jour_ferie ( 
	nom_evenement        VARCHAR(30)      ,
	numero_du_jour       VARCHAR(20)      ,
	mois_du_jour         VARCHAR(20)      ,
	time_event_debut     TIME  NOT NULL    ,
	time_event_fin       TIME  NOT NULL    
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
 ) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

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
	CONSTRAINT fk_demande_audience_public FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

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
	CONSTRAINT fk_demande_stage_domaine FOREIGN KEY ( id_domaine ) REFERENCES stage.domaine( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.non_disponibilite_autorite_date ( 
	date_non_dispo_debut DATE  NOT NULL    ,
	date_non_dispo_fin   DATE  NOT NULL    ,
	id_autorite_enfant   INT  NOT NULL    ,
	time_debut           TIME  NOT NULL    ,
	time_fin             TIME  NOT NULL    ,
	CONSTRAINT fk_non_disponibilite_autorite_date_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.non_disponibilite_autorite_jour ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	jour                 VARCHAR(15)  NOT NULL    ,
	time_non_dispo_jour_debut TIME  NOT NULL    ,
	time_non_dispo_jour_fin TIME  NOT NULL    ,
	id_autorite_enfant   INT  NOT NULL    ,
	CONSTRAINT fk_non_disponibilite_autorite_jour_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

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

CREATE INDEX fk_non_disponibilite_autorite_date_autorite_enfant ON stage.non_disponibilite_autorite_date ( id_autorite_enfant );

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

INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 1, 'Chef de service');
INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 2, 'Directeurs');
INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 3, 'Directeurs Généreaux');
INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 4, 'Sécrétaire Général');
INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 5, 'Ministère');
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin ) VALUES ( 'Toussaint', '11', '11', '00:00:01', '23:59:00');
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin ) VALUES ( 'Noel', '25', '12', '08:00:00', '12:00:00');
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin ) VALUES ( 'Fin d''année', '31', '12', '14:00:00', '16:00:00');
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin ) VALUES ( 'Nouvel an', '11', '1', '08:00:00', '12:00:00');
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin ) VALUES ( 'TEST 21', '21', '10', '15:00:00', '17:00:00');
INSERT INTO stage.autorite_enfant( id, intitule, intitule_code, id_autorite_parent ) VALUES ( 1, 'Directeurs des Ressources Humaines', 'DRH', 2);
INSERT INTO stage.autorite_enfant( id, intitule, intitule_code, id_autorite_parent ) VALUES ( 2, 'Directeurs des Systèmes d''Informations', 'DSI', 2);
INSERT INTO stage.autorite_enfant( id, intitule, intitule_code, id_autorite_parent ) VALUES ( 3, 'Directeurs des Impots', 'DI', 2);
INSERT INTO stage.demande_audience_autorite( id, date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, id_autorite_enfant_receiver, motif, action ) VALUES ( 19, '2022-11-09', '2022-11-09', '03:30:00', '06:30:00', 1, 2, 'Hello world', 0);
INSERT INTO stage.demande_audience_autorite( id, date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, id_autorite_enfant_receiver, motif, action ) VALUES ( 21, '2022-11-09', '2022-11-09', '10:30:00', '11:30:00', 1, 2, 'TEST', 1);
INSERT INTO stage.demande_audience_autorite( id, date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, id_autorite_enfant_receiver, motif, action ) VALUES ( 26, '2022-11-09', '2022-11-09', '12:30:00', '13:30:00', 3, 2, 'TAEST', 1);
INSERT INTO stage.demande_audience_autorite( id, date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, id_autorite_enfant_receiver, motif, action ) VALUES ( 27, '2022-11-09', '2022-11-09', '07:30:00', '08:30:00', 3, 2, 'TEAWST', 0);
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant, cin, numero_telephone, email, nom, prenom ) VALUES ( '2022-10-21', 'Morning', 2, '2022-10-21', '06:30:00', '08:00:00', 1, 1, '', '', '', '', '');
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant, cin, numero_telephone, email, nom, prenom ) VALUES ( '2022-10-21', 'TEST 2510', 4, '2022-10-21', '08:30:00', '10:00:00', 1, 1, '', '', '', '', '');
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant, cin, numero_telephone, email, nom, prenom ) VALUES ( '2022-10-21', 'Test 21', 5, '2022-10-21', '00:00:00', '09:00:00', 1, 1, '', '', '', '', '');
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant, cin, numero_telephone, email, nom, prenom ) VALUES ( '2022-11-09', 'test 08/11/22', 6, '2022-11-09', '03:30:00', '04:00:00', 1, 1, '', '', '', '', '');
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant, cin, numero_telephone, email, nom, prenom ) VALUES ( '2022-11-09', 'TEST 9 Novembre', 7, '2022-11-09', '05:00:00', '06:30:00', 1, 1, '', '', '', '', '');
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant, cin, numero_telephone, email, nom, prenom ) VALUES ( '2022-11-15', 'TEST 15 Novembre', 8, '2022-11-15', '05:00:00', '06:00:00', 0, 1, '', '', '', '', '');
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant, cin, numero_telephone, email, nom, prenom ) VALUES ( '2022-11-09', '', 16, '2022-11-09', '04:30:00', '05:00:00', 0, 1, '', '', '', '', '');
INSERT INTO stage.non_disponibilite_autorite_date( date_non_dispo_debut, date_non_dispo_fin, id_autorite_enfant, time_debut, time_fin ) VALUES ( '2022-10-21', '2022-10-21', 1, '13:00:00', '14:00:00');
INSERT INTO stage.non_disponibilite_autorite_date( date_non_dispo_debut, date_non_dispo_fin, id_autorite_enfant, time_debut, time_fin ) VALUES ( '2022-11-09', '2022-11-09', 1, '07:00:00', '10:00:00');
INSERT INTO stage.non_disponibilite_autorite_jour( id, jour, time_non_dispo_jour_debut, time_non_dispo_jour_fin, id_autorite_enfant ) VALUES ( 1, 'Thursday', '06:00:00', '07:00:00', 1);
INSERT INTO stage.non_disponibilite_autorite_jour( id, jour, time_non_dispo_jour_debut, time_non_dispo_jour_fin, id_autorite_enfant ) VALUES ( 2, 'Monday', '08:00:00', '16:00:00', 1);
INSERT INTO stage.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'porte356', 'porte356@gmail.com', 1, 1, 1);
INSERT INTO stage.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'tale356', 'tale356@gmail.com', 2, 0, 1);