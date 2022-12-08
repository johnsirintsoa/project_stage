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

-- Version 1
CREATE  PROCEDURE `liste_place_disponible_public_par_jour`(IN date_du_jour date,IN session_navigateur varchar(50),in id_autorite int)
BEGIN
    SET @session_navigateur = session_navigateur;
    SET @id_autorite = id_autorite;
    SET @date_du_jour = date_du_jour;
    set @jour_UTF8 = CONVERT(DAYNAME(@date_du_jour) USING utf8);

    (SELECT 
    had.id as id_heure_disponible, 
    CONCAT(@date_du_jour,'T',had.heure_debut) as start,
    CONCAT(@date_du_jour,'T',had.heure_fin) as end, 
    dap.id as id, 
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
    ELSE 'Aucune' END as status_audience, 
    CASE 
        WHEN dap.session_navigateur = @session_navigateur and dap.action = 0 THEN "#407DFF" 
        WHEN dap.session_navigateur = @session_navigateur and dap.action = 1 THEN "#FF0018" 
        ELSE '#FF0018' END as color 
    FROM stage3.heure_disponible had 
    JOIN stage3.dm_aud_public_heure_dispo hd_dap on had.id = hd_dap.id_heure_dispo and  hd_dap.date_audience = @date_du_jour
    JOIN stage3.demande_audience_public dap on hd_dap.id_aud_public = dap.id
    where dap.action >=0 and dap.action <=1
    Group by dap.id order by dap.id Desc LIMIT 1)

    union

    (SELECT 
    hd.id,
    CONCAT(@date_du_jour,'T',hd.heure_debut) as start,
    CONCAT(@date_du_jour,'T',hd.heure_fin) as end, 
    '' id,
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
    '#0AA913' color
    FROM
    stage3.heure_disponible hd
    LEFT JOIN jour_ouvrable jo on hd.id_jour_ouvrable = jo.id and jo.jour = @jour_UTF8
    LEFT JOIN heure_dispo_dm_aud_autorite hddaa on hd.id = hddaa.id_heure_dispo and hddaa.date_audience = @date_du_jour and jo.jour = @jour_UTF8
    LEFT JOIN dm_aud_public_heure_dispo dm_aud_pub_hd on hd.id = dm_aud_pub_hd.id_heure_dispo and dm_aud_pub_hd.date_audience = @date_du_jour and jo.jour = @jour_UTF8
    LEFT JOIN non_disponibilite_autorite_date ndad on hd.id = ndad.id_heure_dispo and ndad.date_non_dispo = @date_du_jour and jo.jour = @jour_UTF8
    LEFT JOIN non_disponibilite_autorite_jour ndaj on hd.id = ndaj.id_heure_dispo and jo.jour = @jour_UTF8
    LEFT JOIN entretien_demande_stage eds on hd.id = eds.id_heure_dispo and eds.date_entretien = @date_du_jour and jo.jour = @jour_UTF8
    WHERE 
    jo.id_autorite = @id_autorite
    and hddaa.id IS NULL
    and dm_aud_pub_hd.id IS NULL
    and ndad.id IS NULL
    and ndaj.id IS NULL
    and eds.id IS NULL);
END

