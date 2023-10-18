-- Tous les agents du MEF sans les autorités 2.42sec executions
select
c.id as id_candidat,
ts.premier_responsable_id,
c.nom,
c.prenom,
c.poste,
c.fonction_actuel,
u.id as id_user,
u.login,
u.password,
c.structureId,
ts.child_id,
ts.child_libelle,
ts.path,
ts.niveau,
ts.rang
FROM rohi.candidat c 
JOIN rohi.t_structure ts on c.structureId = ts.child_id
JOIN rohi.user u on c.user_id = u.id
where NOT EXISTS (
    SELECT 1
    FROM rohi.t_structure t
    WHERE
        (t.niveau = 'MIN' OR
         t.niveau = 'DG' OR
         t.niveau = 'DIR' OR
         t.niveau = 'SCE')
    AND ts.premier_responsable_id = t.premier_responsable_id)

-- Nom utilisateur agent
select
c.id as id_candidat,
ts.premier_responsable_id,
c.nom,
c.prenom,
IFNULL(c.poste,'Agent') as poste,
c.fonction_actuel,
u.id as id_user,
u.login,
u.password,
c.structureId,
ts.child_id,
ts.child_libelle,
ts.path,
ts.niveau,
ts.rang
FROM rohi.candidat c 
JOIN rohi.t_structure ts on c.structureId = ts.child_id
JOIN rohi.user u on c.user_id = u.id
where 
ts.niveau NOT IN ('MIN', 'DG', 'DIR', 'SCE') 
AND
u.login = '${req.body.nom_utilisateur}'

-- Insert agent user
INSERT INTO rohi.user (login,password) values 
('jean1',(SELECT AES_ENCRYPT('jean1','lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau'))),
('jean2',(SELECT AES_ENCRYPT('jean2','lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau'))),
('jean3',(SELECT AES_ENCRYPT('jean3','lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau'))),
('jean4',(SELECT AES_ENCRYPT('jean4','lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau'))),
('jean5',(SELECT AES_ENCRYPT('jean5','lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau')));

-- Insert agent candidat
INSERT INTO rohi.candidat (date_creation,nom,prenom,email,phone,structureId,user_id) values 
((select now()),'VELOSOA','jean1','johnsirintsoa18@gmail.com','0341752875',1417,15414),
((select now()),'JEAN JACQUE','jean2','johnsirintsoa18@gmail.com','0341752875',1342,15415),
((select now()),'RIZIKY','jean3','johnsirintsoa18@gmail.com','0341752875',2930,15416),
((select now()),'ISRAELY','jean4','johnsirintsoa18@gmail.com','0341752875',2960,15417),
((select now()),'RAHOLODINA','jean5','johnsirintsoa18@gmail.com','0341752875',2106,15418);

select
c.id as id_candidat,
ts.premier_responsable_id,
c.nom,
c.prenom,
IFNULL(c.poste,'Agent') as poste,
c.fonction_actuel,
u.id as id_user,
u.login,
u.password,
c.structureId,
ts.child_id,
ts.child_libelle,
ts.path,
ts.niveau,
ts.rang
FROM rohi.candidat c 
JOIN rohi.t_structure ts on c.structureId = ts.child_id
JOIN rohi.user u on c.user_id = u.id
where 
ts.niveau NOT IN ('MIN', 'DG', 'DIR', 'SCE') 
AND
u.login = '${req.body.nom_utilisateur}'
and 
u.password = (SELECT AES_ENCRYPT('${req.body.mot_de_passe}','lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau'));



-- Tableau de bord 
-- Boite à doléance
select 
'Janvier' as x,  count(IF(MONTH(d.date_publication) = 1,1,NULL)) 'y'
from 
stage5.doleance d 
where d.id_autorite = 2961 and year(d.date_publication) = '2023' 

UNION
select 
'Février' as x,  count(IF(MONTH(d.date_publication) = 2,1,NULL)) 'y'
from 
stage5.doleance d 
where d.id_autorite = 2961 and year(d.date_publication) = '2023' 

UNION
select
'Mars' as x,  count(IF(MONTH(d.date_publication) = 3,1,NULL)) 'y'
from 
stage5.doleance d 
where d.id_autorite = 2961 and year(d.date_publication) = '2023' 

UNION 
select 
'Avril' as x,  count(IF(MONTH(d.date_publication) = 4,1,NULL)) 'y'
from 
stage5.doleance d 
where d.id_autorite = 2961 and year(d.date_publication) = '2023' 

UNION
select 
'Mai' as x,  count(IF(MONTH(d.date_publication) = 5,1,NULL)) 'y'
from 
stage5.doleance d 
where d.id_autorite = 2961 and year(d.date_publication) = '2023' 

UNION
select 
'Juin' as x,  count(IF(MONTH(d.date_publication) = 6,1,NULL)) 'y'
from 
stage5.doleance d 
where d.id_autorite = 2961 and year(d.date_publication) = '2023'

UNION 
select 
'Juillet' as x,  count(IF(MONTH(d.date_publication) = 7,1,NULL)) 'y'
from 
stage5.doleance d 
where d.id_autorite = 2961 and year(d.date_publication) = '2023' 

UNION
select 
'Aout' as x,  count(IF(MONTH(d.date_publication) = 8,1,NULL)) 'y'
from 
stage5.doleance d 
where d.id_autorite = 2961 and year(d.date_publication) = '2023' 

