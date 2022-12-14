/*
    * Ajouter heure audience disponible autorite Manuellement
    * Ex: 
        jour: Monday 
        heure_debut: 08:00:00 
        heure_fin: 12:00:00 
        duree_disponibilite: 00:30:00
        id_jour_ouvrable: 157
*/
CREATE  PROCEDURE `ajouter_heure_audience_disponible_autorite`(heure_debut time,heure_fin time,duree_disponibilite time,id_jour_ouvrable int)
BEGIN
	DECLARE hds,hfs,das INT;
	DECLARE tmp_hfs int DEFAULT 0;
	set @hds = time_to_sec(heure_debut);
	set @hfs = time_to_sec(heure_fin);
	set @das = time_to_sec(duree_disponibilite);
	WHILE @hds < @hfs DO
		set @tmp_hfs = @hds + @das;
		-- INSERT INTO stage2.heure_audience_disponible(heure_debut, heure_fin, id_jour_ouvrable) VALUES (sec_to_time(@hds),sec_to_time(@tmp_hfs),id_jour_ouvrable);
		SELECT @hds,@hfs,@das,@tmp_hfs;
        set @hds = @tmp_hfs;
	END WHILE;
END

-- Donnée de test demande_audience_public
INSERT INTO stage2.demande_audience_public
(date_event_debut, motif, date_event_fin, time_event_debut, time_event_fin, action, cin, numero_telephone, email, nom, prenom, session_navigateur, id_heure_audience_disponible) VALUES 
( '2022-11-28', 'TEST 2510','2022-11-28', '08:10:00', '08:15:00', 0, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'johns', 'session669.8439904355946',1),
( '2022-11-28', 'Test 21','2022-11-28', '08:20:00', '08:30:00', 1, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'johns', 'session36.35297770114687',1),
( '2022-11-28', 'TEST 9 Novembre','2022-11-28', '08:40:00', '08:50:00', 0, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'session898.2515433898981',2),
( '2022-11-28', 'TEST 15 Novembre','2022-11-28', '08:55:00', '09:00:00', 1, '112112112', '0341752875', 'johnsirintsoa18@gmail.com', 'RANDRIANARISON', 'johns', 'session669.8439904355946',2),
( '2022-11-28', 'Resaka matotra', '2022-11-28', '09:10:00', '09:20:00', 0, '112112112', '0385699878', 'fifidia@gmail.com', 'RAKOTONIRINA', 'Teo', 'session36.35297770114687',3),
( '2022-11-28', 'Resaka matotra', '2022-11-28', '09:25:00', '09:30:00', 2, '112112112', '0385699878', 'fifidia@gmail.com', 'RAKOTONIRINA', 'Teo', 'session36.35297770114687',3);


-- Donnée de test demande_audience_autorite
INSERT INTO stage2.demande_audience_autorite( date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, motif, action, id_heure_audience_disponible ) VALUES ('2022-11-28', '2022-11-28', '15:00:00', '15:30:00', 1, 'Hello world', 0,29);
INSERT INTO stage2.demande_audience_autorite( date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, motif, action, id_heure_audience_disponible ) VALUES ('2022-11-28', '2022-11-28', '14:10:00', '14:40:00', 2, 'TEST', 1,27);
INSERT INTO stage2.demande_audience_autorite( date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, motif, action, id_heure_audience_disponible ) VALUES ('2022-11-28', '2022-11-28', '14:45:00', '15:10:00', 3, 'TAEST', 1,28);
INSERT INTO stage2.demande_audience_autorite( date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, motif, action, id_heure_audience_disponible ) VALUES ('2022-11-28', '2022-11-28', '15:40:00', '15:50:00', 3, 'TEAWST', 0,30);
INSERT INTO stage2.demande_audience_autorite( date_debut, date_fin, time_debut, time_fin, id_autorite_enfant_sender, motif, action, id_heure_audience_disponible ) VALUES ('2022-11-28', '2022-11-28', '15:30:00', '15:40:00', 2, 'Dossier maika', 0,30);