-- Version 2
CREATE  PROCEDURE `liste_place_disponible_public_par_jour`(IN date_du_jour date,IN session_navigateur varchar(50),in id_autorite int)
BEGIN
    SET @session_navigateur = session_navigateur;
    SET @id_autorite = id_autorite;
    SET @date_du_jour = date_du_jour;
    set @jour_UTF8 = CONVERT(DAYNAME(@date_du_jour) USING utf8);

    SELECT 
    hd.id,
    CONCAT(@date_du_jour,'T',hd.heure_debut) as start,
    CONCAT(@date_du_jour,'T',hd.heure_fin) as end, 
    dap.id as id, 
    hd_dap.date_audience, 
    hd_dap.heure_debut, 
    hd_dap.heure_fin, 
    IFNULL(dap.motif,"Disponible") as title,
    dap.nom, 
    dap.prenom, 
    dap.cin, 
    dap.numero_telephone, 
    dap.email, 
    CASE 
        WHEN dap.action = 0 THEN 'Non validé' 
        WHEN dap.action = 1 THEN 'Validé' 
        WHEN dap.action = 2 THEN 'Reporté' 
        ELSE 'Aucune' END as status_audience, 
    CASE 
        WHEN dap.session_navigateur = @session_navigateur and dap.action = 0 THEN "#407DFF" 
        WHEN dap.session_navigateur = @session_navigateur and dap.action = 1 THEN "#FF0018" 
        ELSE '#FF0018' END as color 
    FROM
    stage3.heure_disponible hd
    LEFT JOIN jour_ouvrable jo on hd.id_jour_ouvrable = jo.id and jo.jour = @jour_UTF8
    LEFT JOIN heure_dispo_dm_aud_autorite hddaa on hd.id = hddaa.id_heure_dispo and hddaa.date_audience = @date_du_jour and jo.jour = @jour_UTF8
    LEFT JOIN dm_aud_public_heure_dispo dm_aud_pub_hd on hd.id = dm_aud_pub_hd.id_heure_dispo and dm_aud_pub_hd.date_audience = @date_du_jour and jo.jour = @jour_UTF8
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
    or 
    jo.id_autorite = @id_autorite
    and dap.session_navigateur = @session_navigateur
    group by hd_dap.id;
END

CREATE PROCEDURE `liste_place_disponible_autorite_par_jour`(IN date_du_jour date,in id_autorite_sender int,in id_autorite_receiver int)
BEGIN
    SET @id_autorite_receiver = id_autorite_receiver;
    SET @id_autorite_sender = id_autorite_sender;
    SET @date_du_jour = date_du_jour;
    set @jour_UTF8 = CONVERT(DAYNAME(@date_du_jour) USING utf8);

    SELECT 
    had.*,
    dap.*,
    '' color
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
        
        -- Jour ferie
        UNION 
        select 
        had.id
        FROM 
        heure_audience_disponible had
        JOIN jour_ouvrable jo on had.id_jour_ouvrable = jo.id
        WHERE 
        had.
        GROUP by had.id 
        ORDER BY heure_debut ASC
    )
END




INSERT INTO stage2.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin ) VALUES ( 'Toussaint', '11', '11', '00:00:01', '23:59:00');
INSERT INTO stage2.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin ) VALUES ( 'Noel', '25', '12', '08:00:00', '12:00:00');
INSERT INTO stage2.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin ) VALUES ( 'Fin d''année', '31', '12', '14:00:00', '16:00:00');
INSERT INTO stage2.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin ) VALUES ( 'Nouvel an', '11', '1', '08:00:00', '12:00:00');
INSERT INTO stage2.jour_ferie( nom_evenement, numero_du_jour, mois_du_jour, time_event_debut, time_event_fin ) VALUES ( 'Black friday', '28', '11', '14:00:00', '15:00:00');


