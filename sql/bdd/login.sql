-- Data login que j'ai crée
INSERT INTO rohi.`user`
	(id,login, password) VALUES (15412,'srcJean1',(SELECT AES_ENCRYPT('srcJean1','lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau')));
INSERT INTO rohi.`user`
	(id,login, password) VALUES (15413,'dirJean1',(SELECT AES_ENCRYPT('dirJean1','lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau')));

-- Get ID the user login
select 
u.id 
from rohi.user u 
where 
u.login = 'srcJean1' 
and u.password = (SELECT AES_ENCRYPT('srcJean1','lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau'))

-- update premier_responsable_id
UPDATE rohi.t_structure SET premier_responsable_id = 15412 where child_id = 2962;
UPDATE rohi.t_structure SET premier_responsable_id = 15413 where child_id = 2961;

-- login (username, password)
select 
ts.child_id,
ts.premier_responsable_id,
ts.child_libelle,
ts.niveau
from rohi.t_structure ts 
join rohi.user u on ts.premier_responsable_id = u.id
where ts.premier_responsable_id = (select 
u.id 
from rohi.user u 
where 
u.login = username 
and u.password = (SELECT AES_ENCRYPT(mdp,'lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau')));



select * from rohi.t_structure;

select * from rohi.user u where u.id = 15413;

select * from rohi.user u where u.login = 'dirJean1';


CREATE PROCEDURE login(IN username varchar(255),IN mdp varchar(255))
BEGIN
	select 
	ts.child_id,
	ts.premier_responsable_id,
	ts.child_libelle,
	ts.niveau
	from rohi.t_structure ts 
	join rohi.user u on ts.premier_responsable_id = u.id
	where ts.premier_responsable_id = (select 
	u.id 
	from rohi.user u 
	where 
	u.login = username 
	and u.password = (SELECT AES_ENCRYPT(mdp,'lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau')));
END;

select 
u.id,
u.login,
u.password 
from rohi.user u 
where 
u.password = (SELECT AES_ENCRYPT('srcJean1','lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau')) 
and u.login = 'srcJean1';

-- SELECT AES_DECRYPT((SELECT FROM rohi.user u where u.id = )

select id, login, AES_DECRYPT(password,'lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau') AS MDP 
from rohi.user where id = 11
