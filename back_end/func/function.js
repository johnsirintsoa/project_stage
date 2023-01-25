    // date
// const 

const genererNbr = () => {
    return  Math.floor(Math.random() * 2000000);
}

function date_in_string(date) {
    const date_splited = date.split('T')
    let mois = [
        'Janvier',
        'Février',
        'Mars',
        'Avril',
        'Mai',
        'Juin',
        'Juillet',
        'Aout',
        'Septembre',
        'Octobre',
        'Novembre',
        'Décembre'
    ]
    // console.log(date_splited[0])
    const date_new_format = date_splited[0].split('-')
    const index_mois = parseInt(date_new_format[1])-1
    let date_string = `${date_new_format[2]} ${mois[index_mois]} ${date_new_format[0]} à ${date_splited[1]}`;
    // console.log(date_string)
    return date_string
}

module.exports = {date_in_string,genererNbr }