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
 ) ENGINE=InnoDB AUTO_INCREMENT=1470 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.date_heure_disponible_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_date_heure_disponible INT      ,
	id_autorite          INT      ,
	est_disponible       TINYINT  NOT NULL DEFAULT ('1')   ,
	CONSTRAINT fk_date_disponible_autorite_id_date_disponible FOREIGN KEY ( id_date_heure_disponible ) REFERENCES stage5.date_heure_disponible( id ) ON DELETE SET NULL ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=2508 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.date_heure_non_disponible_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	date_debut           DATE  NOT NULL    ,
	date_fin             DATE  NOT NULL    ,
	heure_debut          TIME  NOT NULL    ,
	heure_fin            TIME  NOT NULL    ,
	id_autorite          INT  NOT NULL    
 ) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.demande_audience_autorite ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_autorite_enfant_sender INT      ,
	motif                VARCHAR(200)  NOT NULL    ,
	action               INT  NOT NULL DEFAULT ('0')   ,
	email                VARCHAR(200)      ,
	numero_telephone     VARCHAR(10)      ,
	sigle                VARCHAR(255)      ,
	child_libelle        VARCHAR(255)      ,
	est_termine          TINYINT   DEFAULT ('0')   
 ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.demande_audience_public ( 
	motif                VARCHAR(200)  NOT NULL    ,
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	action               INT  NOT NULL DEFAULT ('0')   ,
	cin                  VARCHAR(15)      ,
	numero_telephone     VARCHAR(10)      ,
	email                VARCHAR(255)      ,
	nom                  VARCHAR(255)      ,
	prenom               VARCHAR(255)      ,
	session_navigateur   VARCHAR(100)  NOT NULL    ,
	id_agent             INT   DEFAULT ('0')   ,
	est_termine          TINYINT  NOT NULL DEFAULT ('0')   
 ) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;

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
 ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

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
 ) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;

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
 ) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.domaine ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	nom_domaine          VARCHAR(30)  NOT NULL    
 ) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

CREATE TABLE stage5.pas_disponible ( 
	id                   INT  NOT NULL  AUTO_INCREMENT  PRIMARY KEY,
	id_date_heure_disponible_autorite INT  NOT NULL    ,
	id_date_heure_non_disponible_autorite INT  NOT NULL    ,
	CONSTRAINT fk_pas_disponible_id_date_heure_disponible_autorite FOREIGN KEY ( id_date_heure_disponible_autorite ) REFERENCES stage5.date_heure_disponible_autorite( id ) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT fk_pas_disponible_id_date_heure_non_disponible_autorite FOREIGN KEY ( id_date_heure_non_disponible_autorite ) REFERENCES stage5.date_heure_non_disponible_autorite( id ) ON DELETE CASCADE ON UPDATE CASCADE
 ) ENGINE=InnoDB AUTO_INCREMENT=291 DEFAULT CHARSET=latin1;

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
	etablissement        VARCHAR(255)      ,
	est_termine          TINYINT   DEFAULT ('0')   ,
	CONSTRAINT fk_demande_stage_id_domaine FOREIGN KEY ( id_domaine ) REFERENCES stage5.domaine( id ) ON DELETE SET NULL ON UPDATE NO ACTION
 ) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=latin1;

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
 ) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=latin1;

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

CREATE  FUNCTION `FIRST_DATE_OF_MONTH`(day DATE) RETURNS date
    DETERMINISTIC
BEGIN
  RETURN DATE_SUB(day, INTERVAL DAYOFMONTH(day)-1 DAY);
END

CREATE  PROCEDURE `ajouter_audience_agent`(IN session_navigateur VARCHAR(100),
IN id_agent INT,
IN numero_telephone varchar(10),
IN email varchar(255),
IN id_date_heure_disponible_autorite INT,
IN motif VARCHAR(255),
IN date_debut date,
IN date_fin date,
IN heure_debut time,
IN heure_fin time)
BEGIN 
	SET @session_navigateur = session_navigateur; 
	SET @numero_telephone = numero_telephone; 
	SET @email = email; 
	SET @motif = motif; 
	SET @id_hd = id_date_heure_disponible_autorite; 
	SET @hd = heure_debut;
	SET @hf = heure_fin;
	SET @agent_id = id_agent;	

	-- Ajouter Audience
	INSERT INTO demande_audience_public
	(numero_telephone, email,motif,  session_navigateur,id_agent) 
	VALUES (@numero_telephone, @email,@motif, @session_navigateur,@agent_id);
	
	set @id_audience_tmp = (SELECT max(id) from demande_audience_public where session_navigateur = @session_navigateur and id_agent = @agent_id);

	-- Ajouter audience et date heure disponible autorite dans dm_aud_public_date_heure_dispo
	INSERT INTO dm_aud_public_date_heure_dispo
	( id_aud_public, id_date_heure_disponible_autorite, date_debut,date_fin ,heure_debut, heure_fin) 
	VALUES (@id_audience_tmp, @id_hd ,date_debut,date_fin,@hd,@hf);
	SELECT 'Audience a été ajouté avec succès' as message;
END

CREATE  PROCEDURE `ajouter_audience_autorite`(IN id_autorite_sender INT,
IN id_autorite_receiver INT,
IN id_date_heure_disponible_autorite INT,
IN motif VARCHAR(255),
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
IN nom varchar(255),
IN prenom varchar(255),
IN cin varchar(15),
IN numero_telephone varchar(10),
IN email varchar(255),
IN id_date_heure_disponible_autorite INT,
IN motif VARCHAR(255),
IN date_debut date,
IN date_fin date,
IN heure_debut time,
IN heure_fin time)
BEGIN 
	SET @session_navigateur = session_navigateur; 
	SET @nom = (SELECT UPPER(nom)); 
	SET @prenom = prenom; 
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
		dap.id as id,
		'Agent' as type_evenement,
		c.nom as nom, 
		c.prenom as prenom,
		dap.email as addresse_electronique,
		dap.numero_telephone as numero_telephone
		FROM
		dm_aud_public_date_heure_dispo dapdhd 
		JOIN demande_audience_public dap on dapdhd.id_aud_public = dap.id
		JOIN date_heure_disponible_autorite dhda on dapdhd.id_date_heure_disponible_autorite = dhda.id
		JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		JOIN rohi.candidat c on dap.id_agent = c.id
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

CREATE  PROCEDURE `calendrier_autorite`(IN id_autorite INT, IN masque_event_ended TINYINT)
BEGIN
	set @id_autorite = id_autorite;
	
	IF masque_event_ended IS TRUE THEN
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
		c.nom,
		c.prenom,
		daa.numero_telephone as numero_telephone,
		'' cin,
		daa.email as email,
		'#FF0000' color,
		CASE
			WHEN daa.action = 0 THEN '#35AF11'
			WHEN daa.action = 1 THEN '#E61212'
			ELSE '#000000'
		END AS color_status,
		'Autorité' type_audience,
		c.poste as poste,
		ts.path as path,
		daa.est_termine,
		true as editable
		FROM dm_aud_autorite_date_heure_dispo daadhd
		LEFT join date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
		LEFT JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		LEFT JOIN demande_audience_autorite daa on daadhd.id_dm_aud_autorite = daa.id
		LEFT JOIN rohi.t_structure ts on daa.id_autorite_enfant_sender = ts.child_id
		LEFT JOIN rohi.candidat c on ts.premier_responsable_id = c.id
		where (select year(dhd.date_disponible)) = (select year(now())) and dhda.id_autorite = @id_autorite and daa.est_termine is false
		GROUP by daadhd.id_dm_aud_autorite

		UNION
		
		-- Demande audience public and agent
		SELECT 
		dapdhd.id,
		dhda.id as id_date_heure_disponible_autorite,
		dhd.id as id_date_heure_disponible,
	
		CONCAT(dapdhd.date_debut,'T',dapdhd.heure_debut) as start,
		CONCAT(dapdhd.date_fin,'T',dapdhd.heure_fin) as end,
		dap.id as id_evenement,
		IF(dap.id_agent>0,"Audience agent","Audience public") as title,
		dap.motif as motif,
		IF(dap.id_agent>0, ts.child_libelle, '' ) as child_libelle,
		IF(dap.id_agent>0, ts.sigle, '' ) as sigle,
		dapdhd.date_debut as date_debut,
		dapdhd.date_fin as date_fin,
		dapdhd.heure_debut as heure_debut,
		dapdhd.heure_fin as heure_fin,
		CASE
			WHEN dap.action = 0 THEN 'Non validé'
			WHEN dap.action = 1 THEN 'Validé'
			ELSE 'Reporté'
		END AS status_audience,
		IF(dap.id_agent>0,c.nom,dap.nom) as nom,
		IF(dap.id_agent>0,c.prenom,dap.prenom)  as prenom,
		dap.numero_telephone as numero_telephone,
		dap.cin as cin,
		dap.email as email,
		IF(dap.id_agent>0,"#532006","#008000") color,
		CASE
			WHEN dap.action = 0 THEN '#35AF11'
			WHEN dap.action = 1 THEN '#E61212'
			ELSE '#000000'
		END AS color_status,
		IF(dap.id_agent>0,"Agent","Public") as type_audience,
		
		IF(dap.id_agent>0, IFNULL(c.poste,'Agent'),'') as poste,
		IF(dap.id_agent>0,ts.path,'')as path,
		dap.est_termine,
		true AS editable
		FROM stage5.dm_aud_public_date_heure_dispo dapdhd
		LEFT JOIN date_heure_disponible_autorite dhda on dapdhd.id_date_heure_disponible_autorite = dhda.id
		LEFT JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		LEFT JOIN demande_audience_public dap on dapdhd.id_aud_public = dap.id
		LEFT JOIN rohi.candidat c on dap.id_agent = c.id
		LEFT JOIN rohi.t_structure ts on c.structureId = ts.child_id
		WHERE (select year(dhd.date_disponible)) = (select year(now())) and dhda.id_autorite = @id_autorite and dap.est_termine is false
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
		ds.e_mail as email,
		'#FFA500' color,
		'#FFA500' color_status,
		'Entretien' type_audience,
		
		'' poste,
		'' path,
		ds.est_termine,
		true AS editable
		from entretien_demande_stage eds
		JOIN date_heure_disponible_autorite dhda on eds.id_date_heure_disponible_autorite = dhda.id
		JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		JOIN demande_stage ds on eds.id_demande_stage = ds.id
		where (select year(dhd.date_disponible)) = (select year(now())) and dhda.id_autorite = @id_autorite and ds.est_termine is false
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
		'' email,
		'#000000' color,
		'' color_status,
		'Pas disponible' type_audience,
		'' poste,
		'' path,
		FALSE est_termine,
		 true editable
		from date_heure_non_disponible_autorite dhnda
		JOIN pas_disponible pd on dhnda.id = pd.id_date_heure_non_disponible_autorite
		JOIN date_heure_disponible_autorite dhda on pd.id_date_heure_disponible_autorite = dhda.id
		JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		where (select year(dhd.date_disponible)) = (select year(now())) and dhda.id_autorite = @id_autorite
		GROUP by dhnda.id;

	ELSE
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
		c.nom,
		c.prenom,
		daa.numero_telephone as numero_telephone,
		'' cin,
		daa.email as email,
		'#FF0000' color,
		CASE
			WHEN daa.action = 0 THEN '#35AF11'
			WHEN daa.action = 1 THEN '#E61212'
			ELSE '#000000'
		END AS color_status,
		'Autorité' type_audience,
		c.poste as poste,
		ts.path as path,
		daa.est_termine,
		true as editable
		FROM dm_aud_autorite_date_heure_dispo daadhd
		LEFT join date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
		LEFT JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		LEFT JOIN demande_audience_autorite daa on daadhd.id_dm_aud_autorite = daa.id
		LEFT JOIN rohi.t_structure ts on daa.id_autorite_enfant_sender = ts.child_id
		LEFT JOIN rohi.candidat c on ts.premier_responsable_id = c.id
		where (select year(dhd.date_disponible)) = (select year(now())) and dhda.id_autorite = @id_autorite 
		GROUP by daadhd.id_dm_aud_autorite
	
		UNION
		
		-- Demande audience public and agent
		SELECT 
		dapdhd.id,
		dhda.id as id_date_heure_disponible_autorite,
		dhd.id as id_date_heure_disponible,
	
		CONCAT(dapdhd.date_debut,'T',dapdhd.heure_debut) as start,
		CONCAT(dapdhd.date_fin,'T',dapdhd.heure_fin) as end,
		dap.id as id_evenement,
		IF(dap.id_agent>0,"Audience agent","Audience public") as title,
		dap.motif as motif,
		IF(dap.id_agent>0, ts.child_libelle, '' ) as child_libelle,
		IF(dap.id_agent>0, ts.sigle, '' ) as sigle,
		dapdhd.date_debut as date_debut,
		dapdhd.date_fin as date_fin,
		dapdhd.heure_debut as heure_debut,
		dapdhd.heure_fin as heure_fin,
		CASE
			WHEN dap.action = 0 THEN 'Non validé'
			WHEN dap.action = 1 THEN 'Validé'
			ELSE 'Reporté'
		END AS status_audience,
		IF(dap.id_agent>0,c.nom,dap.nom) as nom,
		IF(dap.id_agent>0,c.prenom,dap.prenom)  as prenom,
		dap.numero_telephone as numero_telephone,
		dap.cin as cin,
		dap.email as email,
		IF(dap.id_agent>0,"#532006","#008000") color,
		CASE
			WHEN dap.action = 0 THEN '#35AF11'
			WHEN dap.action = 1 THEN '#E61212'
			ELSE '#000000'
		END AS color_status,
		IF(dap.id_agent>0,"Agent","Public") as type_audience,
		
		IF(dap.id_agent>0, IFNULL(c.poste,'Agent'),'') as poste,
		IF(dap.id_agent>0,ts.path,'')as path,
		dap.est_termine,
		true AS editable
		FROM stage5.dm_aud_public_date_heure_dispo dapdhd
		LEFT JOIN date_heure_disponible_autorite dhda on dapdhd.id_date_heure_disponible_autorite = dhda.id
		LEFT JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		LEFT JOIN demande_audience_public dap on dapdhd.id_aud_public = dap.id
		LEFT JOIN rohi.candidat c on dap.id_agent = c.id
		LEFT JOIN rohi.t_structure ts on c.structureId = ts.child_id
		WHERE (select year(dhd.date_disponible)) = (select year(now())) and dhda.id_autorite = @id_autorite
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
		ds.e_mail as email,
		'#FFA500' color,
		'#FFA500' color_status,
		'Entretien' type_audience,
		
		'' poste,
		'' path,
		ds.est_termine,
		true AS editable
		from entretien_demande_stage eds
		JOIN date_heure_disponible_autorite dhda on eds.id_date_heure_disponible_autorite = dhda.id
		JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		JOIN demande_stage ds on eds.id_demande_stage = ds.id
		where (select year(dhd.date_disponible)) = (select year(now())) and dhda.id_autorite = @id_autorite
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
		'' email,
		'#000000' color,
		'' color_status,
		'Pas disponible' type_audience,
		'' poste,
		'' path,
		FALSE est_termine,
		 true editable
		from date_heure_non_disponible_autorite dhnda
		JOIN pas_disponible pd on dhnda.id = pd.id_date_heure_non_disponible_autorite
		JOIN date_heure_disponible_autorite dhda on pd.id_date_heure_disponible_autorite = dhda.id
		JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
		where (select year(dhd.date_disponible)) = (select year(now())) and dhda.id_autorite = @id_autorite
		GROUP by dhnda.id;

	END IF;
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

