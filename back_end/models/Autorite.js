const rohi = require('../database').rohi

const login = function (nom_utilisateur,mot_de_passe) {
    const email = `select 
    ts.child_id,
    ts.premier_responsable_id,
    ts.autorite_id,
    ts.child_libelle,
    ts.sigle,
    ts.niveau,
    c.email,
    c.phone
    from rohi.t_structure ts 
    LEFT join rohi.user u on ts.premier_responsable_id = u.id
    LEFT join rohi.candidat c on u.id = c.user_id
    where
    (ts.niveau = 'MIN'
    or ts.niveau = 'DG'
    or ts.niveau = 'DIR'
    or ts.niveau = 'SCE')
    and u.login = '${nom_utilisateur}'`

    const sql = `select 
    ts.child_id,
    ts.premier_responsable_id,
    ts.autorite_id,
    ts.child_libelle,
    ts.sigle,
    ts.niveau,
    c.email,
    c.phone
    from rohi.t_structure ts 
    LEFT join rohi.user u on ts.premier_responsable_id = u.id
    LEFT join rohi.candidat c on u.id = c.user_id
    where
    (ts.niveau = 'MIN'
    or ts.niveau = 'DG'
    or ts.niveau = 'DIR'
    or ts.niveau = 'SCE')
    and u.login = '${nom_utilisateur}'
    and ts.premier_responsable_id = (select 
    u.id
    from rohi.user u 
    where 
    u.password = (SELECT AES_ENCRYPT('${mot_de_passe}','lHommeEstNaturellementBonCEestLaSocieteQuiLeCorrompt-Rousseau')));
    `
    // let data = null
    rohi.query(email, async function(err,result){
        if(err){
            console.log(err)
            return err
        }
        else if(result.length == 0){
            // console.log(result.length)
            // data = {message: `Votre nom d'utilisateur est incorrect` }
            return {message:`Votre nom d'utilisateur est incorrect`}
        }
        else {
            // return res.json(result)
            rohi.query(sql, function(err,result){
                if(err){
                    console.log(err)
                    return {err}
                }
                else if(result.length == 0){
                    // console.log(result.length)
                    // data = {message:'Votre mot de passe est incorrect'}
                    return {message:'Votre mot de passe est incorrect'}
                    // console.log('Votre mot de passe est incorrect')
                }
                else{
                    console.log(result[0])
                    return result[0]
                }
            })
        }
    })
    // return data
}

module.exports = {
    login
}