CREATE SCHEMA stage3;

CREATE TABLE stage3.autorite_parent ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	intitule             VARCHAR(200)  NOT NULL    
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage3.domaine ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nom_domaine          VARCHAR(30)  NOT NULL    
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage3.jour_ferie ( 
	nom_evenement        VARCHAR(30)      ,
	numero_du_jour       VARCHAR(20)      ,
	mois_du_jour         VARCHAR(20)      ,
	time_event_debut     TIME  NOT NULL    ,
	time_event_fin       TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY
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
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

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
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage3.entretien_demande_stage ( 
	date_debut           DATE  NOT NULL    ,
	date_fin             DATE  NOT NULL    ,
	time_debut           TIME  NOT NULL    ,
	time_fin             TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_demande_stage     INT  NOT NULL    ,
	CONSTRAINT fk_entretien_demande_stage FOREIGN KEY ( id_demande_stage ) REFERENCES stage3.demande_stage( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage3.jour_ouvrable ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	jour                 VARCHAR(15)  NOT NULL    ,
	time_debut           TIME  NOT NULL    ,
	time_fin             TIME  NOT NULL    ,
	partie_du_jour       VARCHAR(15)  NOT NULL    ,
	id_autorite          INT  NOT NULL    ,
	CONSTRAINT fk_jour_ouvrable_id_autorite_autorite_enfant FOREIGN KEY ( id_autorite ) REFERENCES stage3.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage3.non_disponibilite_autorite_date ( 
	date_non_dispo_debut DATE  NOT NULL    ,
	date_non_dispo_fin   DATE  NOT NULL    ,
	id_autorite_enfant   INT  NOT NULL    ,
	time_debut           TIME  NOT NULL    ,
	time_fin             TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	CONSTRAINT fk_non_disponibilite_autorite_date FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage3.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage3.non_disponibilite_autorite_jour ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	jour                 VARCHAR(15)  NOT NULL    ,
	time_non_dispo_jour_debut TIME  NOT NULL    ,
	time_non_dispo_jour_fin TIME  NOT NULL    ,
	id_autorite_enfant   INT  NOT NULL    ,
	CONSTRAINT fk_non_disponibilite_autorite_jour_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage3.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage3.profil ( 
	mot_de_passe         VARCHAR(255)  NOT NULL    ,
	nom_utilisateur      VARCHAR(30)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	est_administrateur   SMALLINT  NOT NULL DEFAULT ('0')   ,
	id_autorite_enfant   INT  NOT NULL    ,
	CONSTRAINT fk_profil_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage3.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage3.heure_audience_disponible ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	id_jour_ouvrable     INT  NOT NULL    ,
	CONSTRAINT fk_heure_audience_disponible FOREIGN KEY ( id_jour_ouvrable ) REFERENCES stage3.jour_ouvrable( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage3.demande_audience_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	date_debut           DATE  NOT NULL    ,
	date_fin             DATE  NOT NULL    ,
	time_debut           TIME  NOT NULL    ,
	time_fin             TIME  NOT NULL    ,
	id_autorite_enfant_sender INT  NOT NULL    ,
	motif                VARCHAR(200)  NOT NULL    ,
	action               INT  NOT NULL DEFAULT 0  
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage3.demande_audience_public ( 
	date_event_debut     DATE  NOT NULL    ,
	motif                VARCHAR(200)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	date_event_fin       DATE  NOT NULL    ,
	time_event_debut     TIME  NOT NULL    ,
	time_event_fin       TIME  NOT NULL    ,
	action               INT  NOT NULL DEFAULT 0   ,
	cin                  VARCHAR(15)  NOT NULL    ,
	numero_telephone     VARCHAR(10)  NOT NULL    ,
	email                VARCHAR(200)  NOT NULL    ,
	nom                  VARCHAR(30)  NOT NULL    ,
	prenom               VARCHAR(30)  NOT NULL    ,
	session_navigateur   VARCHAR(100)  NOT NULL    ,
	id_heure_audience_disponible INT  NOT NULL    ,
	CONSTRAINT fk_demande_audience_public FOREIGN KEY ( id_heure_audience_disponible ) REFERENCES stage3.heure_audience_disponible( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE INDEX fk_autorite_enfant_autorite_parent ON stage3.autorite_enfant ( id_autorite_parent );

CREATE INDEX fk_demande_stage_domaine ON stage3.demande_stage ( id_domaine );

CREATE INDEX fk_demande_stage_autorite_enfant ON stage3.demande_stage ( id_autorite_enfant );

CREATE INDEX fk_entretien_demande_stage ON stage3.entretien_demande_stage ( id_demande_stage );

CREATE INDEX fk_jour_ouvrable_id_autorite_autorite_enfant ON stage3.jour_ouvrable ( id_autorite );

CREATE INDEX fk_non_disponibilite_autorite_date ON stage3.non_disponibilite_autorite_date ( id_autorite_enfant );

CREATE INDEX fk_non_disponibilite_autorite_jour ON stage3.non_disponibilite_autorite_jour ( id_autorite_enfant );

CREATE INDEX fk_profil_autorite_enfant ON stage3.profil ( id_autorite_enfant );

CREATE INDEX fk_heure_audience_disponible ON stage3.heure_audience_disponible ( id_jour_ouvrable );

CREATE INDEX fk_demande_audience_autorite ON stage3.demande_audience_autorite ( id_heure_audience_disponible );

CREATE INDEX fk_demande_audience_public ON stage3.demande_audience_public ( id_heure_audience_disponible );

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

CREATE  PROCEDURE `liste_place_disponible_public_par_jour`(IN date_du_jour date,IN session_navigateur varchar(50),in id_autorite int)
BEGIN
    SET @id_autorite = id_autorite;
    SET @session_navigateur = session_navigateur;
    SET @date_du_jour = date_du_jour;
    set @jour_UTF8 = CONVERT(DAYNAME(@date_du_jour) USING utf8);

    SELECT 
    had.*,
    dap.*
    FROM
    stage3.heure_audience_disponible had
    JOIN stage3.demande_audience_public dap on had.id = dap.id_heure_audience_disponible
    WHERE
    dap.date_event_debut = @date_du_jour
    and dap.date_event_fin = @date_du_jour
    and dap.session_navigateur = @session_navigateur
    and dap.action >= 0 and dap.action <= 1
    UNION
    SELECT 
    had.*,
    dap.*
    FROM
    stage3.heure_audience_disponible had
    LEFT JOIN stage3.demande_audience_public dap on had.id = dap.id_heure_audience_disponible
    WHERE 
    had.id NOT IN (
        select 
        had.id
        FROM 
        heure_audience_disponible had
        JOIN jour_ouvrable jo on had.id_jour_ouvrable = jo.id
        JOIN autorite_enfant ae on jo.id_autorite = ae.id
        JOIN non_disponibilite_autorite_date ndad on ndad.id_autorite_enfant = ae.id
        JOIN non_disponibilite_autorite_jour ndaj on ndaj.id_autorite_enfant = ae.id
        JOIN demande_stage ds on ds.id_autorite_enfant = ae.id
        JOIN entretien_demande_stage eds on eds.id_demande_stage = ds.id
        WHERE 
        -- Non disponible autorite date
        jo.jour = @jour_UTF8
        and ndad.id_autorite_enfant = @id_autorite	
        and ndad.date_non_dispo_debut = @date_du_jour
        and ndad.date_non_dispo_fin = @date_du_jour
        and had.heure_debut between SUBTIME(ndad.time_debut,"-00:01:00") and SUBTIME(ndad.time_fin,"00:01:00")
        and had.heure_fin between SUBTIME(ndad.time_debut,"-00:01:00") and SUBTIME(ndad.time_fin,"00:01:00")
		and ndad.time_debut between jo.time_debut and jo.time_fin
		and ndad.time_fin between jo.time_debut and jo.time_fin
        or
        jo.jour = @jour_UTF8
        and ndad.id_autorite_enfant = @id_autorite	
        and ndad.date_non_dispo_debut = @date_du_jour
        and ndad.date_non_dispo_fin = @date_du_jour
        and SUBTIME(ndad.time_debut,"-00:01:00") between had.heure_debut and had.heure_fin
        and SUBTIME(ndad.time_fin,"00:01:00") between had.heure_debut and had.heure_fin
		and ndad.time_debut between jo.time_debut and jo.time_fin
		and ndad.time_fin between jo.time_debut and jo.time_fin
        or
        jo.jour = @jour_UTF8
        and ndad.id_autorite_enfant = @id_autorite	
        and ndad.date_non_dispo_debut = @date_du_jour
        and ndad.date_non_dispo_fin = @date_du_jour
        and SUBTIME(ndad.time_debut,"-00:01:00") between had.heure_debut and had.heure_fin
		and ndad.time_debut between jo.time_debut and jo.time_fin
		and ndad.time_fin between jo.time_debut and jo.time_fin
        or
        jo.jour = @jour_UTF8
        and ndad.id_autorite_enfant = @id_autorite	
        and ndad.date_non_dispo_debut = @date_du_jour
        and ndad.date_non_dispo_fin = @date_du_jour
        and SUBTIME(ndad.time_fin,"00:01:00") between had.heure_debut and had.heure_fin
		and ndad.time_debut between jo.time_debut and jo.time_fin
		and ndad.time_fin between jo.time_debut and jo.time_fin
        or 
        -- Non disponible jour
        ndaj.id_autorite_enfant = @id_autorite	
        and jo.jour = @jour_UTF8
        and ndaj.jour = @jour_UTF8
        and had.heure_debut between SUBTIME(ndaj.time_non_dispo_jour_debut,"-00:01:00") and SUBTIME(ndaj.time_non_dispo_jour_fin,"00:01:00")
        and had.heure_fin between SUBTIME(ndaj.time_non_dispo_jour_debut,"-00:01:00") and SUBTIME(ndaj.time_non_dispo_jour_fin,"00:01:00")
		and ndaj.time_non_dispo_jour_debut between jo.time_debut and jo.time_fin
		and ndaj.time_non_dispo_jour_fin between jo.time_debut and jo.time_fin
        or
        ndaj.id_autorite_enfant = @id_autorite	
        and jo.jour = @jour_UTF8
        and ndaj.jour = @jour_UTF8
        and SUBTIME(ndaj.time_non_dispo_jour_debut,"-00:01:00") between had.heure_debut and had.heure_fin
        and SUBTIME(ndaj.time_non_dispo_jour_fin,"-00:01:00") between had.heure_debut and had.heure_fin
		and ndaj.time_non_dispo_jour_debut between jo.time_debut and jo.time_fin
		and ndaj.time_non_dispo_jour_fin between jo.time_debut and jo.time_fin
        or
        ndaj.id_autorite_enfant = @id_autorite	
        and ndaj.jour  = @jour_UTF8
        and jo.jour = @jour_UTF8
        and SUBTIME(ndaj.time_non_dispo_jour_debut,"-00:01:00") between had.heure_debut and had.heure_fin
		and ndaj.time_non_dispo_jour_debut between jo.time_debut and jo.time_fin
		and ndaj.time_non_dispo_jour_fin between jo.time_debut and jo.time_fin
        or
        ndaj.id_autorite_enfant = @id_autorite	
        and ndaj.jour  = @jour_UTF8
        and jo.jour = @jour_UTF8
        and SUBTIME(ndaj.time_non_dispo_jour_fin,"00:01:00") between had.heure_debut and had.heure_fin
		and ndaj.time_non_dispo_jour_debut between jo.time_debut and jo.time_fin
		and ndaj.time_non_dispo_jour_fin between jo.time_debut and jo.time_fin
        -- Demande Entretien
        or
        jo.id_autorite = @id_autorite
        and ds.id_autorite_enfant = @id_autorite	
        and eds.date_debut = @date_du_jour
        and eds.date_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and had.heure_debut between SUBTIME(eds.time_debut,"-00:01:00") and SUBTIME(eds.time_fin,"00:01:00")
        and had.heure_fin between SUBTIME(eds.time_debut,"-00:01:00") and SUBTIME(eds.time_fin,"00:01:00")
		and eds.time_debut between jo.time_debut and jo.time_fin
		and eds.time_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite = @id_autorite
        and ds.id_autorite_enfant = @id_autorite	
        and eds.date_debut = @date_du_jour
        and eds.date_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and SUBTIME(eds.time_debut,"-00:01:00") between had.heure_debut and had.heure_fin
        and SUBTIME(eds.time_fin,"00:01:00") between had.heure_debut and had.heure_fin
		and eds.time_debut between jo.time_debut and jo.time_fin
		and eds.time_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite = @id_autorite
        and ds.id_autorite_enfant = @id_autorite	
        and eds.date_debut = @date_du_jour
        and eds.date_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and SUBTIME(eds.time_debut,"-00:01:00") between had.heure_debut and had.heure_fin
		and eds.time_debut between jo.time_debut and jo.time_fin
		and eds.time_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite = @id_autorite
        and ds.id_autorite_enfant = @id_autorite	
        and eds.date_debut = @date_du_jour
        and eds.date_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and SUBTIME(eds.time_fin,"00:01:00") between had.heure_debut and had.heure_fin
		and eds.time_debut between jo.time_debut and jo.time_fin
		and eds.time_fin between jo.time_debut and jo.time_fin
        -- Demande audience public
        UNION
        select 
        had.id
        FROM 
        heure_audience_disponible had
        JOIN demande_audience_public dap on had.id = dap.id_heure_audience_disponible
        JOIN jour_ouvrable jo on had.id_jour_ouvrable = jo.id
        WHERE 
        jo.id_autorite = @id_autorite	
        and dap.action >=0 and dap.action <= 1
        and dap.date_event_debut = @date_du_jour
        and dap.date_event_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and had.heure_debut between SUBTIME(dap.time_event_debut,"-00:01:00") and SUBTIME(dap.time_event_fin,"00:01:00")
        and had.heure_fin between SUBTIME(dap.time_event_debut,"-00:01:00") and SUBTIME(dap.time_event_fin,"00:01:00")
		and dap.time_event_debut between jo.time_debut and jo.time_fin
		and dap.time_event_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite  = @id_autorite
        AND dap.action >=0 and dap.action <= 1
        and dap.date_event_debut = @date_du_jour
        and dap.date_event_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and SUBTIME(dap.time_event_debut,"-00:01:00") between had.heure_debut and had.heure_fin
        and SUBTIME(dap.time_event_fin,"00:01:00") between had.heure_debut and had.heure_fin		
		and dap.time_event_debut between jo.time_debut and jo.time_fin
		and dap.time_event_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite  = @id_autorite
        AND dap.action >=0 and dap.action <= 1
        and dap.date_event_debut = @date_du_jour
        and dap.date_event_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and SUBTIME(dap.time_event_debut,"-00:01:00") between had.heure_debut and had.heure_fin
		and dap.time_event_debut between jo.time_debut and jo.time_fin
		and dap.time_event_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite  = @id_autorite
        AND dap.action >=0 and dap.action <= 1
        and dap.date_event_debut = @date_du_jour
        and dap.date_event_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and SUBTIME(dap.time_event_fin,"00:01:00") between had.heure_debut and had.heure_fin
		and dap.time_event_debut between jo.time_debut and jo.time_fin
		and dap.time_event_fin between jo.time_debut and jo.time_fin
        -- Demande audience autorite 
        UNION
        select 
        had.id
        FROM 
        heure_audience_disponible had
        JOIN demande_audience_autorite daa on had.id = daa.id_heure_audience_disponible
        JOIN jour_ouvrable jo on had.id_jour_ouvrable = jo.id
        WHERE 
        jo.id_autorite  = @id_autorite
        AND daa.action >= 0 and daa.action <= 1
        and daa.date_debut = @date_du_jour
        and daa.date_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and had.heure_debut between SUBTIME(daa.time_debut,"-00:01:00") and SUBTIME(daa.time_fin,"00:01:00")
        and had.heure_fin between SUBTIME(daa.time_debut,"-00:01:00") and SUBTIME(daa.time_fin,"00:01:00")
		and daa.time_debut between jo.time_debut and jo.time_fin
		and daa.time_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite  = @id_autorite
        AND daa.action >= 0 and daa.action <= 1
        and daa.date_debut = @date_du_jour
        and daa.date_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and SUBTIME(daa.time_debut,"-00:01:00") between had.heure_debut and had.heure_fin
        and SUBTIME(daa.time_fin,"00:01:00") between had.heure_debut and had.heure_fin
		and daa.time_debut between jo.time_debut and jo.time_fin
		and daa.time_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite  = @id_autorite
        AND daa.action >= 0 and daa.action <= 1
        and daa.date_debut = @date_du_jour
        and daa.date_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and SUBTIME(daa.time_debut,"-00:01:00") between had.heure_debut and had.heure_fin
		and daa.time_debut between jo.time_debut and jo.time_fin
		and daa.time_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite  = @id_autorite
        AND daa.action >= 0 and daa.action <= 1
        and daa.date_debut = @date_du_jour
        and daa.date_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and SUBTIME(daa.time_fin,"00:01:00") between had.heure_debut and had.heure_fin
		and daa.time_debut between jo.time_debut and jo.time_fin
		and daa.time_fin between jo.time_debut and jo.time_fin
        GROUP by had.id 
        ORDER BY heure_debut ASC
    );
END

INSERT INTO stage3.autorite_parent( intitule ) VALUES ('Chef de service');
INSERT INTO stage3.autorite_parent( intitule ) VALUES ('Directeurs');
INSERT INTO stage3.autorite_parent( intitule ) VALUES ('Directeurs Généreaux');
INSERT INTO stage3.autorite_parent( intitule ) VALUES ('Sécrétaire Général');
INSERT INTO stage3.autorite_parent( intitule ) VALUES ('Ministère');
INSERT INTO stage3.domaine( nom_domaine ) VALUES ('Informatique');
INSERT INTO stage3.domaine( nom_domaine ) VALUES ('Marketing');
INSERT INTO stage3.domaine( nom_domaine ) VALUES ('Finances et comptabilité');
INSERT INTO stage3.domaine( nom_domaine ) VALUES ('Communication Marketing');
INSERT INTO stage3.autorite_enfant( intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ('Direction des Ressources Humaines', 'DRH', 2, 'mefstage22022@gmail.com', 'wswrgxbntbumffqs', '356');
INSERT INTO stage3.autorite_enfant( intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ('Direction des Systèmes d''Informations', 'DSI', 2, 'dyranjohns@gmail.com', 'wswrgxbntbumffqs', '413');
INSERT INTO stage3.autorite_enfant( intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ('Direction Générales des Impots', 'DGI', 2, 'johnsirintsoa18@gmail.com', 'wswrgxbntbumffqs', '123');
INSERT INTO stage3.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('RANDRIANARISON', 'Johns', '341777887', 'johnsirintsoa18@gmail.com', '112112112', 4, 'curriculum_vitae_1668365659799_decret_782_96.pdf', 'lettre_motivation_1668365659804_decret_782_96.pdf', 'lettre_introduction_1668365659808_decret_782_96.pdf', 'Je suis un étudiant en première année', 2, 1);
INSERT INTO stage3.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('RAKOTONIRINA', 'Teo', '348899966', 'teo@gmail.com', '112112112', 5, 'curriculum_vitae_1668366150840_Les nombres rationnels.pdf', 'lettre_motivation_1668366150968_Les nombres rationnels.pdf', 'lettre_introduction_1668366150973_Les nombres rationnels.pdf', 'Je suis désolé', 3, 3);
INSERT INTO stage3.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('RANAIVOSOA', 'Tiana', '348899966', 'teo@gmail.com', '112112112', 5, 'curriculum_vitae_1668366340054_Les nombres rationnels.pdf', 'lettre_motivation_1668366340061_Les nombres rationnels.pdf', 'lettre_introduction_1668366340067_Les nombres rationnels.pdf', 'Je suis désolé', 3, 1);
INSERT INTO stage3.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('NAIVOSOA', 'Nirina', '345677889', 'naivosoa@gmail.com', '112112112', 3, 'curriculum_vitae_1668400143631_Les nombres rationnels.pdf', 'lettre_motivation_1668400143714_Les nombres rationnels.pdf', 'lettre_introduction_1668400143721_Les nombres rationnels.pdf', 'Je suis la ', 1, 2);
INSERT INTO stage3.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ( 'FIFIDIA', 'Fy', '345677889', 'fifidia@gmail.com', '112112112', 4, 'curriculum_vitae_1668402706992_Les nombres rationnels.pdf', 'lettre_motivation_1668402707078_Les nombres rationnels.pdf', 'lettre_introduction_1668402707083_Les nombres rationnels.pdf', 'bring it on', 4, 1);
INSERT INTO stage3.entretien_demande_stage( date_debut, date_fin, time_debut, time_fin, id_demande_stage ) VALUES ( '2022-11-28', '2022-11-28', '14:10:00', '14:20:00', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 157, 'Monday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 158, 'Monday', '13:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 159, 'Tuesday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 160, 'Tuesday', '13:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 161, 'Wednesday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 162, 'Wednesday', '13:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 163, 'Thursday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 164, 'Thursday', '13:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 165, 'Friday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage3.jour_ouvrable( id, jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 166, 'Friday', '13:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage3.non_disponibilite_autorite_date( date_non_dispo_debut, date_non_dispo_fin, id_autorite_enfant, time_debut, time_fin) VALUES ( '2022-11-28', '2022-11-28', 1, '08:00:00', '08:40:00');
INSERT INTO stage3.non_disponibilite_autorite_date( date_non_dispo_debut, date_non_dispo_fin, id_autorite_enfant, time_debut, time_fin) VALUES ( '2022-11-28', '2022-11-28', 1, '10:10:00', '10:40:00');
INSERT INTO stage3.non_disponibilite_autorite_jour( jour, time_non_dispo_jour_debut, time_non_dispo_jour_fin ) VALUES ( 'Monday', '13:00:00', '14:00:00');
INSERT INTO stage3.non_disponibilite_autorite_jour( jour, time_non_dispo_jour_debut, time_non_dispo_jour_fin ) VALUES ( 'Wednesday', '15:30:00', '16:00:00');
INSERT INTO stage3.heure_audience_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 1, '08:00:00', '08:30:00', 157);
INSERT INTO stage3.heure_audience_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 2, '08:30:00', '09:00:00', 157);
INSERT INTO stage3.heure_audience_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 3, '09:00:00', '09:30:00', 157);
INSERT INTO stage3.heure_audience_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 4, '09:30:00', '10:00:00', 157);
INSERT INTO stage3.heure_audience_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 5, '10:00:00', '10:30:00', 157);
INSERT INTO stage3.heure_audience_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 6, '10:30:00', '11:00:00', 157);
INSERT INTO stage3.heure_audience_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 7, '11:00:00', '11:30:00', 157);
INSERT INTO stage3.heure_audience_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 8, '11:30:00', '12:00:00', 157);
INSERT INTO stage3.heure_audience_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 25, '13:00:00', '13:30:00', 158);
INSERT INTO stage3.heure_audience_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 26, '13:30:00', '14:00:00', 158);
INSERT INTO stage3.heure_audience_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 27, '14:00:00', '14:30:00', 158);
INSERT INTO stage3.heure_audience_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 28, '14:30:00', '15:00:00', 158);
INSERT INTO stage3.heure_audience_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 29, '15:00:00', '15:30:00', 158);
INSERT INTO stage3.heure_audience_disponible( id, heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( 30, '15:30:00', '16:00:00', 158);
INSERT INTO stage3.demande_audience_autorite(date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, motif, action) VALUES ('2022-11-28', '2022-11-28', '15:00:00', '15:30:00', 1, 'Hello world', 0);
INSERT INTO stage3.demande_audience_autorite(date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, motif, action) VALUES ('2022-11-28', '2022-11-28', '14:10:00', '14:40:00', 2, 'TEST', 1);
INSERT INTO stage3.demande_audience_autorite(date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, motif, action) VALUES ('2022-11-28', '2022-11-28', '14:45:00', '15:10:00', 3, 'TAEST', 1);
INSERT INTO stage3.demande_audience_autorite(date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, motif, action) VALUES ('2022-11-28', '2022-11-28', '15:40:00', '15:50:00', 3, 'TEAWST', 0);
INSERT INTO stage3.demande_audience_autorite(date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, motif, action) VALUES ('2022-11-28', '2022-11-28', '15:30:00', '15:40:00', 2, 'Dossier maika', 0);
INSERT INTO stage3.demande_audience_public( date_event_debut, motif, date_event_fin, time_event_debut, time_event_fin, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-11-28', 'TEST 2510', '2022-11-28', '08:10:00', '08:15:00', 2, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'johns', 'session669.84399043559464');
INSERT INTO stage3.demande_audience_public( date_event_debut, motif, date_event_fin, time_event_debut, time_event_fin, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-11-28', 'Test 21', '2022-11-28', '08:20:00', '08:30:00', 1, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'johns', 'session36.35297770114687');
INSERT INTO stage3.demande_audience_public( date_event_debut, motif, date_event_fin, time_event_debut, time_event_fin, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-11-28', 'TEST 9 Novembre', '2022-11-28', '08:40:00', '08:50:00', 0, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'Jojo', 'session898.2515433898981');
INSERT INTO stage3.demande_audience_public( date_event_debut, motif, date_event_fin, time_event_debut, time_event_fin, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-11-28', 'TEST 15 Novembre',  '2022-11-28', '08:55:00', '09:00:00', 1, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'johns', 'session669.8439904355946');
INSERT INTO stage3.demande_audience_public( date_event_debut, motif, date_event_fin, time_event_debut, time_event_fin, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-11-28', 'Resaka matotra',  '2022-11-28', '09:10:00', '09:20:00', 0, '112112112', '0385699878', 'fifidia@gmail.com', 'RAKOTONIRINA', 'Teo', 'session36.35297770114687');
INSERT INTO stage3.demande_audience_public( date_event_debut, motif, date_event_fin, time_event_debut, time_event_fin, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( '2022-11-28', 'Resaka matotra',  '2022-11-28', '09:25:00', '09:30:00', 0, '112112112', '0385699878', 'fifidia@gmail.com', 'RAKOTONIRINA', 'Teo', 'session36.35297770114687');