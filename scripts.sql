/**
    * Script MYSQL start
    * start
*/

CREATE SCHEMA stage;

CREATE TABLE stage.autorite_parent ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	intitule             VARCHAR(200)  NOT NULL    
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.domaine ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nom_domaine          VARCHAR(30)  NOT NULL    
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.jour_ferie ( 
	nom_evenement        VARCHAR(30)      ,
	numero_du_jour       VARCHAR(20)      ,
	mois_du_jour         VARCHAR(20)      
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.autorite_enfant ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	intitule             VARCHAR(200)      ,
	intitule_code        VARCHAR(10)      ,
	id_autorite_parent   INT   NOT NULL   
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.demande_audience_autorite ( 
	id 	INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	date_debut DATE ,
	date_fin DATE ,
	time_debut      TIME      ,
	time_fin        TIME      ,
	id_autorite_enfant_sender INT   NOT NULL   ,
	id_autorite_enfant_receiver INT   NOT NULL   ,
	motif                VARCHAR(200)      ,
	action               INT  NOT NULL DEFAULT 0   
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.demande_audience_public ( 
	date_event_debut     DATE      ,
	motif                VARCHAR(200)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	date_event_fin       DATE      ,
	time_event_debut     TIME      ,
	time_event_fin       TIME      ,
	action               INT  NOT NULL DEFAULT 0   ,
	id_autorite_enfant   INT   NOT NULL   
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.demande_stage ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nom                  VARCHAR(30)  NOT NULL    ,
	prenom               VARCHAR(30)  NOT NULL    ,
	telephone            VARCHAR(30)  NOT NULL    ,
	e_mail               VARCHAR(30)      ,
	cin                  VARCHAR(20)      ,
	duree                INT   NOT NULL   ,
	curriculum_vitae     MEDIUMTEXT  NOT NULL    ,
	lettre_motivation    MEDIUMTEXT  NOT NULL    ,
	lettre_introduction  MEDIUMTEXT  NOT NULL    ,
	message              MEDIUMTEXT  NOT NULL    ,
	id_domaine           INT   NOT NULL   
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.non_disponibilite_autorite_date ( 
	date_non_dispo_debut DATETIME      ,
	date_non_dispo_fin   DATETIME      ,
	id_autorite_enfant   INT   NOT NULL   
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.non_disponibilite_autorite_jour ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	jour                 VARCHAR(15)      ,
	time_non_dispo_jour_debut TIME  NOT NULL    ,
	time_non_dispo_jour_fin TIME  NOT NULL    ,
	id_autorite_enfant   INT   NOT NULL   
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.profil ( 
	mot_de_passe         VARCHAR(255)  NOT NULL    ,
	nom_utilisateur      VARCHAR(30)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	est_administrateur   SMALLINT  NOT NULL DEFAULT 0   ,
	id_autorite_enfant   INT   NOT NULL   
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE INDEX fk_autorite_enfant_autorite_parent ON stage.autorite_enfant ( id_autorite_parent );

CREATE INDEX fk_demande_audience_autorite_autorite_sender ON stage.demande_audience_autorite ( id_autorite_enfant_sender );

CREATE INDEX fk_demande_audience_autorite_autorite_receiver ON stage.demande_audience_autorite ( id_autorite_enfant_receiver );

CREATE INDEX fk_demande_audience_public ON stage.demande_audience_public ( id_autorite_enfant );

CREATE INDEX fk_demande_stage_domaine ON stage.demande_stage ( id_domaine );

CREATE INDEX fk_non_disponibilite_autorite_date_autorite_enfant ON stage.non_disponibilite_autorite_date ( id_autorite_enfant );

CREATE INDEX fk_non_disponibilite_autorite_jour ON stage.non_disponibilite_autorite_jour ( id_autorite_enfant );

CREATE INDEX fk_profil_autorite_enfant ON stage.profil ( id_autorite_enfant );

ALTER TABLE stage.autorite_enfant ADD CONSTRAINT fk_autorite_enfant_autorite_parent FOREIGN KEY ( id_autorite_parent ) REFERENCES stage.autorite_parent( id );

ALTER TABLE stage.demande_audience_autorite ADD CONSTRAINT fk_demande_audience_autorite_autorite_sender FOREIGN KEY ( id_autorite_enfant_sender ) REFERENCES stage.autorite_enfant( id );

ALTER TABLE stage.demande_audience_autorite ADD CONSTRAINT fk_demande_audience_autorite_autorite_receiver FOREIGN KEY ( id_autorite_enfant_receiver ) REFERENCES stage.autorite_enfant( id );

ALTER TABLE stage.demande_audience_public ADD CONSTRAINT fk_demande_audience_public FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage.autorite_enfant( id );

ALTER TABLE stage.demande_stage ADD CONSTRAINT fk_demande_stage_domaine FOREIGN KEY ( id_domaine ) REFERENCES stage.domaine( id );

ALTER TABLE stage.non_disponibilite_autorite_date ADD CONSTRAINT fk_non_disponibilite_autorite_date_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage.autorite_enfant( id );

ALTER TABLE stage.non_disponibilite_autorite_jour ADD CONSTRAINT fk_non_disponibilite_autorite_jour_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage.autorite_enfant( id );

ALTER TABLE stage.profil ADD CONSTRAINT fk_profil_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage.autorite_enfant( id );

INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 1, 'Chef de service');
INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 2, 'Directeurs');
INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 3, 'Directeurs Généreaux');
INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 4, 'Sécrétaire Général');
INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 5, 'Ministère');
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour ) VALUES ( 'Toussaint', '1', '11');
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour ) VALUES ( 'Noel', '25', '12');
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour ) VALUES ( 'Fin d''année', '31', '12');
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour ) VALUES ( 'Nouvel an', '1', '1');
INSERT INTO stage.autorite_enfant( id, intitule, intitule_code, id_autorite_parent ) VALUES ( 1, 'Directeurs des Ressources Humaines', 'DRH', 2);
INSERT INTO stage.autorite_enfant( id, intitule, intitule_code, id_autorite_parent ) VALUES ( 2, 'Directeurs des Systèmes d''Informations', 'DSI', 2);
INSERT INTO stage.autorite_enfant( id, intitule, intitule_code, id_autorite_parent ) VALUES ( 3, 'Directeurs des Impots', 'DI', 2);
INSERT INTO stage.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'porte356', 'porte356@gmail.com', 1, 0, 1);