CREATE  PROCEDURE `filtre_stage`(IN date_debut date, IN date_fin date, IN nom varchar(30), IN etablissement VARCHAR(30), in id_domaine INT, IN id_autorite INT)
BEGIN
	set @date1 = date_debut;
	set @date2 = date_fin;

	IF nom = '' and etablissement != '' and id_domaine IS NOT NULL THEN 
		select 
		ds.id,
	    ds.nom,
	    ds.prenom,	
		ds.etablissement,
	    ds.duree, 
	    ds.e_mail as addresse_electronique,
	    d.nom_domaine,
		ds.date_creation,
		CASE 
	        when eds.id IS NULL THEN 'Non validé'
			when ds.action = 1 and eds.id IS NOT NULL THEN 'Validé'
			when ds.action = 2 THEN 'Reporté'
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
		and ds.etablissement LIKE concat('%',etablissement,'%')
		GROUP BY ds.id order by ds.date_creation desc;

	ELSEIF nom != '' and etablissement = '' and id_domaine IS NOT NULL THEN
		select 
		ds.id,
	    ds.nom,
	    ds.prenom,
		ds.etablissement,
	    ds.duree, 
	    ds.e_mail as addresse_electronique,
	    d.nom_domaine, 
		ds.date_creation,
		CASE 
	        when eds.id IS NULL THEN 'Non validé'
			when ds.action = 1 and eds.id IS NOT NULL THEN 'Validé'
			when ds.action = 2 THEN 'Reporté'
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
		and (ds.nom LIKE concat('%',nom,'%') or ds.prenom LIKE concat('%',nom,'%'))
		GROUP BY ds.id order by ds.date_creation desc;

	elseif  nom != '' and etablissement != '' and id_domaine IS NULL THEN
		select 
		ds.id,
	    ds.nom,
	    ds.prenom,
		ds.etablissement,
	    ds.duree, 
	    ds.e_mail as addresse_electronique,
	    d.nom_domaine,
		ds.date_creation,
		CASE 
	        when eds.id IS NULL THEN 'Non validé'
			when ds.action = 1 and eds.id IS NOT NULL THEN 'Validé'
			when ds.action = 2 THEN 'Reporté'
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
		and (ds.nom LIKE concat('%',nom,'%') or ds.prenom LIKE concat('%',nom,'%'))
		and ds.etablissement LIKE concat('%',etablissement,'%')
		GROUP BY ds.id order by ds.date_creation desc; 
	elseif nom != '' and etablissement != '' and id_domaine IS NOT NULL THEN
		select 
		ds.id,
	    ds.nom,
	    ds.prenom,
		ds.etablissement,
	    ds.duree, 
	    ds.e_mail as addresse_electronique,
	    d.nom_domaine,
		ds.date_creation,
		CASE 
	        when eds.id IS NULL THEN 'Non validé'
			when ds.action = 1 and eds.id IS NOT NULL THEN 'Validé'
			when ds.action = 2 THEN 'Reporté'
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
		and (ds.nom LIKE concat('%',nom,'%') or ds.prenom LIKE concat('%',nom,'%'))
		and ds.etablissement LIKE concat('%',etablissement,'%')
		GROUP BY ds.id order by ds.date_creation desc;  
	elseif nom = '' and etablissement = '' and id_domaine IS NOT NULL THEN
		select 
		ds.id,
	    ds.nom,
	    ds.prenom,
		ds.etablissement,
	    ds.duree, 
	    ds.e_mail as addresse_electronique,
	    d.nom_domaine,
		ds.date_creation,
		CASE 
	        when eds.id IS NULL THEN 'Non validé'
			when ds.action = 1 and eds.id IS NOT NULL THEN 'Validé'
			when ds.action = 2 THEN 'Reporté'
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
		ds.etablissement,
		ds.duree, 
		ds.e_mail as addresse_electronique,
		d.nom_domaine,
		ds.date_creation,
		CASE 
	        when eds.id IS NULL THEN 'Non validé'
			when ds.action = 1 and eds.id IS NOT NULL THEN 'Validé'
			when ds.action = 2 THEN 'Reporté'
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
	    WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 0 THEN "#FF0018" 
	    WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 1 THEN "#407DFF" 
		WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 2 THEN "#000000"
	END as color,
	CASE 
	    WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 0 THEN "#FF0018" 
	    WHEN daa.id_autorite_enfant_sender = @sender and daa.action = 1 THEN "#407DFF"
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
	and dhd.date_disponible >= (select `FIRST_DATE_OF_MONTH`(curdate()))
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
	and pd.id is NULL
	);
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
	IFNULL(dap.nom,c.nom) as nom,
	IFNULL(dap.prenom,c.prenom) as prenom,
	dap.cin, 
	dap.numero_telephone, 
	dap.email,
	dap.id_agent, 
	CASE 
	    WHEN dap.action = 0 THEN 'Non validé' 
	    WHEN dap.action = 1 THEN 'Validé' 
	    WHEN dap.action = 2 THEN 'Reporté' 
	    ELSE 'Aucune' 
	END as status_audience,
	CASE 
	    WHEN dap.session_navigateur = @session_navigateur and dap.action = 0 THEN "#FF0018" 
	    WHEN dap.session_navigateur = @session_navigateur and dap.action = 1 THEN "#407DFF" 
		WHEN dap.session_navigateur = @session_navigateur and dap.action = 2 THEN "#000000"  
	END as color, 
	CASE 
	    WHEN dap.session_navigateur = @session_navigateur and dap.action = 0 THEN "#FF0018" 
	    WHEN dap.session_navigateur = @session_navigateur and dap.action = 1 THEN "#407DFF" 
		WHEN dap.session_navigateur = @session_navigateur and dap.action = 2 THEN "#000000" 
	END as color_status, 
	false editable 
	FROM date_heure_disponible_autorite dhda
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	JOIN dm_aud_public_date_heure_dispo dapdhd on dhda.id = dapdhd.id_date_heure_disponible_autorite
	JOIN demande_audience_public dap on dapdhd.id_aud_public = dap.id
	LEFT JOIN rohi.candidat c on dap.id_agent = c.id
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
	'' id_agent,
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

CREATE  PROCEDURE `modifier_audience_agent`(IN numero_telephone varchar(10),
IN email varchar(255),
IN motif VARCHAR(255),
IN id_audience INT,
IN id_date_heure_disponible_autorite INT,
IN id_dm_aud_public_heure_dispo INT)
BEGIN 
	select dhd.heure_debut,dhd.heure_fin,dhd.date_disponible into @heure_debut,@heure_fin,@date_audience from date_heure_disponible_autorite dhda
	join date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id where dhda.id = id_date_heure_disponible_autorite;
	set @id_dhda = id_date_heure_disponible_autorite;	

	-- UPDATE demande_audience_public SET nom = nom , prenom = prenom, cin = cin, numero_telephone = numero_telephone, email = email where id = id_audience;
	UPDATE stage5.dm_aud_public_date_heure_dispo SET id_date_heure_disponible_autorite = @id_dhda, heure_debut = @heure_debut, heure_fin = @heure_fin, date_debut=@date_audience, date_fin=@date_audience where id = id_dm_aud_public_heure_dispo;
	SELECT 'Votre audience a bien été modifiée' as message;

	UPDATE stage5.demande_audience_public 
	SET email = email, motif = motif, numero_telephone = numero_telephone
	WHERE id = id_audience;
END

CREATE  PROCEDURE `modifier_audience_autorite`(IN id_date_heure_disponible_autorite INT,
	IN id_dm_aud_autorite_date_heure_dispo INT,
	IN motif VARCHAR(255),
	IN email VARCHAR(255),
	IN numero_telephone VARCHAR(255),
	IN id_audience INT
)
BEGIN
	select dhd.heure_debut,dhd.heure_fin,dhd.date_disponible into @heure_debut,@heure_fin,@date_audience from date_heure_disponible_autorite dhda
	join date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id 
	where dhda.id = id_date_heure_disponible_autorite;
	set @id_dhda = id_date_heure_disponible_autorite;	

	UPDATE demande_audience_autorite SET motif = motif,email = email, numero_telephone = numero_telephone  where id = id_audience;
	UPDATE dm_aud_autorite_date_heure_dispo SET id_date_heure_disponible_autorite = @id_dhda, heure_debut = @heure_debut, heure_fin = @heure_fin,date_debut=@date_audience, date_fin = @date_audience  where id = id_dm_aud_autorite_date_heure_dispo;
	SELECT 'Votre audience a bien été modifiée' as message;
END

CREATE  PROCEDURE `modifier_audience_public`(IN nom varchar(255),
IN prenom varchar(255),
IN cin varchar(15),
IN numero_telephone varchar(10),
IN email varchar(255),
IN motif VARCHAR(255),
IN id_audience INT,
IN id_date_heure_disponible_autorite INT,
IN id_dm_aud_public_heure_dispo INT)
BEGIN 
	select dhd.heure_debut,dhd.heure_fin,dhd.date_disponible into @heure_debut,@heure_fin,@date_audience from date_heure_disponible_autorite dhda
	join date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id where dhda.id = id_date_heure_disponible_autorite;
	set @id_dhda = id_date_heure_disponible_autorite;	

	-- UPDATE demande_audience_public SET nom = nom , prenom = prenom, cin = cin, numero_telephone = numero_telephone, email = email where id = id_audience;
	UPDATE stage5.dm_aud_public_date_heure_dispo SET id_date_heure_disponible_autorite = @id_dhda, heure_debut = @heure_debut, heure_fin = @heure_fin, date_debut=@date_audience, date_fin=@date_audience where id = id_dm_aud_public_heure_dispo;
	SELECT 'Votre audience a bien été modifiée' as message;

	UPDATE stage5.demande_audience_public 
	SET email = email, motif = motif, nom = (SELECT UPPER(nom)), prenom = prenom, cin = cin, numero_telephone = numero_telephone
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