UNION
select 
'Septembre' as x,  count(IF(MONTH(d.date_publication) = 9,1,NULL)) 'y'
from 
stage5.doleance d 
where d.id_autorite = 2961 and year(d.date_publication) = '2023' 

UNION 
select
'Octobre' as x,  count(IF(MONTH(d.date_publication) = 10,1,NULL)) 'y'
from 
stage5.doleance d 
where d.id_autorite = 2961 and year(d.date_publication) = '2023' 

UNION
select
'Novembre' as x,  count(IF(MONTH(d.date_publication) = 11,1,NULL)) 'y'
from 
stage5.doleance d 
where d.id_autorite = 2961 and year(d.date_publication) = '2023' 

UNION 
select
'Décembre' as x,  count(IF(MONTH(d.date_publication) = 12,1,NULL)) 'y'
from 
stage5.doleance d 
where d.id_autorite = 2961 and year(d.date_publication) = '2023' 


-- Tableau de bord
-- Demande de stage

select 
d.nom_domaine as y,
IF(ds.id = NULL ,0,count(ds.id)) as x
from stage5.domaine d 
LEFT JOIN stage5.demande_stage ds on d.id = ds.id_domaine
WHERE (ds.id_autorite_enfant =  2961 and year(ds.date_creation) = (SELECT YEAR(CURRENT_DATE()))) or ds.id is null
group by d.id order by x;

select year(current_time);


select id_autorite,MONTH(date_publication) from stage5.doleance









-- Calendrier autorite 17 octobre 2023
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
	true as editable
	FROM dm_aud_autorite_date_heure_dispo daadhd
	LEFT join date_heure_disponible_autorite dhda on daadhd.id_date_heure_disponible_autorite = dhda.id
	LEFT JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	LEFT JOIN demande_audience_autorite daa on daadhd.id_dm_aud_autorite = daa.id
	LEFT JOIN rohi.t_structure ts on daa.id_autorite_enfant_sender = ts.child_id
	LEFT JOIN rohi.candidat c on ts.premier_responsable_id = c.id
	where dhd.date_disponible >= (SELECT FIRST_DATE_OF_MONTH(CURDATE())) and dhda.id_autorite = @id_autorite
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
	true AS editable
	FROM stage5.dm_aud_public_date_heure_dispo dapdhd
	LEFT JOIN date_heure_disponible_autorite dhda on dapdhd.id_date_heure_disponible_autorite = dhda.id
	LEFT JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	LEFT JOIN demande_audience_public dap on dapdhd.id_aud_public = dap.id
	LEFT JOIN rohi.candidat c on dap.id_agent = c.id
	LEFT JOIN rohi.t_structure ts on c.structureId = ts.child_id
	WHERE dhd.date_disponible >= (SELECT FIRST_DATE_OF_MONTH(CURDATE())) and dhda.id_autorite = @id_autorite
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

	true AS editable
	from entretien_demande_stage eds
	JOIN date_heure_disponible_autorite dhda on eds.id_date_heure_disponible_autorite = dhda.id
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	JOIN demande_stage ds on eds.id_demande_stage = ds.id
	where dhd.date_disponible >= (SELECT FIRST_DATE_OF_MONTH(CURDATE())) and dhda.id_autorite = @id_autorite
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
	 true editable
	from date_heure_non_disponible_autorite dhnda
	JOIN pas_disponible pd on dhnda.id = pd.id_date_heure_non_disponible_autorite
	JOIN date_heure_disponible_autorite dhda on pd.id_date_heure_disponible_autorite = dhda.id
	JOIN date_heure_disponible dhd on dhda.id_date_heure_disponible = dhd.id
	where dhd.date_disponible >= (SELECT FIRST_DATE_OF_MONTH(CURDATE())) and dhda.id_autorite = @id_autorite
	GROUP by dhnda.id;
END

-- Calendrier autorité 18 octobre 2023
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
		where dhd.date_disponible >= (SELECT FIRST_DATE_OF_MONTH(CURDATE())) and dhda.id_autorite = @id_autorite and daa.est_termine is false
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
		WHERE dhd.date_disponible >= (SELECT FIRST_DATE_OF_MONTH(CURDATE())) and dhda.id_autorite = @id_autorite and dap.est_termine is false
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
		where dhd.date_disponible >= (SELECT FIRST_DATE_OF_MONTH(CURDATE())) and dhda.id_autorite = @id_autorite and ds.est_termine is false
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
		where dhd.date_disponible >= (SELECT FIRST_DATE_OF_MONTH(CURDATE())) and dhda.id_autorite = @id_autorite
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
		where dhd.date_disponible >= (SELECT FIRST_DATE_OF_MONTH(CURDATE())) and dhda.id_autorite = @id_autorite 
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
		WHERE dhd.date_disponible >= (SELECT FIRST_DATE_OF_MONTH(CURDATE())) and dhda.id_autorite = @id_autorite
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
		where dhd.date_disponible >= (SELECT FIRST_DATE_OF_MONTH(CURDATE())) and dhda.id_autorite = @id_autorite
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
		where dhd.date_disponible >= (SELECT FIRST_DATE_OF_MONTH(CURDATE())) and dhda.id_autorite = @id_autorite
		GROUP by dhnda.id;

	END IF;
END