INSERT INTO stage.demande_audience_autorite( id, date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, id_autorite_enfant_receiver, motif ) VALUES ( 1, '2022-10-21', '2022-10-21', '09:00:00', '10:00:00', 2, 1, 'Dossier maika');
INSERT INTO stage.demande_audience_autorite( id, date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, id_autorite_enfant_receiver, motif ) VALUES ( 3, '2022-10-21', '2022-10-21', '11:00:00', '12:00:00', 2, 1, 'Dossier maika 2');
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant ) VALUES ( '2022-10-21', 'Morning', 2, '2022-10-21', '05:00:00', '06:00:00', 0, 1);
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant ) VALUES ( '2022-10-21', 'Asa', 3, '2022-10-21', '07:00:00', '08:00:00', 0, 1);


-- Jour non disponible
INSERT INTO stage.non_disponibilite_autorite_jour ( jour, time_non_dispo_jour_debut, time_non_dispo_jour_fin, id_autorite_enfant) VALUES ( 'Thursday', '00:00:00','23:59:00', 1);

/**	
/*
	* Script MYSQL 
    * End
*/

-- CREATE USER
create user 'autorite' identified by '123mef'

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


/**
	* Start Audience directeur
*/
SELECT date_time_debut, date_time_fin, motif, direction.intitule,type_audience,
CASE 
	WHEN demande_stage.nom != ' ' THEN "Entretien"
	ELSE "Audience"
END as status_audience
FROM
	stage.demande_audience e inner join demande_stage on e.id_demande_stage = demande_stage.id join direction on e.id_direction = direction.id;
/**
	* End Audience directeur
*/

/*
	* Start Login utilisateur
*/
	SELECT id_autorite_enfant,autorite_enfant.intitule,autorite_enfant.intitule_code,mot_de_passe,mot_de_passe, nom_utilisateur, profil.id, est_administrateur 
		FROM stage.profil  
			join autorite_enfant on profil.id_autorite_enfant = autorite_enfant.id 
				where profil.nom_utilisateur = 'porte356@gmail.com' and profil.mot_de_passe = 'porte356';
/*
	* End Login utilisateur
*/
/*
	* Disponibilité du directeur
*/
SELECT date_event_debut, date_event_fin, time_event_debut, time_event_fin, motif, id_direction, id
	FROM stage.demande_audience_public c 
		where id_direction = 2 and date_event_debut='2022-10-17'and date_event_fin='2022-10-17' and time_event_debut BETWEEN '08:59:00' and '09:59:00' or date_event_debut='2022-10-17'and date_event_fin='2022-10-17' and time_event_fin BETWEEN '09:01:00' and '10:01:00' 
			order by date_event_debut,date_event_fin,time_event_debut,time_event_fin

