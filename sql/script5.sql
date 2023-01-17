CREATE SCHEMA stage5;

CREATE TABLE stage5.autorite_parent ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	intitule             VARCHAR(200)  NOT NULL    
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage5.demande_audience_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_autorite_enfant_sender INT  NOT NULL    ,
	motif                VARCHAR(200)  NOT NULL    ,
	action               INT  NOT NULL DEFAULT 0   
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage5.demande_audience_public ( 
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

CREATE TABLE stage5.domaine ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nom_domaine          VARCHAR(30)  NOT NULL    
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage5.jour_ferie ( 
	nom_evenement        VARCHAR(30)      ,
	numero_du_jour       VARCHAR(20)      ,
	mois_du_jour         VARCHAR(20)      ,
	time_event_debut     TIME  NOT NULL    ,
	time_event_fin       TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage5.autorite_enfant ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	intitule             VARCHAR(200)  NOT NULL    ,
	intitule_code        VARCHAR(10)  NOT NULL    ,
	id_autorite_parent   INT  NOT NULL    ,
	addresse_electronique VARCHAR(200)  NOT NULL    ,
	mot_de_passe_mailing VARCHAR(100)  NOT NULL    ,
	porte                VARCHAR(5)  NOT NULL    ,
	CONSTRAINT fk_autorite_enfant_autorite_parent FOREIGN KEY ( id_autorite_parent ) REFERENCES stage5.autorite_parent( id ) ON DELETE SET NULL ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage5.demande_stage ( 
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
	CONSTRAINT fk_demande_stage_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage5.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_demande_stage_domaine FOREIGN KEY ( id_domaine ) REFERENCES stage5.domaine( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage5.jour_ouvrable ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	jour                 VARCHAR(15)  NOT NULL    ,
	time_debut           TIME  NOT NULL    ,
	time_fin             TIME  NOT NULL    ,
	partie_du_jour       VARCHAR(15)  NOT NULL    ,
	id_autorite          INT  NOT NULL    ,
	CONSTRAINT fk_jour_ouvrable_id_autorite_autorite_enfant FOREIGN KEY ( id_autorite ) REFERENCES stage5.autorite_enfant( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;



CREATE TABLE stage5.heure_disponible ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	id_jour_ouvrable     INT  NOT NULL    ,
	CONSTRAINT fk_heure_audience_disponible FOREIGN KEY ( id_jour_ouvrable ) REFERENCES stage5.jour_ouvrable( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage5.non_disponibilite_autorite_date ( 
	date_non_dispo       DATE  NOT NULL    ,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_heure_dispo       INT  NOT NULL    ,
	CONSTRAINT fk_non_disponibilite_autorite_id_heure_dispo FOREIGN KEY ( id_heure_dispo ) REFERENCES stage5.heure_disponible( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage5.non_disponibilite_autorite_jour ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_heure_dispo       INT  NOT NULL    ,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	CONSTRAINT fk_heure_dispo_non_dispo_autorite_jour_id_heure_dispo FOREIGN KEY ( id_heure_dispo ) REFERENCES stage5.heure_disponible( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage5.dm_aud_public_heure_dispo ( 
	id_aud_public        INT      ,
	id_heure_dispo       INT  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	date_audience        DATE  NOT NULL    ,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	CONSTRAINT fk_dm_aud_public_heure_dispo FOREIGN KEY ( id_aud_public ) REFERENCES stage5.demande_audience_public( id ) ON DELETE SET NULL ON UPDATE SET NULL,
	CONSTRAINT fk_dm_aud_public_heure_dispo_id_heure_dispo FOREIGN KEY ( id_heure_dispo ) REFERENCES stage5.heure_disponible( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage5.entretien_demande_stage ( 
	date_entretien       DATE  NOT NULL    ,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_demande_stage     INT  NOT NULL    ,
	id_heure_dispo       INT  NOT NULL    ,
	CONSTRAINT fk_entretien_demande_stage FOREIGN KEY ( id_demande_stage ) REFERENCES stage5.demande_stage( id ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_entretien_demande_stage_heure_dispo FOREIGN KEY ( id_heure_dispo ) REFERENCES stage5.heure_disponible( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE TABLE stage5.heure_dispo_dm_aud_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_heure_dispo       INT  NOT NULL    ,
	id_dm_aud_autorite   INT  NOT NULL    ,
	date_audience        DATE  NOT NULL    ,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	CONSTRAINT fk_heure_dispo_dm_aud_autorite_id_dm_aud_autorite FOREIGN KEY ( id_dm_aud_autorite ) REFERENCES stage5.demande_audience_autorite( id ) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_heure_dispo_dm_aud_autorite_id_heure_dispo FOREIGN KEY ( id_heure_dispo ) REFERENCES stage5.heure_disponible( id ) ON DELETE NO ACTION ON UPDATE NO ACTION
 ) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

CREATE INDEX fk_autorite_enfant_autorite_parent ON stage5.autorite_enfant ( id_autorite_parent );

CREATE INDEX fk_demande_stage_autorite_enfant ON stage5.demande_stage ( id_autorite_enfant );

CREATE INDEX fk_demande_stage_domaine ON stage5.demande_stage ( id_domaine );

CREATE INDEX fk_jour_ouvrable_id_autorite_autorite_enfant ON stage5.jour_ouvrable ( id_autorite );

CREATE INDEX fk_profil_autorite_enfant ON stage5.profil ( id_autorite_enfant );

CREATE INDEX fk_heure_audience_disponible ON stage5.heure_disponible ( id_jour_ouvrable );

CREATE INDEX fk_non_disponibilite_autorite_id_heure_dispo ON stage5.non_disponibilite_autorite_date ( id_heure_dispo );

CREATE INDEX fk_heure_dispo_non_dispo_autorite_jour_id_heure_dispo ON stage5.non_disponibilite_autorite_jour ( id_heure_dispo );

CREATE INDEX fk_dm_aud_public_heure_dispo_id_heure_dispo ON stage5.dm_aud_public_heure_dispo ( id_heure_dispo );

CREATE INDEX fk_dm_aud_public_heure_dispo ON stage5.dm_aud_public_heure_dispo ( id_aud_public );

CREATE INDEX fk_entretien_demande_stage ON stage5.entretien_demande_stage ( id_demande_stage );

CREATE INDEX fk_entretien_demande_stage_heure_dispo ON stage5.entretien_demande_stage ( id_heure_dispo );

CREATE INDEX fk_heure_dispo_dm_aud_autorite_id_dm_aud_autorite ON stage5.heure_dispo_dm_aud_autorite ( id_dm_aud_autorite );

CREATE INDEX fk_heure_dispo_dm_aud_autorite_id_heure_dispo ON stage5.heure_dispo_dm_aud_autorite ( id_heure_dispo );

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
	set @id_audience = (SELECT max(dap.id) FROM stage5.demande_audience_public dap where dap.cin = @cin and dap.session_navigateur = @session_navigateur);
	
	IF @id_audience IS NULL THEN
		
		-- Ajouter Audience
		INSERT INTO demande_audience_public
		(nom, prenom,numero_telephone, email,motif,cin,  session_navigateur) 
		VALUES (@nom, @prenom,@numero_telephone, @email,@motif,@cin, @session_navigateur);

		-- Select l'id la plus recent params[cin,session_navigateur]
		set @id_audience_tmp = (SELECT max(dap.id) FROM stage5.demande_audience_public dap where dap.cin = @cin and dap.session_navigateur = @session_navigateur);

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
			INSERT INTO stage5.dm_aud_public_heure_dispo
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
			INSERT INTO stage5.dm_aud_public_heure_dispo
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
		INSERT INTO stage5.heure_disponible(heure_debut, heure_fin, id_jour_ouvrable) VALUES (sec_to_time(@hds),sec_to_time(@tmp_hfs),id_jour_ouvrable);
		set @hds = @tmp_hfs;
	END WHILE;
END

CREATE  PROCEDURE `ajouter_jour_ouvrable_tous_les_jours`(IN heure_debut time,IN heure_fin time,IN id_autorite int)
BEGIN
    INSERT INTO stage5.jour_ouvrable(jour, heure_debut, heure_fin,  id_autorite) VALUES ('Monday', heure_debut,heure_fin ,id_autorite);
    INSERT INTO stage5.jour_ouvrable(jour, heure_debut, heure_fin,  id_autorite) VALUES ('Tuesday', heure_debut,heure_fin ,id_autorite);
    INSERT INTO stage5.jour_ouvrable(jour, heure_debut, heure_fin,  id_autorite) VALUES ('Wednesday', heure_debut,heure_fin ,id_autorite);
    INSERT INTO stage5.jour_ouvrable(jour, heure_debut, heure_fin,  id_autorite) VALUES ('Thursday', heure_debut,heure_fin ,id_autorite);
    INSERT INTO stage5.jour_ouvrable(jour, heure_debut, heure_fin,  id_autorite) VALUES ('Friday', heure_debut,heure_fin ,id_autorite);
END

CREATE  PROCEDURE `ajouter_jour_ouvrable_tous_les_jours`(IN heure_debut time,IN heure_fin time,IN partie_du_jour varchar(15),IN id_autorite int)
BEGIN
    INSERT INTO stage5.jour_ouvrable(jour, heure_debut, heure_fin, partie_du_jour, id_autorite) VALUES ('Monday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage5.jour_ouvrable(jour, heure_debut, heure_fin, partie_du_jour, id_autorite) VALUES ('Tuesday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage5.jour_ouvrable(jour, heure_debut, heure_fin, partie_du_jour, id_autorite) VALUES ('Wednesday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage5.jour_ouvrable(jour, heure_debut, heure_fin, partie_du_jour, id_autorite) VALUES ('Thursday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage5.jour_ouvrable(jour, heure_debut, heure_fin, partie_du_jour, id_autorite) VALUES ('Friday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
END


CREATE  PROCEDURE `ajouter_jour_ouvrable_tous_les_jours`(IN heure_debut time,IN heure_fin time,IN partie_du_jour varchar(15),IN id_autorite int)
BEGIN
    INSERT INTO stage5.jour_ouvrable(jour, time_debut, time_fin, partie_du_jour, id_autorite) VALUES ('Monday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage5.jour_ouvrable(jour, time_debut, time_fin, partie_du_jour, id_autorite) VALUES ('Tuesday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage5.jour_ouvrable(jour, time_debut, time_fin, partie_du_jour, id_autorite) VALUES ('Wednesday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage5.jour_ouvrable(jour, time_debut, time_fin, partie_du_jour, id_autorite) VALUES ('Thursday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
    INSERT INTO stage5.jour_ouvrable(jour, time_debut, time_fin, partie_du_jour, id_autorite) VALUES ('Friday', heure_debut,heure_fin ,partie_du_jour,id_autorite);
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
        FROM stage5.heure_disponible had 
        JOIN stage5.dm_aud_public_heure_dispo hd_dap on had.id = hd_dap.id_heure_dispo and hd_dap.date_audience = @date_du_jour 
        JOIN stage5.demande_audience_public dap on hd_dap.id_aud_public = dap.id 
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
        FROM stage5.heure_disponible hd 
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
        FROM stage5.heure_disponible had 
        JOIN stage5.dm_aud_public_heure_dispo hd_dap on had.id = hd_dap.id_heure_dispo and hd_dap.date_audience = @date_du_jour 
        JOIN stage5.demande_audience_public dap on hd_dap.id_aud_public = dap.id
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
        FROM stage5.heure_disponible hd 
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

INSERT INTO stage5.autorite_parent(intitule ) VALUES ('Chef de service');
INSERT INTO stage5.autorite_parent(intitule ) VALUES ('Directeurs');
INSERT INTO stage5.autorite_parent(intitule ) VALUES ('Directeurs Généreaux');
INSERT INTO stage5.autorite_parent(intitule ) VALUES ('Sécrétaire Général');
INSERT INTO stage5.autorite_parent(intitule ) VALUES ('Ministère');
INSERT INTO stage5.demande_audience_autorite( id_autorite_enfant_sender, motif, action ) VALUES ( 1, 'Hello world', 0);
INSERT INTO stage5.demande_audience_autorite( id_autorite_enfant_sender, motif, action ) VALUES ( 2, 'TEST', 1);
INSERT INTO stage5.demande_audience_autorite( id_autorite_enfant_sender, motif, action ) VALUES ( 3, 'TAEST', 1);
INSERT INTO stage5.demande_audience_autorite( id_autorite_enfant_sender, motif, action ) VALUES ( 3, 'TEAWST', 0);
INSERT INTO stage5.demande_audience_autorite( id_autorite_enfant_sender, motif, action ) VALUES ( 2, 'Dossier maika', 0);
INSERT INTO stage5.demande_audience_public( motif, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'hih', 0, '121212', '0341752875', 'alafia.saifoudine@gmail.com', 'NAIVOSOA', 'adfa', 'session884.5824087825326');
INSERT INTO stage5.demande_audience_public( motif, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Hello world ???? ', 0, '5545789628', '0341752875', 'joris@gmail.com', 'NAIVOSOA', 'Joris', 'session884.5824087825326');
INSERT INTO stage5.domaine( nom_domaine ) VALUES ('Informatique');
INSERT INTO stage5.domaine( nom_domaine ) VALUES ('Marketing');
INSERT INTO stage5.domaine( nom_domaine ) VALUES ('Finances et comptabilité');
INSERT INTO stage5.domaine( nom_domaine ) VALUES ('Communication Marketing');
INSERT INTO stage5.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin) VALUES ( 'Toussaint', '11', '11', '00:00:01', '23:59:00');
INSERT INTO stage5.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin) VALUES ( 'Noel', '25', '12', '08:00:00', '12:00:00');
INSERT INTO stage5.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin) VALUES ( 'Fin d''année', '31', '12', '14:00:00', '16:00:00');
INSERT INTO stage5.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin) VALUES ( 'Nouvel an', '11', '1', '08:00:00', '12:00:00');
INSERT INTO stage5.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin) VALUES ( 'Black Friday', '28', '11', '11:40:00', '12:10:00');
INSERT INTO stage5.autorite_enfant( intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ( 'Direction des Ressources Humaines', 'DRH', 2, 'mefstage22022@gmail.com', 'wswrgxbntbumffqs', '356');
INSERT INTO stage5.autorite_enfant( intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ( 'Direction des Systèmes d''Informations', 'DSI', 2, 'dyranjohns@gmail.com', 'wswrgxbntbumffqs', '413');
INSERT INTO stage5.autorite_enfant( intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ( 'Direction Générales des Impots', 'DGI', 2, 'johnsirintsoa18@gmail.com', 'wswrgxbntbumffqs', '123');
INSERT INTO stage5.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('RANDRIANARISON', 'Johns', '341777887', 'johnsirintsoa18@gmail.com', '112112112', 4, 'curriculum_vitae_1668365659799_decret_782_96.pdf', 'lettre_motivation_1668365659804_decret_782_96.pdf', 'lettre_introduction_1668365659808_decret_782_96.pdf', 'Je suis un étudiant en première année', 2, 1);
INSERT INTO stage5.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('RAKOTONIRINA', 'Teo', '348899966', 'teo@gmail.com', '112112112', 5, 'curriculum_vitae_1668366150840_Les nombres rationnels.pdf', 'lettre_motivation_1668366150968_Les nombres rationnels.pdf', 'lettre_introduction_1668366150973_Les nombres rationnels.pdf', 'Je suis désolé', 3, 3);
INSERT INTO stage5.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('RANAIVOSOA', 'Tiana', '348899966', 'teo@gmail.com', '112112112', 5, 'curriculum_vitae_1668366340054_Les nombres rationnels.pdf', 'lettre_motivation_1668366340061_Les nombres rationnels.pdf', 'lettre_introduction_1668366340067_Les nombres rationnels.pdf', 'Je suis désolé', 3, 1);
INSERT INTO stage5.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('NAIVOSOA', 'Nirina', '345677889', 'naivosoa@gmail.com', '112112112', 3, 'curriculum_vitae_1668400143631_Les nombres rationnels.pdf', 'lettre_motivation_1668400143714_Les nombres rationnels.pdf', 'lettre_introduction_1668400143721_Les nombres rationnels.pdf', 'Je suis la ', 1, 2);
INSERT INTO stage5.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('FIFIDIA', 'Fy', '345677889', 'fifidia@gmail.com', '112112112', 4, 'curriculum_vitae_1668402706992_Les nombres rationnels.pdf', 'lettre_motivation_1668402707078_Les nombres rationnels.pdf', 'lettre_introduction_1668402707083_Les nombres rationnels.pdf', 'bring it on', 4, 1);
INSERT INTO stage5.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Monday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage5.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Tuesday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage5.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Wednesday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage5.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Thursday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage5.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Friday', '08:00:00', '12:00:00', 'Matin', 1);
INSERT INTO stage5.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Monday', '14:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage5.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Tuesday', '14:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage5.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Wednesday', '14:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage5.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Thursday', '14:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage5.jour_ouvrable( jour, time_debut, time_fin, partie_du_jour, id_autorite ) VALUES ( 'Friday', '14:00:00', '16:00:00', 'Après-midi', 1);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('08:00:00', '08:30:00', 1);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('08:30:00', '09:00:00', 1);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('09:00:00', '09:30:00', 1);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('09:30:00', '10:00:00', 1);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('10:00:00', '10:30:00', 1);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('10:30:00', '11:00:00', 1);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('11:00:00', '11:30:00', 1);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('11:30:00', '12:00:00', 1);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ('14:00:00', '14:30:00', 6);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:30:00', '15:00:00', 6);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:00:00', '15:30:00', 6);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:30:00', '16:00:00', 6);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '08:00:00', '08:30:00', 2);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '08:30:00', '09:00:00', 2);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '09:00:00', '09:30:00', 2);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '09:30:00', '10:00:00', 2);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '10:00:00', '10:30:00', 2);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '10:30:00', '11:00:00', 2);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '11:00:00', '11:30:00', 2);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '11:30:00', '12:00:00', 2);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:00:00', '14:30:00', 7);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:30:00', '15:00:00', 7);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:00:00', '15:30:00', 7);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:30:00', '16:00:00', 7);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '08:00:00', '08:30:00', 3);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '08:30:00', '09:00:00', 3);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '09:00:00', '09:30:00', 3);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '09:30:00', '10:00:00', 3);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '10:00:00', '10:30:00', 3);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '10:30:00', '11:00:00', 3);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '11:00:00', '11:30:00', 3);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '11:30:00', '12:00:00', 3);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:00:00', '14:30:00', 8);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:30:00', '15:00:00', 8);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:00:00', '15:30:00', 8);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:30:00', '16:00:00', 8);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '08:00:00', '08:30:00', 4);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '08:30:00', '09:00:00', 4);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '09:00:00', '09:30:00', 4);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '09:30:00', '10:00:00', 4);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '10:00:00', '10:30:00', 4);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '10:30:00', '11:00:00', 4);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '11:00:00', '11:30:00', 4);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '11:30:00', '12:00:00', 4);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:00:00', '14:30:00', 9);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:30:00', '15:00:00', 9);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:00:00', '15:30:00', 9);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:30:00', '16:00:00', 9);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '08:00:00', '08:30:00', 5);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '08:30:00', '09:00:00', 5);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '09:00:00', '09:30:00', 5);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '09:30:00', '10:00:00', 5);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '10:00:00', '10:30:00', 5);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '10:30:00', '11:00:00', 5);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '11:00:00', '11:30:00', 5);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '11:30:00', '12:00:00', 5);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:00:00', '14:30:00', 10);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '14:30:00', '15:00:00', 10);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:00:00', '15:30:00', 10);
INSERT INTO stage5.heure_disponible( heure_debut, heure_fin, id_jour_ouvrable ) VALUES ( '15:30:00', '16:00:00', 10);
INSERT INTO stage5.non_disponibilite_autorite_date( heure_debut, heure_fin, id_heure_dispo , id_date_disponible) VALUES ( (select id from date_disponible where date_disponible = '2022-12-08'), '08:00:00', '08:40:00', 1);
INSERT INTO stage5.non_disponibilite_autorite_date( heure_debut, heure_fin, id_heure_dispo , id_date_disponible) VALUES ( '2022-11-28', '10:10:00', '10:40:00', 5);
INSERT INTO stage5.non_disponibilite_autorite_date( heure_debut, heure_fin, id_heure_dispo , id_date_disponible) VALUES ( '2022-11-28', '08:00:00', '08:40:00', 2);
INSERT INTO stage5.non_disponibilite_autorite_date( heure_debut, heure_fin, id_heure_dispo , id_date_disponible) VALUES ( '2022-11-28', '10:10:00', '10:40:00', 6);
INSERT INTO stage5.non_disponibilite_autorite_jour( id, id_heure_dispo, heure_debut, heure_fin ) VALUES ( 1, 9, '14:20:00', '14:25:00');
INSERT INTO stage5.non_disponibilite_autorite_jour( id, id_heure_dispo, heure_debut, heure_fin ) VALUES ( 2, 10, '14:35:00', '14:50:00');
INSERT INTO stage5.non_disponibilite_autorite_jour( id, id_heure_dispo, heure_debut, heure_fin ) VALUES ( 3, 12, '15:30:00', '15:50:00');
INSERT INTO stage5.dm_aud_public_heure_dispo( id_aud_public, id_heure_dispo, id, date_audience, heure_debut, heure_fin ) VALUES ( 18, 1, 27, '2022-12-12', '08:00:00', '08:30:00');
INSERT INTO stage5.dm_aud_public_heure_dispo( id_aud_public, id_heure_dispo, id, date_audience, heure_debut, heure_fin ) VALUES ( 19, 58, 28, '2022-12-13', '08:30:00', '09:00:00');
INSERT INTO stage5.entretien_demande_stage( date_entretien, heure_debut, heure_fin, id, id_demande_stage, id_heure_dispo ) VALUES ( '2022-11-28', '10:20:00', '10:45:00', 1, 1, 5);
INSERT INTO stage5.entretien_demande_stage( date_entretien, heure_debut, heure_fin, id, id_demande_stage, id_heure_dispo ) VALUES ( '2022-11-28', '10:20:00', '10:45:00', 2, 1, 6);
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id_date_heure_disponible_autorite, id_dm_aud_autorite, date_audience, heure_debut, heure_fin ) VALUES ( 7, 1, '2022-12-19', '11:10:00', '11:20:00');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id_date_heure_disponible_autorite, id_dm_aud_autorite, date_audience, heure_debut, heure_fin ) VALUES ( 9, 2, '2022-12-19', '14:20:00', '14:40:00');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id_date_heure_disponible_autorite, id_dm_aud_autorite, date_audience, heure_debut, heure_fin ) VALUES ( 10, 2, '2022-12-19', '14:20:00', '14:40:00');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id_date_heure_disponible_autorite, id_dm_aud_autorite, date_audience, heure_debut, heure_fin ) VALUES ( 10, 3, '2022-12-19', '14:15:00', '15:15:00');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id_date_heure_disponible_autorite, id_dm_aud_autorite, date_audience, heure_debut, heure_fin ) VALUES ( 11, 3, '2022-12-19', '14:15:00', '15:15:00');

-- Donnée de test dm_aud_autorite_date_heure_dispo
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin ) 
VALUES 
( 57, 1, '11:10:00', '11:20:00'),
( 66, 2, '14:20:00', '14:40:00'),
( 67, 2, '14:20:00', '14:40:00'),
( 66, 3, '14:15:00', '15:15:00'),
( 67, 3, '14:15:00', '15:15:00'),
( 68, 3, '14:15:00', '15:15:00'),
( 68, 4, '15:15:00', '15:30:00');

CALL `ajouter_date_heure_disponible_autorite`(1,'08:00:00' ,'12:00:00','2022-12-19');
CALL `ajouter_date_heure_disponible_autorite`(1,'14:00:00' ,'16:00:00','2022-12-19');

INSERT INTO stage5.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('RANDRIANARISON', 'Johns', '341777887', 'johnsirintsoa18@gmail.com', '112112112', 4, 'curriculum_vitae_1668365659799_decret_782_96.pdf', 'lettre_motivation_1668365659804_decret_782_96.pdf', 'lettre_introduction_1668365659808_decret_782_96.pdf', 'Je suis un étudiant en première année', 2, 1);
INSERT INTO stage5.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('RAKOTONIRINA', 'Teo', '348899966', 'teo@gmail.com', '112112112', 5, 'curriculum_vitae_1668366150840_Les nombres rationnels.pdf', 'lettre_motivation_1668366150968_Les nombres rationnels.pdf', 'lettre_introduction_1668366150973_Les nombres rationnels.pdf', 'Je suis désolé', 3, 3);
INSERT INTO stage5.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('RANAIVOSOA', 'Tiana', '348899966', 'teo@gmail.com', '112112112', 5, 'curriculum_vitae_1668366340054_Les nombres rationnels.pdf', 'lettre_motivation_1668366340061_Les nombres rationnels.pdf', 'lettre_introduction_1668366340067_Les nombres rationnels.pdf', 'Je suis désolé', 3, 1);
INSERT INTO stage5.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('NAIVOSOA', 'Nirina', '345677889', 'naivosoa@gmail.com', '112112112', 3, 'curriculum_vitae_1668400143631_Les nombres rationnels.pdf', 'lettre_motivation_1668400143714_Les nombres rationnels.pdf', 'lettre_introduction_1668400143721_Les nombres rationnels.pdf', 'Je suis la ', 1, 2);
INSERT INTO stage5.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ( 'FIFIDIA', 'Fy', '345677889', 'fifidia@gmail.com', '112112112', 4, 'curriculum_vitae_1668402706992_Les nombres rationnels.pdf', 'lettre_motivation_1668402707078_Les nombres rationnels.pdf', 'lettre_introduction_1668402707083_Les nombres rationnels.pdf', 'bring it on', 4, 1);

SELECT 
dhd.*, daadhd.*, eds.*, dhda.* 
FROM stage5.date_heure_disponible_autorite dhda 
join date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id 
LEFT JOIN dm_aud_autorite_date_heure_dispo daadhd on dhda.id = daadhd.id_date_heure_disponible_autorite 
LEFT JOIN dm_aud_public_date_heure_dispo dapdhd on dhda.id = dapdhd.id_date_heure_disponible_autorite 
LEFT JOIN entretien_demande_stage eds on dhda.id = eds.id_date_heure_disponible_autorite 
where 
dhda.id_autorite = 1 
and dhd.date_disponible = '2022-12-19' 
and dhda.est_disponible is true 
and eds.id is null 
and daadhd.id is null 
and dapdhd.id is null
and (
	(select jf.time_event_debut from jour_ferie jf where CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = dhd.date_disponible ) NOT BETWEEN hd.heure_debut and hd.heure_fin 
	and (select jf.time_event_fin from jour_ferie jf where CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = dhd.date_disponible ) NOT BETWEEN hd.heure_debut and hd.heure_fin 
	and hd.heure_debut NOT BETWEEN (select jf.time_event_debut from jour_ferie jf where CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = dhd.date_disponible ) and (select jf.time_event_fin from jour_ferie jf where CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = dhd.date_disponible) 
	and hd.heure_fin NOT BETWEEN (select jf.time_event_debut from jour_ferie jf where CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = dhd.date_disponible) and (select jf.time_event_fin from jour_ferie jf where CONVERT((select concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour)) USING utf8) = dhd.date_disponible) 
)




-- Calendrier autorite
-- v1
CREATE  PROCEDURE `calendrier_autorite`(IN id_autorite INT)
BEGIN
	set @id_autorite = id_autorite;
	
	SELECT 
	daadhd.id as id,
	dhda.id as id_date_heure_disponible_autorite,
	dhd.id as id_date_heure_disponible,

	ae.id as id_autorite,
	ae.intitule as intitule_autorite,
	ae.intitule_code as intitule_code_autorite,
	ae.porte as porte_autorite,
	ae.addresse_electronique as addresse_electronique_autorite,
	ae.mot_de_passe_mailing as mot_de_passe_mailing_autorite,

	aes.id as id_autorite_sender,
	aes.intitule as intitule_autorite_sender,
	aes.intitule_code as intitule_code_sender,
	aes.addresse_electronique as addresse_electronique_autorite_sender,

	CONCAT(dhd.date_disponible,'T',daadhd.heure_debut) as start,
	CONCAT(dhd.date_disponible,'T',daadhd.heure_fin) as end,
	daa.id as id_evenement,
	'Audience autorité' as title,
	daa.motif as motif,
	daadhd.date_debut as date_debut,
	daadhd.date_fin as date_fin,
	daadhd.heure_debut as heure_debut,
	daadhd.heure_fin as heure_fin,
	CASE
		WHEN daa.action = 0 THEN 'Non validé'
		WHEN daa.action = 1 THEN 'Validé'
		ELSE 'Reporté'
	END AS status_audience,
	'' nom,
	'' prenom,
	'' numero_telephone,
	'' cin,
	'' addresse_electronique_sender_externe,
	'#FF0000' color,
	CASE
		WHEN daa.action = 0 THEN '#35AF11'
		WHEN daa.action = 1 THEN '#E61212'
		ELSE '#9A9393'
	END AS color_status,
	'Autorité' type_audience,
	true as editable 
	FROM
	stage5.date_heure_disponible_autorite dhda 
	join date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id 
	Join autorite_enfant ae on dhda.id_autorite = ae.id
	join dm_aud_autorite_date_heure_dispo daadhd on dhda.id = daadhd.id_date_heure_disponible_autorite
	join demande_audience_autorite daa on daadhd.id_dm_aud_autorite = daa.id
	join autorite_enfant aes on daa.id_autorite_enfant_sender = aes.id
	where dhd.date_disponible >= CURDATE() and dhda.id_autorite = @id_autorite
	
	UNION
	
	-- Demande audience public
	SELECT 
	dapdhd.id,
	dhda.id as id_date_heure_disponible_autorite,
	dhd.id as id_date_heure_disponible,

	ae.id as id_autorite,
	ae.intitule as intitule_autorite,
	ae.intitule_code as intitule_code_autorite,
	ae.porte as porte_autorite,
	ae.addresse_electronique as addresse_electronique_autorite,
	ae.mot_de_passe_mailing as mot_de_passe_mailing_autorite,

	'' id_autorite_sender,
	'' intitule_autorite_sender,
	'' intitule_code_sender,
	'' addresse_electronique_autorite_sender,

	CONCAT(dhd.date_disponible,'T',dapdhd.heure_debut) as start,
	CONCAT(dhd.date_disponible,'T',dapdhd.heure_fin) as end,
	dap.id as id_evenement,
	'Audience public' as title,
	dap.motif as motif,
	dapdhd.date_debut as date_debut,
	dapdhd.date_fin as date_fin,
	dapdhd.heure_debut as heure_debut,
	dapdhd.heure_fin as heure_fin,
	CASE
		WHEN dap.action = 0 THEN 'Non validé'
		WHEN dap.action = 1 THEN 'Validé'
		ELSE 'Reporté'
	END AS status_audience,
	dap.nom as nom,
	dap.prenom as prenom,
	dap.numero_telephone as numero_telephone,
	dap.cin as cin,
	dap.email as addresse_electronique_sender_externe,
	'#008000' color,
	CASE
		WHEN dap.action = 0 THEN '#35AF11'
		WHEN dap.action = 1 THEN '#E61212'
		ELSE '#9A9393'
	END AS color_status,
	'Public' type_audience,
	true as editable
	FROM stage5.date_heure_disponible_autorite dhda
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	JOIN autorite_enfant ae on dhda.id_autorite = ae.id
	JOIN dm_aud_public_date_heure_dispo dapdhd on dhda.id = dapdhd.id_date_heure_disponible_autorite
	JOIN demande_audience_public dap on dapdhd.id_aud_public = dap.id
	WHERE dhd.date_disponible >= CURDATE() and dhda.id_autorite = @id_autorite
	
	UNION
	
	-- Demande entretien stage

	select
	eds.id,
	dhda.id as id_date_heure_disponible_autorite,
	dhd.id as id_date_heure_disponible,

	ae.id as id_autorite,
	ae.intitule as intitule_autorite,
	ae.intitule_code as intitule_code_autorite,
	ae.porte as porte_autorite,
	ae.addresse_electronique as addresse_electronique_autorite,
	ae.mot_de_passe_mailing as mot_de_passe_mailing_autorite,

	'' id_autorite_sender,
	'' intitule_autorite_sender,
	'' intitule_code_sender,
	'' addresse_electronique_autorite_sender,

	CONCAT(dhd.date_disponible,'T',eds.heure_debut) as start,
	CONCAT(dhd.date_disponible,'T',eds.heure_fin) as end,
	ds.id as id_evenement,
	'Entretien' as title,
	CONCAT('Entretien de ',ds.nom,' ',ds.prenom) as motif,
	eds.date_debut as date_debut,
	eds.date_fin as date_fin,
	eds.heure_debut as heure_debut,
	eds.heure_fin as heure_fin,
	'Entretien' status_audience,
	ds.nom as nom,
	ds.prenom as prenom,
	ds.telephone as numero_telephone,
	ds.cin as cin,
	ds.e_mail as addresse_electronique_sender_externe,
	'#FFA500' color,
	'#FFA500' color_status,
	'Entretien' type_audience,
	true as editable
	from entretien_demande_stage eds
	JOIN date_heure_disponible_autorite dhda on eds.id_date_heure_disponible_autorite = dhda.id
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	JOIN demande_stage ds on eds.id_demande_stage = ds.id
	JOIN autorite_enfant ae on dhda.id_autorite = ae.id
	where dhd.date_disponible >= CURDATE() and dhda.id_autorite = @id_autorite
	group by ds.id;

END

-- v2
CREATE  PROCEDURE `calendrier_autorite`(IN id_autorite INT)
BEGIN
	set @id_autorite = id_autorite;
	
	SELECT 
	daadhd.id as id,
	dhda.id as id_date_heure_disponible_autorite,
	dhd.id as id_date_heure_disponible,

	ae.id as id_autorite,
	ae.intitule as intitule_autorite,
	ae.intitule_code as intitule_code_autorite,
	ae.porte as porte_autorite,
	ae.addresse_electronique as addresse_electronique_autorite,
	ae.mot_de_passe_mailing as mot_de_passe_mailing_autorite,

	aes.id as id_autorite_sender,
	aes.intitule as intitule_autorite_sender,
	aes.intitule_code as intitule_code_sender,
	aes.addresse_electronique as addresse_electronique_autorite_sender,

	CONCAT(dhd.date_disponible,'T',daadhd.heure_debut) as start,
	CONCAT(dhd.date_disponible,'T',daadhd.heure_fin) as end,
	daa.id as id_evenement,
	'Audience autorité' as title,
	daa.motif as motif,
	daadhd.date_debut as date_debut,
	daadhd.date_fin as date_fin,
	daadhd.heure_debut as heure_debut,
	daadhd.heure_fin as heure_fin,
	CASE
		WHEN daa.action = 0 THEN 'Non validé'
		WHEN daa.action = 1 THEN 'Validé'
		ELSE 'Reporté'
	END AS status_audience,
	'' nom,
	'' prenom,
	'' numero_telephone,
	'' cin,
	'' addresse_electronique_sender_externe,
	'#FF0000' color,
	CASE
		WHEN daa.action = 0 THEN '#35AF11'
		WHEN daa.action = 1 THEN '#E61212'
		ELSE '#9A9393'
	END AS color_status,
	'Autorité' type_audience,
	true as editable 
	FROM
	stage5.date_heure_disponible_autorite dhda 
	join date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id 
	Join autorite_enfant ae on dhda.id_autorite = ae.id
	join dm_aud_autorite_date_heure_dispo daadhd on dhda.id = daadhd.id_date_heure_disponible_autorite
	join demande_audience_autorite daa on daadhd.id_dm_aud_autorite = daa.id
	join autorite_enfant aes on daa.id_autorite_enfant_sender = aes.id
	where dhd.date_disponible >= CURDATE() and dhda.id_autorite = @id_autorite
	
	UNION
	
	-- Demande audience public
	SELECT 
	dapdhd.id,
	dhda.id as id_date_heure_disponible_autorite,
	dhd.id as id_date_heure_disponible,

	ae.id as id_autorite,
	ae.intitule as intitule_autorite,
	ae.intitule_code as intitule_code_autorite,
	ae.porte as porte_autorite,
	ae.addresse_electronique as addresse_electronique_autorite,
	ae.mot_de_passe_mailing as mot_de_passe_mailing_autorite,

	'' id_autorite_sender,
	'' intitule_autorite_sender,
	'' intitule_code_sender,
	'' addresse_electronique_autorite_sender,

	CONCAT(dhd.date_disponible,'T',dapdhd.heure_debut) as start,
	CONCAT(dhd.date_disponible,'T',dapdhd.heure_fin) as end,
	dap.id as id_evenement,
	'Audience public' as title,
	dap.motif as motif,
	dapdhd.date_debut as date_debut,
	dapdhd.date_fin as date_fin,
	dapdhd.heure_debut as heure_debut,
	dapdhd.heure_fin as heure_fin,
	CASE
		WHEN dap.action = 0 THEN 'Non validé'
		WHEN dap.action = 1 THEN 'Validé'
		ELSE 'Reporté'
	END AS status_audience,
	dap.nom as nom,
	dap.prenom as prenom,
	dap.numero_telephone as numero_telephone,
	dap.cin as cin,
	dap.email as addresse_electronique_sender_externe,
	'#008000' color,
	CASE
		WHEN dap.action = 0 THEN '#35AF11'
		WHEN dap.action = 1 THEN '#E61212'
		ELSE '#9A9393'
	END AS color_status,
	'Public' type_audience,
	true as editable
	FROM stage5.date_heure_disponible_autorite dhda
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	JOIN autorite_enfant ae on dhda.id_autorite = ae.id
	JOIN dm_aud_public_date_heure_dispo dapdhd on dhda.id = dapdhd.id_date_heure_disponible_autorite
	JOIN demande_audience_public dap on dapdhd.id_aud_public = dap.id
	WHERE dhd.date_disponible >= CURDATE() and dhda.id_autorite = @id_autorite
	GROUP by dapdhd.id_aud_public
	
	UNION
	
	-- Demande entretien stage

	select
	eds.id,
	dhda.id as id_date_heure_disponible_autorite,
	dhd.id as id_date_heure_disponible,

	ae.id as id_autorite,
	ae.intitule as intitule_autorite,
	ae.intitule_code as intitule_code_autorite,
	ae.porte as porte_autorite,
	ae.addresse_electronique as addresse_electronique_autorite,
	ae.mot_de_passe_mailing as mot_de_passe_mailing_autorite,

	'' id_autorite_sender,
	'' intitule_autorite_sender,
	'' intitule_code_sender,
	'' addresse_electronique_autorite_sender,

	CONCAT(dhd.date_disponible,'T',eds.heure_debut) as start,
	CONCAT(dhd.date_disponible,'T',eds.heure_fin) as end,
	ds.id as id_evenement,
	'Entretien' as title,
	CONCAT('Entretien de ',ds.nom,' ',ds.prenom) as motif,
	eds.date_debut as date_debut,
	eds.date_fin as date_fin,
	eds.heure_debut as heure_debut,
	eds.heure_fin as heure_fin,
	'Entretien' status_audience,
	ds.nom as nom,
	ds.prenom as prenom,
	ds.telephone as numero_telephone,
	ds.cin as cin,
	ds.e_mail as addresse_electronique_sender_externe,
	'#FFA500' color,
	'#FFA500' color_status,
	'Entretien' type_audience,
	true as editable
	from entretien_demande_stage eds
	JOIN date_heure_disponible_autorite dhda on eds.id_date_heure_disponible_autorite = dhda.id
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	JOIN demande_stage ds on eds.id_demande_stage = ds.id
	JOIN autorite_enfant ae on dhda.id_autorite = ae.id
	where dhd.date_disponible >= CURDATE() and dhda.id_autorite = @id_autorite
	group by ds.id;

END


-- Generer date heure disponible entre deux date
CALL date_heure_dispo_entre_deux_dates('2022-12-26','2023-01-03',3)

CREATE PROCEDURE `verifier_date_heure_dispo_entre_deux_dates`(IN date1 DATE,IN date2 DATE,IN id_autorite INT)
BEGIN
	set @id_autorite = id_autorite;
	looping: LOOP
	set date1 = (select DATE_ADD(date(date1), INTERVAL 1 DAY));
	set  @daten = date1;
	IF @daten <= date2 then
		set @nbr_rows = (SELECT count(id) 
		FROM stage5.date_heure_disponible dhd where dhd.date_disponible = @daten);

		IF @nbr_rows = 0 THEN 
			CALL `ajouter_date_heure_disponible_autorite`(@id_autorite,'08:00:00', '16:00:00' , @daten);	
		END IF;

		iterate looping;
	end if;
	LEAVE looping;
	END LOOP looping;
END;


-- Valider audience public
CREATE  PROCEDURE `valider_audience_public`(IN id_dm_aud_public_date_heure_dispo int,IN id_audience INT,IN date_debut date,IN date_fin date,IN heure_debut time,in heure_fin time, IN id_autorite INT)
BEGIN
	set @id_autorite = id_autorite;
	set @date_debut = date_debut;
	set @date_fin = date_fin;
	
	set @heure_debut = heure_debut;
	set @heure_fin = heure_fin;
	
	SET @hd = SUBTIME(@heure_debut,"-00:01:00");
	SET @hf = SUBTIME(@heure_fin,"00:01:00");
	
	set @hd_timestamp = SUBTIME(@hd,"03:00:00");
	set @hf_timestamp = SUBTIME(@hf,"03:00:00");

	set @timestamp_debut = timestamp(concat(@date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(@date_fin,' ',SUBTIME(@hf,"03:00:00")));

	set @nbr_rows = ( 
	SELECT 
	count(dhda.id)
	FROM
	stage5.date_heure_disponible_autorite dhda 
	JOIN stage5.date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	where 
	dhda.id_autorite = @id_autorite
	and 
	(timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin
	OR timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin)
	OR
	dhda.id_autorite = @id_autorite
	and 
	(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))
	and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))));

	IF @nbr_rows = 0 THEN
		SELECT 'Il n''existe aucune place disponible' as message;
	ELSEIF @nbr_rows = 1 THEN 
		-- Update
		UPDATE stage5.dm_aud_public_date_heure_dispo set date_debut = @date_debut, date_fin = @date_fin, heure_debut = @heure_debut, heure_fin = @heure_fin where id = id_dm_aud_public_date_heure_dispo;
		UPDATE stage5.demande_audience_public set action = 1 where id = id_audience;	
	ELSE
		set @id_aud_public = id_audience;
		-- Delete 
		CALL supprimer_audience_public(@id_aud_public);

		-- insert
		INSERT INTO stage5.dm_aud_public_date_heure_dispo (id_aud_public, id_date_heure_disponible_autorite, heure_debut, heure_fin, date_debut, date_fin)
		SELECT 
		@id_aud_public,
		dhda.id,
		@heure_debut,
		@heure_fin,
		@date_debut,
		@date_fin
		FROM
		stage5.date_heure_disponible_autorite dhda 
		JOIN stage5.date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		where 
		dhda.id_autorite = @id_autorite
		and 
		(timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin
		OR timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin)
		OR
		dhda.id_autorite = @id_autorite
		and 
		(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))
		and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))));
		UPDATE stage5.demande_audience_public set action = 1 where id = @id_aud_public;
	END IF;
