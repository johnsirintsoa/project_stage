CREATE  PROCEDURE `modifier_entretien_stage_calendrier`(IN id_entretien_stage int,IN id_demande_stage INT,IN date_debut date,IN date_fin date,IN heure_debut time,in heure_fin time, IN id_autorite INT)
BEGIN
	set @id_autorite = id_autorite;
	
	SET @hd = SUBTIME(heure_debut,"-00:01:00");
	SET @hf = SUBTIME(heure_fin,"00:01:00");

	set @timestamp_debut = timestamp(concat(date_debut,' ',SUBTIME(@hd,"03:00:00")));
	set @timestamp_fin = timestamp(concat(date_fin,' ',SUBTIME(@hf,"03:00:00")));
	
	set @id_dm_stage = id_demande_stage;
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
			DELETE FROM stage5.entretien_demande_stage where id_demande_stage = @id_dm_stage;
			CALL `ajouter_entretien_stage_date_heure_dispo_entre_deux_date`( id_demande_stage ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
		END IF;
	ELSEIF date_debut < date_fin THEN
		DELETE FROM entretien_demande_stage where id_demande_stage = id_demande_stage;
		CALL `verifier_date_heure_dispo_entre_deux_dates`(date_debut, date_fin, @id_autorite);
		CALL `ajouter_entretien_stage_date_heure_dispo_entre_deux_date`( id_demande_stage ,date_debut , date_fin , heure_debut ,heure_fin ,@id_autorite );
	END IF;
	
	UPDATE demande_stage set action = 1 WHERE id = id_demande_stage;
END