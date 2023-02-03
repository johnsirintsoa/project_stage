CREATE SCHEMA stage5;

CREATE TABLE stage5.autorite_parent ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	intitule             VARCHAR(200)  NOT NULL    
 ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.date_heure_disponible ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	date_disponible      DATE  NOT NULL    ,
	duree                TIME  NOT NULL    
 ) ENGINE=InnoDB AUTO_INCREMENT=510 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.date_heure_non_disponible_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	date_debut           DATE  NOT NULL    ,
	date_fin             DATE  NOT NULL    ,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	id_autorite          INT  NOT NULL    
 ) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.demande_audience_public ( 
	motif                VARCHAR(200)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	action               INT  NOT NULL DEFAULT ('0')   ,
	cin                  VARCHAR(15)  NOT NULL    ,
	numero_telephone     VARCHAR(10)  NOT NULL    ,
	email                VARCHAR(200)  NOT NULL    ,
	nom                  VARCHAR(30)  NOT NULL    ,
	prenom               VARCHAR(30)  NOT NULL    ,
	session_navigateur   VARCHAR(100)  NOT NULL    
 ) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.domaine ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nom_domaine          VARCHAR(30)  NOT NULL    
 ) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.jour_ferie ( 
	nom_evenement        VARCHAR(30)      ,
	numero_du_jour       VARCHAR(20)      ,
	mois_du_jour         VARCHAR(20)      ,
	time_event_debut     TIME  NOT NULL    ,
	time_event_fin       TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY
 ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.autorite_enfant ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	intitule             VARCHAR(200)  NOT NULL    ,
	intitule_code        VARCHAR(10)  NOT NULL    ,
	id_autorite_parent   INT      ,
	addresse_electronique VARCHAR(200)  NOT NULL    ,
	mot_de_passe_mailing VARCHAR(100)  NOT NULL    ,
	porte                VARCHAR(5)  NOT NULL    ,
	CONSTRAINT fk_autorite_enfant_autorite_parent_id_autorite_parent FOREIGN KEY ( id_autorite_parent ) REFERENCES stage5.autorite_parent( id ) ON DELETE SET NULL ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.date_heure_disponible_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_date_heure_disponible INT      ,
	id_autorite          INT      ,
	est_disponible       TINYINT  NOT NULL DEFAULT ('1')   ,
	CONSTRAINT fk_date_disponible_autorite_id_autorite FOREIGN KEY ( id_autorite ) REFERENCES stage5.autorite_enfant( id ) ON DELETE SET NULL ON UPDATE NO ACTION,
	CONSTRAINT fk_date_disponible_autorite_id_date_disponible FOREIGN KEY ( id_date_heure_disponible ) REFERENCES stage5.date_heure_disponible( id ) ON DELETE SET NULL ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=911 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.demande_audience_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_autorite_enfant_sender INT      ,
	motif                VARCHAR(200)  NOT NULL    ,
	action               INT  NOT NULL DEFAULT ('0')   ,
	CONSTRAINT fk_demande_audience_autorite FOREIGN KEY ( id_autorite_enfant_sender ) REFERENCES stage5.autorite_enfant( id ) ON DELETE SET NULL ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;

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
	id_domaine           INT      ,
	id_autorite_enfant   INT      ,
	date_creation        DATE  NOT NULL    ,
	action               INT  NOT NULL DEFAULT ('0')   ,
	CONSTRAINT fk_demande_stage_id_autorite_enfant FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage5.autorite_enfant( id ) ON DELETE SET NULL ON UPDATE NO ACTION,
	CONSTRAINT fk_demande_stage_id_domaine FOREIGN KEY ( id_domaine ) REFERENCES stage5.domaine( id ) ON DELETE SET NULL ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.dm_aud_autorite_date_heure_dispo ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_date_heure_disponible_autorite INT      ,
	id_dm_aud_autorite   INT      ,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	date_debut           DATE      ,
	date_fin             DATE      ,
	CONSTRAINT fk_dm_aud_autorite_date_heure_dispo_id_daa FOREIGN KEY ( id_dm_aud_autorite ) REFERENCES stage5.demande_audience_autorite( id ) ON DELETE SET NULL ON UPDATE NO ACTION,
	CONSTRAINT fk_dm_aud_autorite_date_heure_dispo_id_dh_da FOREIGN KEY ( id_date_heure_disponible_autorite ) REFERENCES stage5.date_heure_disponible_autorite( id ) ON DELETE SET NULL ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=255 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.dm_aud_public_date_heure_dispo ( 
	id_aud_public        INT      ,
	id_date_heure_disponible_autorite INT      ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	date_debut           DATE      ,
	date_fin             DATE      ,
	CONSTRAINT fk_dm_aud_public_date_heure_dispo FOREIGN KEY ( id_aud_public ) REFERENCES stage5.demande_audience_public( id ) ON DELETE CASCADE ON UPDATE NO ACTION,
	CONSTRAINT fk_dm_aud_public_date_heure_dispo_id_date_heure_disponible FOREIGN KEY ( id_date_heure_disponible_autorite ) REFERENCES stage5.date_heure_disponible_autorite( id ) ON DELETE SET NULL ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=515 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.doleance ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	session_navigateur   VARCHAR(100)  NOT NULL    ,
	e_mail               VARCHAR(100)      ,
	titre                VARCHAR(100)  NOT NULL    ,
	cin                  VARCHAR(12)      ,
	numero_telephone     VARCHAR(10)      ,
	message              TEXT  NOT NULL    ,
	nom                  VARCHAR(50)      ,
	prenom               VARCHAR(30)      ,
	date_publication     DATE  NOT NULL    ,
	id_autorite          INT      ,
	heure_publication    TIME  NOT NULL    ,
	message2             TEXT  NOT NULL    ,
	CONSTRAINT fk_doleance_autorite_enfant FOREIGN KEY ( id_autorite ) REFERENCES stage5.autorite_enfant( id ) ON DELETE SET NULL ON UPDATE SET NULL
 ) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.entretien_demande_stage ( 
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_demande_stage     INT      ,
	id_date_heure_disponible_autorite INT      ,
	date_debut           DATE      ,
	date_fin             DATE      ,
	CONSTRAINT fk_entretien_demande_stage_id_date_heure_disponible_autorite FOREIGN KEY ( id_date_heure_disponible_autorite ) REFERENCES stage5.date_heure_disponible_autorite( id ) ON DELETE SET NULL ON UPDATE NO ACTION,
	CONSTRAINT fk_entretien_demande_stage_id_demande_stage FOREIGN KEY ( id_demande_stage ) REFERENCES stage5.demande_stage( id ) ON DELETE SET NULL ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.pas_disponible ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_date_heure_disponible_autorite INT  NOT NULL    ,
	id_date_heure_non_disponible_autorite INT  NOT NULL    ,
	CONSTRAINT fk_pas_disponible_id_date_heure_disponible_autorite FOREIGN KEY ( id_date_heure_disponible_autorite ) REFERENCES stage5.date_heure_disponible_autorite( id ) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_pas_disponible_id_date_heure_non_disponible_autorite FOREIGN KEY ( id_date_heure_non_disponible_autorite ) REFERENCES stage5.date_heure_non_disponible_autorite( id ) ON DELETE CASCADE ON UPDATE CASCADE
 ) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.profil ( 
	mot_de_passe         VARCHAR(255)  NOT NULL    ,
	nom_utilisateur      VARCHAR(30)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	est_administrateur   SMALLINT  NOT NULL DEFAULT ('0')   ,
	id_autorite_enfant   INT      ,
	CONSTRAINT fk_profil_autorite_enfant_id_autorite FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage5.autorite_enfant( id ) ON DELETE SET NULL ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

CREATE INDEX fk_date_heure_non_disponible_autorite_id_autorite ON stage5.date_heure_non_disponible_autorite ( id_autorite );

CREATE INDEX fk_autorite_enfant_autorite_parent_id_autorite_parent ON stage5.autorite_enfant ( id_autorite_parent );

CREATE INDEX fk_date_disponible_autorite_id_date_disponible ON stage5.date_heure_disponible_autorite ( id_date_heure_disponible );

CREATE INDEX fk_date_disponible_autorite_id_autorite ON stage5.date_heure_disponible_autorite ( id_autorite );

CREATE INDEX fk_demande_audience_autorite ON stage5.demande_audience_autorite ( id_autorite_enfant_sender );

CREATE INDEX fk_demande_stage_id_domaine ON stage5.demande_stage ( id_domaine );

CREATE INDEX fk_demande_stage_id_autorite_enfant ON stage5.demande_stage ( id_autorite_enfant );

CREATE INDEX fk_dm_aud_autorite_date_heure_dispo_id_dh_da ON stage5.dm_aud_autorite_date_heure_dispo ( id_date_heure_disponible_autorite );

CREATE INDEX fk_dm_aud_autorite_date_heure_dispo_id_daa ON stage5.dm_aud_autorite_date_heure_dispo ( id_dm_aud_autorite );

CREATE INDEX fk_dm_aud_public_date_heure_dispo ON stage5.dm_aud_public_date_heure_dispo ( id_aud_public );

CREATE INDEX fk_dm_aud_public_date_heure_dispo_id_date_heure_disponible ON stage5.dm_aud_public_date_heure_dispo ( id_date_heure_disponible_autorite );

CREATE INDEX fk_doleance_autorite_enfant ON stage5.doleance ( id_autorite );

CREATE INDEX fk_entretien_demande_stage_id_demande_stage ON stage5.entretien_demande_stage ( id_demande_stage );

CREATE INDEX fk_entretien_demande_stage_id_date_heure_disponible_autorite ON stage5.entretien_demande_stage ( id_date_heure_disponible_autorite );

CREATE INDEX fk_pas_disponible_id_date_heure_disponible_autorite ON stage5.pas_disponible ( id_date_heure_disponible_autorite );

CREATE INDEX fk_pas_disponible_id_date_heure_non_disponible_autorite ON stage5.pas_disponible ( id_date_heure_non_disponible_autorite );

CREATE INDEX fk_profil_autorite_enfant_id_autorite ON stage5.profil ( id_autorite_enfant );

CREATE  PROCEDURE `ajouter_audience_autorite`(IN id_autorite_sender INT,
IN id_autorite_receiver INT,
IN id_date_heure_disponible_autorite INT,
IN motif VARCHAR(200),
IN date_debut DATE,
IN date_fin Date,
IN heure_debut time,
IN heure_fin time)
BEGIN 
	SET @sender = id_autorite_sender; 
	SET @receiver = id_autorite_receiver; 
	SET @motif = motif; 
	SET @id_dhda = id_date_heure_disponible_autorite; 
	SET @hd = heure_debut;
	SET @hf = heure_fin;	

	-- Ajouter Audience
	INSERT INTO demande_audience_autorite
	(id_autorite_enfant_sender,motif) 
	VALUES (@sender,@motif);
	
	set @id_audience_tmp = (SELECT max(id) from demande_audience_autorite where id_autorite_sender = @sender);

	-- Ajouter audience et date heure disponible autorite dans dm_aud_public_date_heure_dispo
	INSERT INTO dm_aud_autorite_date_heure_dispo
	( id_dm_aud_autorite, id_date_heure_disponible_autorite, date_debut,date_fin, heure_debut, heure_fin) 
	VALUES (@id_audience_tmp, @id_dhda ,date_debut,date_fin,@hd,@hf);
	SELECT 'Audience a été ajouté avec succès' as message;
END

CREATE  PROCEDURE `ajouter_audience_public`(IN session_navigateur VARCHAR(100),
IN nom varchar(30),
IN prenom varchar(30),
IN cin varchar(15),
IN numero_telephone varchar(10),
IN email varchar(30),
IN id_date_heure_disponible_autorite INT,
IN motif VARCHAR(200),
IN date_debut date,
IN date_fin date,
IN heure_debut time,
IN heure_fin time)
BEGIN 
	SET @session_navigateur = session_navigateur; 
	SET @nom = (SELECT UPPER(nom)); 
	SET @prenom = (SELECT LOWER(prenom)); 
	SET @cin = cin; 
	SET @numero_telephone = numero_telephone; 
	SET @email = email; 
	SET @motif = motif; 
	SET @id_hd = id_date_heure_disponible_autorite; 
	SET @hd = heure_debut;
	SET @hf = heure_fin;	

	-- Ajouter Audience
	INSERT INTO demande_audience_public
	(nom, prenom,numero_telephone, email,motif,cin,  session_navigateur) 
	VALUES (@nom, @prenom,@numero_telephone, @email,@motif,@cin, @session_navigateur);
	
	set @id_audience_tmp = (SELECT max(id) from demande_audience_public where session_navigateur = @session_navigateur and cin = @cin);

	-- Ajouter audience et date heure disponible autorite dans dm_aud_public_date_heure_dispo
	INSERT INTO dm_aud_public_date_heure_dispo
	( id_aud_public, id_date_heure_disponible_autorite, date_debut,date_fin ,heure_debut, heure_fin) 
	VALUES (@id_audience_tmp, @id_hd ,date_debut,date_fin,@hd,@hf);
	SELECT 'Audience a été ajouté avec succès' as message;
END

CREATE  PROCEDURE `ajouter_date_heure_disponible`(IN date_disponible date,IN heure_debut time,IN heure_fin time,IN duree_disponibilite time)
BEGIN
	DECLARE hds,hfs,das INT;
	DECLARE tmp_hfs int DEFAULT 0;
	set @hds = time_to_sec(heure_debut);
	set @hfs = time_to_sec(heure_fin);
	set @das = time_to_sec(duree_disponibilite);
	WHILE @hds < @hfs DO
		set @tmp_hfs = @hds + @das;
		INSERT INTO stage5.date_heure_disponible(date_disponible,heure_debut, heure_fin,duree) VALUES (date_disponible,sec_to_time(@hds),sec_to_time(@tmp_hfs),duree_disponibilite);
		set @hds = @tmp_hfs;
	END WHILE;
END

CREATE  PROCEDURE `ajouter_date_heure_disponible_autorite`(IN id_autorite int,IN heure_debut time , IN heure_fin time, in date_disponible date)
BEGIN
	
	set @nbr_heure_disponible = (
		select count(id) from date_heure_disponible dhd  
		where 
		dhd.heure_debut >= heure_debut 
		and dhd.heure_fin <= heure_fin 
		and dhd.date_disponible = date_disponible
	);

	IF @nbr_heure_disponible = 0 THEN
		CALL `ajouter_date_heure_disponible`(date_disponible,heure_debut,heure_fin,'00:30:00');
		INSERT INTO date_heure_disponible_autorite ( id_date_heure_disponible, id_autorite )
		SELECT
		dhd.id,
		id_autorite
		FROM
		date_heure_disponible dhd 
		where dhd.heure_debut >= heure_debut and dhd.heure_fin <= heure_fin and dhd.date_disponible = date_disponible;
		
	ELSE
		INSERT INTO date_heure_disponible_autorite ( id_date_heure_disponible, id_autorite )
		SELECT
		dhd.id,
		id_autorite
		FROM
		date_heure_disponible dhd 
		where dhd.heure_debut >= heure_debut and dhd.heure_fin <= heure_fin and dhd.date_disponible = date_disponible;
	END IF;
END

CREATE  PROCEDURE `ajouter_dm_aud_autorite_date_heure_dispo_entre_deux_date`(IN id_audience INT ,IN date_debut DATE, IN date_fin DATE, IN heure_debut time, IN heure_fin time,IN id_autorite int)
BEGIN
	set @id_autorite = id_autorite;
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));

	set @id_aud_autorite = id_audience;

	INSERT INTO stage5.dm_aud_autorite_date_heure_dispo (id_dm_aud_autorite, id_date_heure_disponible_autorite, heure_debut, heure_fin, date_debut, date_fin)
	SELECT 
	@id_aud_autorite,
	dhda.id,
	heure_debut,
	heure_fin,
	date_debut,
	date_fin
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
END

CREATE  PROCEDURE `ajouter_dm_aud_public_date_heure_dispo_entre_deux_date`(IN id_audience INT ,IN date_debut DATE, IN date_fin DATE, IN heure_debut time, IN heure_fin time, IN id_autorite int)
BEGIN
	set @id_autorite = id_autorite;
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));

	set @id_aud_public = id_audience;

	INSERT INTO stage5.dm_aud_public_date_heure_dispo (id_aud_public, id_date_heure_disponible_autorite, heure_debut, heure_fin, date_debut, date_fin)
	SELECT 
	@id_aud_public,
	dhda.id,
	heure_debut,
	heure_fin,
	date_debut,
	date_fin
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
END

CREATE  PROCEDURE `ajouter_entretien_stage`(
	IN id_demande_stage INT,
	IN id_date_heure_disponible_autorite INT
)
BEGIN 
	SET @id_ds = id_demande_stage;
	SET @id_hd = id_date_heure_disponible_autorite;

	select dhd.heure_debut, dhd.heure_fin, dhd.date_disponible,dhd.date_disponible INTO @hd,@hf,@date_debut,@date_fin 
	from date_heure_disponible_autorite dhda
	join date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id where dhda.id = @id_hd;

	-- Ajouter entretien
	INSERT INTO stage5.entretien_demande_stage
	( heure_debut, heure_fin,id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin) 
	VALUES (@hd, @hf, @id_ds, @id_hd, @date_debut, @date_fin);

	SELECT 'Entretien a été bien ajouté avec succès' as message,@hd as heure_debut,@date_debut as date_debut;
END

CREATE  PROCEDURE `ajouter_entretien_stage_date_heure_dispo_entre_deux_date`(IN id_demande_stage INT ,IN date_debut DATE, IN date_fin DATE, IN heure_debut time, IN heure_fin time, IN id_autorite int)
BEGIN
	set @id_autorite = id_autorite;
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));

	set @id_demande_stage = id_demande_stage;

	INSERT INTO entretien_demande_stage (id_demande_stage, id_date_heure_disponible_autorite, heure_debut, heure_fin, date_debut, date_fin)
	SELECT 
	@id_demande_stage,
	dhda.id,
	heure_debut,
	heure_fin,
	date_debut,
	date_fin
	FROM
	date_heure_disponible_autorite dhda 
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
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
END