END

CALL valider_audience_public (13,12, '2023-01-02','2023-01-02','08:30:00','09:00:00',3)
call 


CREATE  PROCEDURE `ajouter_non_disponible_autorite`(IN id_autorite INT,IN date_debut date,IN date_fin date,IN heure_debut time,IN heure_fin time)
BEGIN
	set @id_autorite = id_autorite;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',@hd));
	set @timestamp_fin = timestamp(concat(date_fin,' ',@hf));

	SELECT count(dhnda.id),dhnda.id INTO @nbr_rows,@id_non_dispo	 
	FROM date_heure_non_disponible_autorite dhnda
	WHERE 
	dhnda.date_debut = date_debut 
	and dhnda.date_fin = date_fin 
	and dhnda.heure_debut = heure_debut 
	and dhnda.heure_fin = heure_fin;
	
	IF @nbr_rows = 0 THEN 
		INSERT INTO date_heure_non_disponible_autorite ( date_debut, date_fin, heure_debut, heure_fin) 
		VALUES ( date_debut, date_fin, heure_debut, heure_fin );

		SELECT dhnda.id INTO @id_non_dispo
		FROM date_heure_non_disponible_autorite dhnda
		WHERE 
		dhnda.date_debut = date_debut 
		and dhnda.date_fin = date_fin 
		and dhnda.heure_debut = heure_debut 
		and dhnda.heure_fin = heure_fin;
	end if;
	CALL `set_est_disponible_pas_disponible`(@id_autorite, @id_non_dispo ,date_debut, date_fin, heure_debut , heure_fin, false);

	SELECT SUM(nbr_rows) FROM (	
		SELECT
		count(*) as nbr_rows
		FROM
		dm_aud_public_date_heure_dispo dapdhd 
		JOIN demande_audience_public dap on dapdhd.id_aud_public = dap.id
		JOIN date_heure_disponible_autorite dhda on dapdhd.id_date_heure_disponible_autorite = dhda.id
		JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		where 
		dhda.id_autorite = @id_autorite
		and dap.action between 0 and 1
		and 
		(timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) BETWEEN @timestamp_debut and @timestamp_fin
		OR timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)) BETWEEN @timestamp_debut and @timestamp_fin)
		OR
		dhda.id_autorite = @id_autorite
		and dap.action between 0 and 1
		and 
		(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin))
		and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)))
		UNION
		SELECT 
		count(*) as nbr_rows
		FROM
		entretien_demande_stage eds 
		join date_heure_disponible_autorite dhda on eds.id_date_heure_disponible_autorite = dhda.id
		JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		JOIN demande_stage ds on eds.id_demande_stage = ds.id
		where 
		dhda.id_autorite = @id_autorite
		and ds.action between 0 and 1
		and 
		(timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) BETWEEN @timestamp_debut and @timestamp_fin
		OR timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)) BETWEEN @timestamp_debut and @timestamp_fin)
		OR
		dhda.id_autorite = @id_autorite
		and ds.action between 0 and 1
		and 
		(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin))
		and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)))
		UNION
		SELECT 
		count(*) as nbr_rows
		FROM
		dm_aud_autorite_date_heure_dispo daadhd 
		JOIN date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
		JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		JOIN demande_audience_autorite daa on daadhd.id_dm_aud_autorite = daa.id
		JOIN autorite_enfant aes on daa.id_autorite_enfant_sender = aes.id
		where 
		dhda.id_autorite = @id_autorite
		and daa.action between 0 and 1
		and 
		(timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) BETWEEN @timestamp_debut and @timestamp_fin
		OR timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)) BETWEEN @timestamp_debut and @timestamp_fin)
		OR
		dhda.id_autorite = @id_autorite
		and daa.action between 0 and 1
		and 
		(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin))
		and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)))
	)`x` into @nbr_rows;

	IF @nbr_rows > 0 THEN 
		(SELECT
		dap.id,
		'Public' as type_evenement,
		dap.nom as nom, 
		dap.prenom as prenom,
		dap.email as addresse_electronique
		FROM
		dm_aud_public_date_heure_dispo dapdhd 
		JOIN demande_audience_public dap on dapdhd.id_aud_public = dap.id
		JOIN date_heure_disponible_autorite dhda on dapdhd.id_date_heure_disponible_autorite = dhda.id
		JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		where 
		dhda.id_autorite = @id_autorite
		and dap.action between 0 and 1
		and 
		(timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) BETWEEN @timestamp_debut and @timestamp_fin
		OR timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)) BETWEEN @timestamp_debut and @timestamp_fin)
		OR
		dhda.id_autorite = @id_autorite
		and dap.action between 0 and 1
		and 
		(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin))
		and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)))
		GROUP BY dapdhd.id_aud_public)
		
		union
		
		(SELECT 
		eds.id_demande_stage,
		'Entretien' as type_evenement,
		ds.nom as nom, 
		ds.prenom as prenom,
		ds.e_mail as addresse_electronique
		FROM
		entretien_demande_stage eds 
		join date_heure_disponible_autorite dhda on eds.id_date_heure_disponible_autorite = dhda.id
		JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		JOIN demande_stage ds on eds.id_demande_stage = ds.id
		where 
		dhda.id_autorite = @id_autorite
		and ds.action between 0 and 1
		and 
		(timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) BETWEEN @timestamp_debut and @timestamp_fin
		OR timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)) BETWEEN @timestamp_debut and @timestamp_fin)
		OR
		dhda.id_autorite = @id_autorite
		and ds.action between 0 and 1
		and 
		(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin))
		and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)))
		GROUP BY eds.id_demande_stage)
		
		UNION
		
		(SELECT 
		daa.id,
		'Autorité' as type_evenement,
		aes.intitule as nom,
		aes.intitule_code as prenom,
		aes.addresse_electronique as addresse_electronique	
		FROM
		dm_aud_autorite_date_heure_dispo daadhd 
		JOIN date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
		JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		JOIN demande_audience_autorite daa on daadhd.id_dm_aud_autorite = daa.id
		JOIN autorite_enfant aes on daa.id_autorite_enfant_sender = aes.id
		where 
		dhda.id_autorite = @id_autorite
		and daa.action between 0 and 1
		and 
		(timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) BETWEEN @timestamp_debut and @timestamp_fin
		OR timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)) BETWEEN @timestamp_debut and @timestamp_fin)
		OR
		dhda.id_autorite = @id_autorite
		and daa.action between 0 and 1
		and 
		(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin))
		and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)))
		GROUP BY daadhd.id_dm_aud_autorite);

		
	
	ELSE
		select 'Ces dates disponibles ne seront pas disponible' as message;	
	
	END IF;
