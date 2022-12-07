CREATE SCHEMA stage3;

CREATE TABLE stage3.autorite_parent ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	intitule             VARCHAR(200)  NOT NULL    
 ) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

CREATE TABLE stage3.demande_audience_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	date_debut           DATE  NOT NULL    ,
	date_fin             DATE  NOT NULL    ,
	time_debut           TIME  NOT NULL    ,
	time_fin             TIME  NOT NULL    ,
	id_autorite_enfant_sender INT  NOT NULL    ,
	motif                VARCHAR(200)  NOT NULL    ,
	action               INT  NOT NULL DEFAULT ('0')   
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage3.demande_audience_public ( 
	date_event_debut     DATE  NOT NULL    ,
	motif                VARCHAR(200)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	date_event_fin       DATE  NOT NULL    ,
	time_event_debut     TIME  NOT NULL    ,
	time_event_fin       TIME  NOT NULL    ,
	action               INT  NOT NULL DEFAULT ('0')   ,
	cin                  VARCHAR(15)  NOT NULL    ,
	numero_telephone     VARCHAR(10)  NOT NULL    ,
	email                VARCHAR(200)  NOT NULL    ,
	nom                  VARCHAR(30)  NOT NULL    ,
	prenom               VARCHAR(30)  NOT NULL    ,
	session_navigateur   VARCHAR(100)  NOT NULL    
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage3.domaine ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nom_domaine          VARCHAR(30)  NOT NULL    
 ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

CREATE TABLE stage3.jour_ferie ( 
	nom_evenement        VARCHAR(30)      ,
	numero_du_jour       VARCHAR(20)      ,
	mois_du_jour         VARCHAR(20)      ,
	time_event_debut     TIME  NOT NULL    ,
	time_event_fin       TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage3.non_disponibilite_autorite_date ( 
	date_non_dispo_debut DATE  NOT NULL    ,
	date_non_dispo_fin   DATE  NOT NULL    ,
	time_debut           TIME  NOT NULL    ,
	time_fin             TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage3.non_disponibilite_autorite_jour ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	time_non_dispo_jour_debut TIME  NOT NULL    ,
	time_non_dispo_jour_fin TIME  NOT NULL    
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage3.autorite_enfant ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	intitule             VARCHAR(200)  NOT NULL    ,
	intitule_code        VARCHAR(10)  NOT NULL    ,
	id_autorite_parent   INT  NOT NULL    ,
	addresse_electronique VARCHAR(200)  NOT NULL    ,
	mot_de_passe_mailing VARCHAR(100)  NOT NULL    ,
	porte                VARCHAR(5)  NOT NULL    ,
	CONSTRAINT fk_autorite_enfant_autorite_parent FOREIGN KEY ( id_autorite_parent ) REFERENCES stage3.autorite_parent( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE stage3.demande_stage ( 
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
	CONSTRAINT fk_demande_stage_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage3.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_demande_stage_domaine FOREIGN KEY ( id_domaine ) REFERENCES stage3.domaine( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage3.entretien_demande_stage ( 
	date_debut           DATE  NOT NULL    ,
	date_fin             DATE  NOT NULL    ,
	time_debut           TIME  NOT NULL    ,
	time_fin             TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_demande_stage     INT  NOT NULL    ,
	CONSTRAINT fk_entretien_demande_stage FOREIGN KEY ( id_demande_stage ) REFERENCES stage3.demande_stage( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage3.jour_ouvrable ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	jour                 VARCHAR(15)  NOT NULL    ,
	time_debut           TIME  NOT NULL    ,
	time_fin             TIME  NOT NULL    ,
	partie_du_jour       VARCHAR(15)  NOT NULL    ,
	id_autorite          INT  NOT NULL    ,
	CONSTRAINT fk_jour_ouvrable_id_autorite_autorite_enfant FOREIGN KEY ( id_autorite ) REFERENCES stage3.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=latin1;

CREATE TABLE stage3.profil ( 
	mot_de_passe         VARCHAR(255)  NOT NULL    ,
	nom_utilisateur      VARCHAR(30)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	est_administrateur   SMALLINT  NOT NULL DEFAULT ('0')   ,
	id_autorite_enfant   INT  NOT NULL    ,
	CONSTRAINT fk_profil_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage3.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage3.heure_disponible ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	id_jour_ouvrable     INT  NOT NULL    ,
	CONSTRAINT fk_heure_audience_disponible FOREIGN KEY ( id_jour_ouvrable ) REFERENCES stage3.jour_ouvrable( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

CREATE TABLE stage3.dm_aud_public_heure_dispo ( 
	id_aud_public        INT  NOT NULL    ,
	id_heure_dispo       INT  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	CONSTRAINT fk_dm_aud_public_heure_dispo FOREIGN KEY ( id_aud_public ) REFERENCES stage3.demande_audience_public( id ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_dm_aud_public_heure_dispo_id_heure_dispo FOREIGN KEY ( id_heure_dispo ) REFERENCES stage3.heure_disponible( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage3.heure_dispo_dm_aud_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_heure_dispo       INT  NOT NULL    ,
	id_dm_aud_autorite   INT  NOT NULL    ,
	CONSTRAINT fk_heure_dispo_dm_aud_autorite_id_dm_aud_autorite FOREIGN KEY ( id_dm_aud_autorite ) REFERENCES stage3.demande_audience_autorite( id ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_heure_dispo_dm_aud_autorite_id_heure_dispo FOREIGN KEY ( id_heure_dispo ) REFERENCES stage3.heure_disponible( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage3.heure_dispo_entretien_stage ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_heure_dispo       INT  NOT NULL    ,
	id_entretien_stage   INT  NOT NULL    ,
	CONSTRAINT fk_heure_dispo_entretien_stage FOREIGN KEY ( id_entretien_stage ) REFERENCES stage3.entretien_demande_stage( id ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_heure_dispo_entretien_stage_id_heure_dispo FOREIGN KEY ( id_heure_dispo ) REFERENCES stage3.heure_disponible( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage3.heure_dispo_non_dispo_autorite_date ( 
	id_heure_dispo       INT  NOT NULL    ,
	id_non_dispo_date    INT  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	CONSTRAINT fk_heure_dispo_non_dispo_autorite_date FOREIGN KEY ( id_non_dispo_date ) REFERENCES stage3.non_disponibilite_autorite_date( id ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_heure_dispo_non_dispo_autorite_date_id_heure_dispo FOREIGN KEY ( id_heure_dispo ) REFERENCES stage3.heure_disponible( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage3.heure_dispo_non_dispo_autorite_jour ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_heure_dispo       INT  NOT NULL    ,
	id_non_dispo_jour    INT  NOT NULL    ,
	CONSTRAINT fk_heure_dispo_non_dispo_autorite_jour_id_non_dispo_jour FOREIGN KEY ( id_non_dispo_jour ) REFERENCES stage3.non_disponibilite_autorite_jour( id ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_heure_dispo_non_dispo_autorite_jour_id_heure_dispo FOREIGN KEY ( id_heure_dispo ) REFERENCES stage3.heure_disponible( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE INDEX fk_autorite_enfant_autorite_parent ON stage3.autorite_enfant ( id_autorite_parent );

CREATE INDEX fk_demande_stage_autorite_enfant ON stage3.demande_stage ( id_autorite_enfant );

CREATE INDEX fk_demande_stage_domaine ON stage3.demande_stage ( id_domaine );

CREATE INDEX fk_entretien_demande_stage ON stage3.entretien_demande_stage ( id_demande_stage );

CREATE INDEX fk_jour_ouvrable_id_autorite_autorite_enfant ON stage3.jour_ouvrable ( id_autorite );

CREATE INDEX fk_profil_autorite_enfant ON stage3.profil ( id_autorite_enfant );

CREATE INDEX fk_heure_audience_disponible ON stage3.heure_disponible ( id_jour_ouvrable );

CREATE INDEX fk_dm_aud_public_heure_dispo ON stage3.dm_aud_public_heure_dispo ( id_aud_public );

CREATE INDEX fk_dm_aud_public_heure_dispo_id_heure_dispo ON stage3.dm_aud_public_heure_dispo ( id_heure_dispo );

CREATE INDEX fk_heure_dispo_dm_aud_autorite_id_dm_aud_autorite ON stage3.heure_dispo_dm_aud_autorite ( id_dm_aud_autorite );

CREATE INDEX fk_heure_dispo_dm_aud_autorite_id_heure_dispo ON stage3.heure_dispo_dm_aud_autorite ( id_heure_dispo );

CREATE INDEX fk_heure_dispo_entretien_stage ON stage3.heure_dispo_entretien_stage ( id_entretien_stage );

CREATE INDEX fk_heure_dispo_entretien_stage_id_heure_dispo ON stage3.heure_dispo_entretien_stage ( id_heure_dispo );

CREATE INDEX fk_heure_dispo_non_dispo_autorite_date ON stage3.heure_dispo_non_dispo_autorite_date ( id_non_dispo_date );

CREATE INDEX fk_heure_dispo_non_dispo_autorite_date_id_heure_dispo ON stage3.heure_dispo_non_dispo_autorite_date ( id_heure_dispo );

CREATE INDEX fk_heure_dispo_non_dispo_autorite_jour_id_non_dispo_jour ON stage3.heure_dispo_non_dispo_autorite_jour ( id_non_dispo_jour );

CREATE INDEX fk_heure_dispo_non_dispo_autorite_jour_id_heure_dispo ON stage3.heure_dispo_non_dispo_autorite_jour ( id_heure_dispo );

CREATE  PROCEDURE `ajouter_heure_disponible_autorite`(IN heure_debut time,IN heure_fin time,IN duree_disponibilite time,IN id_jour_ouvrable int)
BEGIN
	DECLARE hds,hfs,das INT;
	DECLARE tmp_hfs int DEFAULT 0;
	set @hds = time_to_sec(heure_debut);
	set @hfs = time_to_sec(heure_fin);
	set @das = time_to_sec(duree_disponibilite);
	WHILE @hds < @hfs DO
		set @tmp_hfs = @hds + @das;
		INSERT INTO stage3.heure_disponible(heure_debut, heure_fin, id_jour_ouvrable) VALUES (sec_to_time(@hds),sec_to_time(@tmp_hfs),id_jour_ouvrable);
		set @hds = @tmp_hfs;
	END WHILE;
END

CREATE  PROCEDURE `ajouter_jour_ouvrable_tous_les_jours`(IN heure_debut time,IN heure_fin time,IN partie_du_jour varchar(15),IN id_autorite int)
BEGIN
    INSERT INTO stage3.jour_ouvrable(jour, time_debut, time_fin, partie_du_jour, id_autorite) VALUES ('Monday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage3.jour_ouvrable(jour, time_debut, time_fin, partie_du_jour, id_autorite) VALUES ('Tuesday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage3.jour_ouvrable(jour, time_debut, time_fin, partie_du_jour, id_autorite) VALUES ('Wednesday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage3.jour_ouvrable(jour, time_debut, time_fin, partie_du_jour, id_autorite) VALUES ('Thursday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage3.jour_ouvrable(jour, time_debut, time_fin, partie_du_jour, id_autorite) VALUES ('Friday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
END

INSERT INTO stage3.autorite_parent( id, intitule ) VALUES ( 1, 'Chef de service');
INSERT INTO stage3.autorite_parent( id, intitule ) VALUES ( 2, 'Directeurs');
INSERT INTO stage3.autorite_parent( id, intitule ) VALUES ( 3, 'Directeurs Généreaux');
INSERT INTO stage3.autorite_parent( id, intitule ) VALUES ( 4, 'Sécrétaire Général');
INSERT INTO stage3.autorite_parent( id, intitule ) VALUES ( 5, 'Ministère');
INSERT INTO stage3.autorite_parent( id, intitule ) VALUES ( 6, 'Ministère');
INSERT INTO stage3.demande_audience_autorite( id, date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, motif, action ) VALUES ( 1, '2022-11-28', '2022-11-28', '15:00:00', '15:30:00', 1, 'Hello world', 0);
INSERT INTO stage3.demande_audience_autorite( id, date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, motif, action ) VALUES ( 2, '2022-11-28', '2022-11-28', '14:10:00', '14:40:00', 2, 'TEST', 1);
INSERT INTO stage3.demande_audience_autorite( id, date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, motif, action ) VALUES ( 3, '2022-11-28', '2022-11-28', '14:45:00', '15:10:00', 3, 'TAEST', 1);
INSERT INTO stage3.demande_audience_autorite( id, date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, motif, action ) VALUES ( 4, '2022-11-28', '2022-11-28', '15:40:00', '15:50:00', 3, 'TEAWST', 0);
INSERT INTO stage3.demande_audience_autorite( id, date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, motif, action ) VALUES ( 5, '2022-11-28', '2022-11-28', '15:30:00', '15:40:00', 2, 'Dossier maika', 0);
INSERT INTO stage3.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-11-28', 'TEST 2510', 1, '2022-11-28', '08:10:00', '08:15:00', 2, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'johns', 'session669.84399043559464');
INSERT INTO stage3.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-11-28', 'Test 21', 2, '2022-11-28', '08:20:00', '08:30:00', 1, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'johns', 'session36.35297770114687');
INSERT INTO stage3.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-11-28', 'TEST 9 Novembre', 3, '2022-11-28', '08:20:00', '08:40:00', 0, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'Jojo', 'session898.2515433898981');
INSERT INTO stage3.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-11-28', 'TEST 15 Novembre', 4, '2022-11-28', '08:45:00', '10:00:00', 1, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'johns', 'session669.8439904355946');
INSERT INTO stage3.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-11-28', 'Resaka matotra', 5, '2022-11-28', '09:10:00', '09:20:00', 0, '112112112', '0385699878', 'fifidia@gmail.com', 'RAKOTONIRINA', 'Teo', 'session36.35297770114687');
INSERT INTO stage3.demande_audience_public( date_event_debut, motif, id, date_event_fin, time_event_debut, time_event_fin, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-11-28', 'Resaka matotra', 6, '2022-11-28', '09:25:00', '09:30:00', 0, '112112112', '0385699878', 'fifidia@gmail.com', 'RAKOTONIRINA', 'Teo', 'session36.35297770114687');
INSERT INTO stage3.domaine( id, nom_domaine ) VALUES ( 1, 'Informatique');
INSERT INTO stage3.domaine( id, nom_domaine ) VALUES ( 2, 'Marketing');
INSERT INTO stage3.domaine( id, nom_domaine ) VALUES ( 3, 'Finances et comptabilité');
INSERT INTO stage3.domaine( id, nom_domaine ) VALUES ( 4, 'Communication Marketing');
INSERT INTO stage3.non_disponibilite_autorite_date( date_non_dispo_debut, date_non_dispo_fin, time_debut, time_fin, id ) VALUES ( '2022-11-28', '2022-11-28', '08:00:00', '08:40:00', 1);
INSERT INTO stage3.non_disponibilite_autorite_date( date_non_dispo_debut, date_non_dispo_fin, time_debut, time_fin, id ) VALUES ( '2022-11-28', '2022-11-28', '10:10:00', '10:40:00', 2);
INSERT INTO stage3.non_disponibilite_autorite_jour( id, time_non_dispo_jour_debut, time_non_dispo_jour_fin ) VALUES ( 1, '14:00:00', '14:40:00');
INSERT INTO stage3.non_disponibilite_autorite_jour( id, time_non_dispo_jour_debut, time_non_dispo_jour_fin ) VALUES ( 2, '15:30:00', '16:00:00');
INSERT INTO stage3.autorite_enfant( id, intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ( 1, 'Direction des Ressources Humaines', 'DRH', 2, 'mefstage22022@gmail.com', 'wswrgxbntbumffqs', '356');
INSERT INTO stage3.autorite_enfant( id, intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ( 2, 'Direction des Systèmes d''Informations', 'DSI', 2, 'dyranjohns@gmail.com', 'wswrgxbntbumffqs', '413');
INSERT INTO stage3.autorite_enfant( id, intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ( 3, 'Direction Générales des Impots', 'DGI', 2, 'johnsirintsoa18@gmail.com', 'wswrgxbntbumffqs', '123');
INSERT INTO stage3.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ( 1, 'RANDRIANARISON', 'Johns', '341777887', 'johnsirintsoa18@gmail.com', '112112112', 4, 'curriculum_vitae_1668365659799_decret_782_96.pdf', 'lettre_motivation_1668365659804_decret_782_96.pdf', 'lettre_introduction_1668365659808_decret_782_96.pdf', 'Je suis un étudiant en première année', 2, 1);
INSERT INTO stage3.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ( 2, 'RAKOTONIRINA', 'Teo', '348899966', 'teo@gmail.com', '112112112', 5, 'curriculum_vitae_1668366150840_Les nombres rationnels.pdf', 'lettre_motivation_1668366150968_Les nombres rationnels.pdf', 'lettre_introduction_1668366150973_Les nombres rationnels.pdf', 'Je suis désolé', 3, 3);
INSERT INTO stage3.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ( 3, 'RANAIVOSOA', 'Tiana', '348899966', 'teo@gmail.com', '112112112', 5, 'curriculum_vitae_1668366340054_Les nombres rationnels.pdf', 'lettre_motivation_1668366340061_Les nombres rationnels.pdf', 'lettre_introduction_1668366340067_Les nombres rationnels.pdf', 'Je suis désolé', 3, 1);
INSERT INTO stage3.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ( 4, 'NAIVOSOA', 'Nirina', '345677889', 'naivosoa@gmail.com', '112112112', 3, 'curriculum_vitae_1668400143631_Les nombres rationnels.pdf', 'lettre_motivation_1668400143714_Les nombres rationnels.pdf', 'lettre_introduction_1668400143721_Les nombres rationnels.pdf', 'Je suis la ', 1, 2);
INSERT INTO stage3.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ( 5, 'FIFIDIA', 'Fy', '345677889', 'fifidia@gmail.com', '112112112', 4, 'curriculum_vitae_1668402706992_Les nombres rationnels.pdf', 'lettre_motivation_1668402707078_Les nombres rationnels.pdf', 'lettre_introduction_1668402707083_Les nombres rationnels.pdf', 'bring it on', 4, 1);
INSERT INTO stage3.entretien_demande_stage( date_debut, date_fin, time_debut, time_fin, id, id_demande_stage ) VALUES ( '2022-11-28', '2022-11-28', '10:20:00', '10:45:00', 1, 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 82, 'Monday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 83, 'Tuesday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 84, 'Wednesday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 85, 'Thursday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 86, 'Friday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 87, 'Monday', '14:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 88, 'Tuesday', '14:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 89, 'Wednesday', '14:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 90, 'Thursday', '14:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 91, 'Friday', '14:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage3.heure_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 1, '08:00:00', '08:30:00', 82);
INSERT INTO stage3.heure_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 2, '08:30:00', '09:00:00', 82);
INSERT INTO stage3.heure_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 3, '09:00:00', '09:30:00', 82);
INSERT INTO stage3.heure_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 4, '09:30:00', '10:00:00', 82);
INSERT INTO stage3.heure_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 5, '10:00:00', '10:30:00', 82);
INSERT INTO stage3.heure_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 6, '10:30:00', '11:00:00', 82);
INSERT INTO stage3.heure_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 7, '11:00:00', '11:30:00', 82);
INSERT INTO stage3.heure_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 8, '11:30:00', '12:00:00', 82);
INSERT INTO stage3.heure_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 9, '14:00:00', '14:30:00', 87);
INSERT INTO stage3.heure_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 10, '14:30:00', '15:00:00', 87);
INSERT INTO stage3.heure_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 11, '15:00:00', '15:30:00', 87);
INSERT INTO stage3.heure_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 12, '15:30:00', '16:00:00', 87);
INSERT INTO stage3.dm_aud_public_heure_dispo( id_aud_public, id_heure_dispo, id ) VALUES ( 1, 1, 1);
INSERT INTO stage3.dm_aud_public_heure_dispo( id_aud_public, id_heure_dispo, id ) VALUES ( 2, 1, 2);
INSERT INTO stage3.dm_aud_public_heure_dispo( id_aud_public, id_heure_dispo, id ) VALUES ( 3, 1, 3);
INSERT INTO stage3.dm_aud_public_heure_dispo( id_aud_public, id_heure_dispo, id ) VALUES ( 3, 2, 4);
INSERT INTO stage3.dm_aud_public_heure_dispo( id_aud_public, id_heure_dispo, id ) VALUES ( 4, 2, 5);
INSERT INTO stage3.dm_aud_public_heure_dispo( id_aud_public, id_heure_dispo, id ) VALUES ( 4, 3, 6);
INSERT INTO stage3.dm_aud_public_heure_dispo( id_aud_public, id_heure_dispo, id ) VALUES ( 4, 4, 7);
INSERT INTO stage3.heure_dispo_dm_aud_autorite( id, id_heure_dispo, id_dm_aud_autorite ) VALUES ( 1, 11, 1);
INSERT INTO stage3.heure_dispo_dm_aud_autorite( id, id_heure_dispo, id_dm_aud_autorite ) VALUES ( 2, 9, 2);
INSERT INTO stage3.heure_dispo_dm_aud_autorite( id, id_heure_dispo, id_dm_aud_autorite ) VALUES ( 3, 10, 2);
INSERT INTO stage3.heure_dispo_dm_aud_autorite( id, id_heure_dispo, id_dm_aud_autorite ) VALUES ( 4, 10, 3);
INSERT INTO stage3.heure_dispo_dm_aud_autorite( id, id_heure_dispo, id_dm_aud_autorite ) VALUES ( 5, 11, 3);
INSERT INTO stage3.heure_dispo_entretien_stage( id, id_heure_dispo, id_entretien_stage ) VALUES ( 1, 5, 1);
INSERT INTO stage3.heure_dispo_entretien_stage( id, id_heure_dispo, id_entretien_stage ) VALUES ( 2, 6, 1);
INSERT INTO stage3.heure_dispo_non_dispo_autorite_date( id_non_dispo_date, id_heure_dispo, id ) VALUES ( 1, 1, 1);
INSERT INTO stage3.heure_dispo_non_dispo_autorite_date( id_non_dispo_date, id_heure_dispo, id ) VALUES ( 1, 2, 2);
INSERT INTO stage3.heure_dispo_non_dispo_autorite_date( id_non_dispo_date, id_heure_dispo, id ) VALUES ( 1, 1, 3);
INSERT INTO stage3.heure_dispo_non_dispo_autorite_date( id_non_dispo_date, id_heure_dispo, id ) VALUES ( 1, 2, 4);
INSERT INTO stage3.heure_dispo_non_dispo_autorite_date( id_non_dispo_date, id_heure_dispo, id ) VALUES ( 2, 5, 5);
INSERT INTO stage3.heure_dispo_non_dispo_autorite_date( id_non_dispo_date, id_heure_dispo, id ) VALUES ( 2, 6, 6);
INSERT INTO stage3.heure_dispo_non_dispo_autorite_jour( id, id_heure_dispo, id_non_dispo_jour ) VALUES ( 1, 9, 1);
INSERT INTO stage3.heure_dispo_non_dispo_autorite_jour( id, id_heure_dispo, id_non_dispo_jour ) VALUES ( 2, 10, 1);
INSERT INTO stage3.heure_dispo_non_dispo_autorite_jour( id, id_heure_dispo, id_non_dispo_jour ) VALUES ( 3, 12, 2);