CREATE  PROCEDURE `ajouter_non_disponible_autorite`(IN id_autorite INT,IN date_debut date,IN date_fin date,IN heure_debut time,IN heure_fin time)
BEGIN
	set @id_autorite = id_autorite;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',@hd));
	set @timestamp_fin = timestamp(concat(date_fin,' ',@hf));

	set @nbr_rows_date_dispo = (
		SELECT 
		count(dhda.id)
		FROM
		date_heure_disponible_autorite dhda 
		JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		where 
		dhda.id_autorite = @id_autorite
		and dhd.date_disponible between date_debut and date_fin		
	);

	IF date_debut = date_fin THEN 
		IF @nbr_rows_date_dispo = 0 THEN
			CALL `ajouter_date_heure_disponible_autorite`(@id_autorite,'08:00:00' , '16:00:00' , date_debut );
		END IF;
	ELSEIF date_debut < date_fin THEN  	
		CALL `verifier_date_heure_dispo_entre_deux_dates`(date_debut, date_fin ,@id_autorite);
	END IF;	

	SELECT count(dhnda.id),dhnda.id INTO @nbr_rows,@id_non_dispo	 
	FROM date_heure_non_disponible_autorite dhnda
	WHERE
	dhnda.id_autorite = @id_autorite
	and dhnda.date_debut = date_debut 
	and dhnda.date_fin = date_fin 
	and dhnda.heure_debut = heure_debut 
	and dhnda.heure_fin = heure_fin;
	
	IF @nbr_rows = 0 THEN 
		INSERT INTO date_heure_non_disponible_autorite ( date_debut, date_fin, heure_debut, heure_fin, id_autorite) 
		VALUES ( date_debut, date_fin, heure_debut, heure_fin, @id_autorite );

		SELECT dhnda.id INTO @id_non_dispo
		FROM date_heure_non_disponible_autorite dhnda
		WHERE
		dhnda.id_autorite = @id_autorite 
		and dhnda.date_debut = date_debut 
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

CREATE  PROCEDURE `calendrier_autorite`(IN id_autorite INT,IN est_admin boolean)
BEGIN
	set @is_admin = est_admin;
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

	CONCAT(daadhd.date_debut,'T',daadhd.heure_debut) as start,
	CONCAT(daadhd.date_fin,'T',daadhd.heure_fin) as end,
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
		ELSE '#000000'
	END AS color_status,
	'Autorité' type_audience,
	CASE 
		WHEN @is_admin = 1 and daa.action = 1 or @is_admin = 1 and daa.action >= 1 THEN false
		ELSE true
	END AS editable
	FROM
	dm_aud_autorite_date_heure_dispo daadhd
	LEFT join date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
	LEFT JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id 
	LEFT JOIN autorite_enfant ae on dhda.id_autorite = ae.id
	LEFT JOIN demande_audience_autorite daa on daadhd.id_dm_aud_autorite = daa.id
	LEFT join autorite_enfant aes on daa.id_autorite_enfant_sender = aes.id	
	where dhd.date_disponible >= CURDATE() and dhda.id_autorite = @id_autorite
	GROUP by daadhd.id_dm_aud_autorite

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

	CONCAT(dapdhd.date_debut,'T',dapdhd.heure_debut) as start,
	CONCAT(dapdhd.date_fin,'T',dapdhd.heure_fin) as end,
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
		ELSE '#000000'
	END AS color_status,
	'Public' type_audience,
	CASE 
		WHEN @is_admin = 1 and dap.action = 1 or @is_admin = 1 and dap.action >= 1 THEN false
		ELSE true
	END AS editable
	FROM stage5.dm_aud_public_date_heure_dispo dapdhd
	LEFT JOIN date_heure_disponible_autorite dhda on dapdhd.id_date_heure_disponible_autorite = dhda.id
	LEFT JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	LEFT JOIN autorite_enfant ae on dhda.id_autorite = ae.id
	LEFT JOIN demande_audience_public dap on dapdhd.id_aud_public = dap.id
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

	CONCAT(eds.date_debut,'T',eds.heure_debut) as start,
	CONCAT(eds.date_fin,'T',eds.heure_fin) as end,
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
	CASE 
		WHEN @is_admin = 1 THEN false
		ELSE true
	END AS editable
	from entretien_demande_stage eds
	JOIN date_heure_disponible_autorite dhda on eds.id_date_heure_disponible_autorite = dhda.id
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	JOIN demande_stage ds on eds.id_demande_stage = ds.id
	JOIN autorite_enfant ae on dhda.id_autorite = ae.id
	where dhd.date_disponible >= CURDATE() and dhda.id_autorite = @id_autorite
	group by ds.id

	UNION
	
	select
	pd.id as id,
	'' id_date_heure_disponible_autorite,
	'' id_date_heure_disponible,

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

	CONCAT(dhnda.date_debut,'T',dhnda.heure_debut) as start,
	CONCAT(dhnda.date_fin,'T',dhnda.heure_fin) as end,
	dhnda.id id_evenement,
	'Pas disponible' as title,
	'' motif,
	dhnda.date_debut as date_debut,
	dhnda.date_fin as date_fin,
	dhnda.heure_debut as heure_debut,
	dhnda.heure_fin as heure_fin,
	'Pas disponible' status_audience,
	'' nom,
	'' prenom,
	'' numero_telephone,
	'' cin,
	'' addresse_electronique_sender_externe,
	'#000000' color,
	'' color_status,
	'Pas disponible' type_audience,
	CASE 
		WHEN @is_admin = 1 THEN false
		ELSE true
	END AS editable
	from date_heure_non_disponible_autorite dhnda
	JOIN pas_disponible pd on dhnda.id = pd.id_date_heure_non_disponible_autorite
	JOIN date_heure_disponible_autorite dhda on pd.id_date_heure_disponible_autorite = dhda.id
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	JOIN autorite_enfant ae on dhda.id_autorite = ae.id
	where dhd.date_disponible >= CURDATE() and dhda.id_autorite = @id_autorite
	GROUP by dhnda.id;
END

CREATE  PROCEDURE `est_disponible_false`(IN id_autorite INT,IN date_debut date,IN date_fin date,IN heure_debut time,IN heure_fin time)
BEGIN
	set @id_autorite = id_autorite;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));

	-- date heure disponible autorite set false
	UPDATE date_heure_disponible_autorite 
	set est_disponible = false 
	WHERE id IN (
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
			(timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin
			OR timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin)
			OR
			dhda.id_autorite = @id_autorite
			and dhda.est_disponible = 1
			and 
			(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))
			and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))))
		) as t
	);
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
		dapdhd.id_date_heure_disponible_autorite as id_date_heure_disponible_autorite,
		'Public' as type_evenement,
		dapdhd.date_debut,
		dapdhd.date_fin,
		dapdhd.heure_debut,
		dapdhd.heure_fin,
		dap.motif,
		dap.nom,
		dap.prenom,
		dap.cin as cin,
		dap.numero_telephone as numero_telephone,
		dap.email as addresse_electronique,
		'' intitule_sender,
		'' intitule_code_sender,
		'' intitule_sender_addresse_electronique,
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
		daadhd.id_date_heure_disponible_autorite as id_date_heure_disponible_autorite,
		'Autorité' as type_evenement,
		daadhd.date_debut,
		daadhd.date_fin,
		daadhd.heure_debut,
		daadhd.heure_fin,
		daa.motif,
		aes.intitule as nom,
		aes.intitule_code as prenom,
		'' cin,
		'' numero_telephone,
		'' addresse_electronique,
		aes.intitule as intitule_sender,
		aes.intitule_code as intitule_code_sender,
		aes.addresse_electronique as intitule_sender_addresse_electronique,
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
		eds.id_date_heure_disponible_autorite as id_date_heure_disponible_autorite,
		'Entretien' as type_evenement,
		eds.date_debut,
		eds.date_fin,
		eds.heure_debut,
		eds.heure_fin,
		ds.message as motif,
		ds.nom,
		ds.prenom,
		ds.cin as cin,
		ds.telephone as numero_telephone,
		ds.e_mail as addresse_electronique,
		'' intitule_sender,
		'' intitule_code_sender,
		'' intitule_sender_addresse_electronique,
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
	ELSEIF status IS NOT NULL and type_evenement = '' THEN
		select 
		dap.id as id,
		dapdhd.id as id_evenement,
		dapdhd.id_date_heure_disponible_autorite as id_date_heure_disponible_autorite,
		'Public' as type_evenement,
		dapdhd.date_debut,
		dapdhd.date_fin,
		dapdhd.heure_debut,
		dapdhd.heure_fin,
		dap.motif,
		dap.nom,
		dap.prenom,
		dap.cin as cin,
		dap.numero_telephone as numero_telephone,
		dap.email as addresse_electronique,
		'' intitule_sender,
		'' intitule_code_sender,
		'' intitule_sender_addresse_electronique,
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
		daadhd.id_date_heure_disponible_autorite as id_date_heure_disponible_autorite,
		'Autorité' as type_evenement,
		daadhd.date_debut,
		daadhd.date_fin,
		daadhd.heure_debut,
		daadhd.heure_fin,
		daa.motif,
		aes.intitule as nom,
		aes.intitule_code as prenom,
		'' cin,
		'' numero_telephone,
		'' addresse_electronique,
		aes.intitule as intitule_sender,
		aes.intitule_code as intitule_code_sender,
		aes.addresse_electronique as intitule_sender_addresse_electronique,
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
		eds.id_date_heure_disponible_autorite as id_date_heure_disponible_autorite,
		'Entretien' as type_evenement,
		eds.date_debut,
		eds.date_fin,
		eds.heure_debut,
		eds.heure_fin,
		ds.message as motif,
		ds.nom,
		ds.prenom,
		ds.cin as cin,
		ds.telephone as numero_telephone,
		ds.e_mail as addresse_electronique,
		'' intitule_sender,
		'' intitule_code_sender,
		'' intitule_sender_addresse_electronique,
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
		dapdhd.id_date_heure_disponible_autorite as id_date_heure_disponible_autorite,
		'Public' as type_evenement,
		dapdhd.date_debut,
		dapdhd.date_fin,
		dapdhd.heure_debut,
		dapdhd.heure_fin,
		dap.motif,
		dap.nom,
		dap.prenom,
		dap.cin as cin,
		dap.numero_telephone as numero_telephone,
		dap.email as addresse_electronique,
		'' intitule_sender,
		'' intitule_code_sender,
		'' intitule_sender_addresse_electronique,
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
		daadhd.id_date_heure_disponible_autorite as id_date_heure_disponible_autorite,
		'Autorité' as type_evenement,
		daadhd.date_debut,
		daadhd.date_fin,
		daadhd.heure_debut,
		daadhd.heure_fin,
		daa.motif,
		aes.intitule as nom,
		aes.intitule_code as prenom,
		'' cin,
		'' numero_telephone,
		'' addresse_electronique,
		aes.intitule as intitule_sender,
		aes.intitule_code as intitule_code_sender,
		aes.addresse_electronique as intitule_sender_addresse_electronique,
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
		eds.id_date_heure_disponible_autorite as id_date_heure_disponible_autorite,
		'Entretien' as type_evenement,
		eds.date_debut,
		eds.date_fin,
		eds.heure_debut,
		eds.heure_fin,
		ds.message as motif,
		ds.nom,
		ds.prenom,
		ds.cin as cin,
		ds.telephone as numero_telephone,
		ds.e_mail as addresse_electronique,
		'' intitule_sender,
		'' intitule_code_sender,
		'' intitule_sender_addresse_electronique,
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

CREATE  PROCEDURE `filtre_doleance`(
	IN date1 date,
	IN date2 date,
	IN type_doleance SMALLINT,
	IN nbr_filtre SMALLINT,
	IN id_autorite INT
)
BEGIN

	IF nbr_filtre = 0 THEN
		IF type_doleance = 0 THEN	
			select 
			d.id,
			d.nom,
			d.prenom,
			d.cin,
			d.e_mail,
			d.message,
			d.numero_telephone,
			d.titre,
			CASE 
				WHEN d.nom IS NULL or d.prenom IS NULL or d.cin IS NULL or d.e_mail IS NULL or d.numero_telephone IS NULL THEN 'Anonyme'
				ELSE 'Non anonyme' 
			END as type_doleance,
			CONCAT(d.date_publication,' ',d.heure_publication) AS date_heure_publication
			from doleance d
			WHERE d.id_autorite = id_autorite and 
			d.date_publication between date1 and date2 
			AND (d.nom IS NOT NULL AND d.prenom IS NOT NULL AND d.cin IS NOT NULL AND d.e_mail IS NOT NULL AND d.numero_telephone IS NOT NULL) order by CONCAT(d.date_publication,' ',d.heure_publication) DESC;		
		ELSEIF type_doleance = 1 THEN
			select 
			d.id,
			d.nom,
			d.prenom,
			d.cin,
			d.e_mail,
			d.message,
			d.numero_telephone,
			d.titre,
			CASE 
				WHEN d.nom IS NULL or d.prenom IS NULL or d.cin IS NULL or d.e_mail IS NULL or d.numero_telephone IS NULL THEN 'Anonyme'
				ELSE 'Non anonyme' 
			END as type_doleance,
			CONCAT(d.date_publication,' ',d.heure_publication) AS date_heure_publication
			from doleance d
			WHERE d.id_autorite = id_autorite and 
			d.date_publication between date1 and date2 
			AND (d.nom IS NULL or d.prenom IS NULL or d.cin IS NULL or d.e_mail IS NULL or d.numero_telephone IS NULL) order by CONCAT(d.date_publication,' ',d.heure_publication) DESC;
		ELSEIF type_doleance = 2 THEN			
			select 
			d.id,
			d.nom,
			d.prenom,
			d.cin,
			d.e_mail,
			d.message,
			d.numero_telephone,
			d.titre,
			CASE 
				WHEN d.nom IS NULL or d.prenom IS NULL or d.cin IS NULL or d.e_mail IS NULL or d.numero_telephone IS NULL THEN 'Anonyme'
				ELSE 'Non anonyme' 
			END as type_doleance,
			CONCAT(d.date_publication,' ',d.heure_publication) AS date_heure_publication
			from doleance d
			WHERE d.id_autorite = id_autorite and 
			d.date_publication between date1 and date2 order by CONCAT(d.date_publication,' ',d.heure_publication) DESC;	
		END IF; 
	ELSE
		IF type_doleance = 0 THEN	
			select 
			d.id,
			d.nom,
			d.prenom,
			d.cin,
			d.e_mail,
			d.message,
			d.numero_telephone,
			d.titre,
			CASE 
				WHEN d.nom IS NULL or d.prenom IS NULL or d.cin IS NULL or d.e_mail IS NULL or d.numero_telephone IS NULL THEN 'Anonyme'
				ELSE 'Non anonyme' 
			END as type_doleance,
			CONCAT(d.date_publication,' ',d.heure_publication) AS date_heure_publication
			from doleance d
			WHERE d.id_autorite = id_autorite and 
			d.date_publication between date1 and date2 
			AND (d.nom IS NOT NULL AND d.prenom IS NOT NULL AND d.cin IS NOT NULL AND d.e_mail IS NOT NULL AND d.numero_telephone IS NOT NULL) order by CONCAT(d.date_publication,' ',d.heure_publication) DESC limit nbr_filtre ;		
		ELSEIF type_doleance = 1 THEN
			select 
			d.id,
			d.nom,
			d.prenom,
			d.cin,
			d.e_mail,
			d.message,
			d.numero_telephone,
			d.titre,
			CASE 
				WHEN d.nom IS NULL or d.prenom IS NULL or d.cin IS NULL or d.e_mail IS NULL or d.numero_telephone IS NULL THEN 'Anonyme'
				ELSE 'Non anonyme' 
			END as type_doleance,
			CONCAT(d.date_publication,' ',d.heure_publication) AS date_heure_publication
			from doleance d
			WHERE d.id_autorite = id_autorite and 
			d.date_publication between date1 and date2 
			AND (d.nom IS NULL or d.prenom IS NULL or d.cin IS NULL or d.e_mail IS NULL or d.numero_telephone IS NULL) order by CONCAT(d.date_publication,' ',d.heure_publication) DESC limit nbr_filtre;		
		ELSEIF type_doleance = 2 THEN 	
			select 
			d.id,
			d.nom,
			d.prenom,
			d.cin,
			d.e_mail,
			d.message,
			d.numero_telephone,
			d.titre,
			CASE 
				WHEN d.nom IS NULL or d.prenom IS NULL or d.cin IS NULL or d.e_mail IS NULL or d.numero_telephone IS NULL THEN 'Anonyme'
				ELSE 'Non anonyme' 
			END as type_doleance,
			CONCAT(d.date_publication,' ',d.heure_publication) AS date_heure_publication
			from doleance d
			WHERE d.id_autorite = id_autorite and 
			d.date_publication between date1 and date2 order by CONCAT(d.date_publication,' ',d.heure_publication) DESC limit nbr_filtre;	
		END IF; 
	END IF;
END

CREATE  PROCEDURE `filtre_stage`(IN date_debut date, IN date_fin date, IN nom varchar(30), IN prenom VARCHAR(30), in id_domaine INT, IN id_autorite INT)
BEGIN
	set @date1 = date_debut;
	set @date2 = date_fin;

	IF nom = '' and prenom != '' and id_domaine IS NOT NULL THEN 
		select 
		ds.id,
	    ds.nom,
	    ds.prenom,
	    ds.duree, 
	    ds.e_mail as addresse_electronique,
	    d.nom_domaine,
		ds.date_creation,
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
		and ds.id_domaine = id_domaine
		and ds.prenom LIKE concat('%',prenom,'%')
		GROUP BY ds.id order by ds.date_creation desc;

	ELSEIF nom != '' and prenom = '' and id_domaine IS NOT NULL THEN
		select 
		ds.id,
	    ds.nom,
	    ds.prenom,
	    ds.duree, 
	    ds.e_mail as addresse_electronique,
	    d.nom_domaine, 
		ds.date_creation,
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
		and ds.id_domaine = id_domaine
		and ds.nom LIKE concat('%',nom,'%')
		GROUP BY ds.id order by ds.date_creation desc;

	elseif  nom != '' and prenom != '' and id_domaine IS NULL THEN
		select 
		ds.id,
	    ds.nom,
	    ds.prenom,
	    ds.duree, 
	    ds.e_mail as addresse_electronique,
	    d.nom_domaine,
		ds.date_creation,
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
		and ds.nom LIKE concat('%',nom,'%')
		and ds.prenom LIKE concat('%',prenom,'%')
		GROUP BY ds.id order by ds.date_creation desc; 
	elseif nom != '' and prenom != '' and id_domaine IS NOT NULL THEN
		select 
		ds.id,
	    ds.nom,
	    ds.prenom,
	    ds.duree, 
	    ds.e_mail as addresse_electronique,
	    d.nom_domaine,
		ds.date_creation,
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
		and ds.id_domaine = id_domaine
		and ds.nom LIKE concat('%',nom,'%')
		and ds.prenom LIKE concat('%',prenom,'%')
		GROUP BY ds.id order by ds.date_creation desc;  
	elseif nom = '' and prenom = '' and id_domaine IS NOT NULL THEN
		select 
		ds.id,
	    ds.nom,
	    ds.prenom,
	    ds.duree, 
	    ds.e_mail as addresse_electronique,
	    d.nom_domaine,
		ds.date_creation,
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
		and ds.id_domaine = id_domaine
		GROUP BY ds.id order by ds.date_creation desc;  
	else 
		select 
		ds.id,
		ds.nom,
		ds.prenom,
		ds.duree, 
		ds.e_mail as addresse_electronique,
		d.nom_domaine,
		ds.date_creation,
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
		GROUP BY ds.id order by ds.date_creation desc;
	END IF;
END