END
CREATE  PROCEDURE `set_est_disponible_pas_disponible`(IN id_autorite INT,IN id_non_dispo INT,IN date_debut date,IN date_fin date,IN heure_debut time,IN heure_fin time,in etat boolean)
BEGIN
	set @id_autorite = id_autorite;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',@hd));
	set @timestamp_fin = timestamp(concat(date_fin,' ',@hf));

	INSERT INTO pas_disponible (id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite) 
	VALUES ((
		SELECT 
		dhda.id
		FROM
		date_heure_disponible_autorite dhda 
		JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id	
		where 
		dhda.id_autorite = @id_autorite
		and dhda.est_disponible = 1
		and 
		(timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) BETWEEN @timestamp_debut and @timestamp_fin
		OR timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)) BETWEEN @timestamp_debut and @timestamp_fin)
		OR
		dhda.id_autorite = @id_autorite
		and dhda.est_disponible = 1
		and 
		(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin))
		and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)))		
	),id_non_dispo);

	UPDATE date_heure_disponible_autorite 
	set est_disponible = etat 
	WHERE date_heure_disponible_autorite.id IN (
		select id from (
			SELECT 
			dhda.id
			FROM
			date_heure_disponible_autorite dhda 
			JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id	
			where 
			dhda.id_autorite = @id_autorite
			and dhda.est_disponible = 1
			and 
			(timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) BETWEEN @timestamp_debut and @timestamp_fin
			OR timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)) BETWEEN @timestamp_debut and @timestamp_fin)
			OR
			dhda.id_autorite = @id_autorite
			and dhda.est_disponible = 1
			and 
			(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin))
			and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)))
		) as t
	);