-- Donnée de test non_disponible_date
INSERT INTO stage2.non_disponibilite_autorite_date( date_non_dispo_debut, date_non_dispo_fin, id_autorite_enfant, time_debut, time_fin ) VALUES ( '2022-11-28', '2022-11-28', 1, '08:00:00', '08:40:00');
INSERT INTO stage2.non_disponibilite_autorite_date( date_non_dispo_debut, date_non_dispo_fin, id_autorite_enfant, time_debut, time_fin ) VALUES ( '2022-11-28', '2022-11-28', 1, '10:10:00', '10:40:00');


-- Donnée de test non_disponible_jour
INSERT INTO stage2.non_disponibilite_autorite_jour( jour, time_non_dispo_jour_debut, time_non_dispo_jour_fin, id_autorite_enfant ) VALUES ('Monday', '13:00:00', '14:00:00', 1);
INSERT INTO stage2.non_disponibilite_autorite_jour( jour, time_non_dispo_jour_debut, time_non_dispo_jour_fin, id_autorite_enfant ) VALUES ('Wednesday', '15:30:00', '16:00:00', 1);

-- Donnée de test domaine
INSERT INTO stage2.domaine( nom_domaine ) VALUES ('Informatique');
INSERT INTO stage2.domaine( nom_domaine ) VALUES ('Marketing');
INSERT INTO stage2.domaine( nom_domaine ) VALUES ('Finances et comptabilité');
INSERT INTO stage2.domaine( nom_domaine ) VALUES ('Communication Marketing');

-- Donnée de test demande entretien
INSERT INTO stage2.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('RANDRIANARISON', 'Johns', '341777887', 'johnsirintsoa18@gmail.com', '112112112', 4, 'curriculum_vitae_1668365659799_decret_782_96.pdf', 'lettre_motivation_1668365659804_decret_782_96.pdf', 'lettre_introduction_1668365659808_decret_782_96.pdf', 'Je suis un étudiant en première année', 2, 1);
INSERT INTO stage2.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('RAKOTONIRINA', 'Teo', '348899966', 'teo@gmail.com', '112112112', 5, 'curriculum_vitae_1668366150840_Les nombres rationnels.pdf', 'lettre_motivation_1668366150968_Les nombres rationnels.pdf', 'lettre_introduction_1668366150973_Les nombres rationnels.pdf', 'Je suis désolé', 3, 3);
INSERT INTO stage2.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('RANAIVOSOA', 'Tiana', '348899966', 'teo@gmail.com', '112112112', 5, 'curriculum_vitae_1668366340054_Les nombres rationnels.pdf', 'lettre_motivation_1668366340061_Les nombres rationnels.pdf', 'lettre_introduction_1668366340067_Les nombres rationnels.pdf', 'Je suis désolé', 3, 1);
INSERT INTO stage2.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('NAIVOSOA', 'Nirina', '345677889', 'naivosoa@gmail.com', '112112112', 3, 'curriculum_vitae_1668400143631_Les nombres rationnels.pdf', 'lettre_motivation_1668400143714_Les nombres rationnels.pdf', 'lettre_introduction_1668400143721_Les nombres rationnels.pdf', 'Je suis la ', 1, 2);
INSERT INTO stage2.demande_stage( nom, prenom, telephone, e_mail, cin, duree, curriculum_vitae, lettre_motivation, lettre_introduction, message, id_domaine, id_autorite_enfant ) VALUES ('FIFIDIA', 'Fy', '345677889', 'fifidia@gmail.com', '112112112', 4, 'curriculum_vitae_1668402706992_Les nombres rationnels.pdf', 'lettre_motivation_1668402707078_Les nombres rationnels.pdf', 'lettre_introduction_1668402707083_Les nombres rationnels.pdf', 'bring it on', 4, 1);