CREATE  PROCEDURE `liste_disponible_autorite`(IN id_autorite_sender int,in id_autorite int)
BEGIN

	set @sender = id_autorite_sender;
	set @id_autorite = id_autorite;
	
	SELECT 
	ae.id as id_autorite_receiver,
	ae.intitule as intitule_receiver,
	ae.intitule_code as intitule_code_receiver,
	ae.addresse_electronique as addresse_electronique_receiver,
	dhd.id as id_date_heure_disponible,
	dhda.id as id_date_heure_disponible_autorite,
	CONCAT(daadhd.date_debut,'T', daadhd.heure_debut) as start, 
	CONCAT(daadhd.date_fin,'T', daadhd.heure_fin) as end, 
	dhd.heure_debut as hd,
	dhd.heure_fin as hf,
	daa.id as id,
	daadhd.id as id_dm_aud_autorite_date_heure_dispo,
	dhd.date_disponible,
	daadhd.heure_debut,
	daadhd.heure_fin,
	aes.id as id_autorite_sender,
	aes.intitule as intitule_sender,
	aes.intitule_code as intitule_code_sender,
	aes.addresse_electronique as addresse_electronique_sender,
	daa.motif as title,
	CASE 
	    WHEN daa.action = 0 THEN 'Non validé' 
	    WHEN daa.action = 1 THEN 'Validé' 
	    WHEN daa.action = 2 THEN 'Reporté' 
	    ELSE 'Aucune' 
	END as status_audience,
	CASE 
	    WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 0 THEN "#407DFF" 
	    WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 1 THEN "#FF0018" 
		WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 2 THEN "#000000"
	END as color,
	CASE 
	    WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 0 THEN "#35AF11" 
	    WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 1 THEN "#FF0018"
		WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 2 THEN "#000000" 
	END as color_status,
	false editable
	FROM
	stage5.dm_aud_autorite_date_heure_dispo daadhd
	JOIN demande_audience_autorite daa on daadhd.id_dm_aud_autorite = daa.id
	JOIN autorite_enfant aes on daa.id_autorite_enfant_sender = aes.id 
	JOIN date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
	JOIN autorite_enfant ae on dhda.id_autorite = ae.id
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	WHERE 
	daa.id_autorite_enfant_sender = @sender
	and dhda.id_autorite = @id_autorite
	and (daa.action >= 0 and daa.action <=2)
	and dhd.date_disponible >= CURDATE()
	group by daadhd.id_dm_aud_autorite
	
	UNION
	
	(SELECT
	'' id_autorite_receiver,
	'' intitule_receiver,
	'' intitule_code_receiver,
	'' addresse_electronique_receiver,
	dhd.id as id_date_heure_disponible,
	dhda.id as id_date_heure_disponible_autorite,
	CONCAT(dhd.date_disponible,'T', dhd.heure_debut) as start, 
	CONCAT(dhd.date_disponible,'T', dhd.heure_fin) as end,
	dhd.heure_debut as hd,
	dhd.heure_fin as hf,
	'' id, 
	daadhd.id as id_dm_aud_autorite_date_heure_dispo,
	dhd.date_disponible,
	dapdhd.heure_debut, 
	dapdhd.heure_fin, 
	'' id_autorite_sender,
	'' intitule_sender,
	'' intitule_code_sender,
	'' addresse_electronique_sender,
	'Disponible' title,
	'' status_audience, 
	'#0AA913' color, 
	'' color_status, 
	false editable  
	FROM date_heure_disponible_autorite dhda
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id 
	LEFT JOIN pas_disponible pd on dhda.id = pd.id_date_heure_disponible_autorite
	LEFT JOIN dm_aud_autorite_date_heure_dispo daadhd on dhda.id = daadhd.id_date_heure_disponible_autorite
	LEFT JOIN demande_audience_autorite daa on daa.id = daadhd.id_dm_aud_autorite
	LEFT JOIN dm_aud_public_date_heure_dispo dapdhd on dhda.id = dapdhd.id_date_heure_disponible_autorite 
	LEFT JOIN demande_audience_public dap on dap.id = dapdhd.id_aud_public
	LEFT JOIN entretien_demande_stage eds on dhda.id = eds.id_date_heure_disponible_autorite 
	WHERE 
	dhda.id_autorite = @id_autorite
	and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) >= (select CURRENT_TIMESTAMP())
	and eds.id is null 
	and daadhd.id is null 
	and dapdhd.id is null
	and pd.id is NULL);
END

CREATE  PROCEDURE `liste_disponible_public`(IN session_navigateur varchar(100), IN id_autorite int)
BEGIN
	SET @session_navigateur = session_navigateur;
	set @id_autorite = id_autorite;

	(SELECT 
	dhd.id as id_date_heure_disponible,
	dhda.id as id_date_heure_disponible_autorite,
	CONCAT(dapdhd.date_debut,'T', dapdhd.heure_debut) as start, 
	CONCAT(dapdhd.date_fin,'T', dapdhd.heure_fin) as end, 
	dhd.heure_debut as hd,
	dhd.heure_fin as hf,
	dap.id as id, 
	dapdhd.id as id_dm_aud_public_heure_dispo,
	dhd.date_disponible,
	dapdhd.heure_debut, 
	dapdhd.heure_fin, 
	dap.motif as title, dap.motif,
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
		WHEN dap.session_navigateur = @session_navigateur and dap.action = 2 THEN "#000000"  
	END as color, 
	CASE 
	    WHEN dap.session_navigateur = @session_navigateur and dap.action = 0 THEN "#35AF11" 
	    WHEN dap.session_navigateur = @session_navigateur and dap.action = 1 THEN "#FF0018" 
		WHEN dap.session_navigateur = @session_navigateur and dap.action = 2 THEN "#000000" 
	END as color_status, 
	false editable 
	FROM date_heure_disponible_autorite dhda
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	JOIN dm_aud_public_date_heure_dispo dapdhd on dhda.id = dapdhd.id_date_heure_disponible_autorite
	JOIN demande_audience_public dap on dapdhd.id_aud_public = dap.id
	WHERE 
	dhda.id_autorite = @id_autorite
	and dhd.date_disponible >= CURDATE()
	and dap.session_navigateur = @session_navigateur
	and dap.action >=0 and dap.action <=2
	GROUP BY dapdhd.id_aud_public)
	
	UNION
	(SELECT 
	dhd.id as id_date_heure_disponible,
	dhda.id as id_date_heure_disponible_autorite,
	CONCAT(dhd.date_disponible,'T', dhd.heure_debut) as start, 
	CONCAT(dhd.date_disponible,'T', dhd.heure_fin) as end, 
	dhd.heure_debut as hd,
	dhd.heure_fin as hf,
	'' id, 
	dapdhd.id as id_dm_aud_public_heure_dispo,
	dhd.date_disponible,
	dapdhd.heure_debut, 
	dapdhd.heure_fin, 
	'Disponible' title, dap.motif,
	'' nom, 
	'' prenom, 
	'' cin, 
	'' numero_telephone, 
	'' email, 
	'' status_audience, 
	'#0AA913' color, 
	'' color_status, 
	false editable  
	FROM date_heure_disponible_autorite dhda
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id 
	LEFT JOIN pas_disponible pd on dhda.id = pd.id_date_heure_disponible_autorite
	LEFT JOIN dm_aud_autorite_date_heure_dispo daadhd on dhda.id = daadhd.id_date_heure_disponible_autorite
	LEFT JOIN demande_audience_autorite daa on daa.id = daadhd.id_dm_aud_autorite
	LEFT JOIN dm_aud_public_date_heure_dispo dapdhd on dhda.id = dapdhd.id_date_heure_disponible_autorite 
	LEFT JOIN demande_audience_public dap on dap.id = dapdhd.id_aud_public
	LEFT JOIN entretien_demande_stage eds on dhda.id = eds.id_date_heure_disponible_autorite 
	WHERE 
	dhda.id_autorite = @id_autorite
	and (timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) >= (select CURRENT_TIMESTAMP()) 
	or timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)) >= (select CURRENT_TIMESTAMP()))
	and eds.id is null 
	and daadhd.id is null 
	and dapdhd.id is null
	and pd.id is NULL);
END

CREATE  PROCEDURE `liste_doleances_public`(
	IN session_navigateur VARCHAR(50)
)
begin 
	select
	d.id as id,
	d.titre as titre,
	d.message as message,
	concat(d.date_publication,' ',d.heure_publication) as date_heure_publication,
	d.nom as nom,
	d.prenom as nom,
	d.cin as cin,
	d.numero_telephone as numero_telephone,
	d.e_mail as addresse_electronique,
	CASE 
		WHEN d.nom IS NULL or d.prenom IS NULL or d.cin IS NULL or d.e_mail IS NULL or d.numero_telephone IS NULL THEN 'Anonyme'
		ELSE 'Non anonyme' 
	END as type_doleance,
	ae.id as id_autorite,
	ae.intitule,
	ae.intitule_code
	from doleance d 
	join autorite_enfant ae on d.id_autorite = ae.id
	where 
	d.session_navigateur = session_navigateur
	and d.date_publication = (select curdate());
end

CREATE  PROCEDURE `liste_evenements_inclus_entre_deux_Dates`(IN id_autorite INT,IN date_debut date,IN date_fin date,IN heure_debut time,IN heure_fin time)
BEGIN
	set @id_autorite = id_autorite;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',@hd));
	set @timestamp_fin = timestamp(concat(date_fin,' ',@hf));
	
	select @id_autorite, @timestamp_debut,@timestamp_fin;
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
	and dhda.est_disponible = 1
	and ds.action between 0 and 1
	and 
	(timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) BETWEEN @timestamp_debut and @timestamp_fin
	OR timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)) BETWEEN @timestamp_debut and @timestamp_fin)
	OR
	dhda.id_autorite = @id_autorite
	and dhda.est_disponible = 1
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
	and dhda.est_disponible = 1
	and daa.action between 0 and 1
	and 
	(timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) BETWEEN @timestamp_debut and @timestamp_fin
	OR timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)) BETWEEN @timestamp_debut and @timestamp_fin)
	OR
	dhda.id_autorite = @id_autorite
	and dhda.est_disponible = 1
	and 
	(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin))
	and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)))
	GROUP BY daadhd.id_dm_aud_autorite);
END

CREATE  PROCEDURE `modifier_action_evenement`(IN id_autorite INT,IN date_debut date,IN date_fin date,IN heure_debut time,IN heure_fin time)
BEGIN
	set @id_autorite = id_autorite;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));
	
	-- entretien demande stage
	UPDATE demande_stage 
	set action = 2 
	where demande_stage.id IN (
		select id from (
			SELECT 
			ds.id
			FROM
			demande_stage ds
			JOIN entretien_demande_stage eds on ds.id = eds.id_demande_stage
			JOIN date_heure_disponible_autorite dhda on eds.id_date_heure_disponible_autorite = dhda.id
			JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
			where 
			dhda.id_autorite = @id_autorite
			and ds.action between 0 and 1
			and 
			(timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin
			OR timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin)
			OR
			dhda.id_autorite = @id_autorite
			and ds.action between 0 and 1
			and 
			(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))
			and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))))
			GROUP BY ds.id	
		) as u
	);

	-- demande audience public
	UPDATE demande_audience_public 
	set action = 2 
	where demande_audience_public.id in (
		select id from (
			SELECT
			dap.id
			FROM
			demande_audience_public dap 
			JOIN dm_aud_public_date_heure_dispo dapdhd on dap.id = dapdhd.id_aud_public
			JOIN date_heure_disponible_autorite dhda on dapdhd.id_date_heure_disponible_autorite = dhda.id 
			JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
			where 
			dhda.id_autorite = @id_autorite
			and (dap.action = 0 or dap.action = 1)
			and 
			(timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin
			OR timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin)
			OR
			dhda.id_autorite = @id_autorite
			and (dap.action = 0 or dap.action = 1)
			and 
			(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))
			and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))))
			GROUP BY dap.id			
		) as t
	);

	-- demande audience autorite
	UPDATE demande_audience_autorite 
	set action = 2 
	where demande_audience_autorite.id IN (
		select id from (
			SELECT 
			daa.id
			FROM
			demande_audience_autorite daa
			JOIN dm_aud_autorite_date_heure_dispo daadhd on daa.id = daadhd.id_dm_aud_autorite
			JOIN date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
			JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
			where 
			dhda.id_autorite = @id_autorite
			and (daa.action = 0 or daa.action = 1)
			and 
			(timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin
			OR timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin)
			OR
			dhda.id_autorite = @id_autorite
			and (daa.action = 0 or daa.action = 1)
			and 
			(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))
			and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))))
			GROUP BY daa.id			
		) as p
	);

	-- date heure disponible autorite set false
	UPDATE date_heure_disponible_autorite 
	set est_disponible = false 
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
			(timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin
			OR timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin)
			OR
			dhda.id_autorite = @id_autorite
			and dhda.est_disponible = 1
			and 
			(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))
			and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))))
		) as t
	);
END

CREATE  PROCEDURE `modifier_audience_public`(IN nom varchar(30),
IN prenom varchar(30),
IN cin varchar(15),
IN numero_telephone varchar(10),
IN email varchar(30),
IN motif VARCHAR(200),
IN id_audience INT,
IN id_date_heure_disponible_autorite INT,
IN id_dm_aud_public_heure_dispo INT)
BEGIN 
	select dhd.heure_debut,dhd.heure_fin into @heure_debut,@heure_fin from date_heure_disponible_autorite dhda
	join date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id where dhda.id = id_date_heure_disponible_autorite;
	set @id_dhda = id_date_heure_disponible_autorite;	

	-- UPDATE demande_audience_public SET nom = nom , prenom = prenom, cin = cin, numero_telephone = numero_telephone, email = email where id = id_audience;
	UPDATE stage5.dm_aud_public_date_heure_dispo SET id_date_heure_disponible_autorite = @id_dhda, heure_debut = @heure_debut, heure_fin = @heure_fin where id = id_dm_aud_public_heure_dispo;
	SELECT 'Votre audience a bien été modifiée' as message;
END

CREATE  PROCEDURE `modifier_entretien_stage`(
	IN id_date_heure_disponible_autorite INT,
	IN id_dm_stage INT
)
BEGIN 
	SET @id_ds = id_dm_stage;
	SET @id_hd = id_date_heure_disponible_autorite;

	select dhd.heure_debut, dhd.heure_fin, dhd.date_disponible,dhd.date_disponible INTO @hd,@hf,@date_debut,@date_fin 
	from date_heure_disponible_autorite dhda
	join date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id where dhda.id = @id_hd;

	-- Modifier entretien
	UPDATE stage5.entretien_demande_stage 
	SET heure_debut = @hd, heure_fin = @hf, date_debut = @date_debut, date_fin = @date_fin, id_date_heure_disponible_autorite = @id_hd
	WHERE id_demande_stage = @id_ds;

	SELECT 'Entretien a bien été mofifié avec succès' as message,@hd as heure_debut,@date_debut as date_debut;
END

CREATE  PROCEDURE `modifier_entretien_stage_calendrier`(IN id_entretien_stage int,IN id_demande_stage INT,IN date_debut date,IN date_fin date,IN heure_debut time,in heure_fin time, IN id_autorite INT)
BEGIN
	set @id_autorite = id_autorite;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));

	set @nbr_rows = ( 
	SELECT 
	count(dhda.id)
	FROM
	date_heure_disponible_autorite dhda 
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	where 
	dhda.id_autorite = @id_autorite
	and dhda.est_disponible = 1
	and 
	(timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin
	OR timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin)
	OR
	dhda.id_autorite = @id_autorite
	and dhda.est_disponible = 1
	and 
	(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))
	and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))));

	-- SCENE 1
	IF date_debut = date_fin THEN
		IF @nbr_rows = 0 THEN 
			DELETE FROM entretien_demande_stage where id_demande_stage = id_demande_stage;
			CALL `ajouter_date_heure_disponible_autorite`(@id_autorite,'08:00:00' , '16:00:00' , date_debut );
			CALL `ajouter_entretien_stage_date_heure_dispo_entre_deux_date`( id_demande_stage ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		ELSEIF @nbr_rows = 1 THEN
			set @id_date_heure_dispo_autorite = (
				SELECT 
				dhda.id 
				from date_heure_disponible_autorite dhda 
				JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
				where dhda.id_autorite = @id_autorite 
				and dhd.date_disponible = date_debut
				and heure_debut between dhd.heure_debut and dhd.heure_fin
				and heure_fin between dhd.heure_debut and dhd.heure_fin
			);
			UPDATE entretien_demande_stage set id_date_heure_disponible_autorite = @id_date_heure_dispo_autorite, date_debut = date_debut, date_fin = date_fin, heure_debut = heure_debut, heure_fin = heure_fin where id = id_entretien_stage;
		ELSEIF @nbr_rows > 1 THEN
			DELETE FROM entretien_demande_stage where id_demande_stage = id_demande_stage;
			CALL `ajouter_entretien_stage_date_heure_dispo_entre_deux_date`( id_demande_stage ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		END IF;
	ELSEIF date_debut < date_fin THEN
		DELETE FROM entretien_demande_stage where id_demande_stage = id_demande_stage;
		CALL `verifier_date_heure_dispo_entre_deux_dates`(date_debut, date_fin, @id_autorite);
		CALL `ajouter_entretien_stage_date_heure_dispo_entre_deux_date`( id_demande_stage ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
	END IF;
END

CREATE  PROCEDURE `modifier_non_disponible_autorite`(
	IN id_autorite INT,
	IN id_non_dispo INT,
	IN date_debut date,
	IN date_fin date,
	IN heure_debut time,
	IN heure_fin time
)
BEGIN
	set @id_non_dispo = (SELECT dhnda.id from date_heure_non_disponible_autorite dhnda where dhnda.id = id_non_dispo); 
	IF @id_non_dispo IS NOT NULL THEN
		UPDATE date_heure_non_disponible_autorite SET date_debut = date_debut, date_fin = date_fin, heure_debut = heure_debut, heure_fin = heure_fin
		WHERE id = id_non_dispo;
		DELETE FROM pas_disponible where id_date_heure_non_disponible_autorite = id_non_dispo;
		CALL set_est_disponible_pas_disponible(id_autorite,@id_non_dispo, date_debut, date_fin, heure_debut ,heure_fin,true);
	
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
	ELSE 
		select 'Id does not exist' as message; 	
	END IF;
	
END

CREATE  PROCEDURE `places_disponible`(IN id_date_heure_disponible_autorite INT,IN id_autorite INT)
BEGIN 
	set @id_autorite = id_autorite;
	set @id_hda = id_date_heure_disponible_autorite;
	set @current_time = (SELECT curtime()); 
	set @current_date = (SELECT CURDATE()); 
	set @timestamp_current = timestamp(concat(@current_date,' ',@current_time));
	

	IF @id_hda IS NULL THEN
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
		and (timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) >= @timestamp_current OR timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin))  >= @timestamp_current)
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
		and (timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) >= @timestamp_current OR timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin))  >= @timestamp_current)
		and eds.id is null 
		and daadhd.id is null 
		and dapdhd.id is null 
		and pd.id is null;		
	END IF;	

END