INSERT INTO stage.autorite_enfant( intitule, intitule_code, id_autorite_parent ) VALUES ( 'Directeurs des Ressources Humaines','DRH',2);
INSERT INTO stage.autorite_enfant( intitule, intitule_code, id_autorite_parent ) VALUES ( 'Directeurs des Systèmes d''Informations','DSI',2);
INSERT INTO stage.autorite_enfant( intitule, intitule_code, id_autorite_parent ) VALUES ( 'Directeurs des Impots', 'DI',2);



/*
	// Calendrier directeur
	// debut
*/



DECLARE time_debut time;
DECLARE time_fin time;
SET @time_debut = SUBTIME("05:00:00","-00:01:00");
SET @time_fin = SUBTIME("09:00:00","00:01:00");

SELECT *
FROM stage.demande_audience_public c 
where id_autorite_enfant = 1 and date_event_debut = '2022-10-21' and date_event_fin = '2022-10-21' and time_event_debut BETWEEN @time_debut and @time_fin and time_event_fin BETWEEN @time_debut and @time_fin OR date_event_debut = '2022-10-21' and date_event_fin = '2022-10-21' and time_event_debut BETWEEN @time_debut and @time_fin OR time_event_fin BETWEEN @time_debut and @time_fin OR date_event_debut = '2022-10-21' and date_event_fin = '2022-10-21' and @time_debut BETWEEN time_event_debut and time_event_fin and @time_fin BETWEEN time_event_debut and time_event_fin
order by date_event_debut,date_event_fin,time_event_debut,time_event_fin; 


SELECT *
FROM stage.demande_audience_public c 
where autorite_enfant.id = 1 and stage.demande_audience_public.date_event_debut = '2022-10-21' and stage.demande_audience_public.date_event_fin = '2022-10-21' and stage.demande_audience_public.time_event_debut BETWEEN @time_debut and @time_fin and stage.demande_audience_public.time_event_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.date_event_debut = '2022-10-21' and stage.demande_audience_public.date_event_fin = '2022-10-21' and stage.demande_audience_public.time_event_debut BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.time_event_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.date_event_debut = '2022-10-21' and stage.demande_audience_public.date_event_fin = '2022-10-21' and @time_debut BETWEEN stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin and @time_fin BETWEEN stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin OR 
autorite_enfant.id = 1 and stage.demande_audience_autorite.date_debut = '2022-10-21' and stage.demande_audience_autorite.date_fin = '2022-10-21' and stage.demande_audience_autorite.time_debut BETWEEN @time_debut and @time_fin and stage.demande_audience_autorite.time_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.date_debut = '2022-10-21' and stage.demande_audience_autorite.date_fin = '2022-10-21' and stage.demande_audience_autorite.time_debut BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.time_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.date_debut = '2022-10-21' and stage.demande_audience_autorite.date_fin = '2022-10-21' and @time_debut BETWEEN stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin and @time_fin BETWEEN stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin OR 
autorite_enfant.id = 1 and non_disponibilite_autorite_date.date_non_dispo_debut = '2022-10-21' and non_disponibilite_autorite_date.date_non_dispo_fin = '2022-10-21' and stage.non_disponibilite_autorite_date.time_debut BETWEEN @time_debut and @time_fin and stage.non_disponibilite_autorite_date.time_fin BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_date.date_non_dispo_debut = '2022-10-21' and non_disponibilite_autorite_date.date_non_dispo_fin = '2022-10-21' and stage.non_disponibilite_autorite_date.time_debut BETWEEN @time_debut and @time_fin OR stage.non_disponibilite_autorite_date.time_fin BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_date.date_non_dispo_debut = '2022-10-21' and non_disponibilite_autorite_date.date_non_dispo_fin = '2022-10-21' and @time_debut BETWEEN stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin and @time_fin BETWEEN stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin
order by stage.demande_audience_public.date_event_debut,stage.demande_audience_public.date_event_fin,stage.demande_audience_public.time_event_debut,stage.demande_audience_public.time_event_fin,demande_audience_autorite.date_debut,demande_audience_autorite.date_fin,demande_audience_autorite.time_debut,demande_audience_autorite.time_fin,non_disponibilite_autorite_date.date_non_dispo_debut,non_disponibilite_autorite_date.date_non_dispo_fin,non_disponibilite_autorite_date.time_debut,non_disponibilite_autorite_date.time_fin; 



SELECT 
	*
FROM
	stage.autorite_enfant 
		LEFT JOIN stage.demande_audience_public on stage.autorite_enfant.id = stage.demande_audience_public.id_autorite_enfant
		LEFT JOIN stage.demande_audience_autorite on stage.autorite_enfant.id = stage.demande_audience_autorite.id_autorite_enfant_receiver
		LEFT JOIN stage.non_disponibilite_autorite_date on stage.autorite_enfant.id = stage.non_disponibilite_autorite_date.id_autorite_enfant
		LEFT JOIN stage.non_disponibilite_autorite_jour on stage.autorite_enfant.id = stage.non_disponibilite_autorite_jour.id_autorite_enfant
