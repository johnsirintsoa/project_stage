export default class Function{
    // nombre aleatoire
    static random_number(min, max) {
        return Math.random() * (max - min) + min;
    }

    static date_in_string(date) {
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
        let date_string = `${date_new_format[2]} ${mois[index_mois]} ${date_new_format[0]} ${date_splited[1]}`;
        // console.log(date_string)
        return date_string
    }

    static split_date_time(date){
        const date_time_split = date.toISOString().split('T')[0]
        const new_date = date_time_split[0];
        const time = date_time_split[1].split('+')[0]
        console.log(date_time_split)
        return {date:new_date,time:time}
    }

    // set sessionStorage
    static session_navigateur(date_expiration) {
        const key='session_navigateur'
        let stringValue = sessionStorage.getItem(key)
        // console.log(stringValue)  
        if(sessionStorage.getItem(key) !== null) {
            let value = JSON.parse(stringValue)
            // console.log(value.expirationDate)        
            let expirationDate = new Date(value.expirationDate) 
            // console.log(expirationDate+' session_expired') 
            if(expirationDate < new Date()){
                sessionStorage.removeItem(key)
            }
        }else{
            let newValue = { value: "session".concat(Function.random_number(0,1000)),expirationDate: date_expiration.toISOString() }  
            sessionStorage.setItem(key, JSON.stringify(newValue))
        }
    }
}