END

CREATE PROCEDURE `modifier_non_disponible_autorite` (
	IN id_autorite INT,
	IN id_non_dispo INT,
	IN date_debut date,
	IN date_fin date,
	IN heure_debut time,
	IN heure_fin time
)
BEGIN
	SELECT dhnda.id into @id_non_dispo from date_heure_non_disponible_autorite dhnda where dhnda.id = id_non_dispo; 	
	IF @id_non_dispo IS NOT NULL THEN
		select 'Id exist' as message;
	ELSE 
		select 'Id does not exist' as message; 	
	END IF;
	
END;


-- AJOUT non disponible tmp
CREATE  PROCEDURE `ajouter_non_disponible_autorite`(IN id_autorite INT,IN date_debut date,IN date_fin date,IN heure_debut time,IN heure_fin time)
BEGIN
	set @id_autorite = id_autorite;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',@hd));
	set @timestamp_fin = timestamp(concat(date_fin,' ',@hf));

	SELECT count(dhnda.id),dhnda.id,dhnda.date_debut,dhnda.date_fin,dhnda.heure_debut,dhnda.heure_fin 
	FROM pas_disponible pd
	JOIN date_heure_disponible_autorite dhda on pd.id_date_heure_disponible_autorite = dhda.id
	JOIN date_heure_non_disponible_autorite dhnda on pd.id_date_heure_non_disponible_autorite = dhnda.id
	WHERE
	dhda.id_autorite = @id_autorite
	and	dhnda.date_debut = date_debut 
	and dhnda.date_fin = date_fin 
	and dhnda.heure_debut = heure_debut 
	and dhnda.heure_fin = heure_fin;
	(timestamp(CONCAT(dhnda.date_debut,' ',dhnda.heure_debut)) BETWEEN @timestamp_debut and @timestamp_fin
	OR timestamp(CONCAT(dhnda.date_fin,' ',dhnda.heure_fin)) BETWEEN @timestamp_debut and @timestamp_fin
	OR (@timestamp_debut BETWEEN timestamp(CONCAT(dhnda.date_debut,' ',dhnda.heure_debut)) and timestamp(CONCAT(dhnda.date_fin,' ',dhnda.heure_fin))
	and @timestamp_fin BETWEEN timestamp(CONCAT(dhnda.date_debut,' ',dhnda.heure_debut)) and timestamp(CONCAT(dhnda.date_fin,' ',dhnda.heure_fin))))
	limit 1;
	select @nbr_rows,@id_non_dispo,@dd,@df,@hd,@hf;