where autorite_enfant.id = 1 and stage.demande_audience_public.date_event_debut = '2022-10-21' and stage.demande_audience_public.date_event_fin = '2022-10-21' and stage.demande_audience_public.time_event_debut BETWEEN @time_debut and @time_fin and stage.demande_audience_public.time_event_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.date_event_debut = '2022-10-21' and stage.demande_audience_public.date_event_fin = '2022-10-21' and stage.demande_audience_public.time_event_debut BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.time_event_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_public.date_event_debut = '2022-10-21' and stage.demande_audience_public.date_event_fin = '2022-10-21' and @time_debut BETWEEN stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin and @time_fin BETWEEN stage.demande_audience_public.time_event_debut and stage.demande_audience_public.time_event_fin OR 
autorite_enfant.id = 1 and stage.demande_audience_autorite.date_debut = '2022-10-21' and stage.demande_audience_autorite.date_fin = '2022-10-21' and stage.demande_audience_autorite.time_debut BETWEEN @time_debut and @time_fin and stage.demande_audience_autorite.time_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.date_debut = '2022-10-21' and stage.demande_audience_autorite.date_fin = '2022-10-21' and stage.demande_audience_autorite.time_debut BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.time_fin BETWEEN @time_debut and @time_fin OR stage.demande_audience_autorite.date_debut = '2022-10-21' and stage.demande_audience_autorite.date_fin = '2022-10-21' and @time_debut BETWEEN stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin and @time_fin BETWEEN stage.demande_audience_autorite.time_debut and stage.demande_audience_autorite.time_fin OR 
autorite_enfant.id = 1 and non_disponibilite_autorite_date.date_non_dispo_debut = '2022-10-21' and non_disponibilite_autorite_date.date_non_dispo_fin = '2022-10-21' and stage.non_disponibilite_autorite_date.time_debut BETWEEN @time_debut and @time_fin and stage.non_disponibilite_autorite_date.time_fin BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_date.date_non_dispo_debut = '2022-10-21' and non_disponibilite_autorite_date.date_non_dispo_fin = '2022-10-21' and stage.non_disponibilite_autorite_date.time_debut BETWEEN @time_debut and @time_fin OR stage.non_disponibilite_autorite_date.time_fin BETWEEN @time_debut and @time_fin OR non_disponibilite_autorite_date.date_non_dispo_debut = '2022-10-21' and non_disponibilite_autorite_date.date_non_dispo_fin = '2022-10-21' and @time_debut BETWEEN stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin and @time_fin BETWEEN stage.non_disponibilite_autorite_date.time_debut and stage.non_disponibilite_autorite_date.time_fin OR 
autorite_enfant.id = 1 and  non_disponibilite_autorite_jour.jour = dayname(dd) and non_disponibilite_autorite_jour.jour =  dayname(df) Or non_disponibilite_autorite_jour.jour = dayname(dd) OR non_disponibilite_autorite_jour.jour =  dayname(df)
order by stage.demande_audience_public.date_event_debut,stage.demande_audience_public.date_event_fin,stage.demande_audience_public.time_event_debut,stage.demande_audience_public.time_event_fin,demande_audience_autorite.date_debut,demande_audience_autorite.date_fin,demande_audience_autorite.time_debut,demande_audience_autorite.time_fin,non_disponibilite_autorite_date.date_non_dispo_debut,non_disponibilite_autorite_date.date_non_dispo_fin,non_disponibilite_autorite_date.time_debut,non_disponibilite_autorite_date.time_fin; 



SELECT 
	*
FROM
	stage.autorite_enfant 
		LEFT JOIN stage.demande_audience_public on stage.autorite_enfant.id = stage.demande_audience_public.id_autorite_enfant
		LEFT JOIN stage.demande_audience_autorite on stage.autorite_enfant.id = stage.demande_audience_autorite.id_autorite_enfant_receiver
		LEFT JOIN stage.non_disponibilite_autorite_date on stage.autorite_enfant.id = stage.non_disponibilite_autorite_date.id_autorite_enfant;


/*
	// Calendrier directeur
	// fin	 
*/

INSERT INTO demande_audience_autorite
	( date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, id_autorite_enfant_receiver, motif) VALUES 
		( '2022-10-21', '2022-10-21','08:00:00','09:00:00', 2,1,'Dossier maika');

RandrianarisonJohnsIrintsoa18


