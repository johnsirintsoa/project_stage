CREATE SCHEMA stage4;

CREATE TABLE stage4.autorite_parent ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	intitule             VARCHAR(200)  NOT NULL    
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage4.demande_audience_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_autorite_enfant_sender INT  NOT NULL    ,
	motif                VARCHAR(200)  NOT NULL    ,
	action               INT  NOT NULL DEFAULT 0   
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage4.demande_audience_public ( 
	motif                VARCHAR(200)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	action               INT  NOT NULL DEFAULT 0   ,
	cin                  VARCHAR(15)  NOT NULL    ,
	numero_telephone     VARCHAR(10)  NOT NULL    ,
	email                VARCHAR(200)  NOT NULL    ,
	nom                  VARCHAR(30)  NOT NULL    ,
	prenom               VARCHAR(30)  NOT NULL    ,
	session_navigateur   VARCHAR(100)  NOT NULL    
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage4.domaine ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nom_domaine          VARCHAR(30)  NOT NULL    
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage4.jour_ferie ( 
	nom_evenement        VARCHAR(30)      ,
	numero_du_jour       VARCHAR(20)      ,
	mois_du_jour         VARCHAR(20)      ,
	time_event_debut     TIME  NOT NULL    ,
	time_event_fin       TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage4.autorite_enfant ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	intitule             VARCHAR(200)  NOT NULL    ,
	intitule_code        VARCHAR(10)  NOT NULL    ,
	id_autorite_parent   INT  NOT NULL    ,
	addresse_electronique VARCHAR(200)  NOT NULL    ,
	mot_de_passe_mailing VARCHAR(100)  NOT NULL    ,
	porte                VARCHAR(5)  NOT NULL    ,
	CONSTRAINT fk_autorite_enfant_autorite_parent FOREIGN KEY ( id_autorite_parent ) REFERENCES stage4.autorite_parent( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage4.demande_stage ( 
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
	CONSTRAINT fk_demande_stage_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage4.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_demande_stage_domaine FOREIGN KEY ( id_domaine ) REFERENCES stage4.domaine( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage4.jour_ouvrable ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	jour                 VARCHAR(15)  NOT NULL    ,
	time_debut           TIME  NOT NULL    ,
	time_fin             TIME  NOT NULL    ,
	partie_du_jour       VARCHAR(15)  NOT NULL    ,
	id_autorite          INT  NOT NULL    ,
	CONSTRAINT fk_jour_ouvrable_id_autorite_autorite_enfant FOREIGN KEY ( id_autorite ) REFERENCES stage4.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage4.profil ( 
	mot_de_passe         VARCHAR(255)  NOT NULL    ,
	nom_utilisateur      VARCHAR(30)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	est_administrateur   SMALLINT  NOT NULL DEFAULT 0   ,
	id_autorite_enfant   INT  NOT NULL    ,
	CONSTRAINT fk_profil_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage4.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE stage4.heure_disponible ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	id_jour_ouvrable     INT  NOT NULL    ,
	CONSTRAINT fk_heure_audience_disponible FOREIGN KEY ( id_jour_ouvrable ) REFERENCES stage4.jour_ouvrable( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage4.non_disponibilite_autorite_date ( 
	date_non_dispo       DATE  NOT NULL    ,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_heure_dispo       INT  NOT NULL    ,
	CONSTRAINT fk_non_disponibilite_autorite_id_heure_dispo FOREIGN KEY ( id_heure_dispo ) REFERENCES stage4.heure_disponible( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage4.non_disponibilite_autorite_jour ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_heure_dispo       INT  NOT NULL    ,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	CONSTRAINT fk_heure_dispo_non_dispo_autorite_jour_id_heure_dispo FOREIGN KEY ( id_heure_dispo ) REFERENCES stage4.heure_disponible( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage4.dm_aud_public_heure_dispo ( 
	id_aud_public        INT      ,
	id_heure_dispo       INT  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	date_audience        DATE  NOT NULL    ,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	CONSTRAINT fk_dm_aud_public_heure_dispo FOREIGN KEY ( id_aud_public ) REFERENCES stage4.demande_audience_public( id ) ON DELETE SET NULL ON UPDATE SET NULL,
	CONSTRAINT fk_dm_aud_public_heure_dispo_id_heure_dispo FOREIGN KEY ( id_heure_dispo ) REFERENCES stage4.heure_disponible( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage4.entretien_demande_stage ( 
	date_entretien       DATE  NOT NULL    ,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_demande_stage     INT  NOT NULL    ,
	id_heure_dispo       INT  NOT NULL    ,
	CONSTRAINT fk_entretien_demande_stage FOREIGN KEY ( id_demande_stage ) REFERENCES stage4.demande_stage( id ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_entretien_demande_stage_heure_dispo FOREIGN KEY ( id_heure_dispo ) REFERENCES stage4.heure_disponible( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage4.heure_dispo_dm_aud_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_heure_dispo       INT  NOT NULL    ,
	id_dm_aud_autorite   INT  NOT NULL    ,
	date_audience        DATE  NOT NULL    ,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	CONSTRAINT fk_heure_dispo_dm_aud_autorite_id_dm_aud_autorite FOREIGN KEY ( id_dm_aud_autorite ) REFERENCES stage4.demande_audience_autorite( id ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_heure_dispo_dm_aud_autorite_id_heure_dispo FOREIGN KEY ( id_heure_dispo ) REFERENCES stage4.heure_disponible( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE INDEX fk_autorite_enfant_autorite_parent ON stage4.autorite_enfant ( id_autorite_parent );

CREATE INDEX fk_demande_stage_autorite_enfant ON stage4.demande_stage ( id_autorite_enfant );

CREATE INDEX fk_demande_stage_domaine ON stage4.demande_stage ( id_domaine );

CREATE INDEX fk_jour_ouvrable_id_autorite_autorite_enfant ON stage4.jour_ouvrable ( id_autorite );

CREATE INDEX fk_profil_autorite_enfant ON stage4.profil ( id_autorite_enfant );

CREATE INDEX fk_heure_audience_disponible ON stage4.heure_disponible ( id_jour_ouvrable );

CREATE INDEX fk_non_disponibilite_autorite_id_heure_dispo ON stage4.non_disponibilite_autorite_date ( id_heure_dispo );

CREATE INDEX fk_heure_dispo_non_dispo_autorite_jour_id_heure_dispo ON stage4.non_disponibilite_autorite_jour ( id_heure_dispo );

CREATE INDEX fk_dm_aud_public_heure_dispo_id_heure_dispo ON stage4.dm_aud_public_heure_dispo ( id_heure_dispo );

CREATE INDEX fk_dm_aud_public_heure_dispo ON stage4.dm_aud_public_heure_dispo ( id_aud_public );

CREATE INDEX fk_entretien_demande_stage ON stage4.entretien_demande_stage ( id_demande_stage );

CREATE INDEX fk_entretien_demande_stage_heure_dispo ON stage4.entretien_demande_stage ( id_heure_dispo );

CREATE INDEX fk_heure_dispo_dm_aud_autorite_id_dm_aud_autorite ON stage4.heure_dispo_dm_aud_autorite ( id_dm_aud_autorite );

CREATE INDEX fk_heure_dispo_dm_aud_autorite_id_heure_dispo ON stage4.heure_dispo_dm_aud_autorite ( id_heure_dispo );

CREATE  PROCEDURE `ajouter_audience_public`(IN session_navigateur VARCHAR(100),
IN nom varchar(30),
IN prenom varchar(30),
IN cin varchar(15),
IN numero_telephone varchar(10),
IN email varchar(30),
IN id_heure_dispo INT,
IN motif VARCHAR(200),
IN date_audience date,
IN heure_debut time,
IN heure_fin time,
IN id_autorite int)
BEGIN 
	SET @session_navigateur = session_navigateur; 
	SET @nom = (SELECT UPPER(nom)); 
	SET @prenom = (SELECT LOWER(prenom)); 
	SET @cin = cin; 
	SET @numero_telephone = numero_telephone; 
	SET @email = email; 
	SET @motif = motif; 
	SET @id_hd = id_heure_dispo; 
	SET @id_autorite = id_autorite;
	SET @date_audience = date_audience; 
	SET @hd = heure_debut;
	SET @hf = heure_fin;
	set @id_audience = 0;	


	-- Select l'id la plus recent params[cin,session_navigateur]
	set @id_audience = (SELECT max(dap.id) FROM stage4.demande_audience_public dap where dap.cin = @cin and dap.session_navigateur = @session_navigateur);
	
	IF @id_audience IS NULL THEN
		
		-- Ajouter Audience
		INSERT INTO demande_audience_public
		(nom, prenom,numero_telephone, email,motif,cin,  session_navigateur) 
		VALUES (@nom, @prenom,@numero_telephone, @email,@motif,@cin, @session_navigateur);

		-- Select l'id la plus recent params[cin,session_navigateur]
		set @id_audience_tmp = (SELECT max(dap.id) FROM stage4.demande_audience_public dap where dap.cin = @cin and dap.session_navigateur = @session_navigateur);

		-- Verifier si l'audience existe et aussi qu'elle est relié
		set @var = (SELECT 
		count(daphd.id)
		FROM
		heure_disponible hd
		LEFT JOIN dm_aud_public_heure_dispo daphd on hd.id = daphd.id_heure_dispo 
		where daphd.id_aud_public = @id_audience_tmp);

		IF @var > 0 THEN
			select 'Votre audience a déja été ajoutée' as message;
		else
			-- Ajouter audience et heure disponible
			INSERT INTO stage4.dm_aud_public_heure_dispo
			( id_aud_public, id_heure_dispo, date_audience, heure_debut, heure_fin) 
			VALUES (@id_audience_tmp, @id_hd ,@date_audience,@hd,@hf);
			SELECT 'Audience a été ajouté avec succès' as message;
		END IF;	

	ELSE  
		-- Verifier si l'audience existe et aussi qu'elle est relié
		set @var = (SELECT 
		count(daphd.id)
		FROM
		heure_disponible hd
		LEFT JOIN dm_aud_public_heure_dispo daphd on hd.id = daphd.id_heure_dispo 
		where daphd.id_aud_public = @id_audience);

		IF @var > 0 THEN
			select 'Votre audience a déja été ajoutée' as message;
		else
			-- Ajouter audience et heure disponible
			INSERT INTO stage4.dm_aud_public_heure_dispo
			( id_aud_public, id_heure_dispo, date_audience, heure_debut, heure_fin) 
			VALUES (@id_audience, @id_hd ,@date_audience,@hd,@hf);
			SELECT 'Audience a été ajouté avec succès' as message;
		END IF;
	END IF;
END

CREATE  PROCEDURE `ajouter_heure_disponible_autorite`(IN heure_debut time,IN heure_fin time,IN duree_disponibilite time,IN id_jour_ouvrable int)
BEGIN
	DECLARE hds,hfs,das INT;
	DECLARE tmp_hfs int DEFAULT 0;
	set @hds = time_to_sec(heure_debut);
	set @hfs = time_to_sec(heure_fin);
	set @das = time_to_sec(duree_disponibilite);
	WHILE @hds < @hfs DO
		set @tmp_hfs = @hds + @das;
		INSERT INTO stage4.heure_disponible(heure_debut, heure_fin, id_jour_ouvrable) VALUES (sec_to_time(@hds),sec_to_time(@tmp_hfs),id_jour_ouvrable);
		set @hds = @tmp_hfs;
	END WHILE;
END

CREATE  PROCEDURE `ajouter_jour_ouvrable_tous_les_jours`(IN heure_debut time,IN heure_fin time,IN id_autorite int)
BEGIN
    INSERT INTO stage4.jour_ouvrable(jour, heure_debut, heure_fin,  id_autorite) VALUES ('Monday', heure_debut,heure_fin ,id_autorite);
    INSERT INTO stage4.jour_ouvrable(jour, heure_debut, heure_fin,  id_autorite) VALUES ('Tuesday', heure_debut,heure_fin ,id_autorite);
    INSERT INTO stage4.jour_ouvrable(jour, heure_debut, heure_fin,  id_autorite) VALUES ('Wednesday', heure_debut,heure_fin ,id_autorite);
    INSERT INTO stage4.jour_ouvrable(jour, heure_debut, heure_fin,  id_autorite) VALUES ('Thursday', heure_debut,heure_fin ,id_autorite);
    INSERT INTO stage4.jour_ouvrable(jour, heure_debut, heure_fin,  id_autorite) VALUES ('Friday', heure_debut,heure_fin ,id_autorite);
END

CREATE  PROCEDURE `ajouter_jour_ouvrable_tous_les_jours`(IN heure_debut time,IN heure_fin time,IN partie_du_jour varchar(15),IN id_autorite int)
BEGIN
    INSERT INTO stage4.jour_ouvrable(jour, heure_debut, heure_fin, partie_du_jour, id_autorite) VALUES ('Monday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage4.jour_ouvrable(jour, heure_debut, heure_fin, partie_du_jour, id_autorite) VALUES ('Tuesday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage4.jour_ouvrable(jour, heure_debut, heure_fin, partie_du_jour, id_autorite) VALUES ('Wednesday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage4.jour_ouvrable(jour, heure_debut, heure_fin, partie_du_jour, id_autorite) VALUES ('Thursday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage4.jour_ouvrable(jour, heure_debut, heure_fin, partie_du_jour, id_autorite) VALUES ('Friday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
END


CREATE  PROCEDURE `ajouter_jour_ouvrable_tous_les_jours`(IN heure_debut time,IN heure_fin time,IN partie_du_jour varchar(15),IN id_autorite int)
BEGIN
    INSERT INTO stage4.jour_ouvrable(jour, time_debut, time_fin, partie_du_jour, id_autorite) VALUES ('Monday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage4.jour_ouvrable(jour, time_debut, time_fin, partie_du_jour, id_autorite) VALUES ('Tuesday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage4.jour_ouvrable(jour, time_debut, time_fin, partie_du_jour, id_autorite) VALUES ('Wednesday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage4.jour_ouvrable(jour, time_debut, time_fin, partie_du_jour, id_autorite) VALUES ('Thursday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage4.jour_ouvrable(jour, time_debut, time_fin, partie_du_jour, id_autorite) VALUES ('Friday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
END

CREATE  PROCEDURE `liste_place_disponible_public_par_jour`(IN date_du_jour date,IN session_navigateur varchar(50),in id_autorite int)
BEGIN 
	SET @session_navigateur = session_navigateur; 
	SET @id_autorite = id_autorite; 
	SET @date_du_jour = date_du_jour; 
	set @jour_UTF8 = CONVERT(DAYNAME(@date_du_jour) USING utf8); 
	set @nbr_jour_ferie = (select count(jf.id) from jour_ferie jf where CONVERT((concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = @date_du_jour); 

	IF @nbr_jour_ferie > 0 THEN 
		(SELECT 
		had.id as id_heure_disponible, 
		CONCAT(@date_du_jour,'T',had.heure_debut) as start, 
		CONCAT(@date_du_jour,'T',had.heure_fin) as end, 
		had.heure_debut as heure_debut,
		had.heure_fin as heure_fin,
		dap.id as id, 
		hd_dap.id as id_dm_aud_public_heure_dispo,
		hd_dap.date_audience,
        hd_dap.heure_debut,
        hd_dap.heure_fin,
        dap.motif as title, 
        dap.nom,
        dap.prenom,
        dap.cin,
        dap.numero_telephone,
        dap.email, 
        CASE 
            WHEN dap.action = 0 THEN 'Non validé' 
            WHEN dap.action = 1 THEN 'Validé' 
            WHEN dap.action = 2 THEN 'Reporté' 
            ELSE 'Aucune' 
        END as status_audience, 
        CASE 
            WHEN dap.session_navigateur = @session_navigateur and dap.action = 0 THEN "#407DFF" 
            WHEN dap.session_navigateur = @session_navigateur and dap.action = 1 THEN "#FF0018" 
            ELSE '#FF0018' END as color, 
        CASE
            WHEN dap.session_navigateur = @session_navigateur and dap.action = 0 THEN "#407DFF" 
            WHEN dap.session_navigateur = @session_navigateur and dap.action = 1 THEN "#FF0018" 
            ELSE '#FF0018' END as color_status, 
        false editable 
        FROM stage4.heure_disponible had 
        JOIN stage4.dm_aud_public_heure_dispo hd_dap on had.id = hd_dap.id_heure_dispo and hd_dap.date_audience = @date_du_jour 
        JOIN stage4.demande_audience_public dap on hd_dap.id_aud_public = dap.id 
        where dap.action >=0 and dap.action <=1 GROUP by dap.id ) 

        union 

        (SELECT 
        hd.id,
        CONCAT(@date_du_jour,'T',hd.heure_debut) as start,
        CONCAT(@date_du_jour,'T',hd.heure_fin) as end, 
		hd.heure_debut as hd,
		hd.heure_fin as hf,
        '' id, 
		dm_aud_pub_hd.id as id_dm_aud_public_heure_dispo,
        '' date_audience, 
        '' heure_debut, 
        '' heure_fin, 
        'Disponible' title, 
        '' nom, 
        '' prenom, 
        '' cin, 
        '' numero_telephone, 
        '' email, 
        '' status_audience, 
        '#0AA913' color, 
        '' color_status, 
        false editable 
        FROM stage4.heure_disponible hd 
        LEFT JOIN jour_ouvrable jo on hd.id_jour_ouvrable = jo.id and jo.jour = @jour_UTF8 
        LEFT JOIN heure_dispo_dm_aud_autorite hddaa on hd.id = hddaa.id_heure_dispo and hddaa.date_audience = @date_du_jour and jo.jour = @jour_UTF8 
        LEFT JOIN dm_aud_public_heure_dispo dm_aud_pub_hd on hd.id = dm_aud_pub_hd.id_heure_dispo and dm_aud_pub_hd.date_audience = @date_du_jour and jo.jour = @jour_UTF8 
  	  LEFT JOIN demande_audience_public dap on dm_aud_pub_hd.id_aud_public = dap.id      
		LEFT JOIN non_disponibilite_autorite_date ndad on hd.id = ndad.id_heure_dispo and ndad.date_non_dispo = @date_du_jour and jo.jour = @jour_UTF8 
        LEFT JOIN non_disponibilite_autorite_jour ndaj on hd.id = ndaj.id_heure_dispo and jo.jour = @jour_UTF8 
        LEFT JOIN entretien_demande_stage eds on hd.id = eds.id_heure_dispo and eds.date_entretien = @date_du_jour and jo.jour = @jour_UTF8 
        WHERE 
        jo.id_autorite = @id_autorite 
        and hddaa.id IS NULL 
        and dm_aud_pub_hd.id IS NULL 
        and ndad.id IS NULL 
        and ndaj.id IS NULL 
        and eds.id IS NULL 
		and dap.id IS NULL
        and (
			(select jf.time_event_debut from jour_ferie jf where CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = @date_du_jour ) NOT BETWEEN hd.heure_debut and hd.heure_fin 
			and (select jf.time_event_fin from jour_ferie jf where CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = @date_du_jour ) NOT BETWEEN hd.heure_debut and hd.heure_fin 
			and hd.heure_debut NOT BETWEEN (select jf.time_event_debut from jour_ferie jf where CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = @date_du_jour ) and (select jf.time_event_fin from jour_ferie jf where CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = @date_du_jour) 
			and hd.heure_fin NOT BETWEEN (select jf.time_event_debut from jour_ferie jf where CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = @date_du_jour) and (select jf.time_event_fin from jour_ferie jf where CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = @date_du_jour) 
		));
        
    ELSE 
        (SELECT 
        had.id as id_heure_disponible,
        CONCAT(@date_du_jour,'T',had.heure_debut) as start, 
		CONCAT(@date_du_jour,'T',had.heure_fin) as end, 
		had.heure_debut as hd,
		had.heure_fin as hf,
        dap.id as id, 
		hd_dap.id as id_dm_aud_public_heure_dispo,
        hd_dap.date_audience, 
        hd_dap.heure_debut, 
        hd_dap.heure_fin, 
        dap.motif as title, 
        dap.nom, 
        dap.prenom, 
        dap.cin, 
        dap.numero_telephone, 
        dap.email, 
        CASE 
            WHEN dap.action = 0 THEN 'Non validé' 
            WHEN dap.action = 1 THEN 'Validé' 
            WHEN dap.action = 2 THEN 'Reporté' 
            ELSE 'Aucune' 
        END as status_audience,
        CASE 
            WHEN dap.session_navigateur = @session_navigateur and dap.action = 0 THEN "#407DFF" 
            WHEN dap.session_navigateur = @session_navigateur and dap.action = 1 THEN "#FF0018" 
            ELSE '#FF0018' 
        END as color, 
        CASE 
            WHEN dap.session_navigateur = @session_navigateur and dap.action = 0 THEN "#407DFF" 
            WHEN dap.session_navigateur = @session_navigateur and dap.action = 1 THEN "#FF0018" 
            ELSE '#FF0018'
        END as color_status, 
        false editable 
        FROM stage4.heure_disponible had 
        JOIN stage4.dm_aud_public_heure_dispo hd_dap on had.id = hd_dap.id_heure_dispo and hd_dap.date_audience = @date_du_jour 
        JOIN stage4.demande_audience_public dap on hd_dap.id_aud_public = dap.id
        where dap.session_navigateur = @session_navigateur and dap.action >=0 and dap.action <=1 GROUP by dap.id ) 
        
        union 
        
        (SELECT 
        hd.id, 
        CONCAT(@date_du_jour,'T',hd.heure_debut) as start, 
        CONCAT(@date_du_jour,'T',hd.heure_fin) as end, 
		hd.heure_debut as hd,
		hd.heure_fin as hf,
        '' id, 
		dm_aud_pub_hd.id as id_dm_aud_public_heure_dispo,
        '' date_audience, 
        '' heure_debut, 
        '' heure_fin, 
        'Disponible' title, 
        '' nom, 
        '' prenom, 
        '' cin, 
        '' numero_telephone, 
        '' email, 
        '' status_audience, 
        '#0AA913' color, 
        '' color_status, 
        false editable 
        FROM stage4.heure_disponible hd 
        LEFT JOIN jour_ouvrable jo on hd.id_jour_ouvrable = jo.id and jo.jour = @jour_UTF8 
        LEFT JOIN heure_dispo_dm_aud_autorite hddaa on hd.id = hddaa.id_heure_dispo and hddaa.date_audience = @date_du_jour and jo.jour = @jour_UTF8 
        LEFT JOIN dm_aud_public_heure_dispo dm_aud_pub_hd on hd.id = dm_aud_pub_hd.id_heure_dispo and dm_aud_pub_hd.date_audience = @date_du_jour and jo.jour = @jour_UTF8 
  	  LEFT JOIN demande_audience_public dap on dm_aud_pub_hd.id_aud_public = dap.id      
		LEFT JOIN non_disponibilite_autorite_date ndad on hd.id = ndad.id_heure_dispo and ndad.date_non_dispo = @date_du_jour and jo.jour = @jour_UTF8 
        LEFT JOIN non_disponibilite_autorite_jour ndaj on hd.id = ndaj.id_heure_dispo and jo.jour = @jour_UTF8 
        LEFT JOIN entretien_demande_stage eds on hd.id = eds.id_heure_dispo and eds.date_entretien = @date_du_jour and jo.jour = @jour_UTF8 
        WHERE jo.id_autorite = @id_autorite 
        and hddaa.id IS NULL 
        and dm_aud_pub_hd.id IS NULL 
        and ndad.id IS NULL 
        and ndaj.id IS NULL 
        and eds.id IS NULL 
		and dap.id IS NULL
        ) ; 
    END IF; 
END

CREATE  PROCEDURE `modifier_audience_public_front`(IN session_navigateur VARCHAR(100),
IN nom varchar(30),
IN prenom varchar(30),
IN cin varchar(15),
IN numero_telephone varchar(10),
IN email varchar(30),
IN motif VARCHAR(200),
IN id_audience INT,
IN id_heure_dispo INT,
IN id_dm_aud_public_heure_dispo INT,
IN id_autorite int)
BEGIN 
	set @heure_debut = (SELECT heure_debut from heure_disponible where id = id_heure_dispo);
	set @heure_fin = (SELECT heure_fin from heure_disponible where id = id_heure_dispo);	
	
	UPDATE demande_audience_public SET nom = nom , prenom = prenom, cin = cin, numero_telephone = numero_telephone, email = email where id = id_audience;
	UPDATE dm_aud_public_heure_dispo SET id_heure_dispo = id_heure_dispo, heure_debut = @heure_debut, heure_fin = @heure_fin where id = id_dm_aud_public_heure_dispo;
	SELECT 'Votre audience a bien été modifiée' as message;
END

CREATE  PROCEDURE `supprimer_aud_public`(IN id INT)
BEGIN 
	SET @id_aud = id;
	DELETE FROM demande_audience_public where demande_audience_public.id = @id_aud;
	DELETE FROM dm_aud_public_heure_dispo WHERE dm_aud_public_heure_dispo.id_aud_public IS NULL;
END

INSERT INTO stage4.autorite_parent(intitule ) VALUES ('Chef de service');
INSERT INTO stage4.autorite_parent(intitule ) VALUES ('Directeurs');
INSERT INTO stage4.autorite_parent(intitule ) VALUES ('Directeurs Généreaux');
INSERT INTO stage4.autorite_parent(intitule ) VALUES ('Sécrétaire Général');
INSERT INTO stage4.autorite_parent(intitule ) VALUES ('Ministère');
INSERT INTO stage4.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 1, 1, 'Hello world', 0);
INSERT INTO stage4.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 2, 2, 'TEST', 1);
INSERT INTO stage4.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 3, 3, 'TAEST', 1);
INSERT INTO stage4.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 4, 3, 'TEAWST', 0);
INSERT INTO stage4.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 5, 2, 'Dossier maika', 0);
INSERT INTO stage4.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'hih', 18, 0, '121212', '0341752875', 'alafia.saifoudine@gmail.com', 'NAIVOSOA', 'adfa', 'session884.5824087825326');
INSERT INTO stage4.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Hello world ???? ', 19, 0, '5545789628', '0341752875', 'joris@gmail.com', 'NAIVOSOA', 'Joris', 'session884.5824087825326');
INSERT INTO stage4.domaine( nom_domaine ) VALUES ('Informatique');
INSERT INTO stage4.domaine( nom_domaine ) VALUES ('Marketing');
INSERT INTO stage4.domaine( nom_domaine ) VALUES ('Finances et comptabilité');
INSERT INTO stage4.domaine( nom_domaine ) VALUES ('Communication Marketing');
INSERT INTO stage4.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin) VALUES ( 'Toussaint', '11', '11', '00:00:01', '23:59:00');
INSERT INTO stage4.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin) VALUES ( 'Noel', '25', '12', '08:00:00', '12:00:00');
INSERT INTO stage4.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin) VALUES ( 'Fin d''année', '31', '12', '14:00:00', '16:00:00');
INSERT INTO stage4.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin) VALUES ( 'Nouvel an', '11', '1', '08:00:00', '12:00:00');
INSERT INTO stage4.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin) VALUES ( 'Black Friday', '28', '11', '11:40:00', '12:10:00');
INSERT INTO stage4.autorite_enfant( intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ( 'Direction des Ressources Humaines', 'DRH', 2, 'mefstage22022@gmail.com', 'wswrgxbntbumffqs', '356');
INSERT INTO stage4.autorite_enfant( intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ( 'Direction des Systèmes d''Informations', 'DSI', 2, 'dyranjohns@gmail.com', 'wswrgxbntbumffqs', '413');
INSERT INTO stage4.autorite_enfant( intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ( 'Direction Générales des Impots', 'DGI', 2, 'johnsirintsoa18@gmail.com', 'wswrgxbntbumffqs', '123');
INSERT INTO stage4.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('RANDRIANARISON', 'Johns', '341777887', 'johnsirintsoa18@gmail.com', '112112112', 4, 'curriculum_vitae_1668365659799_decret_782_96.pdf', 'lettre_motivation_1668365659804_decret_782_96.pdf', 'lettre_introduction_1668365659808_decret_782_96.pdf', 'Je suis un étudiant en première année', 2, 1);
INSERT INTO stage4.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('RAKOTONIRINA', 'Teo', '348899966', 'teo@gmail.com', '112112112', 5, 'curriculum_vitae_1668366150840_Les nombres rationnels.pdf', 'lettre_motivation_1668366150968_Les nombres rationnels.pdf', 'lettre_introduction_1668366150973_Les nombres rationnels.pdf', 'Je suis désolé', 3, 3);
INSERT INTO stage4.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('RANAIVOSOA', 'Tiana', '348899966', 'teo@gmail.com', '112112112', 5, 'curriculum_vitae_1668366340054_Les nombres rationnels.pdf', 'lettre_motivation_1668366340061_Les nombres rationnels.pdf', 'lettre_introduction_1668366340067_Les nombres rationnels.pdf', 'Je suis désolé', 3, 1);
INSERT INTO stage4.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('NAIVOSOA', 'Nirina', '345677889', 'naivosoa@gmail.com', '112112112', 3, 'curriculum_vitae_1668400143631_Les nombres rationnels.pdf', 'lettre_motivation_1668400143714_Les nombres rationnels.pdf', 'lettre_introduction_1668400143721_Les nombres rationnels.pdf', 'Je suis la ', 1, 2);
INSERT INTO stage4.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('FIFIDIA', 'Fy', '345677889', 'fifidia@gmail.com', '112112112', 4, 'curriculum_vitae_1668402706992_Les nombres rationnels.pdf', 'lettre_motivation_1668402707078_Les nombres rationnels.pdf', 'lettre_introduction_1668402707083_Les nombres rationnels.pdf', 'bring it on', 4, 1);
INSERT INTO stage4.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Monday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage4.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Tuesday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage4.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Wednesday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage4.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Thursday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage4.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Friday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage4.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Monday', '14:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage4.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Tuesday', '14:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage4.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Wednesday', '14:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage4.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Thursday', '14:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage4.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Friday', '14:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('08:00:00', '08:30:00', 1);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('08:30:00', '09:00:00', 1);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('09:00:00', '09:30:00', 1);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('09:30:00', '10:00:00', 1);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('10:00:00', '10:30:00', 1);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('10:30:00', '11:00:00', 1);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('11:00:00', '11:30:00', 1);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('11:30:00', '12:00:00', 1);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('14:00:00', '14:30:00', 6);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:30:00', '15:00:00', 6);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:00:00', '15:30:00', 6);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:30:00', '16:00:00', 6);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '08:00:00', '08:30:00', 2);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '08:30:00', '09:00:00', 2);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '09:00:00', '09:30:00', 2);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '09:30:00', '10:00:00', 2);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '10:00:00', '10:30:00', 2);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '10:30:00', '11:00:00', 2);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '11:00:00', '11:30:00', 2);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '11:30:00', '12:00:00', 2);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:00:00', '14:30:00', 7);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:30:00', '15:00:00', 7);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:00:00', '15:30:00', 7);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:30:00', '16:00:00', 7);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '08:00:00', '08:30:00', 3);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '08:30:00', '09:00:00', 3);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '09:00:00', '09:30:00', 3);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '09:30:00', '10:00:00', 3);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '10:00:00', '10:30:00', 3);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '10:30:00', '11:00:00', 3);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '11:00:00', '11:30:00', 3);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '11:30:00', '12:00:00', 3);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:00:00', '14:30:00', 8);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:30:00', '15:00:00', 8);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:00:00', '15:30:00', 8);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:30:00', '16:00:00', 8);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '08:00:00', '08:30:00', 4);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '08:30:00', '09:00:00', 4);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '09:00:00', '09:30:00', 4);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '09:30:00', '10:00:00', 4);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '10:00:00', '10:30:00', 4);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '10:30:00', '11:00:00', 4);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '11:00:00', '11:30:00', 4);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '11:30:00', '12:00:00', 4);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:00:00', '14:30:00', 9);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:30:00', '15:00:00', 9);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:00:00', '15:30:00', 9);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:30:00', '16:00:00', 9);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '08:00:00', '08:30:00', 5);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '08:30:00', '09:00:00', 5);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '09:00:00', '09:30:00', 5);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '09:30:00', '10:00:00', 5);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '10:00:00', '10:30:00', 5);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '10:30:00', '11:00:00', 5);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '11:00:00', '11:30:00', 5);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '11:30:00', '12:00:00', 5);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:00:00', '14:30:00', 10);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:30:00', '15:00:00', 10);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:00:00', '15:30:00', 10);
INSERT INTO stage4.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:30:00', '16:00:00', 10);
INSERT INTO stage4.non_disponibilite_autorite_date( heure_debut, heure_fin, id_heure_dispo , id_date_disponible) VALUES ( (select id from date_disponible where date_disponible = '2022-12-08'), '08:00:00', '08:40:00', 1);
INSERT INTO stage4.non_disponibilite_autorite_date( heure_debut, heure_fin, id_heure_dispo , id_date_disponible) VALUES ( '2022-11-28', '10:10:00', '10:40:00', 5);
INSERT INTO stage4.non_disponibilite_autorite_date( heure_debut, heure_fin, id_heure_dispo , id_date_disponible) VALUES ( '2022-11-28', '08:00:00', '08:40:00', 2);
INSERT INTO stage4.non_disponibilite_autorite_date( heure_debut, heure_fin, id_heure_dispo , id_date_disponible) VALUES ( '2022-11-28', '10:10:00', '10:40:00', 6);
INSERT INTO stage4.non_disponibilite_autorite_jour( id, id_heure_dispo, heure_debut, heure_fin ) VALUES ( 1, 9, '14:20:00', '14:25:00');
INSERT INTO stage4.non_disponibilite_autorite_jour( id, id_heure_dispo, heure_debut, heure_fin ) VALUES ( 2, 10, '14:35:00', '14:50:00');
INSERT INTO stage4.non_disponibilite_autorite_jour( id, id_heure_dispo, heure_debut, heure_fin ) VALUES ( 3, 12, '15:30:00', '15:50:00');
INSERT INTO stage4.dm_aud_public_heure_dispo( id_aud_public, id_heure_dispo, id, date_audience, heure_debut, heure_fin ) VALUES ( 18, 1, 27, '2022-12-12', '08:00:00', '08:30:00');
INSERT INTO stage4.dm_aud_public_heure_dispo( id_aud_public, id_heure_dispo, id, date_audience, heure_debut, heure_fin ) VALUES ( 19, 58, 28, '2022-12-13', '08:30:00', '09:00:00');
INSERT INTO stage4.entretien_demande_stage( date_entretien, heure_debut, heure_fin, id, id_demande_stage, id_heure_dispo ) VALUES ( '2022-11-28', '10:20:00', '10:45:00', 1, 1, 5);
INSERT INTO stage4.entretien_demande_stage( date_entretien, heure_debut, heure_fin, id, id_demande_stage, id_heure_dispo ) VALUES ( '2022-11-28', '10:20:00', '10:45:00', 2, 1, 6);
INSERT INTO stage4.heure_dispo_dm_aud_autorite( id, id_heure_dispo, id_dm_aud_autorite, date_audience, heure_debut, heure_fin ) VALUES ( 1, 7, 1, '2022-10-28', '11:10:00', '11:20:00');
INSERT INTO stage4.heure_dispo_dm_aud_autorite( id, id_heure_dispo, id_dm_aud_autorite, date_audience, heure_debut, heure_fin ) VALUES ( 2, 9, 2, '2022-10-28', '14:20:00', '14:40:00');
INSERT INTO stage4.heure_dispo_dm_aud_autorite( id, id_heure_dispo, id_dm_aud_autorite, date_audience, heure_debut, heure_fin ) VALUES ( 3, 10, 2, '2022-11-28', '14:20:00', '14:40:00');
INSERT INTO stage4.heure_dispo_dm_aud_autorite( id, id_heure_dispo, id_dm_aud_autorite, date_audience, heure_debut, heure_fin ) VALUES ( 4, 10, 3, '2022-11-28', '14:15:00', '15:15:00');
INSERT INTO stage4.heure_dispo_dm_aud_autorite( id, id_heure_dispo, id_dm_aud_autorite, date_audience, heure_debut, heure_fin ) VALUES ( 5, 11, 3, '2022-11-28', '14:15:00', '15:15:00');