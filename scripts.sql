/**
    * Script MYSQL start
    * start
*/

CREATE SCHEMA stage;

CREATE TABLE stage.autorite_parent ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	intitule             VARCHAR(200)  NOT NULL    
 ) engine=InnoDB;

CREATE TABLE stage.direction ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	intitule             VARCHAR(200)  NOT NULL    ,
	id_profil            INT  NOT NULL    ,
	intitule_code        VARCHAR(10)      
 ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE stage.domaine ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nom_domaine          VARCHAR(30)  NOT NULL    
 ) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

CREATE TABLE stage.jour_ferie ( 
	nom_evenement        VARCHAR(30)      ,
	numero_du_jour       VARCHAR(20)      ,
	mois_du_jour         VARCHAR(20)      
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.profil ( 
	nom_utilisateur      VARCHAR(30)  NOT NULL    ,
	mot_de_passe         VARCHAR(255)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	est_administrateur   SMALLINT  NOT NULL DEFAULT ('0')   
 ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

CREATE TABLE stage.autorite_enfant ( 
	id                   INT  NOT NULL    PRIMARY KEY,
	intitule             VARCHAR(200)      ,
	intitule_code        VARCHAR(10)      ,
	id_autorite_parent   INT      
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.autorite_enfant_profil ( 
	id_profil            INT  NOT NULL    ,
	id_autorite_enfant   INT      
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.demande_audience_autorite ( 
	date_time_debut      DATETIME      ,
	date_time_fin        DATETIME      ,
	id_autorite_enfant_sender INT      ,
	id_autorite_enfant_receiver INT      ,
	motif                VARCHAR(200)      
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.demande_audience_public ( 
	date_event_debut     DATE      ,
	motif                VARCHAR(200)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	date_event_fin       DATE      ,
	time_event_debut     TIME      ,
	time_event_fin       TIME      ,
	action               INT      ,
	id_autorite_enfant   INT      
 ) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

CREATE TABLE stage.demande_stage ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nom                  VARCHAR(30)  NOT NULL    ,
	prenom               VARCHAR(30)  NOT NULL    ,
	telephone            VARCHAR(30)  NOT NULL    ,
	e_mail               VARCHAR(30)      ,
	cin                  VARCHAR(20)      ,
	duree                INT      ,
	curriculum_vitae     MEDIUMTEXT  NOT NULL    ,
	lettre_motivation    MEDIUMTEXT  NOT NULL    ,
	lettre_introduction  MEDIUMTEXT  NOT NULL    ,
	message              MEDIUMTEXT  NOT NULL    ,
	id_domaine           INT      
 ) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

CREATE TABLE stage.non_disponibilite_autorite_date ( 
	date_non_dispo_debut DATETIME      ,
	date_non_dispo_fin   DATETIME      ,
	id_autorite_enfant   INT      
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage.non_disponibilite_autorite_jour ( 
	jour                 VARCHAR(15)      ,
	time_non_dispo_jour_debut TIME  NOT NULL    ,
	time_non_dispo_jour_fin TIME  NOT NULL    ,
	id_autorite_enfant   INT  NOT NULL    
 );

CREATE INDEX fk_direction_profil ON stage.direction ( id_profil );

CREATE INDEX fk_autorite_enfant_autorite_parent ON stage.autorite_enfant ( id_autorite_parent );

CREATE INDEX fk_autorite_enfant_profil_id_profil ON stage.autorite_enfant_profil ( id_profil );

CREATE INDEX fk_autorite_enfant_profil_id_autorite_enfant ON stage.autorite_enfant_profil ( id_autorite_enfant );

CREATE INDEX fk_demande_stage_domaine ON stage.demande_stage ( id_domaine );

ALTER TABLE stage.autorite_enfant ADD CONSTRAINT fk_autorite_enfant_autorite_parent FOREIGN KEY ( id_autorite_parent ) REFERENCES stage.autorite_parent( id ) ON DELETE SET NULL ON UPDATE SET NULL;

ALTER TABLE stage.autorite_enfant_profil ADD CONSTRAINT fk_autorite_enfant_profil_id_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage.autorite_enfant( id ) ON DELETE SET NULL ON UPDATE SET NULL;

ALTER TABLE stage.autorite_enfant_profil ADD CONSTRAINT fk_autorite_enfant_profil_id_profil FOREIGN KEY ( id_profil ) REFERENCES stage.profil( id ) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE stage.demande_audience_autorite ADD CONSTRAINT fk_demande_audience_autorite_autorite_sender FOREIGN KEY ( id_autorite_enfant_sender ) REFERENCES stage.autorite_enfant( id ) ON DELETE SET NULL ON UPDATE SET NULL;

ALTER TABLE stage.demande_audience_autorite ADD CONSTRAINT fk_demande_audience_autorite_autorite_receiver FOREIGN KEY ( id_autorite_enfant_receiver ) REFERENCES stage.autorite_enfant( id ) ON DELETE SET NULL ON UPDATE SET NULL;

ALTER TABLE stage.demande_audience_public ADD CONSTRAINT fk_demande_audience_public_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage.autorite_enfant( id ) ON DELETE SET NULL ON UPDATE SET NULL;

ALTER TABLE stage.demande_stage ADD CONSTRAINT fk_demande_stage_domaine FOREIGN KEY ( id_domaine ) REFERENCES stage.domaine( id ) ON DELETE SET NULL ON UPDATE SET NULL;

ALTER TABLE stage.non_disponibilite_autorite_date ADD CONSTRAINT fk_non_disponibilite_autorite_date_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage.autorite_enfant( id ) ON DELETE SET NULL ON UPDATE SET NULL;

ALTER TABLE stage.non_disponibilite_autorite_jour ADD CONSTRAINT fk_non_disponibilite_autorite_jour FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage.autorite_enfant( id ) ON DELETE SET NULL ON UPDATE SET NULL;

INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 1, 'Chef de service');
INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 2, 'Directeurs');
INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 3, 'Directeurs Généreaux');
INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 4, 'Sécrétaire Général');
INSERT INTO stage.autorite_parent( id, intitule ) VALUES ( 5, 'Ministère');
INSERT INTO stage.direction( id, intitule, id_profil, intitule_code ) VALUES ( 1, 'Directeurs des Ressources Humaines', 3, 'DRH');
INSERT INTO stage.direction( id, intitule, id_profil, intitule_code ) VALUES ( 2, 'Directeurs des Systèmes d''Informations', 4, 'DSI');
INSERT INTO stage.direction( id, intitule, id_profil, intitule_code ) VALUES ( 3, 'Directeurs des Impots', 5, 'DI');
INSERT INTO stage.domaine( id, nom_domaine ) VALUES ( 1, 'Informatique');
INSERT INTO stage.domaine( id, nom_domaine ) VALUES ( 2, 'Marketing');
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour ) VALUES ( 'Mazava alina', '8', '10');
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour ) VALUES ( 'Toussaint', '1', '11');
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour ) VALUES ( 'Noel', '25', '12');
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour ) VALUES ( 'Fin d''année', '31', '12');
INSERT INTO stage.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour ) VALUES ( 'Nouvel an', '1', '1');
INSERT INTO stage.profil( nom_utilisateur, mot_de_passe, id, est_administrateur ) VALUES ( 'administrateur@gmail.com', '2dd07c9ce0189aaacacff6a86a5fc61a8d38d851', 2, 0);
INSERT INTO stage.profil( nom_utilisateur, mot_de_passe, id, est_administrateur ) VALUES ( 'porte356@gmail.com', '7d1a3fe8eed303aedda59edecac8e448db5949ce', 3, 0);
INSERT INTO stage.profil( nom_utilisateur, mot_de_passe, id, est_administrateur ) VALUES ( 'porte412@gmail.com', '9a28cbd1491c70432d9b3f228c77722ff115dd05', 4, 0);
INSERT INTO stage.profil( nom_utilisateur, mot_de_passe, id, est_administrateur ) VALUES ( 'porte289@gmail.com', '0f4936674bd87ee70de47b7bc1c61a13ce4186dd', 5, 0);
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant ) VALUES ( '2022-10-17', 'Travail personnel', 1, '2022-10-17', '08:00:00', '08:30:00', 0, null);
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant ) VALUES ( '2022-10-18', 'Patrouille departement', 2, '2022-10-18', '08:30:00', '09:30:00', 0, null);
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant ) VALUES ( '2022-10-17', 'Déjeuner', 4, '2022-10-17', '10:00:00', '10:30:00', 0, null);
INSERT INTO stage.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, id_autorite_enfant ) VALUES ( '2022-10-17', 'Asa speed', 5, '2022-10-17', '08:30:00', '09:00:00', 0, null);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 1, 'Joris', 'agaga', '0345612895', '1213244@gmail.com', '515151', 2, 'ddfkdl.pdf', 'kfjdlf.pdf', 'gdg.pdf', 'Bonjour à tous je suis johns', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 2, 'Naivo', 'agaga', '0345612895', '1213244@gmail.com', '515151', 2, 'ddfkdl.pdf', 'kfjdlf.pdf', 'gdg.pdf', 'Bonjour à tous je suis johns', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 4, 'Johns', 'RANDY', '6523120023', 'jdfdfdjfkd@gmail.com', '54541351', 3, 'curriculum_vitae_1661415411604_Etats_Analyses.pdf', 'curriculum_vitae_1661415411604_Etats_Analyses.pdf', 'curriculum_vitae_1661415411604_Etats_Analyses.pdf', 'Je suis blabalbalbalbao', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 5, 'RAJAONARISOA', 'Johns', '0345677789', 'johns@gmail.com', '112112112112', 3, 'uploadsdemande_stagecurriculum_vitae_1661502143944_Etats_Analyses.pdf', 'uploadsdemande_stagelettre_motivation_1661502144334_Etats_Analyses.pdf', 'uploadsdemande_stagelettre_introduction_1661502144351_Etats_Analyses.pdf', 'Hello world im johns irintsoa', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 6, 'fdf', 'asf', '12424', 'afad', '1422', 2, 'curriculum_vitae_1661518023282_Etats_Analyses.pdf', 'lettre_motivation_1661518023305_Etats_Analyses.pdf', 'lettre_introduction_1661518023339_Etats_Analyses.pdf', 'afad', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 7, 'RANDRIANARISON', 'Johns', '123112324', 'johns@gmail.com', '112112112112', 2, 'curriculum_vitae_1661518676255_Etats_Analyses.pdf', 'lettre_motivation_1661518676270_Etats_Analyses.pdf', 'lettre_introduction_1661518676313_Etats_Analyses.pdf', 'Je suis avec toi', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 8, 'RAJAONARISOA', 'Johns', '0345677789', 'johns@gmail.com', '112112112112', 3, 'curriculum_vitae_1661845237503_ImmoListe.pdf', 'lettre_motivation_1661845237504_Convention de stage.pdf', 'lettre_introduction_1661845237506_Livenexx_saison de stage 2022.pdf', 'Hello world im johns irintsoa', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 9, 'RAVOARISO', 'Nirina', '0345677789', 'johns@gmail.com', '112112112112', 3, 'curriculum_vitae_1661974954240_ImmoListe.pdf', 'lettre_motivation_1661974954241_Convention de stage.pdf', 'lettre_introduction_1661974954244_Livenexx_saison de stage 2022.pdf', 'Hello world im johns irintsoa', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 10, 'RAVOARISO', 'Nirina', '0345677789', 'johns@gmail.com', '112112112112', 3, 'curriculum_vitae_1662012434266_ImmoListe.pdf', 'lettre_motivation_1662012434267_Convention de stage.pdf', 'lettre_introduction_1662012434271_Livenexx_saison de stage 2022.pdf', 'Hello world im johns irintsoa', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 11, 'RAVOARISO', 'Nirina', '0345677789', 'johns@gmail.com', '112112112112', 3, 'curriculum_vitae_1662012477108_ImmoListe.pdf', 'lettre_motivation_1662012477109_Convention de stage.pdf', 'lettre_introduction_1662012477113_Livenexx_saison de stage 2022.pdf', 'Hello world im johns irintsoa', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 12, 'RAVOARISO', 'Nirina', '0345677789', 'johns@gmail.com', '112112112112', 3, 'curriculum_vitae_1662012599995_ImmoListe.pdf', 'lettre_motivation_1662012599995_Convention de stage.pdf', 'lettre_introduction_1662012599998_Livenexx_saison de stage 2022.pdf', 'Hello world im johns irintsoa', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 15, 'RAVOARISO', 'Nirina', '0345677789', 'johns@gmail.com', '112112112112', 3, 'curriculum_vitae_1662013649078_ImmoListe.pdf', 'lettre_motivation_1662013649079_Convention de stage.pdf', 'lettre_introduction_1662013649084_Livenexx_saison de stage 2022.pdf', 'Hello world im johns irintsoa', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 16, 'RAVOARISO', 'Nirina', '0345677789', 'johns@gmail.com', '112112112112', 3, 'curriculum_vitae_1662013794261_ImmoListe.pdf', 'lettre_motivation_1662013794262_Convention de stage.pdf', 'lettre_introduction_1662013794267_Livenexx_saison de stage 2022.pdf', 'Hello world im johns irintsoa', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 17, 'RAVOARISO', 'Nirina', '0345677789', 'johns@gmail.com', '112112112112', 3, 'curriculum_vitae_1662014761343_ImmoListe.pdf', 'lettre_motivation_1662014761352_Convention de stage.pdf', 'lettre_introduction_1662014761366_Livenexx_saison de stage 2022.pdf', 'Hello world im johns irintsoa', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 31, 'RASOA', 'Feno', '13314134', 'admin@gmail.com', '134343', 3, 'curriculum_vitae_1662015939375_mail.pdf', 'lettre_motivation_1662015939376_mail.pdf', 'lettre_introduction_1662015939455_mail.pdf', 'ddddddddddd', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 32, 'Andriamaminaivo', 'Feno', '134134', 'johnsirintsoa18@gmail.com', '134134', 3, 'curriculum_vitae_1662016199028_mail.pdf', 'lettre_motivation_1662016199028_mail.pdf', 'lettre_introduction_1662016199033_mail.pdf', 'ddddddddd', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 33, 'RANDRIANARISON', 'Feno', '341758275', 'johnsirintsoa18@gmail.com', '112112112112', 2, 'curriculum_vitae_1662017293222_mail.pdf', 'lettre_motivation_1662017293224_mail.pdf', 'lettre_introduction_1662017293227_mail.pdf', 'Hello world here we go', 1);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 34, 'Dyran', 'Johns', '341752875', 'dyranjohns@gmail.com', '112112112112', 3, 'curriculum_vitae_1662378969144_mail.pdf', 'lettre_motivation_1662378969350_mail.pdf', 'lettre_introduction_1662378969404_mail.pdf', 'Je suis la et je serai la', 2);
INSERT INTO stage.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine ) VALUES ( 35, ' ', ' ', ' ', ' ', ' ', 0, ' ', ' ', ' ', ' ', 1);
/** 
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
	* Disponibilité du directeur
*/
SELECT date_event_debut, date_event_fin, time_event_debut, time_event_fin, motif, id_direction, id
	FROM stage.demande_audience_public c 
		where id_direction = 2 and date_event_debut='2022-10-17'and date_event_fin='2022-10-17' and time_event_debut BETWEEN '08:59:00' and '09:59:00' or date_event_debut='2022-10-17'and date_event_fin='2022-10-17' and time_event_fin BETWEEN '09:01:00' and '10:01:00' 
			order by date_event_debut,date_event_fin,time_event_debut,time_event_fin