SELECT 
hd.id,
CONCAT(@date_du_jour,'T',hd.heure_debut) as start,
CONCAT(@date_du_jour,'T',hd.heure_fin) as end, 
'' id,
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
'#0AA913' color
FROM
stage3.heure_disponible hd
LEFT JOIN jour_ouvrable jo on hd.id_jour_ouvrable = jo.id and jo.jour = @jour_UTF8
LEFT JOIN heure_dispo_dm_aud_autorite hddaa on hd.id = hddaa.id_heure_dispo and hddaa.date_audience = @date_du_jour and jo.jour = @jour_UTF8
LEFT JOIN dm_aud_public_heure_dispo dm_aud_pub_hd on hd.id = dm_aud_pub_hd.id_heure_dispo and dm_aud_pub_hd.date_audience = @date_du_jour and jo.jour = @jour_UTF8
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
and (select jf.time_event_debut from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8 ) NOT BETWEEN hd.heure_debut and hd.heure_fin
and (select jf.time_event_fin from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8 ) NOT BETWEEN hd.heure_debut and hd.heure_fin
or
jo.id_autorite = @id_autorite
and hddaa.id IS NULL
and dm_aud_pub_hd.id IS NULL
and ndad.id IS NULL
and ndaj.id IS NULL
and eds.id IS NULL
and hd.heure_debut NOT BETWEEN (select jf.time_event_debut from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8 ) and (select jf.time_event_fin from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8)
and hd.heure_fin NOT BETWEEN (select jf.time_event_debut from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8) and (select jf.time_event_fin from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8)
or 
jo.id_autorite = @id_autorite
and hddaa.id IS NULL
and dm_aud_pub_hd.id IS NULL
and ndad.id IS NULL
and ndaj.id IS NULL
and eds.id IS NULL
and hd.heure_debut NOT BETWEEN (select jf.time_event_debut from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8 ) and (select jf.time_event_fin from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8)
and hd.heure_fin BETWEEN (select jf.time_event_debut from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8) and (select jf.time_event_fin from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8)
or
jo.id_autorite = @id_autorite
and hddaa.id IS NULL
and dm_aud_pub_hd.id IS NULL
and ndad.id IS NULL
and ndaj.id IS NULL
and eds.id IS NULL
and hd.heure_debut BETWEEN (select jf.time_event_debut from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8 ) and (select jf.time_event_fin from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8)
and hd.heure_fin NOT BETWEEN (select jf.time_event_debut from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8 ) and (select jf.time_event_fin from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8)
or
jo.id_autorite = @id_autorite
and hddaa.id IS NULL
and dm_aud_pub_hd.id IS NULL
and ndad.id IS NULL
and ndaj.id IS NULL
and eds.id IS NULL
and (select jf.time_event_debut from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8 ) NOT BETWEEN hd.heure_debut and hd.heure_fin
and (select jf.time_event_fin from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8 ) BETWEEN hd.heure_debut and hd.heure_fin

or
jo.id_autorite = @id_autorite
and hddaa.id IS NULL
and dm_aud_pub_hd.id IS NULL
and ndad.id IS NULL
and ndaj.id IS NULL
and eds.id IS NULL
and (select jf.time_event_debut from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8 ) BETWEEN hd.heure_debut and hd.heure_fin
and (select jf.time_event_fin from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8 ) NOT BETWEEN hd.heure_debut and hd.heure_fin


