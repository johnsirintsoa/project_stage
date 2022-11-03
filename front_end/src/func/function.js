export default class Function{
    // nombre aleatoire
    static random_number(min, max) {
        return Math.random() * (max - min) + min;
    }

    static date_in_string(date) {
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
        // console.log(date)
        const num_date = new Date(date).getDate()
        const index_mois = new Date(date).getMonth()
        const annee = new Date(date).getFullYear()
        if(new Date(date).getMinutes()==0){
            return num_date+" "+mois[index_mois]+" "+annee+" "+new Date(date).getHours()+"h0"+new Date(date).getMinutes()+"min"
        }
        return num_date+" "+mois[index_mois]+" "+annee+" "+new Date(date).getHours()+"h"+new Date(date).getMinutes()+"min"
    }
    
    static format_time_hhmmss(time){
        const hour = parseInt(time.split(':')[0])
        if(hour < 10 && hour>0){
            return '0'.concat(time)
        }
        return time
    }
    
    static format_time = (date) =>{
        if(new Date(date).getMinutes()==0){
            return new Date(date).getHours()+"h0"+new Date(date).getMinutes()+"min"
        }else{
            return new Date(date).getHours()+"h"+new Date(date).getMinutes()+"min"
        }
        
    }

    
    static foramt_date_time(date) {
        const date_time = []
        const mois = new Date(date).getMonth()+1
        date_time[0] = new Date(date).getFullYear()+"-"+mois+"-"+new Date(date).getDate()
        date_time[1] = new Date(date).getHours()+":"+new Date(date).getMinutes()+":"+"00"
        if(new Date(date).getMinutes()==0){
            date_time[1] = new Date(date).getHours()+":0"+new Date(date).getMinutes()+":"+"00"
        }
        // console.log(date_time)
        return date_time
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