CREATE  PROCEDURE `reporter_audience_autorite_maintenant`(IN id_dm_aud_aut_date_heure_dispo int,IN id_audience INT,IN date_debut date,IN date_fin date,IN heure_debut time,in heure_fin time, IN id_autorite_receiver INT)
BEGIN
	set @id_autorite = id_autorite_receiver;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));

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

	-- SCENE 1
	IF date_debut = date_fin THEN
		IF @nbr_rows = 0 THEN 
			DELETE FROM stage5.dm_aud_autorite_date_heure_dispo where id_dm_aud_autorite = id_audience;
			CALL `ajouter_date_heure_disponible_autorite`(@id_autorite,'08:00:00' , '16:00:00' , date_debut );
			CALL `ajouter_dm_aud_autorite_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		ELSEIF @nbr_rows = 1 THEN
			set @id_date_heure_dispo_autorite = (
				SELECT 
				dhda.id 
				from stage5.date_heure_disponible_autorite dhda 
				JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
				where dhda.id_autorite = @id_autorite 
				and dhd.date_disponible = date_debut
				and heure_debut between dhd.heure_debut and dhd.heure_fin
				and heure_fin between dhd.heure_debut and dhd.heure_fin
			);
			UPDATE stage5.dm_aud_autorite_date_heure_dispo set id_date_heure_disponible_autorite = @id_date_heure_dispo_autorite, date_debut = date_debut, date_fin = date_fin, heure_debut = heure_debut, heure_fin = heure_fin where id = id_dm_aud_aut_date_heure_dispo;
		ELSEIF @nbr_rows > 1 THEN
			DELETE FROM stage5.dm_aud_autorite_date_heure_dispo where id_dm_aud_autorite = id_audience;
			CALL `ajouter_dm_aud_autorite_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		END IF;
	ELSEIF date_debut < date_fin THEN
		DELETE FROM stage5.dm_aud_autorite_date_heure_dispo where id_dm_aud_autorite = id_audience;
		CALL `verifier_date_heure_dispo_entre_deux_dates`(date_debut, date_fin, @id_autorite);
		CALL `ajouter_dm_aud_autorite_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
	END IF;
	UPDATE stage5.demande_audience_autorite set action = 1 where id = id_audience;
END

CREATE  PROCEDURE `reporter_audience_autorite_plus_tard`(IN id_dm_aud_aut_date_heure_dispo int,IN id_audience INT,IN date_debut date,IN date_fin date,IN heure_debut time,in heure_fin time, IN id_autorite_receiver INT)
BEGIN
	set @id_autorite = id_autorite_receiver;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));

	set @nbr_rows = ( 
	SELECT 
	count(dhda.id)
	FROM
	stage5.date_heure_disponible_autorite dhda 
	JOIN stage5.date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	where 
	dhda.id_autorite = @id_autorite
	and dhda.est_disponible = 1
	and 
	(timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin
	OR timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin)
	OR
	dhda.id_autorite = @id_autorite
	and dhda.est_disponible = 1
	and 
	(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))
	and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))));

	-- SCENE 1
	IF date_debut = date_fin THEN
		IF @nbr_rows = 0 THEN 
			DELETE FROM stage5.dm_aud_autorite_date_heure_dispo where id_dm_aud_autorite = id_audience;
			CALL `ajouter_date_heure_disponible_autorite`(@id_autorite,'08:00:00' , '16:00:00' , date_debut );
			CALL `ajouter_dm_aud_autorite_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		ELSEIF @nbr_rows = 1 THEN
			set @id_date_heure_dispo_autorite = (
				SELECT 
				dhda.id 
				from stage5.date_heure_disponible_autorite dhda 
				JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
				where dhda.id_autorite = @id_autorite 
				and dhd.date_disponible = date_debut
				and heure_debut between dhd.heure_debut and dhd.heure_fin
				and heure_fin between dhd.heure_debut and dhd.heure_fin
			);
			UPDATE stage5.dm_aud_autorite_date_heure_dispo set id_date_heure_disponible_autorite = @id_date_heure_dispo_autorite, date_debut = date_debut, date_fin = date_fin, heure_debut = heure_debut, heure_fin = heure_fin where id = id_dm_aud_aut_date_heure_dispo;
		ELSEIF @nbr_rows > 1 THEN
			DELETE FROM stage5.dm_aud_autorite_date_heure_dispo where id_dm_aud_autorite = id_audience;
			CALL `ajouter_dm_aud_autorite_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		END IF;
	ELSEIF date_debut < date_fin THEN
		DELETE FROM stage5.dm_aud_autorite_date_heure_dispo where id_dm_aud_autorite = id_audience;
		CALL `verifier_date_heure_dispo_entre_deux_dates`(date_debut, date_fin, @id_autorite);
		CALL `ajouter_dm_aud_autorite_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
	END IF;
	UPDATE stage5.demande_audience_autorite set action = 2 where id = id_audience;
END

CREATE  PROCEDURE `reporter_audience_public_maintenant`(IN id_dm_aud_public_date_heure_dispo int,IN id_audience INT,IN date_debut date,IN date_fin date,IN heure_debut time,in heure_fin time, IN id_autorite INT)
BEGIN
	set @id_autorite = id_autorite;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));

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

	-- SCENE 1
	IF date_debut = date_fin THEN
		IF @nbr_rows = 0 THEN 
			DELETE FROM stage5.dm_aud_public_date_heure_dispo where id_aud_public = id_audience;
			CALL `ajouter_date_heure_disponible_autorite`(@id_autorite,'08:00:00' , '16:00:00' , date_debut );
			CALL `ajouter_dm_aud_public_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		ELSEIF @nbr_rows = 1 THEN
			set @id_date_heure_dispo_autorite = (
				SELECT 
				dhda.id 
				from stage5.date_heure_disponible_autorite dhda 
				JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
				where dhda.id_autorite = @id_autorite 
				and dhd.date_disponible = date_debut
				and heure_debut between dhd.heure_debut and dhd.heure_fin
				and heure_fin between dhd.heure_debut and dhd.heure_fin
			);
			UPDATE stage5.dm_aud_public_date_heure_dispo set id_date_heure_disponible_autorite = @id_date_heure_dispo_autorite, date_debut = date_debut, date_fin = date_fin, heure_debut = heure_debut, heure_fin = heure_fin where id = id_dm_aud_public_date_heure_dispo;
		ELSEIF @nbr_rows > 1 THEN
			DELETE FROM stage5.dm_aud_public_date_heure_dispo where id_aud_public = id_audience;
			CALL `ajouter_dm_aud_public_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		END IF;
	ELSEIF date_debut < date_fin THEN
		DELETE FROM stage5.dm_aud_public_date_heure_dispo where id_aud_public = id_audience;
		CALL `verifier_date_heure_dispo_entre_deux_dates`(date_debut, date_fin, @id_autorite);
		CALL `ajouter_dm_aud_public_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
	END IF;
	UPDATE stage5.demande_audience_public set action = 1 where id = id_audience;
END

CREATE  PROCEDURE `reporter_audience_public_plus_tard`(IN id_dm_aud_public_date_heure_dispo int,IN id_audience INT,IN date_debut date,IN date_fin date,IN heure_debut time,in heure_fin time, IN id_autorite INT)
BEGIN
	set @id_autorite = id_autorite;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));

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

	-- SCENE 1
	IF date_debut = date_fin THEN
		IF @nbr_rows = 0 THEN 
			DELETE FROM stage5.dm_aud_public_date_heure_dispo where id_aud_public = id_audience;
			CALL `ajouter_date_heure_disponible_autorite`(@id_autorite,'08:00:00' , '16:00:00' , date_debut );
			CALL `ajouter_dm_aud_public_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		ELSEIF @nbr_rows = 1 THEN
			set @id_date_heure_dispo_autorite = (
				SELECT 
				dhda.id 
				from stage5.date_heure_disponible_autorite dhda 
				JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
				where dhda.id_autorite = @id_autorite 
				and dhd.date_disponible = date_debut
				and heure_debut between dhd.heure_debut and dhd.heure_fin
				and heure_fin between dhd.heure_debut and dhd.heure_fin
			);
			UPDATE stage5.dm_aud_public_date_heure_dispo set id_date_heure_disponible_autorite = @id_date_heure_dispo_autorite, date_debut = date_debut, date_fin = date_fin, heure_debut = heure_debut, heure_fin = heure_fin where id = id_dm_aud_public_date_heure_dispo;
		ELSEIF @nbr_rows > 1 THEN
			DELETE FROM stage5.dm_aud_public_date_heure_dispo where id_aud_public = id_audience;
			CALL `ajouter_dm_aud_public_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		END IF;
	ELSEIF date_debut < date_fin THEN
		DELETE FROM stage5.dm_aud_public_date_heure_dispo where id_aud_public = id_audience;
		CALL `verifier_date_heure_dispo_entre_deux_dates`(date_debut, date_fin, @id_autorite);
		CALL `ajouter_dm_aud_public_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
	END IF;
	UPDATE stage5.demande_audience_public set action = 2 where id = id_audience;
END

CREATE  PROCEDURE `revalider_audience_autorite`(IN id_dm_aud_aut_date_heure_dispo int,IN id_audience INT,IN date_debut date,IN date_fin date,IN heure_debut time,in heure_fin time, IN id_autorite_receiver INT)
BEGIN
	set @id_autorite = id_autorite_receiver;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));

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

	-- SCENE 1
	IF date_debut = date_fin THEN
		IF @nbr_rows = 0 THEN 
			DELETE FROM stage5.dm_aud_autorite_date_heure_dispo where id_dm_aud_autorite = id_audience;
			CALL `ajouter_date_heure_disponible_autorite`(@id_autorite,'08:00:00' , '16:00:00' , date_debut );
			CALL `ajouter_dm_aud_autorite_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		ELSEIF @nbr_rows = 1 THEN
			set @id_date_heure_dispo_autorite = (
				SELECT 
				dhda.id 
				from stage5.date_heure_disponible_autorite dhda 
				JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
				where dhda.id_autorite = @id_autorite 
				and dhd.date_disponible = date_debut
				and heure_debut between dhd.heure_debut and dhd.heure_fin
				and heure_fin between dhd.heure_debut and dhd.heure_fin
			);
			UPDATE stage5.dm_aud_autorite_date_heure_dispo set id_date_heure_disponible_autorite = @id_date_heure_dispo_autorite, date_debut = date_debut, date_fin = date_fin, heure_debut = heure_debut, heure_fin = heure_fin where id = id_dm_aud_aut_date_heure_dispo;
		ELSEIF @nbr_rows > 1 THEN
			DELETE FROM stage5.dm_aud_autorite_date_heure_dispo where id_dm_aud_autorite = id_audience;
			CALL `ajouter_dm_aud_autorite_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		END IF;
	ELSEIF date_debut < date_fin THEN
		DELETE FROM stage5.dm_aud_autorite_date_heure_dispo where id_dm_aud_autorite = id_audience;
		CALL `verifier_date_heure_dispo_entre_deux_dates`(date_debut, date_fin, @id_autorite);
		CALL `ajouter_dm_aud_autorite_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
	END IF;
	UPDATE stage5.demande_audience_autorite set action = 1 where id = id_audience;
END

CREATE  PROCEDURE `revalider_audience_public`(IN id_dm_aud_public_date_heure_dispo int,IN id_audience INT,IN date_debut date,IN date_fin date,IN heure_debut time,in heure_fin time, IN id_autorite INT)
BEGIN
	set @id_autorite = id_autorite;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));

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

	-- SCENE 1
	IF date_debut = date_fin THEN
		IF @nbr_rows = 0 THEN 
			DELETE FROM stage5.dm_aud_public_date_heure_dispo where id_aud_public = id_audience;
			CALL `ajouter_date_heure_disponible_autorite`(@id_autorite,'08:00:00' , '16:00:00' , date_debut );
			CALL `ajouter_dm_aud_public_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		ELSEIF @nbr_rows = 1 THEN
			set @id_date_heure_dispo_autorite = (
				SELECT 
				dhda.id 
				from stage5.date_heure_disponible_autorite dhda 
				JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
				where dhda.id_autorite = @id_autorite 
				and dhd.date_disponible = date_debut
				and heure_debut between dhd.heure_debut and dhd.heure_fin
				and heure_fin between dhd.heure_debut and dhd.heure_fin
			);
			UPDATE stage5.dm_aud_public_date_heure_dispo set id_date_heure_disponible_autorite = @id_date_heure_dispo_autorite, date_debut = date_debut, date_fin = date_fin, heure_debut = heure_debut, heure_fin = heure_fin where id = id_dm_aud_public_date_heure_dispo;
		ELSEIF @nbr_rows > 1 THEN
			DELETE FROM stage5.dm_aud_public_date_heure_dispo where id_aud_public = id_audience;
			CALL `ajouter_dm_aud_public_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		END IF;
	ELSEIF date_debut < date_fin THEN
		DELETE FROM stage5.dm_aud_public_date_heure_dispo where id_aud_public = id_audience;
		CALL `verifier_date_heure_dispo_entre_deux_dates`(date_debut, date_fin, @id_autorite);
		CALL `ajouter_dm_aud_public_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
	END IF;
	UPDATE stage5.demande_audience_public set action = 1 where id = id_audience;
END

CREATE  PROCEDURE `set_est_disponible_pas_disponible`(IN id_autorite INT,IN id_non_dispo INT,IN date_debut date,IN date_fin date,IN heure_debut time,IN heure_fin time,in etat boolean)
BEGIN
	set @id_autorite = id_autorite;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',@hd));
	set @timestamp_fin = timestamp(concat(date_fin,' ',@hf));

	INSERT INTO pas_disponible (id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite)
	SELECT 
	dhda.id,
	id_non_dispo
	FROM
	date_heure_disponible_autorite dhda 
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id	
	where 
	dhda.id_autorite = @id_autorite
	and 
	(timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) BETWEEN @timestamp_debut and @timestamp_fin
	OR timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)) BETWEEN @timestamp_debut and @timestamp_fin)
	OR
	dhda.id_autorite = @id_autorite
	and 
	(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin))
	and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_debut)) and timestamp(CONCAT(dhd.date_disponible,' ',dhd.heure_fin)));
END

CREATE  PROCEDURE `supprimer_audience_autorite`(IN id INT)
BEGIN 
	DELETE FROM stage5.demande_audience_autorite where stage5.demande_audience_autorite.id = id;
	DELETE FROM stage5.dm_aud_autorite_date_heure_dispo WHERE stage5.dm_aud_autorite_date_heure_dispo.id_dm_aud_autorite IS NULL;
	SELECT "Votre audience a bien été supprimée" as message;
END

CREATE  PROCEDURE `supprimer_audience_public`(IN id INT)
BEGIN 
	SET @id_aud = id;
	DELETE FROM demande_audience_public where demande_audience_public.id = @id_aud;
	DELETE FROM dm_aud_public_date_heure_dispo WHERE dm_aud_public_date_heure_dispo.id_aud_public IS NULL;
	SELECT "Votre audience a bien été supprimée" as message;
END

CREATE  PROCEDURE `supprimer_entretien_stage`(IN id INT)
BEGIN 
	DELETE FROM stage5.entretien_demande_stage where entretien_demande_stage.id_demande_stage = id;
	SELECT "Votre entretien a bien été supprimée" as message;
END

CREATE  PROCEDURE `update_action_autorite`(IN id_autorite INT,IN date_debut date,IN date_fin date,IN heure_debut time,IN heure_fin time)
BEGIN

	set @id_autorite = id_autorite;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));

	UPDATE demande_audience_autorite 
	set action = 2 
	where demande_audience_autorite.id IN (
		select id from (
			SELECT 
			daa.id
			FROM
			demande_audience_autorite daa
			JOIN dm_aud_autorite_date_heure_dispo daadhd on daa.id = daadhd.id_dm_aud_autorite
			JOIN date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
			JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
			where 
			dhda.id_autorite = @id_autorite
			and (daa.action = 0 or daa.action = 1)
			and 
			(timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin
			OR timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin)
			OR
			dhda.id_autorite = @id_autorite
			and (daa.action = 0 or daa.action = 1)
			and 
			(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))
			and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))))
			GROUP BY daadhd.id_dm_aud_autorite			
		) as p
	);
END