-- Liste des places disponible coté public
CREATE  PROCEDURE `liste_place_disponible_public_par_jour`(IN date_du_jour date,IN session_navigateur varchar(50),in id_autorite int)
BEGIN
    SET @session_navigateur = session_navigateur;
	SET @id_autorite = 1;
    SET @date_du_jour = '2022-11-28';
    set @jour_UTF8 = CONVERT(DAYNAME(@date_du_jour) USING utf8);
	
	select @id_autorite,@jour_UTF8,@date_du_jour;

	SELECT 
	hd.*,
	hd_dm_aud_aut.*,
	dm_aud_pub_hd.*,
	hd_nd_aut_date.*,
	hd_nd_aut_jour.*,
	hd_es.*
	FROM
	stage3.heure_disponible hd
	-- jour ouvrable
	JOIN jour_ouvrable jo on hd.id_jour_ouvrable = jo.id
	
	-- demande audience autorite 
	LEFT JOIN heure_dispo_dm_aud_autorite hd_dm_aud_aut on hd.id = hd_dm_aud_aut.id_heure_dispo
	join demande_audience_autorite daa on hd_dm_aud_aut.id_dm_aud_autorite = daa.id
	
	-- demande audience public
	LEFT JOIN dm_aud_public_heure_dispo dm_aud_pub_hd on hd.id = dm_aud_pub_hd.id_heure_dispo
	join demande_audience_public dap on dm_aud_pub_hd.id_aud_public = dap.id
	
	-- non disponible date 
	LEFT JOIN heure_dispo_non_dispo_autorite_date hd_nd_aut_date on hd.id = hd_nd_aut_date.id_heure_dispo
	JOIN non_disponibilite_autorite_date ndad on hd_nd_aut_date.id_non_dispo_date = ndad.id
	
	-- non disponible jour
	LEFT JOIN heure_dispo_non_dispo_autorite_jour hd_nd_aut_jour  on hd.id = hd_nd_aut_jour.id_heure_dispo
	JOIN non_disponibilite_autorite_jour ndaj on hd_nd_aut_jour.id_non_dispo_jour = ndaj.id
	
	-- entretien stage
	LEFT JOIN heure_dispo_entretien_stage hd_es on hd.id = hd_es.id_heure_dispo
	JOIN entretien_demande_stage eds on hd_es.id_entretien_stage = eds.id
	
	WHERE 
	jo.id_autorite = @id_autorite
	and daa.date_debut = @date_du_jour
	and daa.date_fin = @date_du_jour
	and dap.date_event_debut = @date_du_jour
	and dap.date_event_fin = @date_du_jour
	and ndad.date_non_dispo_debut = @date_du_jour
	and ndad.date_non_dispo_fin = @date_du_jour
	and jo.jour = @jour_UTF8
	and eds.date_debut = @date_du_jour
	and eds.date_fin = @date_du_jour
	and hd_dm_aud_aut.id IS NULL
	and dm_aud_pub_hd.id IS NULL
	and hd_nd_aut_date.id IS NULL
	and hd_nd_aut_jour.id IS NULL
	and hd_es.id IS NULL
END

CREATE  PROCEDURE `liste_place_disponible_autorite_par_jour`(IN date_du_jour date,IN session_navigateur varchar(50),in id_autorite int)
BEGIN
    SET @session_navigateur = session_navigateur;
    SET @id_autorite = id_autorite;
    SET @date_du_jour = date_du_jour;
    set @jour_UTF8 = CONVERT(DAYNAME(@date_du_jour) USING utf8);

    (SELECT 
    had.id as id_heure_disponible, 
    CONCAT(@date_du_jour,'T',had.heure_debut) as start,
    CONCAT(@date_du_jour,'T',had.heure_fin) as end, 
    dap.id as id, 
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
    ELSE 'Aucune' END as status_audience, 
    CASE 
        WHEN dap.session_navigateur = @session_navigateur and dap.action = 0 THEN "#407DFF" 
        WHEN dap.session_navigateur = @session_navigateur and dap.action = 1 THEN "#FF0018" 
        ELSE '#FF0018' END as color 
    FROM stage3.heure_disponible had 
    JOIN stage3.dm_aud_public_heure_dispo hd_dap on had.id = hd_dap.id_heure_dispo and  hd_dap.date_audience = @date_du_jour
    JOIN stage3.demande_audience_public dap on hd_dap.id_aud_public = dap.id
    where dap.action >=0 and dap.action <=1
    Group by dap.id order by dap.id Desc LIMIT 1)

    union

    (SELECT 
    hd.id,
    CONCAT(@date_du_jour,'T',hd.heure_debut) as start,
    CONCAT(@date_du_jour,'T',hd.heure_fin) as end, 
    '' id,
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
    '#0AA913' color
    FROM
    stage3.heure_disponible hd
    LEFT JOIN jour_ouvrable jo on hd.id_jour_ouvrable = jo.id and jo.jour = @jour_UTF8
    LEFT JOIN heure_dispo_dm_aud_autorite hddaa on hd.id = hddaa.id_heure_dispo and hddaa.date_audience = @date_du_jour and jo.jour = @jour_UTF8
    LEFT JOIN dm_aud_public_heure_dispo dm_aud_pub_hd on hd.id = dm_aud_pub_hd.id_heure_dispo and dm_aud_pub_hd.date_audience = @date_du_jour and jo.jour = @jour_UTF8
    LEFT JOIN non_disponibilite_autorite_date ndad on hd.id = ndad.id_heure_dispo and ndad.date_non_dispo = @date_du_jour and jo.jour = @jour_UTF8
    LEFT JOIN non_disponibilite_autorite_jour ndaj on hd.id = ndaj.id_heure_dispo and jo.jour = @jour_UTF8
    LEFT JOIN entretien_demande_stage eds on hd.id = eds.id_heure_dispo and eds.date_entretien = @date_du_jour and jo.jour = @jour_UTF8
    WHERE 
    jo.id_autorite = @id_autorite
    and hddaa.id IS NULL
    and dm_aud_pub_hd.id IS NULL
    and ndad.id IS NULL
    and ndaj.id IS NULL
    and eds.id IS NULL);