/*
    * Liste de tous les places disponibles 
        ** Ny atao hoe disponible dia izay heure_audience_disponible null
        ** Raha ohatra ka hoe misy evenement an'ilay place 
            nefan null koa ilay izy dia tsy disponible koa ilay izy izay
        ** Dia tsy misy evenement hafa 
            ohatra :
                - audience_autorite, 
                - audience_public,
                - non_dispo_jour,
                - non_dispo_date,
                - jour_ferie
*/

-- Version 2
CREATE PROCEDURE `liste_place_disponible_public_par_jour`(IN date_du_jour date,IN session_navigateur varchar(50),in id_autorite int)
BEGIN
    SET @id_autorite = id_autorite;
    SET @session_navigateur = session_navigateur;
    SET @date_du_jour = date_du_jour;
    set @jour_UTF8 = CONVERT(DAYNAME(@date_du_jour) USING utf8);

    SELECT 
    had.*,
    dap.*
    FROM
    stage2.heure_audience_disponible had
    JOIN stage2.demande_audience_public dap on had.id = dap.id_heure_audience_disponible
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
    stage2.heure_audience_disponible had
    LEFT JOIN stage2.demande_audience_public dap on had.id = dap.id_heure_audience_disponible
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
    )
END

CREATE PROCEDURE `liste_place_disponible_autorite_par_jour`(IN date_du_jour date,in id_autorite_sender int,in id_autorite_receiver int)
BEGIN
    SET @id_autorite_receiver = id_autorite_receiver;
    SET @id_autorite_sender = id_autorite_sender;
    SET @session_navigateur = session_navigateur;
    SET @date_du_jour = date_du_jour;
    set @jour_UTF8 = CONVERT(DAYNAME(@date_du_jour) USING utf8);

    SELECT 
    had.*,
    dap.*
    FROM
    stage2.heure_audience_disponible had
    JOIN stage2.demande_audience_autorite daa on had.id = dap.id_heure_audience_disponible
    WHERE
    daa.date_event_debut = @date_du_jour
    and daa.
    UNION
    SELECT 
    had.*,
    dap.*
    FROM
    stage2.heure_audience_disponible had
    LEFT JOIN stage2.demande_audience_public dap on had.id = dap.id_heure_audience_disponible
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
        and ndad.id_autorite_enfant = @id_autorite_receiver	
        and ndad.date_non_dispo_debut = @date_du_jour
        and ndad.date_non_dispo_fin = @date_du_jour
        and had.heure_debut between SUBTIME(ndad.time_debut,"-00:01:00") and SUBTIME(ndad.time_fin,"00:01:00")
        and had.heure_fin between SUBTIME(ndad.time_debut,"-00:01:00") and SUBTIME(ndad.time_fin,"00:01:00")
		and ndad.time_debut between jo.time_debut and jo.time_fin
		and ndad.time_fin between jo.time_debut and jo.time_fin
        or
        jo.jour = @jour_UTF8
        and ndad.id_autorite_enfant = @id_autorite_receiver	
        and ndad.date_non_dispo_debut = @date_du_jour
        and ndad.date_non_dispo_fin = @date_du_jour
        and SUBTIME(ndad.time_debut,"-00:01:00") between had.heure_debut and had.heure_fin
        and SUBTIME(ndad.time_fin,"00:01:00") between had.heure_debut and had.heure_fin
		and ndad.time_debut between jo.time_debut and jo.time_fin
		and ndad.time_fin between jo.time_debut and jo.time_fin
        or
        jo.jour = @jour_UTF8
        and ndad.id_autorite_enfant = @id_autorite_receiver	
        and ndad.date_non_dispo_debut = @date_du_jour
        and ndad.date_non_dispo_fin = @date_du_jour
        and SUBTIME(ndad.time_debut,"-00:01:00") between had.heure_debut and had.heure_fin
		and ndad.time_debut between jo.time_debut and jo.time_fin
		and ndad.time_fin between jo.time_debut and jo.time_fin
        or
        jo.jour = @jour_UTF8
        and ndad.id_autorite_enfant = @id_autorite_receiver	
        and ndad.date_non_dispo_debut = @date_du_jour
        and ndad.date_non_dispo_fin = @date_du_jour
        and SUBTIME(ndad.time_fin,"00:01:00") between had.heure_debut and had.heure_fin
		and ndad.time_debut between jo.time_debut and jo.time_fin
		and ndad.time_fin between jo.time_debut and jo.time_fin
        or 
        -- Non disponible jour
        ndaj.id_autorite_enfant = @id_autorite_receiver	
        and jo.jour = @jour_UTF8
        and ndaj.jour = @jour_UTF8
        and had.heure_debut between SUBTIME(ndaj.time_non_dispo_jour_debut,"-00:01:00") and SUBTIME(ndaj.time_non_dispo_jour_fin,"00:01:00")
        and had.heure_fin between SUBTIME(ndaj.time_non_dispo_jour_debut,"-00:01:00") and SUBTIME(ndaj.time_non_dispo_jour_fin,"00:01:00")
		and ndaj.time_non_dispo_jour_debut between jo.time_debut and jo.time_fin
		and ndaj.time_non_dispo_jour_fin between jo.time_debut and jo.time_fin
        or
        ndaj.id_autorite_enfant = @id_autorite_receiver	
        and jo.jour = @jour_UTF8
        and ndaj.jour = @jour_UTF8
        and SUBTIME(ndaj.time_non_dispo_jour_debut,"-00:01:00") between had.heure_debut and had.heure_fin
        and SUBTIME(ndaj.time_non_dispo_jour_fin,"-00:01:00") between had.heure_debut and had.heure_fin
		and ndaj.time_non_dispo_jour_debut between jo.time_debut and jo.time_fin
		and ndaj.time_non_dispo_jour_fin between jo.time_debut and jo.time_fin
        or
        ndaj.id_autorite_enfant = @id_autorite_receiver	
        and ndaj.jour  = @jour_UTF8
        and jo.jour = @jour_UTF8
        and SUBTIME(ndaj.time_non_dispo_jour_debut,"-00:01:00") between had.heure_debut and had.heure_fin
		and ndaj.time_non_dispo_jour_debut between jo.time_debut and jo.time_fin
		and ndaj.time_non_dispo_jour_fin between jo.time_debut and jo.time_fin
        or
        ndaj.id_autorite_enfant = @id_autorite_receiver	
        and ndaj.jour  = @jour_UTF8
        and jo.jour = @jour_UTF8
        and SUBTIME(ndaj.time_non_dispo_jour_fin,"00:01:00") between had.heure_debut and had.heure_fin
		and ndaj.time_non_dispo_jour_debut between jo.time_debut and jo.time_fin
		and ndaj.time_non_dispo_jour_fin between jo.time_debut and jo.time_fin
        -- Demande Entretien
        or
        jo.id_autorite = @id_autorite_receiver
        and ds.id_autorite_enfant = @id_autorite_receiver	
        and eds.date_debut = @date_du_jour
        and eds.date_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and had.heure_debut between SUBTIME(eds.time_debut,"-00:01:00") and SUBTIME(eds.time_fin,"00:01:00")
        and had.heure_fin between SUBTIME(eds.time_debut,"-00:01:00") and SUBTIME(eds.time_fin,"00:01:00")
		and eds.time_debut between jo.time_debut and jo.time_fin
		and eds.time_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite = @id_autorite_receiver
        and ds.id_autorite_enfant = @id_autorite_receiver	
        and eds.date_debut = @date_du_jour
        and eds.date_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and SUBTIME(eds.time_debut,"-00:01:00") between had.heure_debut and had.heure_fin
        and SUBTIME(eds.time_fin,"00:01:00") between had.heure_debut and had.heure_fin
		and eds.time_debut between jo.time_debut and jo.time_fin
		and eds.time_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite = @id_autorite_receiver
        and ds.id_autorite_enfant = @id_autorite_receiver	
        and eds.date_debut = @date_du_jour
        and eds.date_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and SUBTIME(eds.time_debut,"-00:01:00") between had.heure_debut and had.heure_fin
		and eds.time_debut between jo.time_debut and jo.time_fin
		and eds.time_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite = @id_autorite_receiver
        and ds.id_autorite_enfant = @id_autorite_receiver	
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
        jo.id_autorite = @id_autorite_receiver	
        and dap.action >=0 and dap.action <= 1
        and dap.date_event_debut = @date_du_jour
        and dap.date_event_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and had.heure_debut between SUBTIME(dap.time_event_debut,"-00:01:00") and SUBTIME(dap.time_event_fin,"00:01:00")
        and had.heure_fin between SUBTIME(dap.time_event_debut,"-00:01:00") and SUBTIME(dap.time_event_fin,"00:01:00")
		and dap.time_event_debut between jo.time_debut and jo.time_fin
		and dap.time_event_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite  = @id_autorite_receiver
        AND dap.action >=0 and dap.action <= 1
        and dap.date_event_debut = @date_du_jour
        and dap.date_event_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and SUBTIME(dap.time_event_debut,"-00:01:00") between had.heure_debut and had.heure_fin
        and SUBTIME(dap.time_event_fin,"00:01:00") between had.heure_debut and had.heure_fin		
		and dap.time_event_debut between jo.time_debut and jo.time_fin
		and dap.time_event_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite  = @id_autorite_receiver
        AND dap.action >=0 and dap.action <= 1
        and dap.date_event_debut = @date_du_jour
        and dap.date_event_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and SUBTIME(dap.time_event_debut,"-00:01:00") between had.heure_debut and had.heure_fin
		and dap.time_event_debut between jo.time_debut and jo.time_fin
		and dap.time_event_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite  = @id_autorite_receiver
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
        jo.id_autorite  = @id_autorite_receiver
        AND daa.action >= 0 and daa.action <= 1
        and daa.date_debut = @date_du_jour
        and daa.date_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and had.heure_debut between SUBTIME(daa.time_debut,"-00:01:00") and SUBTIME(daa.time_fin,"00:01:00")
        and had.heure_fin between SUBTIME(daa.time_debut,"-00:01:00") and SUBTIME(daa.time_fin,"00:01:00")
		and daa.time_debut between jo.time_debut and jo.time_fin
		and daa.time_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite  = @id_autorite_receiver
        AND daa.action >= 0 and daa.action <= 1
        and daa.date_debut = @date_du_jour
        and daa.date_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and SUBTIME(daa.time_debut,"-00:01:00") between had.heure_debut and had.heure_fin
        and SUBTIME(daa.time_fin,"00:01:00") between had.heure_debut and had.heure_fin
		and daa.time_debut between jo.time_debut and jo.time_fin
		and daa.time_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite  = @id_autorite_receiver
        AND daa.action >= 0 and daa.action <= 1
        and daa.date_debut = @date_du_jour
        and daa.date_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and SUBTIME(daa.time_debut,"-00:01:00") between had.heure_debut and had.heure_fin
		and daa.time_debut between jo.time_debut and jo.time_fin
		and daa.time_fin between jo.time_debut and jo.time_fin
        or
        jo.id_autorite  = @id_autorite_receiver
        AND daa.action >= 0 and daa.action <= 1
        and daa.date_debut = @date_du_jour
        and daa.date_fin = @date_du_jour
        and jo.jour = @jour_UTF8
        and SUBTIME(daa.time_fin,"00:01:00") between had.heure_debut and had.heure_fin
		and daa.time_debut between jo.time_debut and jo.time_fin
		and daa.time_fin between jo.time_debut and jo.time_fin
        GROUP by had.id 
        ORDER BY heure_debut ASC
    )
END