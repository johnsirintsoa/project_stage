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
 ) ENGINE=InnoDB AUTO_INCREMENT=670 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.date_heure_disponible_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_date_heure_disponible INT      ,
	id_autorite          INT      ,
	est_disponible       TINYINT  NOT NULL DEFAULT ('1')   ,
	CONSTRAINT fk_date_disponible_autorite_id_date_disponible FOREIGN KEY ( id_date_heure_disponible ) REFERENCES stage5.date_heure_disponible( id ) ON DELETE SET NULL ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=1286 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.date_heure_non_disponible_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	date_debut           DATE  NOT NULL    ,
	date_fin             DATE  NOT NULL    ,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	id_autorite          INT  NOT NULL    
 ) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.demande_audience_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_autorite_enfant_sender INT      ,
	motif                VARCHAR(200)  NOT NULL    ,
	action               INT  NOT NULL DEFAULT ('0')   ,
	email                VARCHAR(200)      ,
	numero_telephone     VARCHAR(10)      ,
	sigle                VARCHAR(255)      ,
	child_libelle        VARCHAR(255)      
 ) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;

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
 ) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.dm_aud_autorite_date_heure_dispo ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_date_heure_disponible_autorite INT      ,
	id_dm_aud_autorite   INT      ,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	date_debut           DATE      ,
	date_fin             DATE      ,
	CONSTRAINT fk_dm_aud_autorite_date_heure_dispo_id_daa FOREIGN KEY ( id_dm_aud_autorite ) REFERENCES stage5.demande_audience_autorite( id ) ON DELETE CASCADE ON UPDATE NO ACTION,
	CONSTRAINT fk_dm_aud_autorite_date_heure_dispo_id_dh_da FOREIGN KEY ( id_date_heure_disponible_autorite ) REFERENCES stage5.date_heure_disponible_autorite( id ) ON DELETE SET NULL ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=296 DEFAULT CHARSET=latin1;

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
 ) ENGINE=InnoDB AUTO_INCREMENT=604 DEFAULT CHARSET=latin1;

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
	sigle                VARCHAR(255)      ,
	child_libelle        VARCHAR(255)      
 ) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

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