END

CREATE  PROCEDURE `liste_place_disponible_public_par_jour`(IN date_du_jour date,IN session_navigateur varchar(50),in id_autorite int)
BEGIN

	SET @session_navigateur = session_navigateur;
	SET @id_autorite = id_autorite;
	SET @date_du_jour = date_du_jour;
	set @jour_UTF8 = CONVERT(DAYNAME(@date_du_jour) USING utf8);
	
	set @nbr_jour_ferie = (select count(jf.id) from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8);
	
	IF @nbr_jour_ferie > 0 THEN 
		(SELECT 
	    had.id as id_heure_disponible, 
	    CONCAT(@date_du_jour,'T',had.heure_debut) as start,
	    -- CONCAT(@date_du_jour,'T',MAX(had.heure_fin)) as end, 
		CONCAT(@date_du_jour,'T',had.heure_fin) as end,    
		dap.id as id, 
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
	    ELSE 'Aucune' END as status_audience, 
	    CASE 
	        WHEN dap.session_navigateur = @session_navigateur and dap.action = 0 THEN "#407DFF" 
	        WHEN dap.session_navigateur = @session_navigateur and dap.action = 1 THEN "#FF0018" 
	        ELSE '#FF0018' END as color,
		false editable
	    FROM stage3.heure_disponible had 
	    JOIN stage3.dm_aud_public_heure_dispo hd_dap on had.id = hd_dap.id_heure_dispo and  hd_dap.date_audience = @date_du_jour
	    JOIN stage3.demande_audience_public dap on hd_dap.id_aud_public = dap.id
	    where dap.action >=0 and dap.action <=1
		GROUP by dap.id
	    )
	
	    union
	
	    (SELECT 
	    hd.id,
	    CONCAT(@date_du_jour,'T',hd.heure_debut) as start,
	    CONCAT(@date_du_jour,'T',hd.heure_fin) as end, 
	    '' id,
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
		false editable
	    FROM
	    stage3.heure_disponible hd
	    LEFT JOIN jour_ouvrable jo on hd.id_jour_ouvrable = jo.id and jo.jour = @jour_UTF8
	    LEFT JOIN heure_dispo_dm_aud_autorite hddaa on hd.id = hddaa.id_heure_dispo and hddaa.date_audience = @date_du_jour and jo.jour = @jour_UTF8
	    LEFT JOIN dm_aud_public_heure_dispo dm_aud_pub_hd on hd.id = dm_aud_pub_hd.id_heure_dispo and dm_aud_pub_hd.date_audience = @date_du_jour and jo.jour = @jour_UTF8
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
	    and (select jf.time_event_debut from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8 ) NOT BETWEEN hd.heure_debut and hd.heure_fin
	    and (select jf.time_event_fin from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8 ) NOT BETWEEN hd.heure_debut and hd.heure_fin
	    and hd.heure_debut NOT BETWEEN (select jf.time_event_debut from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8 ) and (select jf.time_event_fin from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8)
	    and hd.heure_fin NOT BETWEEN (select jf.time_event_debut from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8) and (select jf.time_event_fin from jour_ferie jf where CONVERT((select dayname(concat(YEAR(CURDATE()),'-',jf.mois_du_jour,'-',jf.numero_du_jour))) USING utf8) = @jour_UTF8)
	    );	
	ELSE 
		(SELECT 
	    had.id as id_heure_disponible, 
	    CONCAT(@date_du_jour,'T',had.heure_debut) as start,
	    -- CONCAT(@date_du_jour,'T',MAX(had.heure_fin)) as end, 
		CONCAT(@date_du_jour,'T',had.heure_fin) as end,    
		dap.id as id, 
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
	    ELSE 'Aucune' END as status_audience, 
	    CASE 
	        WHEN dap.session_navigateur = @session_navigateur and dap.action = 0 THEN "#407DFF" 
	        WHEN dap.session_navigateur = @session_navigateur and dap.action = 1 THEN "#FF0018" 
	        ELSE '#FF0018' END as color,
		false editable 
	    FROM stage3.heure_disponible had 
	    JOIN stage3.dm_aud_public_heure_dispo hd_dap on had.id = hd_dap.id_heure_dispo and  hd_dap.date_audience = @date_du_jour
	    JOIN stage3.demande_audience_public dap on hd_dap.id_aud_public = dap.id
	    where dap.action >=0 and dap.action <=1
		GROUP by dap.id
	    )
	
	    union
	
	    (SELECT 
	    hd.id,
	    CONCAT(@date_du_jour,'T',hd.heure_debut) as start,
	    CONCAT(@date_du_jour,'T',hd.heure_fin) as end, 
	    '' id,
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
		false editable
	    FROM
	    stage3.heure_disponible hd
	    LEFT JOIN jour_ouvrable jo on hd.id_jour_ouvrable = jo.id and jo.jour = @jour_UTF8
	    LEFT JOIN heure_dispo_dm_aud_autorite hddaa on hd.id = hddaa.id_heure_dispo and hddaa.date_audience = @date_du_jour and jo.jour = @jour_UTF8
	    LEFT JOIN dm_aud_public_heure_dispo dm_aud_pub_hd on hd.id = dm_aud_pub_hd.id_heure_dispo and dm_aud_pub_hd.date_audience = @date_du_jour and jo.jour = @jour_UTF8
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
	    );
	END IF;