CREATE  PROCEDURE `valider_audience_autorite`(IN id_dm_aud_aut_date_heure_dispo int,IN id_audience INT,IN date_debut date,IN date_fin date,IN heure_debut time,in heure_fin time, IN id_autorite_receiver INT)
BEGIN
	set @id_autorite = id_autorite_receiver;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));

	set @nbr_rows = ( 
	SELECT 
	count(dhda.id)
	FROM
	date_heure_disponible_autorite dhda 
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
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

	-- SCENE 1
	IF date_debut = date_fin THEN
		IF @nbr_rows = 0 THEN 
			DELETE FROM dm_aud_autorite_date_heure_dispo where id_dm_aud_autorite = id_audience;
			CALL `ajouter_date_heure_disponible_autorite`(@id_autorite,'08:00:00' , '16:00:00' , date_debut );
			CALL `ajouter_dm_aud_autorite_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		ELSEIF @nbr_rows = 1 THEN
			set @id_date_heure_dispo_autorite = (
				SELECT 
				dhda.id 
				from date_heure_disponible_autorite dhda 
				JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
				where dhda.id_autorite = @id_autorite 
				and dhd.date_disponible = date_debut
				and heure_debut between dhd.heure_debut and dhd.heure_fin
				and heure_fin between dhd.heure_debut and dhd.heure_fin
			);
			UPDATE dm_aud_autorite_date_heure_dispo set id_date_heure_disponible_autorite = @id_date_heure_dispo_autorite, date_debut = date_debut, date_fin = date_fin, heure_debut = heure_debut, heure_fin = heure_fin where id = id_dm_aud_aut_date_heure_dispo;
		ELSEIF @nbr_rows > 1 THEN
			DELETE FROM dm_aud_autorite_date_heure_dispo where id_dm_aud_autorite = id_audience;
			CALL `ajouter_dm_aud_autorite_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		END IF;
	ELSEIF date_debut < date_fin THEN
		DELETE FROM dm_aud_autorite_date_heure_dispo where id_dm_aud_autorite = id_audience;
		CALL `verifier_date_heure_dispo_entre_deux_dates`(date_debut, date_fin, @id_autorite);
		CALL `ajouter_dm_aud_autorite_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
	END IF;
	UPDATE demande_audience_autorite set action = 1 where id = id_audience;
END

CREATE  PROCEDURE `valider_audience_public`(IN id_dm_aud_public_date_heure_dispo int,IN id_audience INT,IN date_debut date,IN date_fin date,IN heure_debut time,in heure_fin time, IN id_autorite INT)
BEGIN
	set @id_autorite = id_autorite;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));

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

	-- SCENE 1
	IF date_debut = date_fin THEN
		IF @nbr_rows = 0 THEN 
			DELETE FROM stage5.dm_aud_public_date_heure_dispo where id_aud_public = id_audience;
			CALL `ajouter_date_heure_disponible_autorite`(@id_autorite,'08:00:00' , '16:00:00' , date_debut );
			CALL `ajouter_dm_aud_public_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		ELSEIF @nbr_rows = 1 THEN
			set @id_date_heure_dispo_autorite = (
				SELECT 
				dhda.id 
				from stage5.date_heure_disponible_autorite dhda 
				JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
				where dhda.id_autorite = @id_autorite 
				and dhd.date_disponible = date_debut
				and heure_debut between dhd.heure_debut and dhd.heure_fin
				and heure_fin between dhd.heure_debut and dhd.heure_fin
			);
			UPDATE stage5.dm_aud_public_date_heure_dispo set id_date_heure_disponible_autorite = @id_date_heure_dispo_autorite, date_debut = date_debut, date_fin = date_fin, heure_debut = heure_debut, heure_fin = heure_fin where id = id_dm_aud_public_date_heure_dispo;
		ELSEIF @nbr_rows > 1 THEN
			DELETE FROM stage5.dm_aud_public_date_heure_dispo where id_aud_public = id_audience;
			CALL `ajouter_dm_aud_public_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		END IF;
	ELSEIF date_debut < date_fin THEN
		DELETE FROM stage5.dm_aud_public_date_heure_dispo where id_aud_public = id_audience;
		CALL `verifier_date_heure_dispo_entre_deux_dates`(date_debut, date_fin, @id_autorite);
		CALL `ajouter_dm_aud_public_date_heure_dispo_entre_deux_date`(id_audience ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
	END IF;
	UPDATE stage5.demande_audience_public set action = 1 where id = id_audience;
END

CREATE  PROCEDURE `valider_evenement`(
	IN id_date_heure_disponible_autorite INT,
	IN id_evenement INT,
	IN type_evenement VARCHAR(10),
	IN date_debut date,
	IN date_fin date,
	IN heure_debut time,
	IN heure_fin time
)
BEGIN 
	IF type_evenement = 'Public' THEN
		DELETE from dm_aud_public_date_heure_dispo where id_aud_public = id_evenement;
		INSERT INTO dm_aud_public_date_heure_dispo
		( id_aud_public, id_date_heure_disponible_autorite, date_debut, date_fin,heure_debut, heure_fin) VALUES 
		( id_evenement, id_date_heure_disponible_autorite, date_debut, date_fin, heure_debut, heure_fin );
		UPDATE demande_audience_public set action = 1 where id = id_evenement;	
	
	ELSEIF type_evenement = 'Autorité' THEN 
		delete from dm_aud_autorite_date_heure_dispo where id_dm_aud_autorite = id_evenement;
		INSERT INTO dm_aud_autorite_date_heure_dispo
		(id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin) VALUES 
		(id_date_heure_disponible_autorite,id_evenement,  heure_debut, heure_fin, date_debut, date_fin );
		UPDATE demande_audience_autorite set action = 1 where id = id_evenement; 

	ELSEIF type_evenement = 'Entretien' THEN
		delete from entretien_demande_stage where id_demande_stage = id_evenement;	
		INSERT INTO entretien_demande_stage
		( heure_debut, heure_fin, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin) VALUES 
		( heure_debut, heure_fin, id_evenement, id_date_heure_disponible_autorite, date_debut, date_fin);
		UPDATE demande_stage set action = 1 where id = id_evenement;
	END IF;
	SELECT 'Evènement a bien été ajouté' as message;
END

CREATE  PROCEDURE `verifier_date_heure_dispo_entre_deux_dates`(IN date1 DATE,IN date2 DATE,IN id_autorite INT)
BEGIN
	set @id_autorite = id_autorite;
	looping: LOOP
	set  @daten = date1;
	IF @daten <= date2 then
		set @nbr_rows = (SELECT count(id) 
		FROM stage5.date_heure_disponible dhd where dhd.date_disponible = @daten);

		IF @nbr_rows = 0 THEN 
			CALL `ajouter_date_heure_disponible_autorite`(@id_autorite,'08:00:00', '16:00:00' , @daten);	
		END IF;
		set date1 = (select DATE_ADD(date(date1), INTERVAL 1 DAY));
		set @daten = date1;
		iterate looping;
	end if;
	LEAVE looping;
	END LOOP looping;
END

INSERT INTO stage5.autorite_parent( id, intitule ) VALUES ( 1, 'Chef de service');
INSERT INTO stage5.autorite_parent( id, intitule ) VALUES ( 2, 'Directeurs');
INSERT INTO stage5.autorite_parent( id, intitule ) VALUES ( 3, 'Directeurs Généreaux');
INSERT INTO stage5.autorite_parent( id, intitule ) VALUES ( 4, 'Sécrétaire Général');
INSERT INTO stage5.autorite_parent( id, intitule ) VALUES ( 5, 'Ministère');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1, '08:00:00', '08:30:00', '2022-12-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 2, '08:30:00', '09:00:00', '2022-12-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 3, '09:00:00', '09:30:00', '2022-12-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 4, '09:30:00', '10:00:00', '2022-12-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 5, '10:00:00', '10:30:00', '2022-12-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 6, '10:30:00', '11:00:00', '2022-12-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 7, '11:00:00', '11:30:00', '2022-12-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 8, '11:30:00', '12:00:00', '2022-12-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 9, '14:00:00', '14:30:00', '2022-12-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 10, '14:30:00', '15:00:00', '2022-12-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 11, '15:00:00', '15:30:00', '2022-12-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 12, '15:30:00', '16:00:00', '2022-12-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 13, '09:00:00', '09:30:00', '2022-12-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 14, '09:30:00', '10:00:00', '2022-12-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 15, '10:00:00', '10:30:00', '2022-12-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 16, '10:30:00', '11:00:00', '2022-12-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 17, '11:00:00', '11:30:00', '2022-12-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 18, '11:30:00', '12:00:00', '2022-12-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 19, '08:00:00', '08:30:00', '2022-12-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 20, '08:30:00', '09:00:00', '2022-12-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 21, '09:00:00', '09:30:00', '2022-12-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 22, '09:30:00', '10:00:00', '2022-12-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 23, '10:00:00', '10:30:00', '2022-12-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 24, '10:30:00', '11:00:00', '2022-12-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 25, '11:00:00', '11:30:00', '2022-12-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 26, '11:30:00', '12:00:00', '2022-12-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 27, '14:00:00', '14:30:00', '2022-12-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 28, '14:30:00', '15:00:00', '2022-12-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 29, '15:00:00', '15:30:00', '2022-12-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 30, '15:30:00', '16:00:00', '2022-12-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 31, '08:00:00', '08:30:00', '2022-12-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 32, '08:30:00', '09:00:00', '2022-12-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 33, '09:00:00', '09:30:00', '2022-12-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 34, '09:30:00', '10:00:00', '2022-12-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 35, '10:00:00', '10:30:00', '2022-12-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 36, '10:30:00', '11:00:00', '2022-12-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 37, '11:00:00', '11:30:00', '2022-12-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 38, '11:30:00', '12:00:00', '2022-12-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 39, '14:00:00', '14:30:00', '2022-12-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 40, '14:30:00', '15:00:00', '2022-12-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 41, '15:00:00', '15:30:00', '2022-12-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 42, '15:30:00', '16:00:00', '2022-12-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 43, '08:00:00', '08:30:00', '2022-12-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 44, '08:30:00', '09:00:00', '2022-12-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 45, '09:00:00', '09:30:00', '2022-12-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 46, '09:30:00', '10:00:00', '2022-12-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 47, '10:00:00', '10:30:00', '2022-12-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 48, '10:30:00', '11:00:00', '2022-12-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 49, '11:00:00', '11:30:00', '2022-12-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 50, '11:30:00', '12:00:00', '2022-12-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 51, '14:00:00', '14:30:00', '2022-12-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 52, '14:30:00', '15:00:00', '2022-12-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 53, '15:00:00', '15:30:00', '2022-12-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 54, '15:30:00', '16:00:00', '2022-12-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 55, '08:00:00', '08:30:00', '2022-12-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 56, '08:30:00', '09:00:00', '2022-12-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 57, '09:00:00', '09:30:00', '2022-12-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 58, '09:30:00', '10:00:00', '2022-12-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 59, '10:00:00', '10:30:00', '2022-12-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 60, '10:30:00', '11:00:00', '2022-12-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 61, '11:00:00', '11:30:00', '2022-12-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 62, '11:30:00', '12:00:00', '2022-12-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 63, '14:00:00', '14:30:00', '2022-12-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 64, '14:30:00', '15:00:00', '2022-12-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 65, '15:00:00', '15:30:00', '2022-12-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 66, '15:30:00', '16:00:00', '2022-12-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 67, '08:00:00', '08:30:00', '2022-12-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 68, '08:30:00', '09:00:00', '2022-12-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 69, '09:00:00', '09:30:00', '2022-12-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 70, '09:30:00', '10:00:00', '2022-12-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 71, '10:00:00', '10:30:00', '2022-12-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 72, '10:30:00', '11:00:00', '2022-12-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 73, '11:00:00', '11:30:00', '2022-12-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 74, '11:30:00', '12:00:00', '2022-12-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 75, '14:00:00', '14:30:00', '2022-12-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 76, '14:30:00', '15:00:00', '2022-12-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 77, '15:00:00', '15:30:00', '2022-12-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 78, '15:30:00', '16:00:00', '2022-12-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 79, '08:00:00', '08:30:00', '2022-12-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 80, '08:30:00', '09:00:00', '2022-12-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 81, '09:00:00', '09:30:00', '2022-12-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 82, '09:30:00', '10:00:00', '2022-12-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 83, '10:00:00', '10:30:00', '2022-12-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 84, '10:30:00', '11:00:00', '2022-12-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 85, '11:00:00', '11:30:00', '2022-12-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 86, '11:30:00', '12:00:00', '2022-12-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 87, '14:00:00', '14:30:00', '2022-12-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 88, '14:30:00', '15:00:00', '2022-12-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 89, '15:00:00', '15:30:00', '2022-12-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 90, '15:30:00', '16:00:00', '2022-12-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 91, '08:00:00', '08:30:00', '2022-12-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 92, '08:30:00', '09:00:00', '2022-12-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 93, '09:00:00', '09:30:00', '2022-12-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 94, '09:30:00', '10:00:00', '2022-12-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 95, '10:00:00', '10:30:00', '2022-12-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 96, '10:30:00', '11:00:00', '2022-12-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 97, '11:00:00', '11:30:00', '2022-12-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 98, '11:30:00', '12:00:00', '2022-12-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 99, '14:00:00', '14:30:00', '2022-12-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 100, '14:30:00', '15:00:00', '2022-12-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 101, '15:00:00', '15:30:00', '2022-12-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 102, '15:30:00', '16:00:00', '2022-12-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 103, '08:00:00', '08:30:00', '2022-12-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 104, '08:30:00', '09:00:00', '2022-12-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 105, '14:00:00', '14:30:00', '2022-12-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 106, '14:30:00', '15:00:00', '2022-12-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 107, '15:00:00', '15:30:00', '2022-12-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 108, '15:30:00', '16:00:00', '2022-12-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 109, '08:00:00', '08:30:00', '2023-01-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 110, '08:30:00', '09:00:00', '2023-01-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 111, '09:00:00', '09:30:00', '2023-01-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 112, '09:30:00', '10:00:00', '2023-01-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 113, '10:00:00', '10:30:00', '2023-01-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 114, '10:30:00', '11:00:00', '2023-01-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 115, '11:00:00', '11:30:00', '2023-01-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 116, '11:30:00', '12:00:00', '2023-01-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 117, '12:00:00', '12:30:00', '2023-01-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 118, '12:30:00', '13:00:00', '2023-01-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 119, '13:00:00', '13:30:00', '2023-01-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 120, '13:30:00', '14:00:00', '2023-01-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 121, '14:00:00', '14:30:00', '2023-01-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 122, '14:30:00', '15:00:00', '2023-01-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 123, '15:00:00', '15:30:00', '2023-01-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 124, '15:30:00', '16:00:00', '2023-01-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 125, '08:00:00', '08:30:00', '2022-12-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 126, '08:30:00', '09:00:00', '2022-12-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 127, '09:00:00', '09:30:00', '2022-12-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 128, '09:30:00', '10:00:00', '2022-12-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 129, '10:00:00', '10:30:00', '2022-12-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 130, '10:30:00', '11:00:00', '2022-12-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 131, '11:00:00', '11:30:00', '2022-12-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 132, '11:30:00', '12:00:00', '2022-12-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 133, '12:00:00', '12:30:00', '2022-12-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 134, '12:30:00', '13:00:00', '2022-12-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 135, '13:00:00', '13:30:00', '2022-12-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 136, '13:30:00', '14:00:00', '2022-12-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 137, '14:00:00', '14:30:00', '2022-12-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 138, '14:30:00', '15:00:00', '2022-12-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 139, '15:00:00', '15:30:00', '2022-12-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 140, '15:30:00', '16:00:00', '2022-12-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 141, '08:00:00', '08:30:00', '2022-12-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 142, '08:30:00', '09:00:00', '2022-12-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 143, '09:00:00', '09:30:00', '2022-12-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 144, '09:30:00', '10:00:00', '2022-12-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 145, '10:00:00', '10:30:00', '2022-12-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 146, '10:30:00', '11:00:00', '2022-12-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 147, '11:00:00', '11:30:00', '2022-12-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 148, '11:30:00', '12:00:00', '2022-12-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 149, '12:00:00', '12:30:00', '2022-12-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 150, '12:30:00', '13:00:00', '2022-12-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 151, '13:00:00', '13:30:00', '2022-12-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 152, '13:30:00', '14:00:00', '2022-12-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 153, '14:00:00', '14:30:00', '2022-12-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 154, '14:30:00', '15:00:00', '2022-12-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 155, '15:00:00', '15:30:00', '2022-12-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 156, '15:30:00', '16:00:00', '2022-12-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 157, '08:00:00', '08:30:00', '2023-01-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 158, '08:30:00', '09:00:00', '2023-01-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 159, '09:00:00', '09:30:00', '2023-01-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 160, '09:30:00', '10:00:00', '2023-01-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 161, '10:00:00', '10:30:00', '2023-01-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 162, '10:30:00', '11:00:00', '2023-01-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 163, '11:00:00', '11:30:00', '2023-01-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 164, '11:30:00', '12:00:00', '2023-01-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 165, '12:00:00', '12:30:00', '2023-01-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 166, '12:30:00', '13:00:00', '2023-01-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 167, '13:00:00', '13:30:00', '2023-01-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 168, '13:30:00', '14:00:00', '2023-01-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 169, '14:00:00', '14:30:00', '2023-01-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 170, '14:30:00', '15:00:00', '2023-01-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 171, '15:00:00', '15:30:00', '2023-01-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 172, '15:30:00', '16:00:00', '2023-01-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 173, '08:00:00', '08:30:00', '2023-01-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 174, '08:30:00', '09:00:00', '2023-01-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 175, '09:00:00', '09:30:00', '2023-01-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 176, '09:30:00', '10:00:00', '2023-01-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 177, '10:00:00', '10:30:00', '2023-01-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 178, '10:30:00', '11:00:00', '2023-01-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 179, '11:00:00', '11:30:00', '2023-01-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 180, '11:30:00', '12:00:00', '2023-01-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 181, '12:00:00', '12:30:00', '2023-01-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 182, '12:30:00', '13:00:00', '2023-01-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 183, '13:00:00', '13:30:00', '2023-01-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 184, '13:30:00', '14:00:00', '2023-01-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 185, '14:00:00', '14:30:00', '2023-01-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 186, '14:30:00', '15:00:00', '2023-01-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 187, '15:00:00', '15:30:00', '2023-01-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 188, '15:30:00', '16:00:00', '2023-01-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 190, '08:00:00', '08:30:00', '2023-01-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 191, '08:30:00', '09:00:00', '2023-01-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 192, '09:00:00', '09:30:00', '2023-01-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 193, '09:30:00', '10:00:00', '2023-01-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 194, '10:00:00', '10:30:00', '2023-01-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 195, '10:30:00', '11:00:00', '2023-01-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 196, '11:00:00', '11:30:00', '2023-01-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 197, '11:30:00', '12:00:00', '2023-01-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 198, '12:00:00', '12:30:00', '2023-01-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 199, '12:30:00', '13:00:00', '2023-01-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 200, '13:00:00', '13:30:00', '2023-01-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 201, '13:30:00', '14:00:00', '2023-01-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 202, '14:00:00', '14:30:00', '2023-01-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 203, '14:30:00', '15:00:00', '2023-01-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 204, '15:00:00', '15:30:00', '2023-01-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 205, '15:30:00', '16:00:00', '2023-01-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 254, '08:00:00', '08:30:00', '2023-01-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 255, '08:30:00', '09:00:00', '2023-01-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 256, '09:00:00', '09:30:00', '2023-01-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 257, '09:30:00', '10:00:00', '2023-01-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 258, '10:00:00', '10:30:00', '2023-01-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 259, '10:30:00', '11:00:00', '2023-01-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 260, '11:00:00', '11:30:00', '2023-01-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 261, '11:30:00', '12:00:00', '2023-01-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 262, '12:00:00', '12:30:00', '2023-01-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 263, '12:30:00', '13:00:00', '2023-01-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 264, '13:00:00', '13:30:00', '2023-01-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 265, '13:30:00', '14:00:00', '2023-01-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 266, '14:00:00', '14:30:00', '2023-01-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 267, '14:30:00', '15:00:00', '2023-01-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 268, '15:00:00', '15:30:00', '2023-01-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 269, '15:30:00', '16:00:00', '2023-01-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 270, '08:00:00', '08:30:00', '2023-01-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 271, '08:30:00', '09:00:00', '2023-01-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 272, '09:00:00', '09:30:00', '2023-01-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 273, '09:30:00', '10:00:00', '2023-01-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 274, '10:00:00', '10:30:00', '2023-01-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 275, '10:30:00', '11:00:00', '2023-01-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 276, '11:00:00', '11:30:00', '2023-01-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 277, '11:30:00', '12:00:00', '2023-01-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 278, '12:00:00', '12:30:00', '2023-01-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 279, '12:30:00', '13:00:00', '2023-01-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 280, '13:00:00', '13:30:00', '2023-01-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 281, '13:30:00', '14:00:00', '2023-01-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 282, '14:00:00', '14:30:00', '2023-01-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 283, '14:30:00', '15:00:00', '2023-01-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 284, '15:00:00', '15:30:00', '2023-01-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 285, '15:30:00', '16:00:00', '2023-01-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 286, '08:00:00', '08:30:00', '2023-01-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 287, '08:30:00', '09:00:00', '2023-01-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 288, '09:00:00', '09:30:00', '2023-01-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 289, '09:30:00', '10:00:00', '2023-01-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 290, '10:00:00', '10:30:00', '2023-01-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 291, '10:30:00', '11:00:00', '2023-01-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 292, '11:00:00', '11:30:00', '2023-01-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 293, '11:30:00', '12:00:00', '2023-01-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 294, '12:00:00', '12:30:00', '2023-01-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 295, '12:30:00', '13:00:00', '2023-01-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 296, '13:00:00', '13:30:00', '2023-01-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 297, '13:30:00', '14:00:00', '2023-01-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 298, '14:00:00', '14:30:00', '2023-01-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 299, '14:30:00', '15:00:00', '2023-01-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 300, '15:00:00', '15:30:00', '2023-01-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 301, '15:30:00', '16:00:00', '2023-01-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 302, '08:00:00', '08:30:00', '2023-01-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 303, '08:30:00', '09:00:00', '2023-01-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 304, '09:00:00', '09:30:00', '2023-01-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 305, '09:30:00', '10:00:00', '2023-01-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 306, '10:00:00', '10:30:00', '2023-01-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 307, '10:30:00', '11:00:00', '2023-01-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 308, '11:00:00', '11:30:00', '2023-01-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 309, '11:30:00', '12:00:00', '2023-01-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 310, '12:00:00', '12:30:00', '2023-01-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 311, '12:30:00', '13:00:00', '2023-01-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 312, '13:00:00', '13:30:00', '2023-01-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 313, '13:30:00', '14:00:00', '2023-01-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 314, '14:00:00', '14:30:00', '2023-01-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 315, '14:30:00', '15:00:00', '2023-01-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 316, '15:00:00', '15:30:00', '2023-01-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 317, '15:30:00', '16:00:00', '2023-01-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 318, '08:00:00', '08:30:00', '2023-01-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 319, '08:30:00', '09:00:00', '2023-01-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 320, '09:00:00', '09:30:00', '2023-01-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 321, '09:30:00', '10:00:00', '2023-01-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 322, '10:00:00', '10:30:00', '2023-01-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 323, '10:30:00', '11:00:00', '2023-01-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 324, '11:00:00', '11:30:00', '2023-01-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 325, '11:30:00', '12:00:00', '2023-01-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 326, '12:00:00', '12:30:00', '2023-01-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 327, '12:30:00', '13:00:00', '2023-01-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 328, '13:00:00', '13:30:00', '2023-01-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 329, '13:30:00', '14:00:00', '2023-01-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 330, '14:00:00', '14:30:00', '2023-01-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 331, '14:30:00', '15:00:00', '2023-01-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 332, '15:00:00', '15:30:00', '2023-01-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 333, '15:30:00', '16:00:00', '2023-01-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 334, '08:00:00', '08:30:00', '2023-01-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 335, '08:30:00', '09:00:00', '2023-01-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 336, '09:00:00', '09:30:00', '2023-01-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 337, '09:30:00', '10:00:00', '2023-01-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 338, '10:00:00', '10:30:00', '2023-01-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 339, '10:30:00', '11:00:00', '2023-01-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 340, '11:00:00', '11:30:00', '2023-01-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 341, '11:30:00', '12:00:00', '2023-01-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 342, '12:00:00', '12:30:00', '2023-01-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 343, '12:30:00', '13:00:00', '2023-01-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 344, '13:00:00', '13:30:00', '2023-01-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 345, '13:30:00', '14:00:00', '2023-01-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 346, '14:00:00', '14:30:00', '2023-01-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 347, '14:30:00', '15:00:00', '2023-01-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 348, '15:00:00', '15:30:00', '2023-01-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 349, '15:30:00', '16:00:00', '2023-01-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 350, '08:00:00', '08:30:00', '2023-01-13', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 351, '08:30:00', '09:00:00', '2023-01-13', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 352, '09:00:00', '09:30:00', '2023-01-13', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 353, '09:30:00', '10:00:00', '2023-01-13', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 354, '10:00:00', '10:30:00', '2023-01-13', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 355, '10:30:00', '11:00:00', '2023-01-13', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 356, '11:00:00', '11:30:00', '2023-01-13', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 357, '11:30:00', '12:00:00', '2023-01-13', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 358, '12:00:00', '12:30:00', '2023-01-13', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 359, '12:30:00', '13:00:00', '2023-01-13', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 360, '13:00:00', '13:30:00', '2023-01-13', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 361, '13:30:00', '14:00:00', '2023-01-13', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 362, '14:00:00', '14:30:00', '2023-01-13', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 363, '14:30:00', '15:00:00', '2023-01-13', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 364, '15:00:00', '15:30:00', '2023-01-13', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 365, '15:30:00', '16:00:00', '2023-01-13', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 366, '08:00:00', '08:30:00', '2023-01-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 367, '08:30:00', '09:00:00', '2023-01-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 368, '09:00:00', '09:30:00', '2023-01-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 369, '09:30:00', '10:00:00', '2023-01-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 370, '10:00:00', '10:30:00', '2023-01-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 371, '10:30:00', '11:00:00', '2023-01-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 372, '11:00:00', '11:30:00', '2023-01-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 373, '11:30:00', '12:00:00', '2023-01-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 374, '12:00:00', '12:30:00', '2023-01-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 375, '12:30:00', '13:00:00', '2023-01-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 376, '13:00:00', '13:30:00', '2023-01-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 377, '13:30:00', '14:00:00', '2023-01-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 378, '14:00:00', '14:30:00', '2023-01-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 379, '14:30:00', '15:00:00', '2023-01-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 380, '15:00:00', '15:30:00', '2023-01-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 381, '15:30:00', '16:00:00', '2023-01-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 382, '08:00:00', '08:30:00', '2023-01-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 383, '08:30:00', '09:00:00', '2023-01-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 384, '09:00:00', '09:30:00', '2023-01-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 385, '09:30:00', '10:00:00', '2023-01-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 386, '10:00:00', '10:30:00', '2023-01-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 387, '10:30:00', '11:00:00', '2023-01-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 388, '11:00:00', '11:30:00', '2023-01-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 389, '11:30:00', '12:00:00', '2023-01-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 390, '12:00:00', '12:30:00', '2023-01-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 391, '12:30:00', '13:00:00', '2023-01-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 392, '13:00:00', '13:30:00', '2023-01-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 393, '13:30:00', '14:00:00', '2023-01-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 394, '14:00:00', '14:30:00', '2023-01-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 395, '14:30:00', '15:00:00', '2023-01-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 396, '15:00:00', '15:30:00', '2023-01-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 397, '15:30:00', '16:00:00', '2023-01-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 398, '08:00:00', '08:30:00', '2023-01-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 399, '08:30:00', '09:00:00', '2023-01-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 400, '09:00:00', '09:30:00', '2023-01-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 401, '09:30:00', '10:00:00', '2023-01-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 402, '10:00:00', '10:30:00', '2023-01-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 403, '10:30:00', '11:00:00', '2023-01-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 404, '11:00:00', '11:30:00', '2023-01-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 405, '11:30:00', '12:00:00', '2023-01-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 406, '12:00:00', '12:30:00', '2023-01-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 407, '12:30:00', '13:00:00', '2023-01-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 408, '13:00:00', '13:30:00', '2023-01-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 409, '13:30:00', '14:00:00', '2023-01-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 410, '14:00:00', '14:30:00', '2023-01-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 411, '14:30:00', '15:00:00', '2023-01-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 412, '15:00:00', '15:30:00', '2023-01-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 413, '15:30:00', '16:00:00', '2023-01-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 414, '08:00:00', '08:30:00', '2023-01-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 415, '08:30:00', '09:00:00', '2023-01-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 416, '09:00:00', '09:30:00', '2023-01-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 417, '09:30:00', '10:00:00', '2023-01-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 418, '10:00:00', '10:30:00', '2023-01-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 419, '10:30:00', '11:00:00', '2023-01-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 420, '11:00:00', '11:30:00', '2023-01-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 421, '11:30:00', '12:00:00', '2023-01-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 422, '12:00:00', '12:30:00', '2023-01-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 423, '12:30:00', '13:00:00', '2023-01-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 424, '13:00:00', '13:30:00', '2023-01-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 425, '13:30:00', '14:00:00', '2023-01-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 426, '14:00:00', '14:30:00', '2023-01-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 427, '14:30:00', '15:00:00', '2023-01-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 428, '15:00:00', '15:30:00', '2023-01-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 429, '15:30:00', '16:00:00', '2023-01-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 430, '08:00:00', '08:30:00', '2023-01-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 431, '08:30:00', '09:00:00', '2023-01-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 432, '09:00:00', '09:30:00', '2023-01-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 433, '09:30:00', '10:00:00', '2023-01-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 434, '10:00:00', '10:30:00', '2023-01-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 435, '10:30:00', '11:00:00', '2023-01-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 436, '11:00:00', '11:30:00', '2023-01-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 437, '11:30:00', '12:00:00', '2023-01-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 438, '12:00:00', '12:30:00', '2023-01-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 439, '12:30:00', '13:00:00', '2023-01-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 440, '13:00:00', '13:30:00', '2023-01-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 441, '13:30:00', '14:00:00', '2023-01-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 442, '14:00:00', '14:30:00', '2023-01-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 443, '14:30:00', '15:00:00', '2023-01-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 444, '15:00:00', '15:30:00', '2023-01-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 445, '15:30:00', '16:00:00', '2023-01-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 446, '08:00:00', '08:30:00', '2023-01-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 447, '08:30:00', '09:00:00', '2023-01-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 448, '09:00:00', '09:30:00', '2023-01-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 449, '09:30:00', '10:00:00', '2023-01-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 450, '10:00:00', '10:30:00', '2023-01-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 451, '10:30:00', '11:00:00', '2023-01-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 452, '11:00:00', '11:30:00', '2023-01-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 453, '11:30:00', '12:00:00', '2023-01-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 454, '12:00:00', '12:30:00', '2023-01-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 455, '12:30:00', '13:00:00', '2023-01-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 456, '13:00:00', '13:30:00', '2023-01-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 457, '13:30:00', '14:00:00', '2023-01-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 458, '14:00:00', '14:30:00', '2023-01-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 459, '14:30:00', '15:00:00', '2023-01-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 460, '15:00:00', '15:30:00', '2023-01-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 461, '15:30:00', '16:00:00', '2023-01-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 462, '08:00:00', '08:30:00', '2023-01-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 463, '08:30:00', '09:00:00', '2023-01-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 464, '09:00:00', '09:30:00', '2023-01-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 465, '09:30:00', '10:00:00', '2023-01-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 466, '10:00:00', '10:30:00', '2023-01-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 467, '10:30:00', '11:00:00', '2023-01-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 468, '11:00:00', '11:30:00', '2023-01-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 469, '11:30:00', '12:00:00', '2023-01-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 470, '12:00:00', '12:30:00', '2023-01-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 471, '12:30:00', '13:00:00', '2023-01-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 472, '13:00:00', '13:30:00', '2023-01-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 473, '13:30:00', '14:00:00', '2023-01-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 474, '14:00:00', '14:30:00', '2023-01-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 475, '14:30:00', '15:00:00', '2023-01-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 476, '15:00:00', '15:30:00', '2023-01-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 477, '15:30:00', '16:00:00', '2023-01-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 478, '08:00:00', '08:30:00', '2023-01-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 479, '08:30:00', '09:00:00', '2023-01-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 480, '09:00:00', '09:30:00', '2023-01-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 481, '09:30:00', '10:00:00', '2023-01-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 482, '10:00:00', '10:30:00', '2023-01-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 483, '10:30:00', '11:00:00', '2023-01-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 484, '11:00:00', '11:30:00', '2023-01-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 485, '11:30:00', '12:00:00', '2023-01-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 486, '12:00:00', '12:30:00', '2023-01-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 487, '12:30:00', '13:00:00', '2023-01-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 488, '13:00:00', '13:30:00', '2023-01-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 489, '13:30:00', '14:00:00', '2023-01-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 490, '14:00:00', '14:30:00', '2023-01-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 491, '14:30:00', '15:00:00', '2023-01-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 492, '15:00:00', '15:30:00', '2023-01-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 493, '15:30:00', '16:00:00', '2023-01-30', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 494, '08:00:00', '08:30:00', '2023-01-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 495, '08:30:00', '09:00:00', '2023-01-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 496, '09:00:00', '09:30:00', '2023-01-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 497, '09:30:00', '10:00:00', '2023-01-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 498, '10:00:00', '10:30:00', '2023-01-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 499, '10:30:00', '11:00:00', '2023-01-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 500, '11:00:00', '11:30:00', '2023-01-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 501, '11:30:00', '12:00:00', '2023-01-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 502, '12:00:00', '12:30:00', '2023-01-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 503, '12:30:00', '13:00:00', '2023-01-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 504, '13:00:00', '13:30:00', '2023-01-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 505, '13:30:00', '14:00:00', '2023-01-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 506, '14:00:00', '14:30:00', '2023-01-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 507, '14:30:00', '15:00:00', '2023-01-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 508, '15:00:00', '15:30:00', '2023-01-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 509, '15:30:00', '16:00:00', '2023-01-31', '00:30:00');
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 20, '2023-01-12', '2023-01-12', '12:00:00', '13:00:00', 3);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 22, '2023-01-12', '2023-01-12', '13:00:00', '14:30:00', 3);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 23, '2023-01-13', '2023-01-13', '11:30:00', '14:30:00', 3);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 24, '2023-01-16', '2023-01-16', '09:00:00', '15:00:00', 3);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 25, '2023-01-17', '2023-01-18', '14:00:00', '09:30:00', 3);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 26, '2023-01-13', '2023-01-13', '08:00:00', '08:30:00', 3);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 27, '2023-01-18', '2023-01-18', '12:00:00', '14:00:00', 3);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 28, '2023-01-19', '2023-01-19', '14:30:00', '15:00:00', 3);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 29, '2023-01-26', '2023-01-26', '10:30:00', '13:30:00', 3);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 30, '2023-01-27', '2023-01-27', '11:00:00', '13:00:00', 3);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 31, '2023-01-30', '2023-01-30', '08:00:00', '10:00:00', 3);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 32, '2023-01-31', '2023-01-31', '09:00:00', '11:00:00', 3);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Hello world ???? ', 2, 1, '5545789628', '0341752875', 'joris@gmail.com', 'NAIVOSOA', 'Joris', 'session884.5824087825326');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'fafa', 3, 1, '552552552552', '0341752875', 'johns.irintsoa@gmail.com', 'RAKOTONIRINA', 'nirina', '123456789');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Dadada', 4, 1, '121212', '0341752875', 'johns.irintsoa@gmail.com', 'RANDRIANARISON', 'teo', '123456789');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Hi Je suis johns irintsoa, Un Rendez-vous avec toi ', 5, 1, '112112112', '0341752875', 'johns.irintsoa@gmail.com', 'RANDRIANARISON', 'johns irintsoa', '');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Hello world', 6, 1, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RAKOTONIRINA', 'teo', 'session484.16446685492673');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Hi', 9, 1, '2131232', '0341752875', 'johns.irintsoa@gmail.com', 'SAIFOUDINE', 'teo', 'session260.65258734384656');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Hi', 10, 1, '2131232', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'teo', 'session482.0560317367997');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Hi every one I m johns', 23, 1, '552552552552', '0341752875', 'johns.irintsoa@gmail.com', 'RAKOTONIRINA', 'johns', 'session667.0425578374497');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'dfsdf', 24, 1, '2131232', '0341752875', 'johns.irintsoa@gmail.com', 'RANDRIANARISON', 'johns', 'session758.8425892739461');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'gf', 25, 1, '2131232', '0341752875', 'johns.irintsoa@gmail.com', 'RANDRIANARISON', 'johns', 'session367.06106880374125');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Hi i want you', 26, 2, '112112112112', '0341752875', 'johns.irintsoa@gmail.com', 'ZAHO', 'july', 'session438.45809287053174');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Hello world everyone', 27, 1, '1212112121', '0341752875', 'johns.irintsoa@gmail.com', 'NAIVOSOA', 'nirina', 'session438.45809287053174');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Hello world', 28, 1, '552552552552', '0341752875', 'johns.irintsoa@gmail.com', 'RANDRIANARISON', 'johns', 'session476.79020881446377');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Hello everyone welcome to team ki', 30, 1, '2131232', '0341752875', 'johns.irintsoa@gmail.com', 'PATTERSON', 'george', 'session719.414786474689');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Hello world', 31, 1, '552552552552', '0341752875', 'johns.irintsoa@gmail.com', 'RAJA', 'gael', 'session579.6630785288803');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Hello world ', 32, 1, '112112112112', '0341752875', 'johns.irintsoa@gmail.com', 'RANDRIANARISON', 'johns irintsoa', 'session675.9615947922701');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Never missed work out day', 34, 0, '552552552552', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'johns', 'session624.6196312374357');
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur ) VALUES ( 'Hello world Je suis johns', 35, 0, '112112112112', '0341752875', 'johns.irintsoa@gmail.com', 'RANDRIANARISON', 'johns', 'session145.28218943383163');
INSERT INTO stage5.domaine( id, nom_domaine ) VALUES ( 1, 'Informatique');
INSERT INTO stage5.domaine( id, nom_domaine ) VALUES ( 2, 'Marketing');
INSERT INTO stage5.domaine( id, nom_domaine ) VALUES ( 3, 'Finances et comptabilité');
INSERT INTO stage5.domaine( id, nom_domaine ) VALUES ( 4, 'Communication Marketing');
INSERT INTO stage5.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin, id ) VALUES ( 'Toussaint', '11', '11', '00:00:01', '23:59:00', 1);
INSERT INTO stage5.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin, id ) VALUES ( 'Noel', '25', '12', '08:00:00', '12:00:00', 2);
INSERT INTO stage5.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin, id ) VALUES ( 'Fin d''année', '31', '12', '14:00:00', '16:00:00', 3);
INSERT INTO stage5.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin, id ) VALUES ( 'Nouvel an', '11', '1', '08:00:00', '12:00:00', 4);
INSERT INTO stage5.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin, id ) VALUES ( 'Black Friday', '28', '11', '11:40:00', '12:10:00', 5);
INSERT INTO stage5.autorite_enfant( id, intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ( 1, 'Direction des Ressources Humaines', 'DRH', 2, 'johns.irintsoa@gmail.com', 'wswrgxbntbumffqs', '356');
INSERT INTO stage5.autorite_enfant( id, intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ( 2, 'Direction des Systèmes d''Informations', 'DSI', 2, 'dyranjohns@gmail.com', 'wswrgxbntbumffqs', '413');
INSERT INTO stage5.autorite_enfant( id, intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ( 3, 'Direction Générales des Impots', 'DGI', 2, 'mefstage2022@gmail.com', 'wswrgxbntbumffqs', '123');
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 38, 7, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 39, 8, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 40, 9, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 41, 10, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 45, 13, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 46, 14, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 47, 15, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 48, 16, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 49, 17, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 50, 18, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 51, 19, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 52, 20, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 53, 21, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 54, 22, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 55, 23, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 56, 24, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 57, 25, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 58, 26, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 66, 27, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 67, 28, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 68, 29, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 69, 30, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 70, 31, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 71, 32, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 72, 33, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 73, 34, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 74, 35, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 75, 36, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 76, 37, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 77, 38, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 85, 39, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 86, 40, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 87, 41, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 88, 42, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 89, 31, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 90, 32, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 91, 33, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 92, 34, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 93, 35, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 94, 36, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 95, 37, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 96, 38, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 104, 39, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 105, 40, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 106, 41, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 107, 42, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 111, 43, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 112, 44, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 113, 45, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 114, 46, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 115, 47, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 116, 48, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 117, 49, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 118, 50, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 126, 51, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 127, 52, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 128, 53, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 129, 54, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 130, 55, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 131, 56, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 132, 57, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 133, 58, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 134, 59, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 135, 60, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 136, 61, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 137, 62, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 145, 63, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 146, 64, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 147, 65, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 148, 66, 2, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 149, 67, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 150, 68, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 151, 69, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 152, 70, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 153, 71, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 154, 72, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 155, 73, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 156, 74, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 164, 75, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 165, 76, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 166, 77, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 167, 78, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 171, 67, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 172, 68, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 173, 69, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 174, 70, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 175, 71, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 176, 72, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 177, 73, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 178, 74, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 186, 75, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 187, 76, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 188, 77, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 189, 78, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 190, 79, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 191, 80, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 192, 81, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 193, 82, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 194, 83, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 195, 84, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 196, 85, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 197, 86, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 205, 87, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 206, 88, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 207, 89, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 208, 90, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 212, 91, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 213, 92, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 214, 93, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 215, 94, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 216, 95, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 217, 96, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 218, 97, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 219, 98, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 227, 99, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 228, 100, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 229, 101, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 230, 102, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 231, 67, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 232, 68, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 233, 69, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 234, 70, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 235, 71, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 236, 72, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 237, 73, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 238, 74, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 246, 75, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 247, 76, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 248, 77, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 249, 78, 1, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 263, 103, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 264, 104, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 266, 105, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 267, 106, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 268, 107, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 269, 108, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 270, 109, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 271, 110, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 272, 111, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 273, 112, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 274, 113, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 275, 114, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 276, 115, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 277, 116, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 278, 117, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 279, 118, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 280, 119, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 281, 120, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 282, 121, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 283, 122, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 284, 123, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 285, 124, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 301, 125, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 302, 126, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 303, 127, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 304, 128, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 305, 129, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 306, 130, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 307, 131, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 308, 132, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 309, 133, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 310, 134, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 311, 135, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 312, 136, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 313, 137, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 314, 138, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 315, 139, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 316, 140, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 332, 141, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 333, 142, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 334, 143, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 335, 144, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 336, 145, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 337, 146, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 338, 147, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 339, 148, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 340, 149, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 341, 150, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 342, 151, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 343, 152, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 344, 153, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 345, 154, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 346, 155, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 347, 156, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 363, 157, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 364, 158, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 365, 159, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 366, 160, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 367, 161, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 368, 162, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 369, 163, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 370, 164, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 371, 165, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 372, 166, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 373, 167, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 374, 168, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 375, 169, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 376, 170, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 377, 171, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 378, 172, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 394, 173, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 395, 174, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 396, 175, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 397, 176, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 398, 177, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 399, 178, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 400, 179, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 401, 180, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 402, 181, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 403, 182, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 404, 183, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 405, 184, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 406, 185, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 407, 186, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 408, 187, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 409, 188, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 426, 190, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 427, 191, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 428, 192, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 429, 193, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 430, 194, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 431, 195, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 432, 196, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 433, 197, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 434, 198, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 435, 199, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 436, 200, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 437, 201, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 438, 202, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 439, 203, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 440, 204, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 441, 205, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 550, 254, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 551, 255, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 552, 256, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 553, 257, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 554, 258, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 555, 259, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 556, 260, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 557, 261, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 558, 262, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 559, 263, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 560, 264, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 561, 265, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 562, 266, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 563, 267, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 564, 268, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 565, 269, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 581, 270, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 582, 271, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 583, 272, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 584, 273, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 585, 274, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 586, 275, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 587, 276, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 588, 277, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 589, 278, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 590, 279, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 591, 280, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 592, 281, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 593, 282, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 594, 283, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 595, 284, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 596, 285, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 597, 286, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 598, 287, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 599, 288, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 600, 289, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 601, 290, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 602, 291, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 603, 292, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 604, 293, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 605, 294, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 606, 295, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 607, 296, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 608, 297, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 609, 298, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 610, 299, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 611, 300, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 612, 301, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 613, 302, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 614, 303, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 615, 304, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 616, 305, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 617, 306, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 618, 307, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 619, 308, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 620, 309, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 621, 310, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 622, 311, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 623, 312, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 624, 313, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 625, 314, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 626, 315, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 627, 316, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 628, 317, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 644, 318, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 645, 319, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 646, 320, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 647, 321, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 648, 322, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 649, 323, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 650, 324, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 651, 325, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 652, 326, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 653, 327, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 654, 328, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 655, 329, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 656, 330, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 657, 331, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 658, 332, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 659, 333, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 675, 334, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 676, 335, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 677, 336, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 678, 337, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 679, 338, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 680, 339, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 681, 340, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 682, 341, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 683, 342, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 684, 343, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 685, 344, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 686, 345, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 687, 346, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 688, 347, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 689, 348, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 690, 349, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 691, 350, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 692, 351, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 693, 352, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 694, 353, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 695, 354, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 696, 355, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 697, 356, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 698, 357, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 699, 358, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 700, 359, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 701, 360, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 702, 361, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 703, 362, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 704, 363, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 705, 364, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 706, 365, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 707, 366, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 708, 367, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 709, 368, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 710, 369, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 711, 370, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 712, 371, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 713, 372, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 714, 373, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 715, 374, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 716, 375, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 717, 376, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 718, 377, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 719, 378, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 720, 379, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 721, 380, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 722, 381, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 738, 382, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 739, 383, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 740, 384, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 741, 385, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 742, 386, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 743, 387, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 744, 388, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 745, 389, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 746, 390, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 747, 391, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 748, 392, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 749, 393, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 750, 394, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 751, 395, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 752, 396, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 753, 397, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 769, 398, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 770, 399, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 771, 400, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 772, 401, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 773, 402, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 774, 403, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 775, 404, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 776, 405, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 777, 406, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 778, 407, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 779, 408, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 780, 409, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 781, 410, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 782, 411, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 783, 412, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 784, 413, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 785, 414, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 786, 415, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 787, 416, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 788, 417, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 789, 418, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 790, 419, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 791, 420, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 792, 421, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 793, 422, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 794, 423, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 795, 424, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 796, 425, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 797, 426, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 798, 427, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 799, 428, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 800, 429, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 801, 430, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 802, 431, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 803, 432, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 804, 433, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 805, 434, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 806, 435, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 807, 436, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 808, 437, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 809, 438, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 810, 439, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 811, 440, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 812, 441, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 813, 442, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 814, 443, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 815, 444, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 816, 445, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 817, 446, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 818, 447, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 819, 448, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 820, 449, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 821, 450, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 822, 451, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 823, 452, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 824, 453, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 825, 454, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 826, 455, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 827, 456, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 828, 457, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 829, 458, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 830, 459, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 831, 460, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 832, 461, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 848, 462, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 849, 463, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 850, 464, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 851, 465, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 852, 466, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 853, 467, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 854, 468, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 855, 469, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 856, 470, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 857, 471, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 858, 472, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 859, 473, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 860, 474, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 861, 475, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 862, 476, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 863, 477, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 864, 478, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 865, 479, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 866, 480, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 867, 481, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 868, 482, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 869, 483, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 870, 484, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 871, 485, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 872, 486, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 873, 487, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 874, 488, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 875, 489, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 876, 490, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 877, 491, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 878, 492, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 879, 493, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 880, 494, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 881, 495, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 882, 496, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 883, 497, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 884, 498, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 885, 499, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 886, 500, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 887, 501, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 888, 502, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 889, 503, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 890, 504, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 891, 505, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 892, 506, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 893, 507, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 894, 508, 3, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 895, 509, 3, 1);
INSERT INTO stage5.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 15, 1, 'hHALA', 1);
INSERT INTO stage5.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 18, 2, 'Hiiii\n', 1);
INSERT INTO stage5.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 19, 2, 'Hi Everyone. Happy new year', 1);
INSERT INTO stage5.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 20, 1, 'Hi DGI je suis DRH', 1);
INSERT INTO stage5.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 22, 1, 'Hi everyone ', 1);
INSERT INTO stage5.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 23, 1, 'Hie', 1);
INSERT INTO stage5.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 29, 1, 'Salama tale', 1);
INSERT INTO stage5.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 30, 1, 'Hello world', 1);
INSERT INTO stage5.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 31, 1, 'Hi everyone', 1);
INSERT INTO stage5.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 32, 1, 'Hello world tale', 1);
INSERT INTO stage5.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 34, 1, 'Hello Are you good today', 0);
INSERT INTO stage5.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action ) VALUES ( 35, 1, 'Dossier avy amin ny SG', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action ) VALUES ( 6, 'RANDRIANARISON', 'Johns', '341777887', 'johnsirintsoa18@gmail.com', '112112112', 4, 'curriculum_vitae_1668365659799_decret_782_96.pdf', 'lettre_motivation_1668365659804_decret_782_96.pdf', 'lettre_introduction_1668365659808_decret_782_96.pdf', 'Je suis un étudiant en première année', 2, 1, '2023-01-16', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action ) VALUES ( 7, 'RAKOTONIRINA', 'Teo', '348899966', 'johns.irintsoa@gmail.com', '112112112', 5, 'curriculum_vitae_1668366150840_Les nombres rationnels.pdf', 'lettre_motivation_1668366150968_Les nombres rationnels.pdf', 'lettre_introduction_1668366150973_Les nombres rationnels.pdf', 'Je suis désolé', 3, 3, '2023-01-16', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action ) VALUES ( 8, 'RANAIVOSOA', 'Tiana', '348899966', 'teo@gmail.com', '112112112', 5, 'curriculum_vitae_1668366340054_Les nombres rationnels.pdf', 'lettre_motivation_1668366340061_Les nombres rationnels.pdf', 'lettre_introduction_1668366340067_Les nombres rationnels.pdf', 'Je suis désolé', 3, 1, '2023-01-16', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action ) VALUES ( 9, 'NAIVOSOA', 'Nirina', '345677889', 'naivosoa@gmail.com', '112112112', 3, 'curriculum_vitae_1668400143631_Les nombres rationnels.pdf', 'lettre_motivation_1668400143714_Les nombres rationnels.pdf', 'lettre_introduction_1668400143721_Les nombres rationnels.pdf', 'Je suis la ', 1, 2, '2023-01-16', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action ) VALUES ( 10, 'FIFIDIA', 'Fy', '345677889', 'fifidia@gmail.com', '112112112', 4, 'curriculum_vitae_1668402706992_Les nombres rationnels.pdf', 'lettre_motivation_1668402707078_Les nombres rationnels.pdf', 'lettre_introduction_1668402707083_Les nombres rationnels.pdf', 'bring it on', 4, 1, '2023-01-16', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action ) VALUES ( 11, 'RANDRIANARISON', 'Johns Irintsoa', '341752875', 'johns.irintsoa@gmail.com', '112112112', 3, 'curriculum_vitae_1671710383664_mail.pdf', 'lettre_motivation_1671710383802_mail.pdf', 'lettre_introduction_1671710383899_mail.pdf', 'Je voudrais faire un stage dans votre département.', 1, 1, '2023-01-16', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action ) VALUES ( 12, 'RANDRIANARISON', 'Johns', '341752875', 'johnsirintsoa18@gmail.com', '552552552552', 2, 'curriculum_vitae_1672901739308_mail.pdf', 'lettre_motivation_1672901739324_mail.pdf', 'lettre_introduction_1672901739334_mail.pdf', 'Je suis blablblla', 1, 1, '2023-01-16', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action ) VALUES ( 13, 'RANDRIANARISON', 'Johns', '341752875', 'johnsirintsoa18@gmail.com', '552552552552', 3, 'curriculum_vitae_1672903286979_mail.pdf', 'lettre_motivation_1672903286982_mail.pdf', 'lettre_introduction_1672903286986_mail.pdf', 'Hello world', 1, 1, '2023-01-16', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action ) VALUES ( 14, 'RANDRIANARISON', 'Johns', '341752875', 'johns.irintsoa@gmail.com', '112112112112', 3, 'curriculum_vitae_1673098224540_mail.pdf', 'lettre_motivation_1673098224705_mail.pdf', 'lettre_introduction_1673098224706_mail.pdf', 'Je suis un élève de ITU. Je voudrais faire mon stage chez vous pour une durée de 3 Mois.', 1, 3, '2023-01-16', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action ) VALUES ( 15, 'SAIFOUDINE', 'Nirina', '341752875', 'johns.irintsoa@gmail.com', '1212112121', 3, 'curriculum_vitae_1673190500288_mail.pdf', 'lettre_motivation_1673190500291_mail.pdf', 'lettre_introduction_1673190500294_mail.pdf', 'Hello world', 1, 3, '2023-01-16', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action ) VALUES ( 16, 'RAKOTOVA', 'Solofo', '341752875', 'johns.irintsoa@gmail.com', '1212112121', 3, 'curriculum_vitae_1673205163466_mail.pdf', 'lettre_motivation_1673205163469_mail.pdf', 'lettre_introduction_1673205163473_mail.pdf', 'Hello world', 3, 3, '2023-01-16', 2);
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 18, 130, 15, '08:00:00', '08:30:00', '2022-12-29', '2022-12-29');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 21, 171, 18, '08:00:00', '08:30:00', '2022-12-29', '2022-12-29');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 22, 174, 19, '09:30:00', '10:00:00', '2022-12-29', '2022-12-29');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 23, 268, 20, '15:00:00', '15:30:00', '2022-12-29', '2022-12-29');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 29, 435, 29, '12:30:00', '13:00:00', '2023-01-04', '2023-01-04');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 231, 584, 31, '09:30:00', '11:00:00', '2023-01-06', '2023-01-06');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 232, 585, 31, '09:30:00', '11:00:00', '2023-01-06', '2023-01-06');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 233, 586, 31, '09:30:00', '11:00:00', '2023-01-06', '2023-01-06');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 234, 591, 30, '13:00:00', '15:00:00', '2023-01-06', '2023-01-06');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 235, 592, 30, '13:00:00', '15:00:00', '2023-01-06', '2023-01-06');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 236, 593, 30, '13:00:00', '15:00:00', '2023-01-06', '2023-01-06');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 237, 594, 30, '13:00:00', '15:00:00', '2023-01-06', '2023-01-06');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 241, 583, 32, '09:00:00', '09:30:00', '2023-01-06', '2023-01-06');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 249, 688, 34, '14:30:00', '15:00:00', '2023-01-12', '2023-01-12');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 254, 738, 35, '08:00:00', '08:30:00', '2023-01-17', '2023-01-17');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 2, 52, 2, '08:30:00', '09:00:00', null, null);
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 3, 70, 3, '08:00:00', '08:30:00', null, null);
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 4, 71, 4, '08:30:00', '09:00:00', null, null);
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 5, 175, 5, '10:00:00', '10:30:00', null, null);
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 6, 190, 6, '08:00:00', '08:30:00', null, null);
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 9, 213, 9, '08:30:00', '09:00:00', '2022-12-28', '2022-12-28');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 10, 263, 11, '08:00:00', '08:30:00', '2022-12-29', '2022-12-29');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 23, 430, 215, '10:00:00', '12:00:00', '2023-01-04', '2023-01-04');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 23, 431, 216, '10:00:00', '12:00:00', '2023-01-04', '2023-01-04');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 23, 432, 217, '10:00:00', '12:00:00', '2023-01-04', '2023-01-04');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 23, 433, 218, '10:00:00', '12:00:00', '2023-01-04', '2023-01-04');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 24, 587, 279, '11:00:00', '13:00:00', '2023-01-06', '2023-01-06');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 24, 588, 280, '11:00:00', '13:00:00', '2023-01-06', '2023-01-06');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 24, 589, 281, '11:00:00', '13:00:00', '2023-01-06', '2023-01-06');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 24, 590, 282, '11:00:00', '13:00:00', '2023-01-06', '2023-01-06');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 27, 739, 465, '08:30:00', '11:00:00', '2023-01-17', '2023-01-17');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 27, 740, 466, '08:30:00', '11:00:00', '2023-01-17', '2023-01-17');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 27, 741, 467, '08:30:00', '11:00:00', '2023-01-17', '2023-01-17');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 27, 742, 468, '08:30:00', '11:00:00', '2023-01-17', '2023-01-17');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 27, 743, 469, '08:30:00', '11:00:00', '2023-01-17', '2023-01-17');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 25, 774, 472, '10:30:00', '11:30:00', '2023-01-18', '2023-01-18');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 25, 775, 473, '10:30:00', '11:30:00', '2023-01-18', '2023-01-18');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 26, 779, 475, '13:00:00', '15:00:00', '2023-01-18', '2023-01-18');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 26, 780, 476, '13:00:00', '15:00:00', '2023-01-18', '2023-01-18');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 26, 781, 477, '13:00:00', '15:00:00', '2023-01-18', '2023-01-18');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 26, 782, 478, '13:00:00', '15:00:00', '2023-01-18', '2023-01-18');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 30, 776, 483, '11:30:00', '12:00:00', '2023-01-18', '2023-01-18');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 31, 744, 490, '11:00:00', '11:30:00', '2023-01-17', '2023-01-17');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 32, 808, 492, '11:30:00', '13:30:00', '2023-01-20', '2023-01-20');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 32, 809, 493, '11:30:00', '13:30:00', '2023-01-20', '2023-01-20');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 32, 810, 494, '11:30:00', '13:30:00', '2023-01-20', '2023-01-20');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 32, 811, 495, '11:30:00', '13:30:00', '2023-01-20', '2023-01-20');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 28, 787, 499, '09:00:00', '12:30:00', '2023-01-19', '2023-01-19');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 28, 788, 500, '09:00:00', '12:30:00', '2023-01-19', '2023-01-19');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 28, 789, 501, '09:00:00', '12:30:00', '2023-01-19', '2023-01-19');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 28, 790, 502, '09:00:00', '12:30:00', '2023-01-19', '2023-01-19');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 28, 791, 503, '09:00:00', '12:30:00', '2023-01-19', '2023-01-19');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 28, 792, 504, '09:00:00', '12:30:00', '2023-01-19', '2023-01-19');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 28, 793, 505, '09:00:00', '12:30:00', '2023-01-19', '2023-01-19');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 34, 828, 513, '13:30:00', '14:00:00', '2023-01-26', '2023-01-26');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 35, 848, 514, '08:00:00', '08:30:00', '2023-01-27', '2023-01-27');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 1, 'session907.532594562493', null, 'sdfds', null, null, 'Hi dear, perhaps a little more rest and food will you be back at strength.', null, null, '2023-01-20', 2, '09:47:44', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 2, 'session258.62666900364275', null, 'sdfds', null, null, 'Hi it is me again. But this one i will address non anonymous, So remember me, here is my name my contacts, do not be late, but i can not stand to it anymore.', null, null, '2023-01-20', 2, '09:47:44', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 3, 'session428.0507486275105', null, 'Fafaa', null, null, 'fgfgsf', null, null, '2023-01-20', 2, '10:05:51', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 4, 'session428.0507486275105', null, 'Fafaa', null, null, 'fgfgsf', null, null, '2023-01-20', 2, '10:05:51', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 5, 'session781.9242674941864', null, 'Mauvaise comportement', null, null, 'Je suis un visiteur et jai constate que gkjfkgjkfgfg', null, null, '2023-01-20', 2, '10:10:43', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 6, 'session543.7488385071574', 'johns.irintsoa@gmail.com', 'Ratsy fandraisana be ry zareo ', '112111211211', '0341752875', '', 'RANDRIANARISON', 'Johns', '2023-01-20', 1, '11:38:53', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 7, 'session570.4293885686607', 'johns@gmail.com', 'CYCLONE', '112112121212', '0341752875', '', 'DYRAN', 'Johns', '2023-01-20', 1, '11:41:46', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 8, 'session307.8347883714374', 'johns@gmail.com', 'sdfdsfdf', '565442151515', '6546546546', 'Hello world ', 'sfdfd', 'sdfdf', '2023-01-20', 1, '11:43:29', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 9, 'session524.3624453793367', null, 'Hello sunday', null, null, 'It raining today.', null, null, '2023-01-22', 3, '16:33:57', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 10, 'session524.3624453793367', 'johns.irintsoa18@gmail.com', 'Sunday', '112121112122', '0341752875', 'Hi sunday. Creating more and consumming less by Ruri ohama. The more you say no to the things doesnt matter the more you say yes to things that do', 'Dyran', 'Johns', '2023-01-22', 3, '17:02:45', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 11, 'session373.19367097786846', 'johns.irintsoa@gmail.com', 'Hi Monday', '512698789633', '0341752875', 'Hi i have checked all of my duty for tody and half of them was done', 'RANDRIANARISON', 'Johns', '2023-01-23', 3, '16:18:41', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 12, 'session373.19367097786846', null, 'Hi DGI', null, null, 'Mmmh you do not know me. How was last night. Have you dreamnt about me? Did I do my best? Have a good day Sweetie ???? ', null, null, '2023-01-23', 3, '16:20:58', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 13, 'session576.6437598202781', null, 'Monday 2', null, null, 'I am just here concern of people, perhaps i can offend any one of you but the more you know who and how i am, the more you have to be carefull of yourself.', null, null, '2023-01-23', 3, '16:41:35', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 14, 'session414.00372984251834', null, 'Monday 3', null, null, 'I am reapting myself sorry. The point is to release our comrade toward an amount of BitCoins. Are you in?', null, null, '2023-01-23', 3, '16:43:33', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 15, 'session518.4698767437472', null, 'Tuesday', null, null, 'Hi dear, perhaps a little more rest and food will you back at strength.', null, null, '2023-01-24', 3, '08:56:52', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 16, 'session518.4698767437472', 'johns.irintsoa@gmail.com', 'Tuesday', '112112122122', '0341752875', 'Hi it is me again. But this one i will address non anonymous, So remember me, here is my name my contacts, do not late, but i can not stand to it anymore.', 'RANDRIANARIASON', 'Johns', '2023-01-24', 3, '08:59:10', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 17, 'session518.4698767437472', 'johns.irintsoa@gmail.com', 'Tuesday', '112112111221', '0341752875', 'Re-bonjour, today we will practice some of vary amin anana. it is a mixing languages, but not very helpful for ou education freedom, what i am saying, we are not in daily stoic, we are in boite à doléance. And yet, i am still wondering what is the purpose', 'RANDRIANARISON', 'Johns', '2023-01-24', 3, '10:44:43', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 18, 'session518.4698767437472', null, 'Tuesday', null, null, 'Mmmh, it was not completed. Half of message did not send, Good news,we have resolved the issues, but i have no clue what is going on, Afterwards i am just a person who want to disturb the organization hihihihihihihihi, Sorry you do not know who I am, I am just a girl with a wide thick, Love you Have good day, and one more thing, your wife can be good wife but never better on bed than me hahahahahahah just joking. Thank you to read', null, null, '2023-01-24', 3, '10:57:36', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 19, 'session948.1640243568852', null, 'Wednesday 2', null, null, 'Hi, i suppose it is news. So we should start a new test for today. Not today we are here to focus on the project.Good morning to you misy update kely', null, null, '2023-01-25', 3, '07:52:53', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 20, 'session948.1640243568852', null, 'Wednesday 1', null, null, 'Hello everyone we are not perfect at all. It is a test. Sit Beneath tree.', null, null, '2023-01-25', 3, '07:53:53', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 21, 'session948.1640243568852', 'johns.irintsoa@gmail.com', 'Wednesday 3', '112111211211', '0341752875', 'Among us is the traitor, Why do argue you each other? there is non-sense, You should pay attention of everything, I do not care what is happening the only i want is calm and tranquilitty.Okay? Bye.', 'RANDRIANARISON', 'Johns', '2023-01-25', 3, '08:15:08', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 22, 'session701.2027086467638', null, 'Thursday night', null, null, 'It is a last test for today. I want to make sure about the popup show if it works. Good night to you adminstrator. Do not forget to pray, I love you ', null, null, '2023-01-26', 3, '22:25:56', '');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, message2 ) VALUES ( 23, 'session733.2137905238567', null, 'Friday', null, null, 'Test i want to see if it works perfectly but do not worry, behave a trustworthy not untrustworthy person okay, I lalalallalalalalalal love you kisss yo you ', null, null, '2023-01-27', 3, '15:22:40', '');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '08:30:00', '09:00:00', 117, 14, 676, '2023-01-12', '2023-01-12');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '08:30:00', '09:00:00', 118, 14, 676, '2023-01-12', '2023-01-12');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '08:30:00', '09:00:00', 119, 14, 676, '2023-01-12', '2023-01-12');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '08:30:00', '09:00:00', 120, 14, 676, '2023-01-12', '2023-01-12');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '10:00:00', '10:30:00', 121, 16, 773, '2023-01-18', '2023-01-18');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '14:30:00', '15:00:00', 123, 16, 720, '2023-01-16', '2023-01-16');
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 37, 685, 22);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 38, 686, 22);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 39, 687, 22);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 40, 683, 20);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 41, 684, 20);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 81, 750, 25);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 82, 751, 25);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 83, 752, 25);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 84, 753, 25);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 85, 769, 25);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 86, 770, 25);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 87, 771, 25);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 88, 691, 26);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 149, 698, 23);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 150, 699, 23);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 151, 700, 23);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 152, 701, 23);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 153, 702, 23);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 154, 703, 23);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 155, 777, 27);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 156, 778, 27);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 157, 779, 27);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 158, 780, 27);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 162, 709, 24);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 163, 710, 24);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 164, 711, 24);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 165, 712, 24);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 166, 713, 24);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 167, 714, 24);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 168, 715, 24);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 169, 716, 24);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 170, 717, 24);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 171, 718, 24);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 172, 719, 24);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 173, 720, 24);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 174, 798, 28);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 175, 822, 29);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 176, 823, 29);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 177, 824, 29);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 178, 825, 29);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 179, 826, 29);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 180, 827, 29);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 182, 854, 30);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 183, 855, 30);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 184, 856, 30);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 185, 857, 30);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 186, 864, 31);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 187, 865, 31);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 188, 866, 31);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 189, 867, 31);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 190, 882, 32);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 191, 883, 32);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 192, 884, 32);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 193, 885, 32);
INSERT INTO stage5.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'porte356', 'porte356@gmail.com', 1, 1, 1);
INSERT INTO stage5.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'tale356', 'tale356@gmail.com', 2, 0, 1);
INSERT INTO stage5.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'porteDSI', 'porteDSI@gmail.com', 3, 1, 2);
INSERT INTO stage5.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'tale414', 'tale414@gmail.com', 5, 0, 2);
INSERT INTO stage5.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'jean', 'jean', 6, 1, 3);
INSERT INTO stage5.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'taleDGI', 'taleDGI', 7, 0, 3);



-- Filtre stage 
-- v2
CREATE  PROCEDURE `filtre_stage`(IN date_debut date, IN date_fin date, IN nom varchar(30), IN prenom VARCHAR(30), in id_domaine INT, IN id_autorite INT)
BEGIN
	set @date1 = date_debut;
	set @date2 = date_fin;

	IF nom = '' and prenom != '' and id_domaine IS NOT NULL THEN 
		select 
		ds.id,
	    ds.nom,
	    ds.prenom,
	    ds.duree, 
	    ds.e_mail as addresse_electronique,
	    d.nom_domaine,
		ds.date_creation,
		CASE
			WHEN ds.action = 0 THEN 'Non validé'
			WHEN ds.action = 1 THEN 'Validé'
			WHEN ds.action = 2 THEN 'Reporté'
			ELSE 'Aucune'
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
		and ds.id_domaine = id_domaine
		and ds.prenom LIKE concat('%',prenom,'%')
		GROUP BY ds.id order by ds.date_creation desc;

	ELSEIF nom != '' and prenom = '' and id_domaine IS NOT NULL THEN
		select 
		ds.id,
	    ds.nom,
	    ds.prenom,
	    ds.duree, 
	    ds.e_mail as addresse_electronique,
	    d.nom_domaine, 
		ds.date_creation,
		CASE
			WHEN ds.action = 0 THEN 'Non validé'
			WHEN ds.action = 1 THEN 'Validé'
			WHEN ds.action = 2 THEN 'Reporté'
			ELSE 'Aucune'
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
		and ds.id_domaine = id_domaine
		and ds.nom LIKE concat('%',nom,'%')
		GROUP BY ds.id order by ds.date_creation desc;

	elseif  nom != '' and prenom != '' and id_domaine IS NULL THEN
		select 
		ds.id,
	    ds.nom,
	    ds.prenom,
	    ds.duree, 
	    ds.e_mail as addresse_electronique,
	    d.nom_domaine,
		ds.date_creation,
		CASE
			WHEN ds.action = 0 THEN 'Non validé'
			WHEN ds.action = 1 THEN 'Validé'
			WHEN ds.action = 2 THEN 'Reporté'
			ELSE 'Aucune'
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
		and ds.nom LIKE concat('%',nom,'%')
		and ds.prenom LIKE concat('%',prenom,'%')
		GROUP BY ds.id order by ds.date_creation desc; 
	elseif nom != '' and prenom != '' and id_domaine IS NOT NULL THEN
		select 
		ds.id,
	    ds.nom,
	    ds.prenom,
	    ds.duree, 
	    ds.e_mail as addresse_electronique,
	    d.nom_domaine,
		ds.date_creation,
		CASE
			WHEN ds.action = 0 THEN 'Non validé'
			WHEN ds.action = 1 THEN 'Validé'
			WHEN ds.action = 2 THEN 'Reporté'
			ELSE 'Aucune'
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
		and ds.id_domaine = id_domaine
		and ds.nom LIKE concat('%',nom,'%')
		and ds.prenom LIKE concat('%',prenom,'%')
		GROUP BY ds.id order by ds.date_creation desc;  
	elseif nom = '' and prenom = '' and id_domaine IS NOT NULL THEN
		select 
		ds.id,
	    ds.nom,
	    ds.prenom,
	    ds.duree, 
	    ds.e_mail as addresse_electronique,
	    d.nom_domaine,
		ds.date_creation,
		CASE
			WHEN ds.action = 0 THEN 'Non validé'
			WHEN ds.action = 1 THEN 'Validé'
			WHEN ds.action = 2 THEN 'Reporté'
			ELSE 'Aucune'
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
		and ds.id_domaine = id_domaine
		GROUP BY ds.id order by ds.date_creation desc;  
	else 
		select 
		ds.id,
		ds.nom,
		ds.prenom,
		ds.duree, 
		ds.e_mail as addresse_electronique,
		d.nom_domaine,
		ds.date_creation,
		CASE
			WHEN ds.action = 0 THEN 'Non validé'
			WHEN ds.action = 1 THEN 'Validé'
			WHEN ds.action = 2 THEN 'Reporté'
			ELSE 'Aucune'
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
		GROUP BY ds.id order by ds.date_creation desc;
	END IF;
END


-- Calendrier evenementiel 
-- v2
CREATE  PROCEDURE `calendrier_autorite`(IN id_autorite INT,IN est_admin boolean)
BEGIN
	set @is_admin = est_admin;
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

	CONCAT(daadhd.date_debut,'T',daadhd.heure_debut) as start,
	CONCAT(daadhd.date_fin,'T',daadhd.heure_fin) as end,
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
		ELSE '#000000'
	END AS color_status,
	'Autorité' type_audience,
	CASE 
		WHEN @is_admin = 1 and daa.action = 1 or @is_admin = 1 and daa.action >= 1 THEN false
		ELSE true
	END AS editable
	FROM
	dm_aud_autorite_date_heure_dispo daadhd
	LEFT join date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
	LEFT JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id 
	LEFT JOIN autorite_enfant ae on dhda.id_autorite = ae.id
	LEFT JOIN demande_audience_autorite daa on daadhd.id_dm_aud_autorite = daa.id
	LEFT join autorite_enfant aes on daa.id_autorite_enfant_sender = aes.id	
	where dhd.date_disponible >= CURDATE() and dhda.id_autorite = @id_autorite
	GROUP by daadhd.id_dm_aud_autorite

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

	CONCAT(dapdhd.date_debut,'T',dapdhd.heure_debut) as start,
	CONCAT(dapdhd.date_fin,'T',dapdhd.heure_fin) as end,
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
		ELSE '#000000'
	END AS color_status,
	'Public' type_audience,
	CASE 
		WHEN @is_admin = 1 and dap.action = 1 or @is_admin = 1 and dap.action >= 1 THEN false
		ELSE true
	END AS editable
	FROM stage_temp.dm_aud_public_date_heure_dispo dapdhd
	LEFT JOIN date_heure_disponible_autorite dhda on dapdhd.id_date_heure_disponible_autorite = dhda.id
	LEFT JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	LEFT JOIN autorite_enfant ae on dhda.id_autorite = ae.id
	LEFT JOIN demande_audience_public dap on dapdhd.id_aud_public = dap.id
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

	CONCAT(eds.date_debut,'T',eds.heure_debut) as start,
	CONCAT(eds.date_fin,'T',eds.heure_fin) as end,
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
	CASE
		WHEN ds.action = 0 THEN '#35AF11'
		WHEN ds.action = 1 THEN '#E61212'
		WHEN ds.action = 2 THEN '#000000'
		ELSE '#FFFFFF'
	END AS color_status,
	'Entretien' type_audience,
	CASE 
		WHEN @is_admin = 1 THEN false
		ELSE true
	END AS editable
	from entretien_demande_stage eds
	JOIN date_heure_disponible_autorite dhda on eds.id_date_heure_disponible_autorite = dhda.id
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	JOIN demande_stage ds on eds.id_demande_stage = ds.id
	JOIN autorite_enfant ae on dhda.id_autorite = ae.id
	where dhd.date_disponible >= CURDATE() and dhda.id_autorite = @id_autorite
	group by ds.id

	UNION
	
	select
	pd.id as id,
	'' id_date_heure_disponible_autorite,
	'' id_date_heure_disponible,

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

	CONCAT(dhnda.date_debut,'T',dhnda.heure_debut) as start,
	CONCAT(dhnda.date_fin,'T',dhnda.heure_fin) as end,
	dhnda.id id_evenement,
	'Pas disponible' as title,
	'' motif,
	dhnda.date_debut as date_debut,
	dhnda.date_fin as date_fin,
	dhnda.heure_debut as heure_debut,
	dhnda.heure_fin as heure_fin,
	'Pas disponible' status_audience,
	'' nom,
	'' prenom,
	'' numero_telephone,
	'' cin,
	'' addresse_electronique_sender_externe,
	'#000000' color,
	'' color_status,
	'Pas disponible' type_audience,
	CASE 
		WHEN @is_admin = 1 THEN false
		ELSE true
	END AS editable
	from date_heure_non_disponible_autorite dhnda
	JOIN pas_disponible pd on dhnda.id = pd.id_date_heure_non_disponible_autorite
	JOIN date_heure_disponible_autorite dhda on pd.id_date_heure_disponible_autorite = dhda.id
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	JOIN autorite_enfant ae on dhda.id_autorite = ae.id
	where dhd.date_disponible >= CURDATE() and dhda.id_autorite = @id_autorite
	GROUP by dhnda.id;
END

-- Modifier entretien stage
-- v2
CREATE  PROCEDURE `modifier_entretien_stage_calendrier`(IN id_entretien_stage int,IN id_demande_stage INT,IN date_debut date,IN date_fin date,IN heure_debut time,in heure_fin time, IN id_autorite INT)
BEGIN
	set @id_autorite = id_autorite;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));

	set @nbr_rows = ( 
	SELECT 
	count(dhda.id)
	FROM
	date_heure_disponible_autorite dhda 
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	where 
	dhda.id_autorite = @id_autorite
	and dhda.est_disponible = 1
	and 
	(timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin
	OR timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00"))) BETWEEN @timestamp_debut and @timestamp_fin)
	OR
	dhda.id_autorite = @id_autorite
	and dhda.est_disponible = 1
	and 
	(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))
	and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))));

	-- SCENE 1
	IF date_debut = date_fin THEN
		IF @nbr_rows = 0 THEN 
			DELETE FROM entretien_demande_stage where id_demande_stage = id_demande_stage;
			CALL `ajouter_date_heure_disponible_autorite`(@id_autorite,'08:00:00' , '16:00:00' , date_debut );
			CALL `ajouter_entretien_stage_date_heure_dispo_entre_deux_date`( id_demande_stage ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		ELSEIF @nbr_rows = 1 THEN
			set @id_date_heure_dispo_autorite = (
				SELECT 
				dhda.id 
				from date_heure_disponible_autorite dhda 
				JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
				where dhda.id_autorite = @id_autorite 
				and dhd.date_disponible = date_debut
				and heure_debut between dhd.heure_debut and dhd.heure_fin
				and heure_fin between dhd.heure_debut and dhd.heure_fin
			);
			UPDATE entretien_demande_stage set id_date_heure_disponible_autorite = @id_date_heure_dispo_autorite, date_debut = date_debut, date_fin = date_fin, heure_debut = heure_debut, heure_fin = heure_fin where id = id_entretien_stage;
		ELSEIF @nbr_rows > 1 THEN
			DELETE FROM entretien_demande_stage where id_demande_stage = id_demande_stage;
			CALL `ajouter_entretien_stage_date_heure_dispo_entre_deux_date`( id_demande_stage ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		END IF;
	ELSEIF date_debut < date_fin THEN
		DELETE FROM entretien_demande_stage where id_demande_stage = id_demande_stage;
		CALL `verifier_date_heure_dispo_entre_deux_dates`(date_debut, date_fin, @id_autorite);
		CALL `ajouter_entretien_stage_date_heure_dispo_entre_deux_date`( id_demande_stage ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
	END IF;
	UPDATE demande_stage set action = 1 where id = id_audience;
END