END

CALL `filtre_stage`('2023-01-14', '2023-01-14', '', '', 1, 3)

CREATE  PROCEDURE `filtre_stage`(IN date_debut date, IN date_fin date, IN nom varchar(30), IN prenom VARCHAR(30), in id_domaine INT, IN id_autorite INT)
BEGIN
	set @date1 = date_debut;
	set @date2 = date_fin;

	select 
	ds.id,
    ds.nom,
    ds.prenom,
    ds.duree, 
    ds.e_mail as addresse_electronique,
    d.nom_domaine,
	CASE 
        when eds.id IS NULL THEN 'Non validé'
        ELSE 'Validé'
    END as demande_status,
    eds.id as id_entretien_stage,
    dhda.id as id_date_heure_disponible_autorite
	from demande_stage ds
	JOIN domaine d on ds.id_domaine = d.id
    LEFT JOIN entretien_demande_stage eds on ds.id = eds.id_demande_stage
    LEFT JOIN date_heure_disponible_autorite dhda on eds.id_date_heure_disponible_autorite = dhda.id
	WHERE 
	ds.date_creation between @date1 and @date2
	and ds.id_autorite_enfant = id_autorite
	and
	(
	ds.id_domaine = id_domaine 
	or  ds.nom LIKE concat('%',nom,'%') 
	or ds.prenom LIKE concat('%',prenom,'%')
	or (ds.id_domaine = id_domaine and ds.nom LIKE concat('%',nom,'%') and ds.prenom LIKE concat('%',prenom,'%'))
	)
	GROUP BY ds.id order by ds.date_creation desc;