CREATE TABLE stage5.pas_disponible ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_date_heure_disponible_autorite INT  NOT NULL    ,
	id_date_heure_non_disponible_autorite INT  NOT NULL    ,
	CONSTRAINT fk_pas_disponible_id_date_heure_disponible_autorite FOREIGN KEY ( id_date_heure_disponible_autorite ) REFERENCES stage5.date_heure_disponible_autorite( id ) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_pas_disponible_id_date_heure_non_disponible_autorite FOREIGN KEY ( id_date_heure_non_disponible_autorite ) REFERENCES stage5.date_heure_non_disponible_autorite( id ) ON DELETE CASCADE ON UPDATE CASCADE
 ) ENGINE=InnoDB AUTO_INCREMENT=500 DEFAULT CHARSET=latin1;

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
	CONSTRAINT fk_demande_stage_id_domaine FOREIGN KEY ( id_domaine ) REFERENCES stage5.domaine( id ) ON DELETE SET NULL ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

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
 ) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.profil ( 
	mot_de_passe         VARCHAR(255)  NOT NULL    ,
	nom_utilisateur      VARCHAR(30)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	est_administrateur   SMALLINT  NOT NULL DEFAULT ('0')   ,
	id_autorite_enfant   INT      ,
	CONSTRAINT fk_profil_autorite_enfant_id_autorite FOREIGN KEY ( id_autorite_enfant ) REFERENCES stage5.autorite_enfant( id ) ON DELETE SET NULL ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

CREATE INDEX fk_date_disponible_autorite_id_date_disponible ON stage5.date_heure_disponible_autorite ( id_date_heure_disponible );

CREATE INDEX fk_date_disponible_autorite_id_autorite ON stage5.date_heure_disponible_autorite ( id_autorite );

CREATE INDEX fk_date_heure_non_disponible_autorite_id_autorite ON stage5.date_heure_non_disponible_autorite ( id_autorite );

CREATE INDEX fk_demande_audience_autorite ON stage5.demande_audience_autorite ( id_autorite_enfant_sender );

CREATE INDEX fk_dm_aud_autorite_date_heure_dispo_id_dh_da ON stage5.dm_aud_autorite_date_heure_dispo ( id_date_heure_disponible_autorite );

CREATE INDEX fk_dm_aud_autorite_date_heure_dispo_id_daa ON stage5.dm_aud_autorite_date_heure_dispo ( id_dm_aud_autorite );

CREATE INDEX fk_dm_aud_public_date_heure_dispo ON stage5.dm_aud_public_date_heure_dispo ( id_aud_public );

CREATE INDEX fk_dm_aud_public_date_heure_dispo_id_date_heure_disponible ON stage5.dm_aud_public_date_heure_dispo ( id_date_heure_disponible_autorite );

CREATE INDEX fk_doleance_autorite_enfant ON stage5.doleance ( id_autorite );

CREATE INDEX fk_pas_disponible_id_date_heure_disponible_autorite ON stage5.pas_disponible ( id_date_heure_disponible_autorite );

CREATE INDEX fk_pas_disponible_id_date_heure_non_disponible_autorite ON stage5.pas_disponible ( id_date_heure_non_disponible_autorite );

CREATE INDEX fk_autorite_enfant_autorite_parent_id_autorite_parent ON stage5.autorite_enfant ( id_autorite_parent );

CREATE INDEX fk_demande_stage_id_domaine ON stage5.demande_stage ( id_domaine );

CREATE INDEX fk_demande_stage_id_autorite_enfant ON stage5.demande_stage ( id_autorite_enfant );

CREATE INDEX fk_entretien_demande_stage_id_demande_stage ON stage5.entretien_demande_stage ( id_demande_stage );

CREATE INDEX fk_entretien_demande_stage_id_date_heure_disponible_autorite ON stage5.entretien_demande_stage ( id_date_heure_disponible_autorite );

CREATE INDEX fk_profil_autorite_enfant_id_autorite ON stage5.profil ( id_autorite_enfant );

CREATE  PROCEDURE `ajouter_audience_autorite`(IN id_autorite_sender INT,
IN id_autorite_receiver INT,
IN id_date_heure_disponible_autorite INT,
IN motif VARCHAR(200),
IN date_debut DATE,
IN date_fin Date,
IN heure_debut time,
IN heure_fin time,
IN email varchar(255),
IN numero_telephone VARCHAR(255),
IN sigle VARCHAR(255),
IN child_libelle VARCHAR(255))
BEGIN 
	SET @sender = id_autorite_sender; 
	SET @receiver = id_autorite_receiver; 
	SET @motif = motif; 
	SET @id_dhda = id_date_heure_disponible_autorite; 
	SET @hd = heure_debut;
	SET @hf = heure_fin;	

	-- Ajouter Audience
	INSERT INTO demande_audience_autorite
	(id_autorite_enfant_sender,motif,email,numero_telephone,sigle,child_libelle) 
	VALUES (@sender,@motif,email,numero_telephone,sigle,child_libelle);
	
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
	
	UPDATE demande_stage SET action = 1 where id = id_demande_stage;

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
		dap.id as id,
		'Public' as type_evenement,
		dap.nom as nom, 
		dap.prenom as prenom,
		dap.email as addresse_electronique,
		dap.numero_telephone as numero_telephone
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
		eds.id_demande_stage as id,
		'Entretien' as type_evenement,
		ds.nom as nom, 
		ds.prenom as prenom,
		ds.e_mail as addresse_electronique,
		ds.telephone as numero_telephone
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
		daa.id as id,
		'Autorité' as type_evenement,
		daa.child_libelle as nom,
		daa.sigle as prenom,
		daa.email as addresse_electronique,
		daa.numero_telephone as numero_telephone	
		FROM
		dm_aud_autorite_date_heure_dispo daadhd 
		JOIN date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
		JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		JOIN demande_audience_autorite daa on daadhd.id_dm_aud_autorite = daa.id
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

CREATE  PROCEDURE `calendrier_autorite`(IN id_autorite INT)
BEGIN
	set @id_autorite = id_autorite;

	SELECT 
	daadhd.id as id,
	dhda.id as id_date_heure_disponible_autorite,
	dhd.id as id_date_heure_disponible,

	CONCAT(daadhd.date_debut,'T',daadhd.heure_debut) as start,
	CONCAT(daadhd.date_fin,'T',daadhd.heure_fin) as end,
	daa.id as id_evenement,
	'Audience autorité' as title,
	daa.motif as motif,
	daa.child_libelle as child_libelle,
	daa.sigle as sigle,
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
	daa.numero_telephone as numero_telephone,
	'' cin,
	daa.email as addresse_electronique_sender_externe,
	'#FF0000' color,
	CASE
		WHEN daa.action = 0 THEN '#35AF11'
		WHEN daa.action = 1 THEN '#E61212'
		ELSE '#000000'
	END AS color_status,
	'Autorité' type_audience,
	true as editable
	FROM
	dm_aud_autorite_date_heure_dispo daadhd
	LEFT join date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
	LEFT JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	LEFT JOIN demande_audience_autorite daa on daadhd.id_dm_aud_autorite = daa.id
	where dhd.date_disponible >= CURDATE() and dhda.id_autorite = @id_autorite
	GROUP by daadhd.id_dm_aud_autorite

	UNION
	
	-- Demande audience public
	SELECT 
	dapdhd.id,
	dhda.id as id_date_heure_disponible_autorite,
	dhd.id as id_date_heure_disponible,

	CONCAT(dapdhd.date_debut,'T',dapdhd.heure_debut) as start,
	CONCAT(dapdhd.date_fin,'T',dapdhd.heure_fin) as end,
	dap.id as id_evenement,
	'Audience public' as title,
	dap.motif as motif,
	'' child_libelle,
	'' sigle,
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
	true AS editable
	FROM stage5.dm_aud_public_date_heure_dispo dapdhd
	LEFT JOIN date_heure_disponible_autorite dhda on dapdhd.id_date_heure_disponible_autorite = dhda.id
	LEFT JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	LEFT JOIN demande_audience_public dap on dapdhd.id_aud_public = dap.id
	WHERE dhd.date_disponible >= CURDATE() and dhda.id_autorite = @id_autorite


	GROUP by dapdhd.id_aud_public
	
	UNION
	
	-- Demande entretien stage

	select
	eds.id,
	dhda.id as id_date_heure_disponible_autorite,
	dhd.id as id_date_heure_disponible,

	CONCAT(eds.date_debut,'T',eds.heure_debut) as start,
	CONCAT(eds.date_fin,'T',eds.heure_fin) as end,
	ds.id as id_evenement,
	'Entretien' as title,
	CONCAT('Entretien de ',ds.nom,' ',ds.prenom) as motif,
	'' child_libelle,
	'' sigle,
	eds.date_debut as date_debut,
	eds.date_fin as date_fin,
	eds.heure_debut as heure_debut,
	eds.heure_fin as heure_fin,
	CASE 
        when eds.id IS NULL THEN 'Non validé'
		when ds.action = 1 and eds.id IS NOT NULL THEN 'Validé'
		when ds.action = 2 and eds.id IS NOT NULL THEN 'Reporté'
        ELSE 'Aucune'
    END as status_audience,
	ds.nom as nom,
	ds.prenom as prenom,
	ds.telephone as numero_telephone,
	ds.cin as cin,
	ds.e_mail as addresse_electronique_sender_externe,
	'#FFA500' color,
	'#FFA500' color_status,
	'Entretien' type_audience,
	true AS editable
	from entretien_demande_stage eds
	JOIN date_heure_disponible_autorite dhda on eds.id_date_heure_disponible_autorite = dhda.id
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	JOIN demande_stage ds on eds.id_demande_stage = ds.id
	where dhd.date_disponible >= CURDATE() and dhda.id_autorite = @id_autorite
	group by ds.id

	UNION
	
	select
	pd.id as id,
	'' id_date_heure_disponible_autorite,
	'' id_date_heure_disponible,

	CONCAT(dhnda.date_debut,'T',dhnda.heure_debut) as start,
	CONCAT(dhnda.date_fin,'T',dhnda.heure_fin) as end,
	dhnda.id id_evenement,
	'Pas disponible' as title,
	'' motif,
	'' child_libelle,
	'' sigle,
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
	 true editable
	from date_heure_non_disponible_autorite dhnda
	JOIN pas_disponible pd on dhnda.id = pd.id_date_heure_non_disponible_autorite
	JOIN date_heure_disponible_autorite dhda on pd.id_date_heure_disponible_autorite = dhda.id
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
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
			when ds.action = 1 and eds.id IS NOT NULL THEN 'Validé'
			when ds.action = 2 and eds.id IS NOT NULL THEN 'Reporté'
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
	        when eds.id IS NULL THEN 'Non validé'
			when ds.action = 1 and eds.id IS NOT NULL THEN 'Validé'
			when ds.action = 2 and eds.id IS NOT NULL THEN 'Reporté'
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
	        when eds.id IS NULL THEN 'Non validé'
			when ds.action = 1 and eds.id IS NOT NULL THEN 'Validé'
			when ds.action = 2 and eds.id IS NOT NULL THEN 'Reporté'
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
	        when eds.id IS NULL THEN 'Non validé'
			when ds.action = 1 and eds.id IS NOT NULL THEN 'Validé'
			when ds.action = 2 and eds.id IS NOT NULL THEN 'Reporté'
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
	        when eds.id IS NULL THEN 'Non validé'
			when ds.action = 1 and eds.id IS NOT NULL THEN 'Validé'
			when ds.action = 2 and eds.id IS NOT NULL THEN 'Reporté'
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
	        when eds.id IS NULL THEN 'Non validé'
			when ds.action = 1 and eds.id IS NOT NULL THEN 'Validé'
			when ds.action = 2 and eds.id IS NOT NULL THEN 'Reporté'
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

CREATE  PROCEDURE `liste_disponible_autorite`(IN id_autorite_sender int,in id_autorite int)
BEGIN

	set @sender = id_autorite_sender;
	set @id_autorite = id_autorite;
	
	SELECT 
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
	daa.motif as motif,
	daa.motif as title,
	daa.email as email,
	daa.numero_telephone,
	daa.sigle as sigle,
	daa.child_libelle as child_libelle,
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
	JOIN date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	WHERE 
	daa.id_autorite_enfant_sender = @sender
	and dhda.id_autorite = @id_autorite
	and (daa.action >= 0 and daa.action <=2)
	and dhd.date_disponible >= CURDATE()
	group by daadhd.id_dm_aud_autorite
	
	UNION
	
	(SELECT
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
	'' as motif,
	'Disponible' as title,
	'' email,
	'' numero_telephone,
	'' sigle,
	'' child_libelle,
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
	d.id_autorite as structure_id,
	d.child_libelle,
	d.sigle 
	from doleance d 
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

CREATE  PROCEDURE `modifier_audience_autorite`(IN id_date_heure_disponible_autorite INT,
	IN id_dm_aud_autorite_date_heure_dispo INT,
	IN motif VARCHAR(255),
	IN email VARCHAR(255),
	IN numero_telephone VARCHAR(255),
	IN id_audience INT
)
BEGIN
	select dhd.heure_debut,dhd.heure_fin into @heure_debut,@heure_fin from date_heure_disponible_autorite dhda
	join date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id 
	where dhda.id = id_date_heure_disponible_autorite;
	set @id_dhda = id_date_heure_disponible_autorite;	

	UPDATE demande_audience_autorite SET motif = motif,email = email, numero_telephone = numero_telephone  where id = id_audience;
	UPDATE dm_aud_autorite_date_heure_dispo SET id_date_heure_disponible_autorite = @id_dhda, heure_debut = @heure_debut, heure_fin = @heure_fin where id = id_dm_aud_autorite_date_heure_dispo;
	SELECT 'Votre audience a bien été modifiée' as message;
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

	UPDATE stage5.demande_audience_public 
	SET email = email, motif = motif, nom = nom, prenom = prenom, cin = cin, numero_telephone = numero_telephone
	WHERE id = id_audience;
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

	UPDATE demande_stage
	set action = 1 
	WHERE id = @id_ds;

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
			dap.email as addresse_electronique,
			dap.numero_telephone as numero_telephone
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
			ds.e_mail as addresse_electronique,
			ds.telephone as numero_telephone
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
			daa.child_libelle as nom,
			daa.sigle as prenom,
			daa.email as addresse_electronique,
			daa.numero_telephone as numero_telephone	
			FROM
			dm_aud_autorite_date_heure_dispo daadhd 
			JOIN date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
			JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
			JOIN demande_audience_autorite daa on daadhd.id_dm_aud_autorite = daa.id
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
