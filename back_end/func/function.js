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
    const date_new_format = date_splited[0].split('-')
    const index_mois = parseInt(date_new_format[1])-1
    let date_string = `${date_new_format[2]} ${mois[index_mois]} ${date_new_format[0]} à ${date_splited[1]}`;
    return date_string
}

function upSetFirstLetter(arg){
    let argTolower = arg.toLowerCase()
    let argLowerSplited = argTolower.split(' ')
    let newArg = ''
    argLowerSplited.forEach(word => {
        let firstLetter = word.charAt(0).toUpperCase()
		let Allletter = word.substring(1)
		let newWord = firstLetter+Allletter+' '
		newArg+=newWord
    });
    return newArg.trim()
}

module.exports = {date_in_string,genererNbr,upSetFirstLetter }