END


CREATE  PROCEDURE `filtre_calendrier_evenement`(
	IN date_debut date,
	IN date_fin date,
	IN type_evenement VARCHAR(10),
	IN status int,	
	IN id_autorite INT
)
BEGIN 
	IF type_evenement = 'Public' THEN
		select 
		dap.id as id,
		dapdhd.id as id_evenement,
		'Public' as type_evenement,
		dapdhd.date_debut,
		dapdhd.date_fin,
		dapdhd.heure_debut,
		dapdhd.heure_fin,
		dap.motif,
		dap.nom,
		dap.prenom,
		case 
			WHEN dap.action = 0 THEN 'Non validé'
			WHEN dap.action = 1 THEN 'Validé'
			WHEN dap.action = 2 THEN 'Reporté'
			ELSE 'Aucune'
		end as status
		from demande_audience_public dap 
		join dm_aud_public_date_heure_dispo dapdhd on dap.id = dapdhd.id_aud_public
		join date_heure_disponible_autorite dhda on dapdhd.id_date_heure_disponible_autorite = dhda.id
		where dapdhd.date_debut between date_debut and date_fin
		and dhda.id_autorite = id_autorite
		or 
		(dapdhd.date_debut between date_debut and date_fin
		and dap.action = status
		and dhda.id_autorite = id_autorite)
		group by dap.id;  

	ELSEIF type_evenement = 'Autorité' THEN
		select
		daa.id as id,
		daadhd.id as id_evenement,
		'Autorité' as type_evenement,
		daadhd.date_debut,
		daadhd.date_fin,
		daadhd.heure_debut,
		daadhd.heure_fin,
		daa.motif,
		aes.intitule as nom,
		aes.intitule_code as prenom,
		case 
			WHEN daa.action = 0 THEN 'Non validé'
			WHEN daa.action = 1 THEN 'Validé'
			WHEN daa.action = 2 THEN 'Reporté'
			ELSE 'Aucune'
		end as status
		from 
		demande_audience_autorite daa 
		join dm_aud_autorite_date_heure_dispo daadhd on daa.id = daadhd.id_dm_aud_autorite
		join date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
		join autorite_enfant aes on daa.id_autorite_enfant_sender = aes.id
		where daadhd.date_debut between date_debut and date_fin
		and dhda.id_autorite = id_autorite
		or 
		( daadhd.date_debut between date_debut and date_fin 
		and dhda.id_autorite = id_autorite
		and daa.action = status)
		group by daa.id;
	ELSEIF type_evenement = 'Entretien' THEN
		select
		ds.id as id,
		eds.id as id_evenement,
		'Entretien' as type_evenement,
		eds.date_debut,
		eds.date_fin,
		eds.heure_debut,
		eds.heure_fin,
		ds.message as motif,
		ds.nom,
		ds.prenom,
		case 
			WHEN ds.action = 0 THEN 'Non validé'
			WHEN ds.action = 1 THEN 'Validé'
			WHEN ds.action = 2 THEN 'Reporté'
			ELSE 'Aucune'
		end as status		
		from
		demande_stage ds
		join entretien_demande_stage eds on ds.id = eds.id_demande_stage
		join date_heure_disponible_autorite dhda on eds.id_date_heure_disponible_autorite = dhda.id
		where eds.date_debut between date_debut and date_fin
		and dhda.id_autorite = id_autorite
		or
		(eds.date_debut between date_debut and date_fin and ds.action = status and dhda.id_autorite = id_autorite)
		group by ds.id;
	ELSEIF status IS NOT NULL OR type_evenement = '' THEN
		select 
		dap.id as id,
		dapdhd.id as id_evenement,
		'Public' as type_evenement,
		dapdhd.date_debut,
		dapdhd.date_fin,
		dapdhd.heure_debut,
		dapdhd.heure_fin,
		dap.motif,
		dap.nom,
		dap.prenom,
		case 
			WHEN dap.action = 0 THEN 'Non validé'
			WHEN dap.action = 1 THEN 'Validé'
			WHEN dap.action = 2 THEN 'Reporté'
			ELSE 'Aucune'
		end as status
		from demande_audience_public dap 
		join dm_aud_public_date_heure_dispo dapdhd on dap.id = dapdhd.id_aud_public
		join date_heure_disponible_autorite dhda on dapdhd.id_date_heure_disponible_autorite = dhda.id
		where 
		dapdhd.date_debut between date_debut and date_fin
		and dap.action = status
		and dhda.id_autorite = id_autorite
		group by dap.id 
		
		UNION

		select
		daa.id as id,
		daadhd.id as id_evenement,
		'Autorité' as type_evenement,
		daadhd.date_debut,
		daadhd.date_fin,
		daadhd.heure_debut,
		daadhd.heure_fin,
		daa.motif,
		aes.intitule as nom,
		aes.intitule_code as prenom,
		case 
			WHEN daa.action = 0 THEN 'Non validé'
			WHEN daa.action = 1 THEN 'Validé'
			WHEN daa.action = 2 THEN 'Reporté'
			ELSE 'Aucune'
		end as status
		from 
		demande_audience_autorite daa 
		join dm_aud_autorite_date_heure_dispo daadhd on daa.id = daadhd.id_dm_aud_autorite
		join date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
		join autorite_enfant aes on daa.id_autorite_enfant_sender = aes.id
		where daadhd.date_debut between date_debut and date_fin
		and daa.action = status
		and dhda.id_autorite = id_autorite
		group by daa.id

		UNION

		select
		ds.id as id,
		eds.id as id_evenement,
		'Entretien' as type_evenement,
		eds.date_debut,
		eds.date_fin,
		eds.heure_debut,
		eds.heure_fin,
		ds.message as motif,
		ds.nom,
		ds.prenom,
		case 
			WHEN ds.action = 0 THEN 'Non validé'
			WHEN ds.action = 1 THEN 'Validé'
			WHEN ds.action = 2 THEN 'Reporté'
			ELSE 'Aucune'
		end as status		
		from
		demande_stage ds
		join entretien_demande_stage eds on ds.id = eds.id_demande_stage
		join date_heure_disponible_autorite dhda on eds.id_date_heure_disponible_autorite = dhda.id
		where eds.date_debut between date_debut and date_fin 
 	   and ds.action = status
		and dhda.id_autorite = id_autorite
		group by ds.id;		
		
	ELSE	
		select 
		dap.id as id,
		dapdhd.id as id_evenement,
		'Public' as type_evenement,
		dapdhd.date_debut,
		dapdhd.date_fin,
		dapdhd.heure_debut,
		dapdhd.heure_fin,
		dap.motif,
		dap.nom,
		dap.prenom,
		case 
			WHEN dap.action = 0 THEN 'Non validé'
			WHEN dap.action = 1 THEN 'Validé'
			WHEN dap.action = 2 THEN 'Reporté'
			ELSE 'Aucune'
		end as status
		from demande_audience_public dap 
		join dm_aud_public_date_heure_dispo dapdhd on dap.id = dapdhd.id_aud_public
		join date_heure_disponible_autorite dhda on dapdhd.id_date_heure_disponible_autorite = dhda.id
		where 
		dapdhd.date_debut between date_debut and date_fin
		and dhda.id_autorite = id_autorite
		group by dap.id 
		
		UNION

		select
		daa.id as id,
		daadhd.id as id_evenement,
		'Autorité' as type_evenement,
		daadhd.date_debut,
		daadhd.date_fin,
		daadhd.heure_debut,
		daadhd.heure_fin,
		daa.motif,
		aes.intitule as nom,
		aes.intitule_code as prenom,
		case 
			WHEN daa.action = 0 THEN 'Non validé'
			WHEN daa.action = 1 THEN 'Validé'
			WHEN daa.action = 2 THEN 'Reporté'
			ELSE 'Aucune'
		end as status
		from 
		demande_audience_autorite daa 
		join dm_aud_autorite_date_heure_dispo daadhd on daa.id = daadhd.id_dm_aud_autorite
		join date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
		join autorite_enfant aes on daa.id_autorite_enfant_sender = aes.id
		where daadhd.date_debut between date_debut and date_fin
		and dhda.id_autorite = id_autorite
		group by daa.id

		UNION

		select
		ds.id as id,
		eds.id as id_evenement,
		'Entretien' as type_evenement,
		eds.date_debut,
		eds.date_fin,
		eds.heure_debut,
		eds.heure_fin,
		ds.message as motif,
		ds.nom,
		ds.prenom,
		case 
			WHEN ds.action = 0 THEN 'Non validé'
			WHEN ds.action = 1 THEN 'Validé'
			WHEN ds.action = 2 THEN 'Reporté'
			ELSE 'Aucune'
		end as status		
		from
		demande_stage ds
		join entretien_demande_stage eds on ds.id = eds.id_demande_stage
		join date_heure_disponible_autorite dhda on eds.id_date_heure_disponible_autorite = dhda.id
		where eds.date_debut between date_debut and date_fin 
		and dhda.id_autorite = id_autorite
		group by ds.id;
	END IF;
