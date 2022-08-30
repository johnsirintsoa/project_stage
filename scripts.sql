/**
    * Script sql start
    * start
*/

CREATE SCHEMA stage;

CREATE TABLE stage.demande_audience ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	direction            VARCHAR(200)      
 ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE stage.domaine ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nom_domaine          VARCHAR(30)  NOT NULL    
 ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE stage.profil ( 
	nom_utilisateur      VARCHAR(30)  NOT NULL    ,
	mot_de_passe         VARCHAR(255)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY
 ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE stage.demande_stage ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nom                  VARCHAR(30)  NOT NULL    ,
	prenom               VARCHAR(30)  NOT NULL    ,
	telephone            VARCHAR(30)  NOT NULL    ,
	e_mail               VARCHAR(30)      ,
	cin                  VARCHAR(12)      ,
	duree                INT      ,
	curriculum_vitae     MEDIUMTEXT  NOT NULL    ,
	lettre_motivation    MEDIUMTEXT  NOT NULL    ,
	lettre_introduction  MEDIUMTEXT  NOT NULL    ,
	message              MEDIUMTEXT  NOT NULL    ,
	id_domaine           INT      ,
	CONSTRAINT fk_demande_stage_domaine FOREIGN KEY ( id_domaine ) REFERENCES stage.domaine( id ) ON DELETE SET NULL ON UPDATE SET NULL
 ) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

CREATE TABLE stage.rendez_vous_directeur ( 
	date_time_debut      DATETIME      ,
	date_time_fin        DATETIME      ,
	id_demande_stage     INT  NOT NULL    ,
	id_demande_audience  INT  NOT NULL    ,
	motif                VARCHAR(200)  NOT NULL    ,
	CONSTRAINT fk_demande_audience_calendrier_directeur FOREIGN KEY ( id_demande_audience ) REFERENCES stage.demande_audience( id ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_demande_stage_calendrier_directeur FOREIGN KEY ( id_demande_stage ) REFERENCES stage.demande_stage( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE INDEX fk_demande_stage_domaine ON stage.demande_stage ( id_domaine );

CREATE INDEX fk_demande_stage_calendrier_directeur ON stage.rendez_vous_directeur ( id_demande_stage );

CREATE INDEX fk_demande_audience_calendrier_directeur ON stage.rendez_vous_directeur ( id_demande_audience );

INSERT INTO stage.demande_audience( id, direction ) VALUES ( 1, ' ');
INSERT INTO stage.domaine( id, nom_domaine ) VALUES ( 1, 'Informatique');
INSERT INTO stage.domaine( id, nom_domaine ) VALUES ( 2, 'Marketing');
INSERT INTO stage.profil( nom_utilisateur, mot_de_passe, id ) VALUES ( 'administrateur@gmail.com', '28dca2a7b33b7413ad3bce1d58c26dd679c799f1', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 1, 'Joris', 'agaga', '0345612895', '1213244@gmail.com', '515151', 2, 'ddfkdl.pdf', 'kfjdlf.pdf', 'gdg.pdf', 'Bonjour à tous je suis johns', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 2, 'Naivo', 'agaga', '0345612895', '1213244@gmail.com', '515151', 2, 'ddfkdl.pdf', 'kfjdlf.pdf', 'gdg.pdf', 'Bonjour à tous je suis johns', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 4, 'Johns', 'RANDY', '6523120023', 'jdfdfdjfkd@gmail.com', '54541351', 3, 'curriculum_vitae_1661415411604_Etats_Analyses.pdf', 'curriculum_vitae_1661415411604_Etats_Analyses.pdf', 'curriculum_vitae_1661415411604_Etats_Analyses.pdf', 'Je suis blabalbalbalbao', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 5, 'RAJAONARISOA', 'Johns', '0345677789', 'johns@gmail.com', '112112112112', 3, 'uploadsdemande_stagecurriculum_vitae_1661502143944_Etats_Analyses.pdf', 'uploadsdemande_stagelettre_motivation_1661502144334_Etats_Analyses.pdf', 'uploadsdemande_stagelettre_introduction_1661502144351_Etats_Analyses.pdf', 'Hello world im johns irintsoa', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 6, 'fdf', 'asf', '12424', 'afad', '1422', 2, 'curriculum_vitae_1661518023282_Etats_Analyses.pdf', 'lettre_motivation_1661518023305_Etats_Analyses.pdf', 'lettre_introduction_1661518023339_Etats_Analyses.pdf', 'afad', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 7, 'RANDRIANARISON', 'Johns', '123112324', 'johns@gmail.com', '112112112112', 2, 'curriculum_vitae_1661518676255_Etats_Analyses.pdf', 'lettre_motivation_1661518676270_Etats_Analyses.pdf', 'lettre_introduction_1661518676313_Etats_Analyses.pdf', 'Je suis avec toi', 1);
INSERT INTO stage.rendez_vous_directeur( date_time_debut, date_time_fin, id_demande_stage, id_demande_audience, motif ) VALUES ( '2022-08-29 07.09.06 PM', '2022-08-29 07.09.06 PM', 2, 1, 'Demande de stage');

/** 
    * Script sql 
    * End
*/


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