CREATE  PROCEDURE `modifier_entretien_stage_calendrier`(IN id_entretien_stage int,IN id_dm_stage INT,IN date_debut date,IN date_fin date,IN heure_debut time,in heure_fin time, IN id_autorite INT)
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
	and 
	(@timestamp_debut BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))
	and @timestamp_fin BETWEEN timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_debut,"03:00:00"))) and timestamp(CONCAT(dhd.date_disponible,' ',SUBTIME(dhd.heure_fin,"03:00:00")))));

	-- SCENE 1
	IF date_debut = date_fin THEN
		IF @nbr_rows = 0 THEN 
			DELETE FROM entretien_demande_stage where id_demande_stage = id_dm_stage;
			CALL `ajouter_date_heure_disponible_autorite`(@id_autorite,'08:00:00' , '16:00:00' , date_debut );
			CALL `ajouter_entretien_stage_date_heure_dispo_entre_deux_date`( id_dm_stage ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
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
			DELETE FROM entretien_demande_stage where id_demande_stage = id_dm_stage;
			CALL `ajouter_entretien_stage_date_heure_dispo_entre_deux_date`( id_dm_stage ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		END IF;
	ELSEIF date_debut < date_fin THEN
		DELETE FROM entretien_demande_stage where id_demande_stage = id_dm_stage;
		CALL `verifier_date_heure_dispo_entre_deux_dates`(date_debut, date_fin, @id_autorite);
		CALL `ajouter_entretien_stage_date_heure_dispo_entre_deux_date`( id_dm_stage ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
	END IF;
	UPDATE demande_stage set action = 1 WHERE id = id_dm_stage;
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

CREATE  PROCEDURE `prolonger_duree_stage`(duree_de_stage int,id_entretien_stage int)
BEGIN
	SELECT  
        ds.duree,
		es.id_demande_stage
    FROM
        stage5.entretien_demande_stage es 
            INNER JOIN demande_stage ds on es.id_demande_stage = ds.id	
            	where es.id = id_entretien_stage into @duree_initial,@id_demande_stage;  
	IF duree_de_stage <= 0 THEN
		SELECT 'Durée en plus non validé' as message;
	ELSE 
		set @duree_final = @duree_initial + duree_de_stage;	
		UPDATE stage5.demande_stage SET stage5.demande_stage.duree = @duree_final where stage5.demande_stage.id = @id_demande_stage;
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
	UPDATE stage5.demande_stage SET action = 2 where id = id;
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
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 734, '08:00:00', '08:30:00', '2023-02-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 735, '08:30:00', '09:00:00', '2023-02-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 736, '09:00:00', '09:30:00', '2023-02-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 737, '09:30:00', '10:00:00', '2023-02-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 738, '10:00:00', '10:30:00', '2023-02-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 739, '10:30:00', '11:00:00', '2023-02-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 740, '11:00:00', '11:30:00', '2023-02-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 741, '11:30:00', '12:00:00', '2023-02-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 742, '12:00:00', '12:30:00', '2023-02-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 743, '12:30:00', '13:00:00', '2023-02-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 744, '13:00:00', '13:30:00', '2023-02-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 745, '13:30:00', '14:00:00', '2023-02-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 746, '14:00:00', '14:30:00', '2023-02-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 747, '14:30:00', '15:00:00', '2023-02-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 748, '15:00:00', '15:30:00', '2023-02-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 749, '15:30:00', '16:00:00', '2023-02-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 750, '08:00:00', '08:30:00', '2023-02-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 751, '08:30:00', '09:00:00', '2023-02-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 752, '09:00:00', '09:30:00', '2023-02-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 753, '09:30:00', '10:00:00', '2023-02-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 754, '10:00:00', '10:30:00', '2023-02-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 755, '10:30:00', '11:00:00', '2023-02-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 756, '11:00:00', '11:30:00', '2023-02-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 757, '11:30:00', '12:00:00', '2023-02-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 758, '12:00:00', '12:30:00', '2023-02-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 759, '12:30:00', '13:00:00', '2023-02-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 760, '13:00:00', '13:30:00', '2023-02-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 761, '13:30:00', '14:00:00', '2023-02-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 762, '14:00:00', '14:30:00', '2023-02-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 763, '14:30:00', '15:00:00', '2023-02-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 764, '15:00:00', '15:30:00', '2023-02-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 765, '15:30:00', '16:00:00', '2023-02-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 766, '08:00:00', '08:30:00', '2023-02-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 767, '08:30:00', '09:00:00', '2023-02-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 768, '09:00:00', '09:30:00', '2023-02-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 769, '09:30:00', '10:00:00', '2023-02-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 770, '10:00:00', '10:30:00', '2023-02-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 771, '10:30:00', '11:00:00', '2023-02-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 772, '11:00:00', '11:30:00', '2023-02-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 773, '11:30:00', '12:00:00', '2023-02-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 774, '12:00:00', '12:30:00', '2023-02-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 775, '12:30:00', '13:00:00', '2023-02-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 776, '13:00:00', '13:30:00', '2023-02-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 777, '13:30:00', '14:00:00', '2023-02-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 778, '14:00:00', '14:30:00', '2023-02-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 779, '14:30:00', '15:00:00', '2023-02-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 780, '15:00:00', '15:30:00', '2023-02-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 781, '15:30:00', '16:00:00', '2023-02-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 782, '08:00:00', '08:30:00', '2023-02-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 783, '08:30:00', '09:00:00', '2023-02-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 784, '09:00:00', '09:30:00', '2023-02-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 785, '09:30:00', '10:00:00', '2023-02-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 786, '10:00:00', '10:30:00', '2023-02-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 787, '10:30:00', '11:00:00', '2023-02-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 788, '11:00:00', '11:30:00', '2023-02-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 789, '11:30:00', '12:00:00', '2023-02-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 790, '12:00:00', '12:30:00', '2023-02-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 791, '12:30:00', '13:00:00', '2023-02-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 792, '13:00:00', '13:30:00', '2023-02-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 793, '13:30:00', '14:00:00', '2023-02-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 794, '14:00:00', '14:30:00', '2023-02-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 795, '14:30:00', '15:00:00', '2023-02-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 796, '15:00:00', '15:30:00', '2023-02-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 797, '15:30:00', '16:00:00', '2023-02-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 798, '08:00:00', '08:30:00', '2023-02-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 799, '08:30:00', '09:00:00', '2023-02-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 800, '09:00:00', '09:30:00', '2023-02-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 801, '09:30:00', '10:00:00', '2023-02-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 802, '10:00:00', '10:30:00', '2023-02-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 803, '10:30:00', '11:00:00', '2023-02-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 804, '11:00:00', '11:30:00', '2023-02-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 805, '11:30:00', '12:00:00', '2023-02-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 806, '12:00:00', '12:30:00', '2023-02-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 807, '12:30:00', '13:00:00', '2023-02-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 808, '13:00:00', '13:30:00', '2023-02-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 809, '13:30:00', '14:00:00', '2023-02-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 810, '14:00:00', '14:30:00', '2023-02-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 811, '14:30:00', '15:00:00', '2023-02-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 812, '15:00:00', '15:30:00', '2023-02-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 813, '15:30:00', '16:00:00', '2023-02-27', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 814, '08:00:00', '08:30:00', '2023-02-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 815, '08:30:00', '09:00:00', '2023-02-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 816, '09:00:00', '09:30:00', '2023-02-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 817, '09:30:00', '10:00:00', '2023-02-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 818, '10:00:00', '10:30:00', '2023-02-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 819, '10:30:00', '11:00:00', '2023-02-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 820, '11:00:00', '11:30:00', '2023-02-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 821, '11:30:00', '12:00:00', '2023-02-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 822, '12:00:00', '12:30:00', '2023-02-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 823, '12:30:00', '13:00:00', '2023-02-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 824, '13:00:00', '13:30:00', '2023-02-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 825, '13:30:00', '14:00:00', '2023-02-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 826, '14:00:00', '14:30:00', '2023-02-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 827, '14:30:00', '15:00:00', '2023-02-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 828, '15:00:00', '15:30:00', '2023-02-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 829, '15:30:00', '16:00:00', '2023-02-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 830, '08:00:00', '08:30:00', '2023-03-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 831, '08:30:00', '09:00:00', '2023-03-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 832, '09:00:00', '09:30:00', '2023-03-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 833, '09:30:00', '10:00:00', '2023-03-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 834, '10:00:00', '10:30:00', '2023-03-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 835, '10:30:00', '11:00:00', '2023-03-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 836, '11:00:00', '11:30:00', '2023-03-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 837, '11:30:00', '12:00:00', '2023-03-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 838, '12:00:00', '12:30:00', '2023-03-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 839, '12:30:00', '13:00:00', '2023-03-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 840, '13:00:00', '13:30:00', '2023-03-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 841, '13:30:00', '14:00:00', '2023-03-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 842, '14:00:00', '14:30:00', '2023-03-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 843, '14:30:00', '15:00:00', '2023-03-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 844, '15:00:00', '15:30:00', '2023-03-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 845, '15:30:00', '16:00:00', '2023-03-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 846, '08:00:00', '08:30:00', '2023-03-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 847, '08:30:00', '09:00:00', '2023-03-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 848, '09:00:00', '09:30:00', '2023-03-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 849, '09:30:00', '10:00:00', '2023-03-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 850, '10:00:00', '10:30:00', '2023-03-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 851, '10:30:00', '11:00:00', '2023-03-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 852, '11:00:00', '11:30:00', '2023-03-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 853, '11:30:00', '12:00:00', '2023-03-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 854, '12:00:00', '12:30:00', '2023-03-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 855, '12:30:00', '13:00:00', '2023-03-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 856, '13:00:00', '13:30:00', '2023-03-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 857, '13:30:00', '14:00:00', '2023-03-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 858, '14:00:00', '14:30:00', '2023-03-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 859, '14:30:00', '15:00:00', '2023-03-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 860, '15:00:00', '15:30:00', '2023-03-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 861, '15:30:00', '16:00:00', '2023-03-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 862, '08:00:00', '08:30:00', '2023-03-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 863, '08:30:00', '09:00:00', '2023-03-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 864, '09:00:00', '09:30:00', '2023-03-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 865, '09:30:00', '10:00:00', '2023-03-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 866, '10:00:00', '10:30:00', '2023-03-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 867, '10:30:00', '11:00:00', '2023-03-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 868, '11:00:00', '11:30:00', '2023-03-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 869, '11:30:00', '12:00:00', '2023-03-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 870, '12:00:00', '12:30:00', '2023-03-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 871, '12:30:00', '13:00:00', '2023-03-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 872, '13:00:00', '13:30:00', '2023-03-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 873, '13:30:00', '14:00:00', '2023-03-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 874, '14:00:00', '14:30:00', '2023-03-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 875, '14:30:00', '15:00:00', '2023-03-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 876, '15:00:00', '15:30:00', '2023-03-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 877, '15:30:00', '16:00:00', '2023-03-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 878, '08:00:00', '08:30:00', '2023-03-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 879, '08:30:00', '09:00:00', '2023-03-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 880, '09:00:00', '09:30:00', '2023-03-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 881, '09:30:00', '10:00:00', '2023-03-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 882, '10:00:00', '10:30:00', '2023-03-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 883, '10:30:00', '11:00:00', '2023-03-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 884, '11:00:00', '11:30:00', '2023-03-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 885, '11:30:00', '12:00:00', '2023-03-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 886, '12:00:00', '12:30:00', '2023-03-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 887, '12:30:00', '13:00:00', '2023-03-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 888, '13:00:00', '13:30:00', '2023-03-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 889, '13:30:00', '14:00:00', '2023-03-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 890, '14:00:00', '14:30:00', '2023-03-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 891, '14:30:00', '15:00:00', '2023-03-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 892, '15:00:00', '15:30:00', '2023-03-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 893, '15:30:00', '16:00:00', '2023-03-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 894, '08:00:00', '08:30:00', '2023-03-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 895, '08:30:00', '09:00:00', '2023-03-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 896, '09:00:00', '09:30:00', '2023-03-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 897, '09:30:00', '10:00:00', '2023-03-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 898, '10:00:00', '10:30:00', '2023-03-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 899, '10:30:00', '11:00:00', '2023-03-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 900, '11:00:00', '11:30:00', '2023-03-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 901, '11:30:00', '12:00:00', '2023-03-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 902, '12:00:00', '12:30:00', '2023-03-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 903, '12:30:00', '13:00:00', '2023-03-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 904, '13:00:00', '13:30:00', '2023-03-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 905, '13:30:00', '14:00:00', '2023-03-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 906, '14:00:00', '14:30:00', '2023-03-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 907, '14:30:00', '15:00:00', '2023-03-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 908, '15:00:00', '15:30:00', '2023-03-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 909, '15:30:00', '16:00:00', '2023-03-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 910, '08:00:00', '08:30:00', '2023-03-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 911, '08:30:00', '09:00:00', '2023-03-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 912, '09:00:00', '09:30:00', '2023-03-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 913, '09:30:00', '10:00:00', '2023-03-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 914, '10:00:00', '10:30:00', '2023-03-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 915, '10:30:00', '11:00:00', '2023-03-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 916, '11:00:00', '11:30:00', '2023-03-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 917, '11:30:00', '12:00:00', '2023-03-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 918, '12:00:00', '12:30:00', '2023-03-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 919, '12:30:00', '13:00:00', '2023-03-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 920, '13:00:00', '13:30:00', '2023-03-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 921, '13:30:00', '14:00:00', '2023-03-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 922, '14:00:00', '14:30:00', '2023-03-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 923, '14:30:00', '15:00:00', '2023-03-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 924, '15:00:00', '15:30:00', '2023-03-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 925, '15:30:00', '16:00:00', '2023-03-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 926, '08:00:00', '08:30:00', '2023-03-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 927, '08:30:00', '09:00:00', '2023-03-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 928, '09:00:00', '09:30:00', '2023-03-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 929, '09:30:00', '10:00:00', '2023-03-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 930, '10:00:00', '10:30:00', '2023-03-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 931, '10:30:00', '11:00:00', '2023-03-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 932, '11:00:00', '11:30:00', '2023-03-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 933, '11:30:00', '12:00:00', '2023-03-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 934, '12:00:00', '12:30:00', '2023-03-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 935, '12:30:00', '13:00:00', '2023-03-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 936, '13:00:00', '13:30:00', '2023-03-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 937, '13:30:00', '14:00:00', '2023-03-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 938, '14:00:00', '14:30:00', '2023-03-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 939, '14:30:00', '15:00:00', '2023-03-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 940, '15:00:00', '15:30:00', '2023-03-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 941, '15:30:00', '16:00:00', '2023-03-22', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 942, '08:00:00', '08:30:00', '2023-04-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 943, '08:30:00', '09:00:00', '2023-04-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 944, '09:00:00', '09:30:00', '2023-04-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 945, '09:30:00', '10:00:00', '2023-04-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 946, '10:00:00', '10:30:00', '2023-04-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 947, '10:30:00', '11:00:00', '2023-04-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 948, '11:00:00', '11:30:00', '2023-04-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 949, '11:30:00', '12:00:00', '2023-04-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 950, '12:00:00', '12:30:00', '2023-04-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 951, '12:30:00', '13:00:00', '2023-04-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 952, '13:00:00', '13:30:00', '2023-04-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 953, '13:30:00', '14:00:00', '2023-04-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 954, '14:00:00', '14:30:00', '2023-04-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 955, '14:30:00', '15:00:00', '2023-04-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 956, '15:00:00', '15:30:00', '2023-04-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 957, '15:30:00', '16:00:00', '2023-04-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 958, '08:00:00', '08:30:00', '2023-04-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 959, '08:30:00', '09:00:00', '2023-04-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 960, '09:00:00', '09:30:00', '2023-04-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 961, '09:30:00', '10:00:00', '2023-04-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 962, '10:00:00', '10:30:00', '2023-04-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 963, '10:30:00', '11:00:00', '2023-04-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 964, '11:00:00', '11:30:00', '2023-04-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 965, '11:30:00', '12:00:00', '2023-04-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 966, '12:00:00', '12:30:00', '2023-04-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 967, '12:30:00', '13:00:00', '2023-04-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 968, '13:00:00', '13:30:00', '2023-04-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 969, '13:30:00', '14:00:00', '2023-04-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 970, '14:00:00', '14:30:00', '2023-04-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 971, '14:30:00', '15:00:00', '2023-04-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 972, '15:00:00', '15:30:00', '2023-04-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 973, '15:30:00', '16:00:00', '2023-04-05', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 974, '08:00:00', '08:30:00', '2023-04-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 975, '08:30:00', '09:00:00', '2023-04-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 976, '09:00:00', '09:30:00', '2023-04-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 977, '09:30:00', '10:00:00', '2023-04-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 978, '10:00:00', '10:30:00', '2023-04-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 979, '10:30:00', '11:00:00', '2023-04-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 980, '11:00:00', '11:30:00', '2023-04-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 981, '11:30:00', '12:00:00', '2023-04-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 982, '12:00:00', '12:30:00', '2023-04-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 983, '12:30:00', '13:00:00', '2023-04-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 984, '13:00:00', '13:30:00', '2023-04-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 985, '13:30:00', '14:00:00', '2023-04-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 986, '14:00:00', '14:30:00', '2023-04-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 987, '14:30:00', '15:00:00', '2023-04-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 988, '15:00:00', '15:30:00', '2023-04-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 989, '15:30:00', '16:00:00', '2023-04-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 990, '08:00:00', '08:30:00', '2023-04-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 991, '08:30:00', '09:00:00', '2023-04-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 992, '09:00:00', '09:30:00', '2023-04-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 993, '09:30:00', '10:00:00', '2023-04-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 994, '10:00:00', '10:30:00', '2023-04-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 995, '10:30:00', '11:00:00', '2023-04-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 996, '11:00:00', '11:30:00', '2023-04-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 997, '11:30:00', '12:00:00', '2023-04-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 998, '12:00:00', '12:30:00', '2023-04-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 999, '12:30:00', '13:00:00', '2023-04-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1000, '13:00:00', '13:30:00', '2023-04-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1001, '13:30:00', '14:00:00', '2023-04-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1002, '14:00:00', '14:30:00', '2023-04-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1003, '14:30:00', '15:00:00', '2023-04-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1004, '15:00:00', '15:30:00', '2023-04-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1005, '15:30:00', '16:00:00', '2023-04-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1006, '08:00:00', '08:30:00', '2023-04-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1007, '08:30:00', '09:00:00', '2023-04-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1008, '09:00:00', '09:30:00', '2023-04-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1009, '09:30:00', '10:00:00', '2023-04-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1010, '10:00:00', '10:30:00', '2023-04-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1011, '10:30:00', '11:00:00', '2023-04-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1012, '11:00:00', '11:30:00', '2023-04-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1013, '11:30:00', '12:00:00', '2023-04-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1014, '12:00:00', '12:30:00', '2023-04-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1015, '12:30:00', '13:00:00', '2023-04-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1016, '13:00:00', '13:30:00', '2023-04-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1017, '13:30:00', '14:00:00', '2023-04-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1018, '14:00:00', '14:30:00', '2023-04-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1019, '14:30:00', '15:00:00', '2023-04-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1020, '15:00:00', '15:30:00', '2023-04-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1021, '15:30:00', '16:00:00', '2023-04-21', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1022, '08:00:00', '08:30:00', '2023-04-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1023, '08:30:00', '09:00:00', '2023-04-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1024, '09:00:00', '09:30:00', '2023-04-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1025, '09:30:00', '10:00:00', '2023-04-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1026, '10:00:00', '10:30:00', '2023-04-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1027, '10:30:00', '11:00:00', '2023-04-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1028, '11:00:00', '11:30:00', '2023-04-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1029, '11:30:00', '12:00:00', '2023-04-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1030, '12:00:00', '12:30:00', '2023-04-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1031, '12:30:00', '13:00:00', '2023-04-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1032, '13:00:00', '13:30:00', '2023-04-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1033, '13:30:00', '14:00:00', '2023-04-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1034, '14:00:00', '14:30:00', '2023-04-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1035, '14:30:00', '15:00:00', '2023-04-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1036, '15:00:00', '15:30:00', '2023-04-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1037, '15:30:00', '16:00:00', '2023-04-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1038, '08:00:00', '08:30:00', '2023-06-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1039, '08:30:00', '09:00:00', '2023-06-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1040, '09:00:00', '09:30:00', '2023-06-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1041, '09:30:00', '10:00:00', '2023-06-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1042, '10:00:00', '10:30:00', '2023-06-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1043, '10:30:00', '11:00:00', '2023-06-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1044, '11:00:00', '11:30:00', '2023-06-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1045, '11:30:00', '12:00:00', '2023-06-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1046, '12:00:00', '12:30:00', '2023-06-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1047, '12:30:00', '13:00:00', '2023-06-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1048, '13:00:00', '13:30:00', '2023-06-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1049, '13:30:00', '14:00:00', '2023-06-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1050, '14:00:00', '14:30:00', '2023-06-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1051, '14:30:00', '15:00:00', '2023-06-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1052, '15:00:00', '15:30:00', '2023-06-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1053, '15:30:00', '16:00:00', '2023-06-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1054, '08:00:00', '08:30:00', '2023-06-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1055, '08:30:00', '09:00:00', '2023-06-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1056, '09:00:00', '09:30:00', '2023-06-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1057, '09:30:00', '10:00:00', '2023-06-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1058, '10:00:00', '10:30:00', '2023-06-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1059, '10:30:00', '11:00:00', '2023-06-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1060, '11:00:00', '11:30:00', '2023-06-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1061, '11:30:00', '12:00:00', '2023-06-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1062, '12:00:00', '12:30:00', '2023-06-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1063, '12:30:00', '13:00:00', '2023-06-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1064, '13:00:00', '13:30:00', '2023-06-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1065, '13:30:00', '14:00:00', '2023-06-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1066, '14:00:00', '14:30:00', '2023-06-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1067, '14:30:00', '15:00:00', '2023-06-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1068, '15:00:00', '15:30:00', '2023-06-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1069, '15:30:00', '16:00:00', '2023-06-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1070, '08:00:00', '08:30:00', '2023-06-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1071, '08:30:00', '09:00:00', '2023-06-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1072, '09:00:00', '09:30:00', '2023-06-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1073, '09:30:00', '10:00:00', '2023-06-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1074, '10:00:00', '10:30:00', '2023-06-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1075, '10:30:00', '11:00:00', '2023-06-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1076, '11:00:00', '11:30:00', '2023-06-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1077, '11:30:00', '12:00:00', '2023-06-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1078, '12:00:00', '12:30:00', '2023-06-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1079, '12:30:00', '13:00:00', '2023-06-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1080, '13:00:00', '13:30:00', '2023-06-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1081, '13:30:00', '14:00:00', '2023-06-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1082, '14:00:00', '14:30:00', '2023-06-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1083, '14:30:00', '15:00:00', '2023-06-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1084, '15:00:00', '15:30:00', '2023-06-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1085, '15:30:00', '16:00:00', '2023-06-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1086, '08:00:00', '08:30:00', '2023-06-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1087, '08:30:00', '09:00:00', '2023-06-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1088, '09:00:00', '09:30:00', '2023-06-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1089, '09:30:00', '10:00:00', '2023-06-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1090, '10:00:00', '10:30:00', '2023-06-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1091, '10:30:00', '11:00:00', '2023-06-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1092, '11:00:00', '11:30:00', '2023-06-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1093, '11:30:00', '12:00:00', '2023-06-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1094, '12:00:00', '12:30:00', '2023-06-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1095, '12:30:00', '13:00:00', '2023-06-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1096, '13:00:00', '13:30:00', '2023-06-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1097, '13:30:00', '14:00:00', '2023-06-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1098, '14:00:00', '14:30:00', '2023-06-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1099, '14:30:00', '15:00:00', '2023-06-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1100, '15:00:00', '15:30:00', '2023-06-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1101, '15:30:00', '16:00:00', '2023-06-06', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1102, '08:00:00', '08:30:00', '2023-06-08', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1103, '08:30:00', '09:00:00', '2023-06-08', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1104, '09:00:00', '09:30:00', '2023-06-08', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1105, '09:30:00', '10:00:00', '2023-06-08', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1106, '10:00:00', '10:30:00', '2023-06-08', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1107, '10:30:00', '11:00:00', '2023-06-08', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1108, '11:00:00', '11:30:00', '2023-06-08', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1109, '11:30:00', '12:00:00', '2023-06-08', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1110, '12:00:00', '12:30:00', '2023-06-08', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1111, '12:30:00', '13:00:00', '2023-06-08', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1112, '13:00:00', '13:30:00', '2023-06-08', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1113, '13:30:00', '14:00:00', '2023-06-08', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1114, '14:00:00', '14:30:00', '2023-06-08', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1115, '14:30:00', '15:00:00', '2023-06-08', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1116, '15:00:00', '15:30:00', '2023-06-08', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1117, '15:30:00', '16:00:00', '2023-06-08', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1118, '08:00:00', '08:30:00', '2023-06-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1119, '08:30:00', '09:00:00', '2023-06-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1120, '09:00:00', '09:30:00', '2023-06-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1121, '09:30:00', '10:00:00', '2023-06-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1122, '10:00:00', '10:30:00', '2023-06-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1123, '10:30:00', '11:00:00', '2023-06-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1124, '11:00:00', '11:30:00', '2023-06-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1125, '11:30:00', '12:00:00', '2023-06-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1126, '12:00:00', '12:30:00', '2023-06-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1127, '12:30:00', '13:00:00', '2023-06-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1128, '13:00:00', '13:30:00', '2023-06-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1129, '13:30:00', '14:00:00', '2023-06-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1130, '14:00:00', '14:30:00', '2023-06-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1131, '14:30:00', '15:00:00', '2023-06-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1132, '15:00:00', '15:30:00', '2023-06-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1133, '15:30:00', '16:00:00', '2023-06-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1134, '08:00:00', '08:30:00', '2023-06-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1135, '08:30:00', '09:00:00', '2023-06-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1136, '09:00:00', '09:30:00', '2023-06-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1137, '09:30:00', '10:00:00', '2023-06-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1138, '10:00:00', '10:30:00', '2023-06-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1139, '10:30:00', '11:00:00', '2023-06-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1140, '11:00:00', '11:30:00', '2023-06-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1141, '11:30:00', '12:00:00', '2023-06-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1142, '12:00:00', '12:30:00', '2023-06-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1143, '12:30:00', '13:00:00', '2023-06-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1144, '13:00:00', '13:30:00', '2023-06-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1145, '13:30:00', '14:00:00', '2023-06-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1146, '14:00:00', '14:30:00', '2023-06-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1147, '14:30:00', '15:00:00', '2023-06-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1148, '15:00:00', '15:30:00', '2023-06-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1149, '15:30:00', '16:00:00', '2023-06-23', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1150, '08:00:00', '08:30:00', '2023-06-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1151, '08:30:00', '09:00:00', '2023-06-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1152, '09:00:00', '09:30:00', '2023-06-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1153, '09:30:00', '10:00:00', '2023-06-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1154, '10:00:00', '10:30:00', '2023-06-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1155, '10:30:00', '11:00:00', '2023-06-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1156, '11:00:00', '11:30:00', '2023-06-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1157, '11:30:00', '12:00:00', '2023-06-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1158, '12:00:00', '12:30:00', '2023-06-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1159, '12:30:00', '13:00:00', '2023-06-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1160, '13:00:00', '13:30:00', '2023-06-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1161, '13:30:00', '14:00:00', '2023-06-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1162, '14:00:00', '14:30:00', '2023-06-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1163, '14:30:00', '15:00:00', '2023-06-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1164, '15:00:00', '15:30:00', '2023-06-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1165, '15:30:00', '16:00:00', '2023-06-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1166, '08:00:00', '08:30:00', '2023-07-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1167, '08:30:00', '09:00:00', '2023-07-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1168, '09:00:00', '09:30:00', '2023-07-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1169, '09:30:00', '10:00:00', '2023-07-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1170, '10:00:00', '10:30:00', '2023-07-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1171, '10:30:00', '11:00:00', '2023-07-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1172, '11:00:00', '11:30:00', '2023-07-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1173, '11:30:00', '12:00:00', '2023-07-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1174, '12:00:00', '12:30:00', '2023-07-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1175, '12:30:00', '13:00:00', '2023-07-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1176, '13:00:00', '13:30:00', '2023-07-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1177, '13:30:00', '14:00:00', '2023-07-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1178, '14:00:00', '14:30:00', '2023-07-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1179, '14:30:00', '15:00:00', '2023-07-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1180, '15:00:00', '15:30:00', '2023-07-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1181, '15:30:00', '16:00:00', '2023-07-12', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1182, '08:00:00', '08:30:00', '2023-07-14', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1183, '08:30:00', '09:00:00', '2023-07-14', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1184, '09:00:00', '09:30:00', '2023-07-14', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1185, '09:30:00', '10:00:00', '2023-07-14', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1186, '10:00:00', '10:30:00', '2023-07-14', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1187, '10:30:00', '11:00:00', '2023-07-14', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1188, '11:00:00', '11:30:00', '2023-07-14', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1189, '11:30:00', '12:00:00', '2023-07-14', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1190, '12:00:00', '12:30:00', '2023-07-14', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1191, '12:30:00', '13:00:00', '2023-07-14', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1192, '13:00:00', '13:30:00', '2023-07-14', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1193, '13:30:00', '14:00:00', '2023-07-14', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1194, '14:00:00', '14:30:00', '2023-07-14', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1195, '14:30:00', '15:00:00', '2023-07-14', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1196, '15:00:00', '15:30:00', '2023-07-14', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1197, '15:30:00', '16:00:00', '2023-07-14', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1198, '08:00:00', '08:30:00', '2023-07-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1199, '08:30:00', '09:00:00', '2023-07-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1200, '09:00:00', '09:30:00', '2023-07-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1201, '09:30:00', '10:00:00', '2023-07-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1202, '10:00:00', '10:30:00', '2023-07-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1203, '10:30:00', '11:00:00', '2023-07-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1204, '11:00:00', '11:30:00', '2023-07-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1205, '11:30:00', '12:00:00', '2023-07-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1206, '12:00:00', '12:30:00', '2023-07-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1207, '12:30:00', '13:00:00', '2023-07-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1208, '13:00:00', '13:30:00', '2023-07-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1209, '13:30:00', '14:00:00', '2023-07-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1210, '14:00:00', '14:30:00', '2023-07-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1211, '14:30:00', '15:00:00', '2023-07-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1212, '15:00:00', '15:30:00', '2023-07-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1213, '15:30:00', '16:00:00', '2023-07-24', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1214, '08:00:00', '08:30:00', '2023-07-25', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1215, '08:30:00', '09:00:00', '2023-07-25', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1216, '09:00:00', '09:30:00', '2023-07-25', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1217, '09:30:00', '10:00:00', '2023-07-25', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1218, '10:00:00', '10:30:00', '2023-07-25', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1219, '10:30:00', '11:00:00', '2023-07-25', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1220, '11:00:00', '11:30:00', '2023-07-25', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1221, '11:30:00', '12:00:00', '2023-07-25', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1222, '12:00:00', '12:30:00', '2023-07-25', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1223, '12:30:00', '13:00:00', '2023-07-25', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1224, '13:00:00', '13:30:00', '2023-07-25', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1225, '13:30:00', '14:00:00', '2023-07-25', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1226, '14:00:00', '14:30:00', '2023-07-25', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1227, '14:30:00', '15:00:00', '2023-07-25', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1228, '15:00:00', '15:30:00', '2023-07-25', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1229, '15:30:00', '16:00:00', '2023-07-25', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1230, '08:00:00', '08:30:00', '2023-07-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1231, '08:30:00', '09:00:00', '2023-07-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1232, '09:00:00', '09:30:00', '2023-07-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1233, '09:30:00', '10:00:00', '2023-07-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1234, '10:00:00', '10:30:00', '2023-07-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1235, '10:30:00', '11:00:00', '2023-07-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1236, '11:00:00', '11:30:00', '2023-07-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1237, '11:30:00', '12:00:00', '2023-07-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1238, '12:00:00', '12:30:00', '2023-07-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1239, '12:30:00', '13:00:00', '2023-07-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1240, '13:00:00', '13:30:00', '2023-07-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1241, '13:30:00', '14:00:00', '2023-07-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1242, '14:00:00', '14:30:00', '2023-07-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1243, '14:30:00', '15:00:00', '2023-07-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1244, '15:00:00', '15:30:00', '2023-07-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1245, '15:30:00', '16:00:00', '2023-07-26', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1246, '08:00:00', '08:30:00', '2023-07-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1247, '08:30:00', '09:00:00', '2023-07-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1248, '09:00:00', '09:30:00', '2023-07-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1249, '09:30:00', '10:00:00', '2023-07-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1250, '10:00:00', '10:30:00', '2023-07-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1251, '10:30:00', '11:00:00', '2023-07-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1252, '11:00:00', '11:30:00', '2023-07-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1253, '11:30:00', '12:00:00', '2023-07-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1254, '12:00:00', '12:30:00', '2023-07-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1255, '12:30:00', '13:00:00', '2023-07-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1256, '13:00:00', '13:30:00', '2023-07-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1257, '13:30:00', '14:00:00', '2023-07-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1258, '14:00:00', '14:30:00', '2023-07-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1259, '14:30:00', '15:00:00', '2023-07-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1260, '15:00:00', '15:30:00', '2023-07-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1261, '15:30:00', '16:00:00', '2023-07-31', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1262, '08:00:00', '08:30:00', '2023-08-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1263, '08:30:00', '09:00:00', '2023-08-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1264, '09:00:00', '09:30:00', '2023-08-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1265, '09:30:00', '10:00:00', '2023-08-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1266, '10:00:00', '10:30:00', '2023-08-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1267, '10:30:00', '11:00:00', '2023-08-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1268, '11:00:00', '11:30:00', '2023-08-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1269, '11:30:00', '12:00:00', '2023-08-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1270, '12:00:00', '12:30:00', '2023-08-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1271, '12:30:00', '13:00:00', '2023-08-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1272, '13:00:00', '13:30:00', '2023-08-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1273, '13:30:00', '14:00:00', '2023-08-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1274, '14:00:00', '14:30:00', '2023-08-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1275, '14:30:00', '15:00:00', '2023-08-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1276, '15:00:00', '15:30:00', '2023-08-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1277, '15:30:00', '16:00:00', '2023-08-02', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1278, '08:00:00', '08:30:00', '2023-08-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1279, '08:30:00', '09:00:00', '2023-08-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1280, '09:00:00', '09:30:00', '2023-08-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1281, '09:30:00', '10:00:00', '2023-08-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1282, '10:00:00', '10:30:00', '2023-08-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1283, '10:30:00', '11:00:00', '2023-08-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1284, '11:00:00', '11:30:00', '2023-08-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1285, '11:30:00', '12:00:00', '2023-08-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1286, '12:00:00', '12:30:00', '2023-08-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1287, '12:30:00', '13:00:00', '2023-08-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1288, '13:00:00', '13:30:00', '2023-08-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1289, '13:30:00', '14:00:00', '2023-08-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1290, '14:00:00', '14:30:00', '2023-08-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1291, '14:30:00', '15:00:00', '2023-08-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1292, '15:00:00', '15:30:00', '2023-08-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1293, '15:30:00', '16:00:00', '2023-08-01', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1294, '08:00:00', '08:30:00', '2023-08-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1295, '08:30:00', '09:00:00', '2023-08-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1296, '09:00:00', '09:30:00', '2023-08-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1297, '09:30:00', '10:00:00', '2023-08-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1298, '10:00:00', '10:30:00', '2023-08-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1299, '10:30:00', '11:00:00', '2023-08-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1300, '11:00:00', '11:30:00', '2023-08-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1301, '11:30:00', '12:00:00', '2023-08-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1302, '12:00:00', '12:30:00', '2023-08-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1303, '12:30:00', '13:00:00', '2023-08-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1304, '13:00:00', '13:30:00', '2023-08-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1305, '13:30:00', '14:00:00', '2023-08-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1306, '14:00:00', '14:30:00', '2023-08-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1307, '14:30:00', '15:00:00', '2023-08-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1308, '15:00:00', '15:30:00', '2023-08-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1309, '15:30:00', '16:00:00', '2023-08-04', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1310, '08:00:00', '08:30:00', '2023-08-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1311, '08:30:00', '09:00:00', '2023-08-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1312, '09:00:00', '09:30:00', '2023-08-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1313, '09:30:00', '10:00:00', '2023-08-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1314, '10:00:00', '10:30:00', '2023-08-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1315, '10:30:00', '11:00:00', '2023-08-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1316, '11:00:00', '11:30:00', '2023-08-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1317, '11:30:00', '12:00:00', '2023-08-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1318, '12:00:00', '12:30:00', '2023-08-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1319, '12:30:00', '13:00:00', '2023-08-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1320, '13:00:00', '13:30:00', '2023-08-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1321, '13:30:00', '14:00:00', '2023-08-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1322, '14:00:00', '14:30:00', '2023-08-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1323, '14:30:00', '15:00:00', '2023-08-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1324, '15:00:00', '15:30:00', '2023-08-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1325, '15:30:00', '16:00:00', '2023-08-03', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1326, '08:00:00', '08:30:00', '2023-08-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1327, '08:30:00', '09:00:00', '2023-08-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1328, '09:00:00', '09:30:00', '2023-08-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1329, '09:30:00', '10:00:00', '2023-08-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1330, '10:00:00', '10:30:00', '2023-08-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1331, '10:30:00', '11:00:00', '2023-08-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1332, '11:00:00', '11:30:00', '2023-08-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1333, '11:30:00', '12:00:00', '2023-08-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1334, '12:00:00', '12:30:00', '2023-08-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1335, '12:30:00', '13:00:00', '2023-08-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1336, '13:00:00', '13:30:00', '2023-08-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1337, '13:30:00', '14:00:00', '2023-08-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1338, '14:00:00', '14:30:00', '2023-08-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1339, '14:30:00', '15:00:00', '2023-08-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1340, '15:00:00', '15:30:00', '2023-08-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1341, '15:30:00', '16:00:00', '2023-08-10', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1342, '08:00:00', '08:30:00', '2023-08-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1343, '08:30:00', '09:00:00', '2023-08-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1344, '09:00:00', '09:30:00', '2023-08-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1345, '09:30:00', '10:00:00', '2023-08-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1346, '10:00:00', '10:30:00', '2023-08-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1347, '10:30:00', '11:00:00', '2023-08-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1348, '11:00:00', '11:30:00', '2023-08-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1349, '11:30:00', '12:00:00', '2023-08-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1350, '12:00:00', '12:30:00', '2023-08-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1351, '12:30:00', '13:00:00', '2023-08-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1352, '13:00:00', '13:30:00', '2023-08-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1353, '13:30:00', '14:00:00', '2023-08-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1354, '14:00:00', '14:30:00', '2023-08-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1355, '14:30:00', '15:00:00', '2023-08-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1356, '15:00:00', '15:30:00', '2023-08-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1357, '15:30:00', '16:00:00', '2023-08-09', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1358, '08:00:00', '08:30:00', '2023-08-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1359, '08:30:00', '09:00:00', '2023-08-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1360, '09:00:00', '09:30:00', '2023-08-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1361, '09:30:00', '10:00:00', '2023-08-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1362, '10:00:00', '10:30:00', '2023-08-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1363, '10:30:00', '11:00:00', '2023-08-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1364, '11:00:00', '11:30:00', '2023-08-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1365, '11:30:00', '12:00:00', '2023-08-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1366, '12:00:00', '12:30:00', '2023-08-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1367, '12:30:00', '13:00:00', '2023-08-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1368, '13:00:00', '13:30:00', '2023-08-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1369, '13:30:00', '14:00:00', '2023-08-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1370, '14:00:00', '14:30:00', '2023-08-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1371, '14:30:00', '15:00:00', '2023-08-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1372, '15:00:00', '15:30:00', '2023-08-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1373, '15:30:00', '16:00:00', '2023-08-11', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1374, '08:00:00', '08:30:00', '2023-09-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1375, '08:30:00', '09:00:00', '2023-09-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1376, '09:00:00', '09:30:00', '2023-09-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1377, '09:30:00', '10:00:00', '2023-09-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1378, '10:00:00', '10:30:00', '2023-09-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1379, '10:30:00', '11:00:00', '2023-09-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1380, '11:00:00', '11:30:00', '2023-09-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1381, '11:30:00', '12:00:00', '2023-09-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1382, '12:00:00', '12:30:00', '2023-09-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1383, '12:30:00', '13:00:00', '2023-09-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1384, '13:00:00', '13:30:00', '2023-09-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1385, '13:30:00', '14:00:00', '2023-09-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1386, '14:00:00', '14:30:00', '2023-09-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1387, '14:30:00', '15:00:00', '2023-09-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1388, '15:00:00', '15:30:00', '2023-09-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1389, '15:30:00', '16:00:00', '2023-09-28', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1390, '08:00:00', '08:30:00', '2023-09-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1391, '08:30:00', '09:00:00', '2023-09-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1392, '09:00:00', '09:30:00', '2023-09-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1393, '09:30:00', '10:00:00', '2023-09-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1394, '10:00:00', '10:30:00', '2023-09-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1395, '10:30:00', '11:00:00', '2023-09-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1396, '11:00:00', '11:30:00', '2023-09-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1397, '11:30:00', '12:00:00', '2023-09-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1398, '12:00:00', '12:30:00', '2023-09-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1399, '12:30:00', '13:00:00', '2023-09-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1400, '13:00:00', '13:30:00', '2023-09-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1401, '13:30:00', '14:00:00', '2023-09-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1402, '14:00:00', '14:30:00', '2023-09-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1403, '14:30:00', '15:00:00', '2023-09-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1404, '15:00:00', '15:30:00', '2023-09-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1405, '15:30:00', '16:00:00', '2023-09-29', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1406, '08:00:00', '08:30:00', '2023-10-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1407, '08:30:00', '09:00:00', '2023-10-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1408, '09:00:00', '09:30:00', '2023-10-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1409, '09:30:00', '10:00:00', '2023-10-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1410, '10:00:00', '10:30:00', '2023-10-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1411, '10:30:00', '11:00:00', '2023-10-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1412, '11:00:00', '11:30:00', '2023-10-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1413, '11:30:00', '12:00:00', '2023-10-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1414, '12:00:00', '12:30:00', '2023-10-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1415, '12:30:00', '13:00:00', '2023-10-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1416, '13:00:00', '13:30:00', '2023-10-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1417, '13:30:00', '14:00:00', '2023-10-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1418, '14:00:00', '14:30:00', '2023-10-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1419, '14:30:00', '15:00:00', '2023-10-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1420, '15:00:00', '15:30:00', '2023-10-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1421, '15:30:00', '16:00:00', '2023-10-16', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1422, '08:00:00', '08:30:00', '2023-10-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1423, '08:30:00', '09:00:00', '2023-10-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1424, '09:00:00', '09:30:00', '2023-10-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1425, '09:30:00', '10:00:00', '2023-10-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1426, '10:00:00', '10:30:00', '2023-10-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1427, '10:30:00', '11:00:00', '2023-10-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1428, '11:00:00', '11:30:00', '2023-10-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1429, '11:30:00', '12:00:00', '2023-10-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1430, '12:00:00', '12:30:00', '2023-10-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1431, '12:30:00', '13:00:00', '2023-10-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1432, '13:00:00', '13:30:00', '2023-10-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1433, '13:30:00', '14:00:00', '2023-10-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1434, '14:00:00', '14:30:00', '2023-10-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1435, '14:30:00', '15:00:00', '2023-10-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1436, '15:00:00', '15:30:00', '2023-10-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1437, '15:30:00', '16:00:00', '2023-10-18', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1438, '08:00:00', '08:30:00', '2023-10-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1439, '08:30:00', '09:00:00', '2023-10-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1440, '09:00:00', '09:30:00', '2023-10-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1441, '09:30:00', '10:00:00', '2023-10-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1442, '10:00:00', '10:30:00', '2023-10-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1443, '10:30:00', '11:00:00', '2023-10-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1444, '11:00:00', '11:30:00', '2023-10-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1445, '11:30:00', '12:00:00', '2023-10-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1446, '12:00:00', '12:30:00', '2023-10-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1447, '12:30:00', '13:00:00', '2023-10-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1448, '13:00:00', '13:30:00', '2023-10-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1449, '13:30:00', '14:00:00', '2023-10-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1450, '14:00:00', '14:30:00', '2023-10-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1451, '14:30:00', '15:00:00', '2023-10-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1452, '15:00:00', '15:30:00', '2023-10-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1453, '15:30:00', '16:00:00', '2023-10-20', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1454, '08:00:00', '08:30:00', '2023-10-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1455, '08:30:00', '09:00:00', '2023-10-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1456, '09:00:00', '09:30:00', '2023-10-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1457, '09:30:00', '10:00:00', '2023-10-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1458, '10:00:00', '10:30:00', '2023-10-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1459, '10:30:00', '11:00:00', '2023-10-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1460, '11:00:00', '11:30:00', '2023-10-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1461, '11:30:00', '12:00:00', '2023-10-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1462, '12:00:00', '12:30:00', '2023-10-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1463, '12:30:00', '13:00:00', '2023-10-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1464, '13:00:00', '13:30:00', '2023-10-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1465, '13:30:00', '14:00:00', '2023-10-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1466, '14:00:00', '14:30:00', '2023-10-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1467, '14:30:00', '15:00:00', '2023-10-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1468, '15:00:00', '15:30:00', '2023-10-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1469, '15:30:00', '16:00:00', '2023-10-17', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1470, '08:00:00', '08:30:00', '2023-10-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1471, '08:30:00', '09:00:00', '2023-10-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1472, '09:00:00', '09:30:00', '2023-10-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1473, '09:30:00', '10:00:00', '2023-10-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1474, '10:00:00', '10:30:00', '2023-10-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1475, '10:30:00', '11:00:00', '2023-10-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1476, '11:00:00', '11:30:00', '2023-10-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1477, '11:30:00', '12:00:00', '2023-10-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1478, '12:00:00', '12:30:00', '2023-10-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1479, '12:30:00', '13:00:00', '2023-10-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1480, '13:00:00', '13:30:00', '2023-10-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1481, '13:30:00', '14:00:00', '2023-10-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1482, '14:00:00', '14:30:00', '2023-10-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1483, '14:30:00', '15:00:00', '2023-10-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1484, '15:00:00', '15:30:00', '2023-10-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible( id, heure_debut, heure_fin, date_disponible, duree ) VALUES ( 1485, '15:30:00', '16:00:00', '2023-10-19', '00:30:00');
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1411, 734, 2962, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1412, 735, 2962, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1413, 736, 2962, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1414, 737, 2962, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1415, 738, 2962, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1416, 739, 2962, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1417, 740, 2962, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1418, 741, 2962, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1419, 742, 2962, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1420, 743, 2962, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1421, 744, 2962, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1422, 745, 2962, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1423, 746, 2962, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1424, 747, 2962, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1425, 748, 2962, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1426, 749, 2962, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1442, 734, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1443, 735, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1444, 736, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1445, 737, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1446, 738, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1447, 739, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1448, 740, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1449, 741, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1450, 742, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1451, 743, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1452, 744, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1453, 745, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1454, 746, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1455, 747, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1456, 748, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1457, 749, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1473, 750, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1474, 751, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1475, 752, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1476, 753, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1477, 754, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1478, 755, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1479, 756, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1480, 757, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1481, 758, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1482, 759, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1483, 760, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1484, 761, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1485, 762, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1486, 763, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1487, 764, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1488, 765, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1504, 766, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1505, 767, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1506, 768, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1507, 769, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1508, 770, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1509, 771, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1510, 772, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1511, 773, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1512, 774, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1513, 775, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1514, 776, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1515, 777, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1516, 778, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1517, 779, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1518, 780, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1519, 781, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1520, 782, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1521, 783, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1522, 784, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1523, 785, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1524, 786, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1525, 787, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1526, 788, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1527, 789, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1528, 790, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1529, 791, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1530, 792, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1531, 793, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1532, 794, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1533, 795, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1534, 796, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1535, 797, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1536, 798, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1537, 799, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1538, 800, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1539, 801, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1540, 802, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1541, 803, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1542, 804, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1543, 805, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1544, 806, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1545, 807, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1546, 808, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1547, 809, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1548, 810, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1549, 811, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1550, 812, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1551, 813, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1567, 814, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1568, 815, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1569, 816, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1570, 817, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1571, 818, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1572, 819, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1573, 820, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1574, 821, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1575, 822, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1576, 823, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1577, 824, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1578, 825, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1579, 826, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1580, 827, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1581, 828, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1582, 829, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1598, 830, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1599, 831, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1600, 832, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1601, 833, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1602, 834, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1603, 835, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1604, 836, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1605, 837, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1606, 838, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1607, 839, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1608, 840, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1609, 841, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1610, 842, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1611, 843, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1612, 844, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1613, 845, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1614, 846, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1615, 847, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1616, 848, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1617, 849, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1618, 850, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1619, 851, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1620, 852, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1621, 853, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1622, 854, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1623, 855, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1624, 856, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1625, 857, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1626, 858, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1627, 859, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1628, 860, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1629, 861, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1630, 862, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1631, 863, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1632, 864, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1633, 865, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1634, 866, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1635, 867, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1636, 868, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1637, 869, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1638, 870, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1639, 871, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1640, 872, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1641, 873, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1642, 874, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1643, 875, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1644, 876, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1645, 877, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1646, 878, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1647, 879, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1648, 880, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1649, 881, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1650, 882, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1651, 883, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1652, 884, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1653, 885, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1654, 886, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1655, 887, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1656, 888, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1657, 889, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1658, 890, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1659, 891, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1660, 892, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1661, 893, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1677, 894, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1678, 895, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1679, 896, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1680, 897, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1681, 898, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1682, 899, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1683, 900, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1684, 901, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1685, 902, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1686, 903, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1687, 904, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1688, 905, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1689, 906, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1690, 907, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1691, 908, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1692, 909, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1708, 910, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1709, 911, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1710, 912, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1711, 913, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1712, 914, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1713, 915, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1714, 916, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1715, 917, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1716, 918, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1717, 919, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1718, 920, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1719, 921, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1720, 922, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1721, 923, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1722, 924, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1723, 925, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1739, 926, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1740, 927, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1741, 928, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1742, 929, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1743, 930, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1744, 931, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1745, 932, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1746, 933, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1747, 934, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1748, 935, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1749, 936, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1750, 937, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1751, 938, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1752, 939, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1753, 940, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1754, 941, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1755, 942, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1756, 943, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1757, 944, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1758, 945, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1759, 946, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1760, 947, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1761, 948, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1762, 949, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1763, 950, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1764, 951, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1765, 952, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1766, 953, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1767, 954, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1768, 955, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1769, 956, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1770, 957, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1786, 958, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1787, 959, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1788, 960, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1789, 961, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1790, 962, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1791, 963, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1792, 964, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1793, 965, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1794, 966, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1795, 967, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1796, 968, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1797, 969, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1798, 970, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1799, 971, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1800, 972, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1801, 973, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1802, 974, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1803, 975, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1804, 976, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1805, 977, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1806, 978, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1807, 979, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1808, 980, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1809, 981, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1810, 982, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1811, 983, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1812, 984, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1813, 985, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1814, 986, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1815, 987, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1816, 988, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1817, 989, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1833, 990, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1834, 991, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1835, 992, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1836, 993, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1837, 994, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1838, 995, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1839, 996, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1840, 997, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1841, 998, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1842, 999, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1843, 1000, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1844, 1001, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1845, 1002, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1846, 1003, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1847, 1004, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1848, 1005, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1864, 1006, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1865, 1007, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1866, 1008, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1867, 1009, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1868, 1010, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1869, 1011, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1870, 1012, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1871, 1013, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1872, 1014, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1873, 1015, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1874, 1016, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1875, 1017, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1876, 1018, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1877, 1019, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1878, 1020, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1879, 1021, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1880, 1022, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1881, 1023, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1882, 1024, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1883, 1025, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1884, 1026, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1885, 1027, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1886, 1028, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1887, 1029, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1888, 1030, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1889, 1031, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1890, 1032, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1891, 1033, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1892, 1034, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1893, 1035, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1894, 1036, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1895, 1037, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1896, 1038, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1897, 1039, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1898, 1040, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1899, 1041, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1900, 1042, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1901, 1043, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1902, 1044, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1903, 1045, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1904, 1046, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1905, 1047, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1906, 1048, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1907, 1049, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1908, 1050, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1909, 1051, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1910, 1052, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1911, 1053, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1927, 1054, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1928, 1055, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1929, 1056, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1930, 1057, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1931, 1058, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1932, 1059, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1933, 1060, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1934, 1061, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1935, 1062, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1936, 1063, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1937, 1064, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1938, 1065, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1939, 1066, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1940, 1067, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1941, 1068, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1942, 1069, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1958, 1070, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1959, 1071, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1960, 1072, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1961, 1073, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1962, 1074, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1963, 1075, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1964, 1076, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1965, 1077, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1966, 1078, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1967, 1079, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1968, 1080, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1969, 1081, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1970, 1082, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1971, 1083, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1972, 1084, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1973, 1085, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1974, 1086, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1975, 1087, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1976, 1088, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1977, 1089, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1978, 1090, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1979, 1091, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1980, 1092, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1981, 1093, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1982, 1094, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1983, 1095, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1984, 1096, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1985, 1097, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1986, 1098, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1987, 1099, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1988, 1100, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1989, 1101, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1990, 1102, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1991, 1103, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1992, 1104, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1993, 1105, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1994, 1106, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1995, 1107, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1996, 1108, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1997, 1109, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1998, 1110, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 1999, 1111, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2000, 1112, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2001, 1113, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2002, 1114, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2003, 1115, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2004, 1116, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2005, 1117, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2006, 1118, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2007, 1119, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2008, 1120, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2009, 1121, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2010, 1122, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2011, 1123, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2012, 1124, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2013, 1125, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2014, 1126, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2015, 1127, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2016, 1128, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2017, 1129, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2018, 1130, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2019, 1131, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2020, 1132, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2021, 1133, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2022, 1134, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2023, 1135, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2024, 1136, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2025, 1137, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2026, 1138, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2027, 1139, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2028, 1140, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2029, 1141, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2030, 1142, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2031, 1143, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2032, 1144, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2033, 1145, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2034, 1146, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2035, 1147, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2036, 1148, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2037, 1149, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2038, 1150, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2039, 1151, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2040, 1152, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2041, 1153, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2042, 1154, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2043, 1155, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2044, 1156, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2045, 1157, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2046, 1158, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2047, 1159, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2048, 1160, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2049, 1161, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2050, 1162, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2051, 1163, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2052, 1164, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2053, 1165, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2054, 1166, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2055, 1167, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2056, 1168, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2057, 1169, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2058, 1170, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2059, 1171, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2060, 1172, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2061, 1173, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2062, 1174, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2063, 1175, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2064, 1176, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2065, 1177, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2066, 1178, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2067, 1179, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2068, 1180, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2069, 1181, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2070, 1182, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2071, 1183, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2072, 1184, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2073, 1185, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2074, 1186, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2075, 1187, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2076, 1188, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2077, 1189, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2078, 1190, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2079, 1191, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2080, 1192, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2081, 1193, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2082, 1194, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2083, 1195, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2084, 1196, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2085, 1197, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2086, 1198, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2087, 1199, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2088, 1200, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2089, 1201, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2090, 1202, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2091, 1203, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2092, 1204, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2093, 1205, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2094, 1206, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2095, 1207, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2096, 1208, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2097, 1209, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2098, 1210, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2099, 1211, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2100, 1212, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2101, 1213, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2117, 1214, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2118, 1215, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2119, 1216, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2120, 1217, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2121, 1218, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2122, 1219, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2123, 1220, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2124, 1221, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2125, 1222, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2126, 1223, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2127, 1224, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2128, 1225, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2129, 1226, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2130, 1227, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2131, 1228, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2132, 1229, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2148, 1230, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2149, 1231, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2150, 1232, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2151, 1233, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2152, 1234, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2153, 1235, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2154, 1236, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2155, 1237, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2156, 1238, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2157, 1239, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2158, 1240, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2159, 1241, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2160, 1242, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2161, 1243, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2162, 1244, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2163, 1245, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2164, 1246, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2165, 1247, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2166, 1248, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2167, 1249, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2168, 1250, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2169, 1251, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2170, 1252, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2171, 1253, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2172, 1254, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2173, 1255, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2174, 1256, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2175, 1257, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2176, 1258, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2177, 1259, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2178, 1260, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2179, 1261, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2195, 1262, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2196, 1263, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2197, 1264, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2198, 1265, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2199, 1266, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2200, 1267, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2201, 1268, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2202, 1269, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2203, 1270, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2204, 1271, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2205, 1272, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2206, 1273, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2207, 1274, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2208, 1275, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2209, 1276, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2210, 1277, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2226, 1278, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2227, 1279, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2228, 1280, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2229, 1281, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2230, 1282, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2231, 1283, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2232, 1284, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2233, 1285, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2234, 1286, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2235, 1287, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2236, 1288, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2237, 1289, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2238, 1290, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2239, 1291, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2240, 1292, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2241, 1293, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2242, 1294, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2243, 1295, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2244, 1296, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2245, 1297, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2246, 1298, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2247, 1299, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2248, 1300, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2249, 1301, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2250, 1302, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2251, 1303, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2252, 1304, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2253, 1305, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2254, 1306, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2255, 1307, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2256, 1308, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2257, 1309, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2273, 1310, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2274, 1311, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2275, 1312, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2276, 1313, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2277, 1314, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2278, 1315, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2279, 1316, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2280, 1317, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2281, 1318, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2282, 1319, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2283, 1320, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2284, 1321, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2285, 1322, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2286, 1323, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2287, 1324, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2288, 1325, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2289, 1326, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2290, 1327, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2291, 1328, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2292, 1329, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2293, 1330, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2294, 1331, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2295, 1332, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2296, 1333, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2297, 1334, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2298, 1335, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2299, 1336, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2300, 1337, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2301, 1338, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2302, 1339, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2303, 1340, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2304, 1341, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2320, 1342, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2321, 1343, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2322, 1344, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2323, 1345, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2324, 1346, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2325, 1347, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2326, 1348, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2327, 1349, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2328, 1350, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2329, 1351, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2330, 1352, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2331, 1353, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2332, 1354, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2333, 1355, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2334, 1356, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2335, 1357, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2351, 1358, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2352, 1359, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2353, 1360, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2354, 1361, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2355, 1362, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2356, 1363, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2357, 1364, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2358, 1365, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2359, 1366, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2360, 1367, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2361, 1368, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2362, 1369, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2363, 1370, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2364, 1371, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2365, 1372, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2366, 1373, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2367, 1374, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2368, 1375, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2369, 1376, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2370, 1377, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2371, 1378, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2372, 1379, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2373, 1380, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2374, 1381, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2375, 1382, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2376, 1383, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2377, 1384, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2378, 1385, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2379, 1386, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2380, 1387, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2381, 1388, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2382, 1389, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2398, 1390, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2399, 1391, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2400, 1392, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2401, 1393, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2402, 1394, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2403, 1395, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2404, 1396, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2405, 1397, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2406, 1398, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2407, 1399, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2408, 1400, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2409, 1401, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2410, 1402, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2411, 1403, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2412, 1404, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2413, 1405, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2414, 1406, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2415, 1407, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2416, 1408, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2417, 1409, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2418, 1410, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2419, 1411, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2420, 1412, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2421, 1413, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2422, 1414, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2423, 1415, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2424, 1416, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2425, 1417, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2426, 1418, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2427, 1419, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2428, 1420, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2429, 1421, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2430, 1422, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2431, 1423, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2432, 1424, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2433, 1425, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2434, 1426, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2435, 1427, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2436, 1428, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2437, 1429, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2438, 1430, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2439, 1431, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2440, 1432, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2441, 1433, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2442, 1434, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2443, 1435, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2444, 1436, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2445, 1437, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2461, 1438, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2462, 1439, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2463, 1440, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2464, 1441, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2465, 1442, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2466, 1443, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2467, 1444, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2468, 1445, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2469, 1446, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2470, 1447, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2471, 1448, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2472, 1449, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2473, 1450, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2474, 1451, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2475, 1452, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2476, 1453, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2492, 1454, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2493, 1455, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2494, 1456, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2495, 1457, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2496, 1458, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2497, 1459, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2498, 1460, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2499, 1461, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2500, 1462, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2501, 1463, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2502, 1464, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2503, 1465, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2504, 1466, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2505, 1467, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2506, 1468, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2507, 1469, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2508, 1470, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2509, 1471, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2510, 1472, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2511, 1473, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2512, 1474, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2513, 1475, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2514, 1476, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2515, 1477, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2516, 1478, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2517, 1479, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2518, 1480, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2519, 1481, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2520, 1482, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2521, 1483, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2522, 1484, 2961, 1);
INSERT INTO stage5.date_heure_disponible_autorite( id, id_date_heure_disponible, id_autorite, est_disponible ) VALUES ( 2523, 1485, 2961, 1);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 2, '2023-02-21', '2023-02-21', '09:30:00', '11:00:00', 2962);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 4, '2023-02-24', '2023-02-24', '10:30:00', '14:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 5, '2023-02-27', '2023-02-27', '09:00:00', '12:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 9, '2023-02-28', '2023-02-28', '08:30:00', '09:30:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 11, '2023-03-24', '2023-03-24', '10:30:00', '12:30:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 12, '2023-04-04', '2023-04-04', '09:00:00', '10:30:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 13, '2023-04-20', '2023-04-20', '12:00:00', '14:30:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 14, '2023-04-24', '2023-04-24', '09:30:00', '11:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 15, '2023-06-01', '2023-06-01', '08:30:00', '11:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 16, '2023-06-08', '2023-06-08', '09:00:00', '11:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 17, '2023-06-08', '2023-06-08', '09:00:00', '10:30:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 18, '2023-06-19', '2023-06-19', '12:00:00', '13:30:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 21, '2023-06-23', '2023-06-23', '14:00:00', '16:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 22, '2023-06-29', '2023-06-29', '10:00:00', '14:30:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 23, '2023-07-12', '2023-07-12', '09:30:00', '12:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 24, '2023-07-14', '2023-07-14', '11:30:00', '12:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 25, '2023-07-24', '2023-07-24', '11:00:00', '11:30:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 26, '2023-07-25', '2023-07-25', '09:00:00', '11:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 27, '2023-07-26', '2023-07-26', '11:00:00', '12:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 28, '2023-07-31', '2023-07-31', '11:30:00', '12:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 30, '2023-08-03', '2023-08-03', '09:30:00', '10:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 31, '2023-07-31', '2023-07-31', '12:30:00', '13:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 32, '2023-08-04', '2023-08-04', '10:00:00', '10:30:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 33, '2023-08-03', '2023-08-03', '10:00:00', '10:30:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 34, '2023-08-10', '2023-08-10', '10:00:00', '11:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 35, '2023-08-09', '2023-08-09', '11:30:00', '13:30:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 38, '2023-08-09', '2023-08-09', '09:30:00', '10:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 45, '2023-08-10', '2023-08-10', '12:30:00', '16:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 46, '2023-08-10', '2023-08-10', '08:00:00', '09:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 47, '2023-08-10', '2023-08-10', '11:30:00', '12:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 53, '2023-10-19', '2023-10-19', '12:00:00', '12:30:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 59, '2023-10-20', '2023-10-20', '08:30:00', '11:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 63, '2023-10-19', '2023-10-19', '09:30:00', '13:00:00', 2961);
INSERT INTO stage5.date_heure_non_disponible_autorite( id, date_debut, date_fin, heure_debut, heure_fin, id_autorite ) VALUES ( 65, '2023-10-17', '2023-10-17', '13:00:00', '13:30:00', 2961);
INSERT INTO stage5.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action, email, numero_telephone, sigle, child_libelle, est_termine ) VALUES ( 2, 2962, 'Dossier ministère à signer urgent', 1, 'dyranjohns@gmail.com', '0340221609', 'SJT', 'SERVICE JOHNS TEST', 0);
INSERT INTO stage5.demande_audience_autorite( id, id_autorite_enfant_sender, motif, action, email, numero_telephone, sigle, child_libelle, est_termine ) VALUES ( 3, 2962, 'Hi there there is one thing you can to do?', 1, 'dyranjohns@gmail.com', '0340221609', 'SJT', 'SERVICE JOHNS TEST', 0);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'Hi there', 27, 0, '112121212121', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'Johns', 'session647.4330458838675', 0, 0);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'Interview Real TV', 28, 2, null, '0341752875', 'johns.irintsoa@gmail.com', null, null, '0', 27613, 0);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'May be a little moment will make you better, then turn off your phone and focus on me\nThat''s how real couple do if they in love.', 29, 2, null, '0341752875', 'johnsirintsoa18@gmail.com', null, null, 'session647.4330458838675', 27617, 0);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'Le service SMS Connect permet de réaliser à partir d''une interface web simple et sécurisé, des envois massifs de SMS', 30, 2, null, '0341752875', 'johnsirintsoa18@gmail.com', null, null, 'session8.78256163977098', 27615, 0);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'Hi there is more thing to talk', 31, 1, '112112121121', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'Johns', 'session375.94902944338025', 0, 0);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'Misy convocation ministérielle aterina aty aminao', 34, 1, null, '0341752875', 'johnsirintsoa18@gmail.com', null, null, 'session375.94902944338025', 27616, 0);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'Interview RealTV', 35, 0, '112121221121', '0341752875', 'johnsirintsoa18@gmail.com', 'FENOSOA', 'Gascar', 'session375.94902944338025', 0, 0);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'Interview RealTV', 36, 0, '112112112121', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'Johns', 'session179.06674897816322', 0, 0);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'Je suis la. Et j''aimerai te voir', 37, 2, '111212121212', '0341752875', 'johns.irintsoa@gmail.com', 'RANDRIANARISON', 'Johns', 'session57.3809619231811', 0, 0);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'Je suis ici', 38, 1, '112121212121', '0341752875', 'johns@gmail.com', 'RANDRIANARISON', 'Johns', 'session57.3809619231811', 0, 0);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'Hlello world', 39, 2, null, '0341752875', 'johns.irintsoa@gmail.com', null, null, 'session550.0112760795653', 27613, 0);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'Hello world', 40, 1, '112112112122', '0341752875', 'johns.irintsoa@gmail.com', 'RANDRIANARISON', 'Johns', 'session302.13517341700214', 0, 0);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'Interview Real TV', 41, 0, '111111111111', '0341752875', 'johns.irintsoa@gmail.com', 'Gasikara', 'Fenosoa', 'session329.6930453769491', 0, 1);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'Hi talé how are you?', 42, 1, null, '0341752875', 'johnsirintsoa18@gmail.com', null, null, 'session329.6930453769491', 27613, 1);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'Firaisankinan''ny Tia Tanindrazana', 43, 1, '11211211311', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'Johns', 'session142.01682872823795', 0, 0);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'Interview Real TV', 44, 1, '112121211212', '0341752875', 'johnsirintsoa18@gmail.com', 'GASIKARA', 'Fenosoa', 'session142.01682872823795', 0, 1);
INSERT INTO stage5.demande_audience_public( motif, id, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_agent, est_termine ) VALUES ( 'Groupe sodiat', 45, 1, '112192819219', '0341752876', 'johns.irintsoa@gmail.com', 'RANDRIANARISON', 'Irintsoa', 'session142.01682872823795', 0, 1);
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 2, 2352, 2, '08:30:00', '09:00:00', '2023-08-11', '2023-08-11');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 7, 2467, 3, '11:00:00', '13:30:00', '2023-10-20', '2023-10-20');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 8, 2468, 3, '11:00:00', '13:30:00', '2023-10-20', '2023-10-20');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 9, 2469, 3, '11:00:00', '13:30:00', '2023-10-20', '2023-10-20');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 10, 2470, 3, '11:00:00', '13:30:00', '2023-10-20', '2023-10-20');
INSERT INTO stage5.dm_aud_autorite_date_heure_dispo( id, id_date_heure_disponible_autorite, id_dm_aud_autorite, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 11, 2471, 3, '11:00:00', '13:30:00', '2023-10-20', '2023-10-20');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 27, 2297, 27, '12:00:00', '12:30:00', '2023-08-10', '2023-08-10');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 28, 2292, 28, '09:30:00', '10:00:00', '2023-08-10', '2023-08-10');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 30, 2361, 38, '13:00:00', '14:00:00', '2023-08-11', '2023-08-11');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 30, 2362, 39, '13:00:00', '14:00:00', '2023-08-11', '2023-08-11');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 29, 2299, 47, '13:00:00', '14:30:00', '2023-08-10', '2023-08-10');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 29, 2300, 48, '13:00:00', '14:30:00', '2023-08-10', '2023-08-10');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 29, 2301, 49, '13:00:00', '14:30:00', '2023-08-10', '2023-08-10');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 31, 2291, 50, '09:00:00', '09:30:00', '2023-08-10', '2023-08-10');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 34, 2356, 53, '10:30:00', '11:00:00', '2023-08-11', '2023-08-11');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 35, 2295, 54, '11:00:00', '11:30:00', '2023-08-10', '2023-08-10');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 36, 2358, 55, '11:30:00', '12:00:00', '2023-08-11', '2023-08-11');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 37, 2380, 56, '14:30:00', '15:00:00', '2023-09-28', '2023-09-28');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 38, 2407, 58, '12:30:00', '14:00:00', '2023-09-29', '2023-09-29');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 38, 2408, 59, '12:30:00', '14:00:00', '2023-09-29', '2023-09-29');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 38, 2409, 60, '12:30:00', '14:00:00', '2023-09-29', '2023-09-29');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 39, 2374, 61, '11:30:00', '12:00:00', '2023-09-28', '2023-09-28');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 40, 2398, 62, '08:00:00', '08:30:00', '2023-09-29', '2023-09-29');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 41, 2414, 63, '08:00:00', '08:30:00', '2023-10-16', '2023-10-16');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 43, 2523, 65, '15:30:00', '16:00:00', '2023-10-19', '2023-10-19');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 45, 2498, 67, '11:00:00', '11:30:00', '2023-10-17', '2023-10-17');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 44, 2473, 90, '14:00:00', '15:00:00', '2023-10-20', '2023-10-20');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 44, 2474, 91, '14:00:00', '15:00:00', '2023-10-20', '2023-10-20');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 42, 2520, 106, '14:00:00', '15:00:00', '2023-10-19', '2023-10-19');
INSERT INTO stage5.dm_aud_public_date_heure_dispo( id_aud_public, id_date_heure_disponible_autorite, id, heure_debut, heure_fin, date_debut, date_fin ) VALUES ( 42, 2521, 107, '14:00:00', '15:00:00', '2023-10-19', '2023-10-19');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 1, 'session588.292160128779', null, 'sdfds', null, null, 'Hi dear, perhaps a little more rest and food will you be back at strength.', null, null, '2023-01-20', 2, '09:47:44', null, 'DIRECTION DES RESSOURCES HUMAINES');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 2, 'session753.1394602049512', null, 'sdfds', null, null, 'Hi it is me again. But this one i will address non anonymous, So remember me, here is my name my contacts, do not be late, but i can not stand to it anymore.', null, null, '2023-01-20', 2, '09:47:44', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 3, 'session428.0507486275105', null, 'Fafaa', null, null, 'fgfgsf', null, null, '2023-01-20', 2, '10:05:51', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 4, 'session428.0507486275105', null, 'Fafaa', null, null, 'fgfgsf', null, null, '2023-01-20', 2, '10:05:51', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 5, 'session781.9242674941864', null, 'Mauvaise comportement', null, null, 'Je suis un visiteur et jai constate que gkjfkgjkfgfg', null, null, '2023-01-20', 2, '10:10:43', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 6, 'session543.7488385071574', null, 'Ratsy fandraisana be ry zareo ', null, null, '', null, null, '2023-01-20', 1, '11:38:53', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 7, 'session570.4293885686607', null, 'CYCLONE', null, null, '', null, null, '2023-01-20', 1, '11:41:46', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 8, 'session307.8347883714374', null, 'sdfdsfdf', null, null, 'Hello world ', null, null, '2023-01-20', 1, '11:43:29', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 9, 'session524.3624453793367', null, 'Hello sunday', null, null, 'It raining today.', null, null, '2023-01-22', 3, '16:33:57', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 10, 'session524.3624453793367', null, 'Sunday', null, null, 'Hi sunday. Creating more and consumming less by Ruri ohama. The more you say no to the things doesnt matter the more you say yes to things that do', null, null, '2023-01-22', 3, '17:02:45', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 11, 'session373.19367097786846', null, 'Hi Monday', null, null, 'Hi i have checked all of my duty for tody and half of them was done', null, null, '2023-01-23', 3, '16:18:41', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 12, 'session373.19367097786846', null, 'Hi DGI', null, null, 'Mmmh you do not know me. How was last night. Have you dreamnt about me? Did I do my best? Have a good day Sweetie ???? ', null, null, '2023-01-23', 3, '16:20:58', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 13, 'session576.6437598202781', null, 'Monday 2', null, null, 'I am just here concern of people, perhaps i can offend any one of you but the more you know who and how i am, the more you have to be carefull of yourself.', null, null, '2023-01-23', 3, '16:41:35', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 14, 'session414.00372984251834', null, 'Monday 3', null, null, 'I am reapting myself sorry. The point is to release our comrade toward an amount of BitCoins. Are you in?', null, null, '2023-01-23', 3, '16:43:33', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 15, 'session518.4698767437472', null, 'Tuesday', null, null, 'Hi dear, perhaps a little more rest and food will you back at strength.', null, null, '2023-01-24', 3, '08:56:52', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 16, 'session518.4698767437472', null, 'Tuesday', null, null, 'Hi it is me again. But this one i will address non anonymous, So remember me, here is my name my contacts, do not late, but i can not stand to it anymore.', null, null, '2023-01-24', 3, '08:59:10', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 17, 'session518.4698767437472', null, 'Tuesday', null, null, 'Re-bonjour, today we will practice some of vary amin anana. it is a mixing languages, but not very helpful for ou education freedom, what i am saying, we are not in daily stoic, we are in boite à doléance. And yet, i am still wondering what is the purpose', null, null, '2023-01-24', 3, '10:44:43', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 18, 'session518.4698767437472', null, 'Tuesday', null, null, 'Mmmh, it was not completed. Half of message did not send, Good news,we have resolved the issues, but i have no clue what is going on, Afterwards i am just a person who want to disturb the organization hihihihihihihihi, Sorry you do not know who I am, I am just a girl with a wide thick, Love you Have good day, and one more thing, your wife can be good wife but never better on bed than me hahahahahahah just joking. Thank you to read', null, null, '2023-01-24', 3, '10:57:36', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 19, 'session948.1640243568852', null, 'Wednesday 2', null, null, 'Hi, i suppose it is news. So we should start a new test for today. Not today we are here to focus on the project.Good morning to you misy update kely', null, null, '2023-01-25', 3, '07:52:53', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 20, 'session948.1640243568852', null, 'Wednesday 1', null, null, 'Hello everyone we are not perfect at all. It is a test. Sit Beneath tree.', null, null, '2023-01-25', 3, '07:53:53', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 21, 'session948.1640243568852', null, 'Wednesday 3', null, null, 'Among us is the traitor, Why do argue you each other? there is non-sense, You should pay attention of everything, I do not care what is happening the only i want is calm and tranquilitty.Okay? Bye.', null, null, '2023-01-25', 3, '08:15:08', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 22, 'session701.2027086467638', null, 'Thursday night', null, null, 'It is a last test for today. I want to make sure about the popup show if it works. Good night to you adminstrator. Do not forget to pray, I love you ', null, null, '2023-01-26', 3, '22:25:56', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 23, 'session733.2137905238567', null, 'Friday', null, null, 'Test i want to see if it works perfectly but do not worry, behave a trustworthy not untrustworthy person okay, I lalalallalalalalalal love you kisss yo you ', null, null, '2023-01-27', 3, '15:22:40', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 24, 'session94.11554778211628', null, 'Monday 30', null, null, 'It is a test for us, I can not be your boyfriend', null, null, '2023-01-30', 3, '09:18:24', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 25, 'session545.7728144861633', null, 'Monday 30 part 2', null, null, 'Never skip work out time you will not regret it, otherwise be well', null, null, '2023-01-30', 3, '09:19:42', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 26, 'session887.9265175160962', null, 'Tuesday 5', null, null, 'Hello world. We are not here for you', null, null, '2023-01-31', 3, '14:39:02', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 28, 'session263.6617506296885', null, 'Tuesday 8', null, null, 'Hi you are not alon buddy I want you for everything in my life, So keep going you little brat, we need you, All of us need you.', null, null, '2023-01-31', 3, '15:14:21', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 29, 'session263.6617506296885', null, 'Tuesday 8', null, null, 'Hi you are not alone buddy I want you for everything in my life, So keep going you little brat, we need you, All of us need you.', null, null, '2023-01-31', 2, '15:16:43', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 30, 'session520.7831797049284', null, 'Wednesday 1st Ferbuary', null, null, 'MMmmh We made it right? We are february, January ended yesterday, Thinking fast and slow, that is the new chapter of this month. GOGOGOGOGOGOGOGO!!!!!!!!!!!!!', null, null, '2023-02-01', 3, '08:28:22', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 31, 'session125.44095828487345', null, 'Wednesday 2 ', null, null, 'Never give up, whether you are not win today perhaps the next day you will.', null, null, '2023-02-01', 3, '08:41:04', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 32, 'session177.36852525378555', null, 'Wednesday 3', null, null, 'You will  not survive, you are just suffocating us, There is no us, Since you ignore my presence for everything I have done many things changed', null, null, '2023-02-01', 3, '08:42:38', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 33, 'session765.2613752804665', null, 'Wednesday 5', null, null, 'I am here for you so open up, Crank up the bath,', null, null, '2023-02-01', 3, '09:44:00', null, null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 34, 'session793.0911453911575', null, 'Tuesday 2 February', null, null, 'Hi you there please tell me more', null, null, '2023-02-02', 204, '22:50:10', 'DRH', null);
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 35, 'session877.7483667099051', null, 'Friday 3 frebruary', null, null, 'you there mister', null, null, '2023-02-03', 204, '01:20:52', 'DRH', 'DIRECTION DES RESSOURCES HUMAINES');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 37, 'session753.1394602049512', null, 'FRIDAY 3 Morning', null, null, 'hI youzouzozuozuozuzouzou', null, null, '2023-02-03', 204, '08:37:48', 'DRH', 'DIRECTION DES RESSOURCES HUMAINES');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 38, 'session444.4484439094811', null, 'sgfgf', null, null, 'gsgfg', null, null, '2023-02-03', 204, '16:14:18', 'DRH', 'DIRECTION DES RESSOURCES HUMAINES');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 39, 'undefined', null, 'dvfdfvdfvd', null, null, 'htggfgh', null, null, '2023-02-03', 204, '16:23:07', 'DRH', 'DIRECTION DES RESSOURCES HUMAINES');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 40, 'session87.78130863522927', null, 'Tuesday 1', null, null, 'Hello to you DJT', null, null, '2023-02-07', 2961, '09:39:35', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 41, 'session87.78130863522927', null, 'Tuesday 2', null, null, 'You are never here when we need you, you betray us because you are selfish', null, null, '2023-02-07', 2961, '09:40:35', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 42, 'session87.78130863522927', null, 'Tuesday 3', null, null, 'Hello everyone, you make cum, I want just tell you.', null, null, '2023-02-07', 2961, '09:41:25', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 43, 'session187.2740160096724', null, 'Tuesday 4', null, null, 'Never come back, do not tell me the things i do not want to believe,', null, null, '2023-02-07', 2961, '09:42:02', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 44, 'session187.2740160096724', null, 'Tuesday 5', null, null, 'Go and never come back, go away from i do not need anymore, That is enough, I confess I want to join the part of lucifer mongstar', null, null, '2023-02-07', 2961, '09:43:19', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 45, 'session187.2740160096724', 'johns.irintsoa@gmail.com', 'Tuesday 5', '121121112111', '0341752875', 'Go and never come back, go away from i do not need anymore, That is enough, I confess I want to join the part of lucifer mongstar, Hope, I have never deny hope and i hope you too, Just tell me when and where you should see each other. Besides, I need to see you. ', 'RANDRIANARISON', 'Johns', '2023-02-07', 2961, '09:44:35', 'DJT', 'undefined');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 46, 'session123.07432559934273', null, 'FRIDAY Lasting test', null, null, 'You are here for everything Never tell us what to do', null, null, '2023-02-10', 2962, '07:49:47', 'SJT', 'SERVICE JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 47, 'session13.915653439517506', 'dyranjohns@gmail.com', 'Friday afternoon', 'null', '0341752875', 'Good afternoon everyone are you okay today?', 'RANDRIANARISON', 'Johns', '2023-02-24', 2961, '00:48:32', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 48, 'session795.9215920601614', null, 'Monday 19 April 2023 Move inhabituel', null, null, 'Still you work on it but before you get in it it will be more unsecured ', null, null, '2023-04-19', 2961, '12:16:48', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 51, 'session452.32807550561404', null, 'Monday 19 2', null, null, 'Hello world 192 ', null, null, '2023-04-19', 2961, '12:20:29', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 52, 'session797.3678398791784', 'johnsirintsoa18@gmail.com', 'Monday 19 3', '', '0341752875', 'Hello world everything you got in here', 'RANDRIANARISON', 'Johns', '2023-04-19', 2961, '12:20:59', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 53, 'session468.20943801861705', 'undefined', 'Monday 194', 'undefined', 'undefined', 'Hello world start over here never been alone so go on it', 'undefined', 'undefined', '2023-04-19', 2961, '12:23:43', 'DJT', 'undefined');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 54, 'session664.69182575371', 'johnsirintsoa18@gmail.com', 'Monday 19 9', 'null', '0341752875', 'Hi there', 'RANDRIANARISON', 'Johns', '2023-04-19', 2961, '12:32:36', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 55, 'session664.69182575371', null, 'Monday 19 9', null, null, 'Hi there', null, null, '2023-04-19', 2961, '12:33:38', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 56, 'session504.8519744320346', 'undefined', 'Monday 19 10', 'undefined', 'undefined', 'Hello world 34', 'undefined', 'undefined', '2023-04-19', 2961, '12:44:42', 'DJT', 'undefined');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 57, 'session229.1258464376027', 'johnsirintsoa18@gmail.com', 'KTO', '', '0341752875', 'lkdfjghfklgfkjgflkgfhgh', 'OSGHLGJFSLKGJFLKGJFL', 'LKGJFLKGJFLGJFLKG', '2023-04-19', 2961, '14:00:35', 'DJT', 'undefined');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 58, 'session229.1258464376027', 'johnsirintsoa18@gmail.com', 'CLKGJGJFJGHDJK', '', '0341752875', 'dfhjkgffkgfkgfjgfk', 'RANDRIANARISON', 'Johns', '2023-04-19', 2961, '14:03:02', 'DJT', 'undefined');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 59, 'session812.0841273788025', 'johnsirintsoa18@gmail.com', 'SLKGFLGFKLGJ', '', '0341752875', 'ljfkhfkgdjgknfngfhgklfjghfgf', 'RANDRIANARISON', 'Johns', '2023-04-19', 2961, '14:10:15', 'DJT', 'undefined');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 60, 'session218.68146505700926', 'johnsirintsoa18@gmail.com', 'JOLGJFKLGJFLKG', '', '0341752875', 'Hello world never release something obvious for certain person', 'RANDRIANARISON', 'Johns', '2023-04-19', 2961, '14:14:08', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 65, 'session989.9021934340484', 'johnsirintsoa18@gmail.com', 'Tale tsy tiako', 'null', '0340221609', 'Rehefa miresaka dia maimbo vava. Masiso elika', 'RANDRIANARISON', 'Andriamahefa Johnando Hertiana', '2023-04-19', 2961, '20:30:22', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 66, 'session120.87202397036224', null, 'Friday 19', null, null, 'Hello world we have fight to do', null, null, '2023-06-16', 2961, '10:02:56', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 67, 'session289.22751883233036', null, 'Wednesday 21 Jona', null, null, 'Hello world ', null, null, '2023-06-21', 2961, '16:44:11', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 68, 'session199.43210816661593', null, 'Doléance 1', null, null, 'Reraka ao miaka midina eo', null, null, '2023-07-10', 2961, '12:10:44', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 69, 'session199.43210816661593', 'dyranjohns@gmail.com', 'Doléance 2', '112112112112', '0341752875', 'Lasa lavitra loatra ', 'RANDRIANARISON', 'Johns', '2023-07-10', 2961, '12:11:19', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 70, 'session276.99444025865574', null, 'Doléance 1', null, null, 'Bonjour. Votre service d''accueil m''importume avec ces questions inutiles.', null, null, '2023-09-05', 2961, '17:17:23', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 71, 'session276.99444025865574', 'tsiky.nomena@yahoo.fr', 'Doléance 2', '112112111211', '0340221609', 'Les immobilisations de votre département manquent de rigueur', 'RABETOKOTANY', 'Tsiky Nomena', '2023-09-05', 2961, '17:19:16', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 72, 'session276.99444025865574', 'aingo.tantianah@gmail.com', 'Doléance 3', '112112111211', '0349518357', 'Ny fandraisana antonta taratasy dia mitaky ora maro vao tafavoaka ato aminareo', 'RAVOLOLONIRINA', 'Aingo Tantianah', '2023-09-05', 2961, '17:22:01', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 73, 'session811.9985758524062', null, 'Fandraisana', null, null, 'Lahy be daholo izy ireo. Ka samy sahirana eo amin''ny solosaina avokoa izy ireo', null, null, '2023-10-11', 2961, '14:29:45', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 74, 'session811.9985758524062', null, 'Ratsy fandraisana', null, null, 'Toy ny tsy misy olona rehefa mankao ao aminareo', null, null, '2023-10-11', 2961, '14:33:17', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 75, 'session683.3771411872402', null, 'Doléance 1 du 11/10/2023', null, null, 'Fitiavana ranovelona', null, null, '2023-10-11', 2961, '14:34:12', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 76, 'session226.56552553578345', null, 'Doléance 2 11/10/2023', null, null, 'Raha azo atao tompoko dia iangaviana mba amin''ny ora maha eo an''i talé no andalavoko', null, null, '2023-10-11', 2961, '14:41:37', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 77, 'session226.56552553578345', null, 'Doléance 3 11/10/2023', null, null, 'Tsy ampy ny seza ao aminareo.', null, null, '2023-10-11', 2961, '14:42:50', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 78, 'session665.6774429851966', null, 'Doléance 4 11/10/2023', null, null, 'Rehefa mitady an''ilay personnel ao aminareo dia tsy maintsy miandry kely satria lasa nivoka kely', null, null, '2023-10-11', 2961, '15:25:30', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 79, 'session948.4131059464171', null, 'Doléance 6', null, null, 'Tsy milamina ato', null, null, '2023-10-11', 2961, '15:32:25', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 80, 'session637.6723078077564', null, 'Doléance 8', null, null, 'Mitabataba loatra ', null, null, '2023-10-11', 2961, '15:39:52', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 81, 'session87.80217259213563', null, 'Doléance 4', null, null, 'Serieux an', null, null, '2023-10-11', 2961, '15:45:32', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 82, 'session363.6688275898754', null, 'Doléance ', null, null, 'Hi there ', null, null, '2023-10-11', 2961, '15:57:41', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 83, 'session883.4617648244987', null, 'Doléance 6 ', null, null, 'Hi there 2', null, null, '2023-10-11', 2961, '16:02:56', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 84, 'session883.4617648244987', null, 'Doléance I don''t know ', null, null, 'Hi there ', null, null, '2023-10-11', 2961, '16:04:41', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 85, 'session823.1143629060058', null, 'Test Are you in there please go on', null, null, 'Hi everyone', null, null, '2023-10-11', 2961, '16:06:09', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 86, 'session592.4507304160525', null, 'Hi ', null, null, 'Hi', null, null, '2023-10-11', 2961, '16:12:13', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 87, 'session592.4507304160525', null, 'fa', null, null, 'af', null, null, '2023-10-11', 2961, '16:13:05', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 88, 'session650.9686568372413', null, 'Doleance 1', null, null, 'Hi there', null, null, '2023-10-12', 2961, '08:14:31', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 89, 'session650.9686568372413', null, 'Doléace 1', null, null, 'hi ', null, null, '2023-10-12', 2961, '08:41:37', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 90, 'session925.5322619641478', null, 'Doléance ', null, null, 'Djt', null, null, '2023-10-12', 2961, '14:51:06', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 91, 'session925.5322619641478', null, 'Didi', null, null, 'Oraf', null, null, '2023-10-12', 2961, '14:51:37', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 92, 'session925.5322619641478', null, 'Didi', null, null, 'Oraf', null, null, '2023-10-12', 2961, '14:51:58', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 93, 'session629.3339740906894', null, 'Hi every one', null, null, 'There', null, null, '2023-10-12', 2961, '15:22:31', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 94, 'session629.3339740906894', null, 'New Castle', null, null, 'Mamam', null, null, '2023-10-12', 2961, '15:22:53', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.doleance( id, session_navigateur, e_mail, titre, cin, numero_telephone, message, nom, prenom, date_publication, id_autorite, heure_publication, sigle, child_libelle ) VALUES ( 95, 'session629.3339740906894', null, 'New Castle', null, null, 'Mamam', null, null, '2023-10-12', 2961, '15:22:55', 'DJT', 'DIRECTION JOHNS TEST');
INSERT INTO stage5.domaine( id, nom_domaine ) VALUES ( 1, 'Informatique');
INSERT INTO stage5.domaine( id, nom_domaine ) VALUES ( 2, 'Marketing');
INSERT INTO stage5.domaine( id, nom_domaine ) VALUES ( 3, 'Finances et comptabilité');
INSERT INTO stage5.domaine( id, nom_domaine ) VALUES ( 4, 'Communication Marketing');
INSERT INTO stage5.domaine( id, nom_domaine ) VALUES ( 5, 'Droit privé');
INSERT INTO stage5.domaine( id, nom_domaine ) VALUES ( 6, 'Droit public');
INSERT INTO stage5.domaine( id, nom_domaine ) VALUES ( 7, 'Ressource Humaines');
INSERT INTO stage5.domaine( id, nom_domaine ) VALUES ( 8, 'Management des affaires');
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 8, 1414, 2);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 9, 1415, 2);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 10, 1416, 2);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 18, 1509, 4);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 19, 1510, 4);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 20, 1511, 4);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 21, 1512, 4);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 22, 1513, 4);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 23, 1514, 4);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 24, 1515, 4);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 25, 1538, 5);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 26, 1539, 5);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 27, 1540, 5);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 28, 1541, 5);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 29, 1542, 5);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 30, 1543, 5);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 57, 1568, 9);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 58, 1569, 9);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 74, 1682, 11);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 75, 1683, 11);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 76, 1684, 11);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 77, 1685, 11);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 78, 1757, 12);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 79, 1758, 12);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 80, 1759, 12);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 99, 1810, 13);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 100, 1811, 13);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 101, 1812, 13);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 102, 1813, 13);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 103, 1814, 13);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 104, 1883, 14);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 105, 1884, 14);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 106, 1885, 14);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 107, 1897, 15);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 108, 1898, 15);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 109, 1899, 15);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 110, 1900, 15);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 111, 1901, 15);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 116, 1992, 17);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 117, 1993, 17);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 118, 1994, 17);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 119, 2014, 18);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 120, 2015, 18);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 121, 2016, 18);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 126, 2034, 21);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 127, 2035, 21);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 128, 2036, 21);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 129, 2037, 21);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 133, 2042, 22);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 134, 2043, 22);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 135, 2044, 22);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 136, 2045, 22);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 137, 2046, 22);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 138, 2047, 22);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 139, 2048, 22);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 140, 2049, 22);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 141, 2050, 22);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 143, 2057, 23);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 144, 2058, 23);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 145, 2059, 23);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 146, 2060, 23);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 147, 2061, 23);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 148, 2077, 24);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 149, 2092, 25);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 150, 2119, 26);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 151, 2120, 26);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 152, 2121, 26);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 153, 2122, 26);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 157, 2154, 27);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 158, 2155, 27);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 159, 2171, 28);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 164, 2173, 31);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 165, 2246, 32);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 166, 2277, 33);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 167, 2293, 34);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 168, 2294, 34);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 170, 2327, 35);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 171, 2328, 35);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 172, 2329, 35);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 173, 2330, 35);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 223, 2323, 38);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 257, 2298, 45);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 258, 2299, 45);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 259, 2300, 45);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 260, 2301, 45);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 261, 2302, 45);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 262, 2303, 45);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 263, 2304, 45);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 264, 2289, 46);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 265, 2290, 46);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 267, 2296, 47);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 349, 2462, 59);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 350, 2463, 59);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 351, 2464, 59);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 352, 2465, 59);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 353, 2466, 59);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 421, 2511, 63);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 422, 2512, 63);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 423, 2513, 63);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 424, 2514, 63);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 425, 2515, 63);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 426, 2516, 63);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 427, 2517, 63);
INSERT INTO stage5.pas_disponible( id, id_date_heure_disponible_autorite, id_date_heure_non_disponible_autorite ) VALUES ( 429, 2502, 65);
INSERT INTO stage5.autorite_enfant( id, intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ( 1, 'Direction des Ressources Humaines', 'DRH', 2, 'johns.irintsoa@gmail.com', 'wswrgxbntbumffqs', '356');
INSERT INTO stage5.autorite_enfant( id, intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ( 2, 'Direction des Systèmes d''Informations', 'DSI', 2, 'dyranjohns@gmail.com', 'wswrgxbntbumffqs', '413');
INSERT INTO stage5.autorite_enfant( id, intitule, intitule_code, id_autorite_parent, addresse_electronique, mot_de_passe_mailing, porte ) VALUES ( 3, 'Direction Générales des Impots', 'DGI', 2, 'mefstage2022@gmail.com', 'wswrgxbntbumffqs', '123');
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 43, 'RANDRIANARISON', 'Johns', '0341752875', 'dyranjohns@gmail.com', '', 5, 'curriculum_vitae_1677657292707_kamasutra.pdf', 'lettre_motivation_1677657292782_kamasutra.pdf', 'lettre_introduction_1677657292789_kamasutra.pdf', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 1, 2961, '2023-03-01', 2, 'ITU', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 44, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '112112112112', 3, 'curriculum_vitae_1679550112166_file.pdf', 'lettre_motivation_1679550112206_file.pdf', 'lettre_introduction_1679550112227_file.pdf', 'Je suis un élève en 3eme année  à ITU, Je suis à la recherche d''un stage de 3 mois et votre organisation m''a semblé l''idéal pour acquérir de potentiel.', 1, 2961, '2023-03-23', 2, 'ITU', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 45, 'RAKOTONIRINA', 'Teo', '0341752875', 'dyranjohns@gmail.com', '552552552552', 1, 'curriculum_vitae_1679550415964_file.pdf', 'lettre_motivation_1679550415973_file.pdf', 'lettre_introduction_1679550415981_file.pdf', 'Je suis un étudiant 2 eme annee chez l''ISCAM j''aimerai acquérir de compétence chez vous.', 2, 2961, '2023-03-23', 2, 'ISCAM', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 46, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '112112112112', 3, 'curriculum_vitae_1681904863675_file.pdf', 'lettre_motivation_1681904863891_file.pdf', 'lettre_introduction_1681904863920_file.pdf', 'Hi and never come back again ', 2, 2961, '2023-04-19', 2, 'ITU', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 47, 'RANDRIANARISON', 'Johns', '0341752875', 'johns.irintsoa@gmail.com', '', 3, 'curriculum_vitae_1686152154125_Profile.pdf', 'lettre_motivation_1686152154126_Profile.pdf', 'lettre_introduction_1686152154126_Profile.pdf', 'Hahahaha', 1, 2961, '2023-06-07', 2, '', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 48, 'RANDRIANARISON', 'Johns', '0341752875', 'johns.irintsoa@gmail.com', '112112112112', 2, 'curriculum_vitae_1687516222531_Profile.pdf', 'lettre_motivation_1687516222533_Profile.pdf', 'lettre_introduction_1687516222534_Profile.pdf', 'Je suis un élève de 3eme année de licence', 1, 2961, '2023-06-23', 1, 'ITU', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 49, 'RANDRIANARISON', 'Johns', '0341752875', 'johns.irintsoa@gmail.com', '112112112112', 1, 'curriculum_vitae_1687517605703_Profile.pdf', 'lettre_motivation_1687517605705_Profile.pdf', 'lettre_introduction_1687517605705_Profile.pdf', 'Hi DRH', 2, 2961, '2023-06-23', 2, 'ITU', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 50, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '552552552552', 3, 'curriculum_vitae_1687940161657_Profile.pdf', 'lettre_motivation_1687940161663_Profile.pdf', 'lettre_introduction_1687940161664_Profile.pdf', 'Candidats stagiaire te hanandrato fianarana ary ampiatra ny fahazaiko nandritra ny taom-pianarana ako aho', 1, 2961, '2023-06-28', 2, 'Johns', 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 51, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 7, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 52, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 7, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 53, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 7, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 54, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 8, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 55, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 8, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 56, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 8, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 57, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 8, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 58, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 8, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 59, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 8, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 60, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 8, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 61, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 4, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 62, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 4, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 63, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 5, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 64, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 5, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 65, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 5, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 66, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 5, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 67, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 5, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 68, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 5, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 69, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 5, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 70, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 5, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 71, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 5, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 72, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 6, 2961, '2023-08-18', 1, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 73, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 6, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 74, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 6, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 75, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 6, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 76, 'RANDRIANARISON', 'Johns', '0341752875', 'johnsirintsoa18@gmail.com', '28371947394738', 3, 'haha', 'haha', 'haha', 'Stay here', 6, 2961, '2023-08-18', 0, null, 0);
INSERT INTO stage5.demande_stage( id, nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant, date_creation, action, etablissement, est_termine ) VALUES ( 77, 'ANDRIAMAMINAIVO ', 'Idéale Liantsoa', '0349870961', 'ideale.liantsoa@gmail.com', '112111211211', 3, 'curriculum_vitae_1695821028455_johns.pdf', 'lettre_motivation_1695821028913_johns.pdf', 'lettre_introduction_1695821029000_johns.pdf', 'Je suis une étudiante en 3 ème année en communication marketing.', 4, 2961, '2023-09-27', 1, 'MCCI', 1);
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '08:30:00', '09:30:00', 172, 45, 1678, '2023-03-24', '2023-03-24');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '08:30:00', '09:30:00', 173, 45, 1679, '2023-03-24', '2023-03-24');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '13:00:00', '14:00:00', 178, 44, 1687, '2023-03-24', '2023-03-24');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '13:00:00', '14:00:00', 179, 44, 1688, '2023-03-24', '2023-03-24');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '14:30:00', '15:00:00', 181, 49, 2035, '2023-06-23', '2023-06-23');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '11:30:00', '12:00:00', 182, 50, 2045, '2023-06-29', '2023-06-29');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '13:00:00', '13:30:00', 183, 47, 2064, '2023-07-12', '2023-07-12');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '15:00:00', '15:30:00', 184, 48, 2365, '2023-08-11', '2023-08-11');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '09:30:00', '10:30:00', 188, 72, 2401, '2023-09-29', '2023-09-29');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '09:30:00', '10:30:00', 189, 72, 2402, '2023-09-29', '2023-09-29');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '15:00:00', '16:00:00', 190, 77, 2475, '2023-10-20', '2023-10-20');
INSERT INTO stage5.entretien_demande_stage( heure_debut, heure_fin, id, id_demande_stage, id_date_heure_disponible_autorite, date_debut, date_fin ) VALUES ( '15:00:00', '16:00:00', 191, 77, 2476, '2023-10-20', '2023-10-20');
INSERT INTO stage5.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'porte356', 'porte356@gmail.com', 1, 1, 1);
INSERT INTO stage5.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'tale356', 'tale356@gmail.com', 2, 0, 1);
INSERT INTO stage5.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'porteDSI', 'porteDSI@gmail.com', 3, 1, 2);
INSERT INTO stage5.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'tale414', 'tale414@gmail.com', 5, 0, 2);
INSERT INTO stage5.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'jean', 'jean', 6, 1, 3);
INSERT INTO stage5.profil( mot_de_passe, nom_utilisateur, id, est_administrateur, id_autorite_enfant ) VALUES ( 'taleDGI', 'taleDGI', 7, 0, 3);