END


CREATE  PROCEDURE `places_disponible`(IN id_date_heure_disponible_autorite INT,IN id_autorite INT)
BEGIN 
	set @id_autorite = id_autorite;
	set @id_hda = id_date_heure_disponible_autorite;
	set @current_time = (SELECT curtime()); 
	set @current_date = (SELECT CURDATE()); 
	set @timestamp_current = timestamp(concat(@current_date,' ',@current_time));

	IF @id_hda IS NOT NULL THEN
		SELECT 
		dhda.id as id_date_heure_disponible_autorite,
		dhd.date_disponible, 
		dhd.heure_debut,
		dhd.heure_fin 
		FROM stage5.date_heure_disponible_autorite dhda 
		join date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id 
		where dhda.id = @id_hda
		UNION
		SELECT 
		dhda.id as id_date_heure_disponible_autorite, 
		dhd.date_disponible, 
		dhd.heure_debut,
		dhd.heure_fin 
		FROM stage5.date_heure_disponible_autorite dhda 
		join date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id 
		LEFT JOIN pas_disponible pd on dhda.id = pd.id_date_heure_disponible_autorite 
		LEFT JOIN dm_aud_autorite_date_heure_dispo daadhd on dhda.id = daadhd.id_date_heure_disponible_autorite 
		LEFT JOIN demande_audience_autorite daa on daa.id = daadhd.id_dm_aud_autorite 
		LEFT JOIN dm_aud_public_date_heure_dispo dapdhd on dhda.id = dapdhd.id_date_heure_disponible_autorite 
		LEFT JOIN demande_audience_public dap on dap.id = dapdhd.id_aud_public 
		LEFT JOIN entretien_demande_stage eds on dhda.id = eds.id_date_heure_disponible_autorite 
		where dhda.id_autorite = @id_autorite 
		and @timestamp_current BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) AND timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)) 
		and eds.id is null 
		and daadhd.id is null 
		and dapdhd.id is null 
		and pd.id is null; 
	ELSE
		SELECT 
		dhda.id as id_date_heure_disponible_autorite, 
		dhd.date_disponible, 
		dhd.heure_debut,
		dhd.heure_fin 
		FROM stage5.date_heure_disponible_autorite dhda 
		join date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id 
		LEFT JOIN pas_disponible pd on dhda.id = pd.id_date_heure_disponible_autorite 
		LEFT JOIN dm_aud_autorite_date_heure_dispo daadhd on dhda.id = daadhd.id_date_heure_disponible_autorite 
		LEFT JOIN demande_audience_autorite daa on daa.id = daadhd.id_dm_aud_autorite 
		LEFT JOIN dm_aud_public_date_heure_dispo dapdhd on dhda.id = dapdhd.id_date_heure_disponible_autorite 
		LEFT JOIN demande_audience_public dap on dap.id = dapdhd.id_aud_public 
		LEFT JOIN entretien_demande_stage eds on dhda.id = eds.id_date_heure_disponible_autorite 
		where dhda.id_autorite = @id_autorite 
		and @timestamp_current BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) AND timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)) 
		and eds.id is null 
		and daadhd.id is null 
		and dapdhd.id is null 
		and pd.id is null; 		
	END IF;	

END