END


SET @session_navigateur = 'session669.84399043559464';
SET @id_autorite = '1';
SET @date_du_jour = '2022-11-28';
set @jour_UTF8 = CONVERT(DAYNAME(@date_du_jour) USING utf8);


call `liste_place_disponible_public_par_jour`('2022-11-28','session669.84399043559464',1)



CREATE  PROCEDURE `ajouter_audience_public`(session_navigateur VARCHAR(100),nom varchar(30),prenom varchar(30),cin varchar(15),numero_telephone varchar(10),email varchar(30),IN id_heure_dispo INT,motif VARCHAR(200),id_autorite int)
BEGIN 
	SET @session_navigateur = session_navigateur; 
	SET @nom = (SELECT UPPER(nom)); 
	SET @prenom = (SELECT LOWER(prenom)); 
	SET @cin = cin; 
	SET @numero_telephone = numero_telephone; 
	SET @mail = email; 
	SET @motif = motif; 
	SET @id_hd = id_heure_dispo; 
	SET @id_autorite = id_autorite; 

	set @id_audience = (SELECT max(dap.id) FROM stage3.demande_audience_public dap where dap.cin = @cin and dap.session_navigateur = @session_navigateur);
	IF @id_audience IS NULL THEN 
		SELECT 'Ajouter une audience' as message;
	ELSE 
		select concat('Misy',@id_audience) as message;
		INSERT INTO stage3.dm_aud_public_heure_dispo
		( id_aud_public, id_heure_dispo, date_audience, heure_debut, heure_fin) VALUES ( ?, ?, ?, ?, ?, ? );
	END IF;
END