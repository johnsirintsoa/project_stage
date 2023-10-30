const rohi = require('../database').rohi

const isAutorite = function (id) {
    const sql = `select 
    ts.child_id,
    ts.premier_responsable_id,
    ts.autorite_id,
    ts.child_libelle,
    ts.sigle,
    ts.niveau,
    c.email,
    c.phone
    from t_structure ts 
    LEFT join user u on ts.premier_responsable_id = u.id
    LEFT join candidat c on u.id = c.user_id
    where
    (ts.niveau = 'MIN'
    or ts.niveau = 'DG'
    or ts.niveau = 'DIR'
    or ts.niveau = 'SCE')
    and ts.child_id = ${id}`

    
    rohi.then((rohi) => {
        rohi.query(sql, function(err,result){
            if(err){
                console.log(err)
                return {err}
            }
            else if(result.length == 0){
                // console.log(result.length)
                // data = {message:'Votre mot de passe est incorrect'}
                // return {message:'Votre mot de passe est incorrect'}
                // console.log('Votre mot de passe est incorrect')
                return false
            }
            else{
                return true
                // console.log(result[0])
                // return result[0]
            }
        })
    }).catch((err) => {
        throw err 
     });
    // return data
}


module.exports = {
    isAutorite
}