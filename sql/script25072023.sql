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

select year(current_time);


select id_autorite,MONTH(date_publication) from stage5.doleance