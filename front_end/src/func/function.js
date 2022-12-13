// import DemandeAudiencePublic from '../api/demande_audience_public'
export default class Function{

    static initcap(arg){
        const arg_split = arg.split(' ')
        let name_formatted = ''
        for (let index = 0; index < arg_split.length; index++) {
            const element = arg_split[index];
            const char0  = element.charAt(0).toUpperCase()
            const charN = element.substring(1).toLowerCase()
            name_formatted = name_formatted.concat(char0.concat(charN),' ')
        }
        return name_formatted.trim()
    }

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


    static format_date_time(date) {
        const date_arg = {
            annee: new Date(date).getFullYear(),
            mois: new Date(date).getMonth(),
            date: new Date(date).getDate(),
            heure: new Date(date).getHours(),
            minute: new Date(date).getMinutes(),
            second: new Date(date).getSeconds()
        }
        const date_time = []
        const date_split = date.toLocaleString("fr").split(' ')
        date_time[0] = date_split[0].split('/')[2].concat("-",date_split[0].split('/')[1],"-",date_split[0].split('/')[0])
        date_time[1]=date_split[1] 
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
            let newValue = { value: "session".concat(Function.random_number(0,1000)),expirationDate: date_expiration }  
            sessionStorage.setItem(key, JSON.stringify(newValue))
        }
    }

    static format_date_html(date){
        const date_grid = String(date).split(' ')
        const mois_dot = [
            "janv.",
            "févr.",
            "mars",
            "avr.",
            "mai",
            "juin",
            "juil.",
            "août",
            "sept.",
            "oct.",
            "nov.",
            "déc."
        ]
        if(date_grid.length == 2){
            // date = new Date().getDate()+" "+date
            const mois = parseInt(new Date(date).getMonth())+1
            date = new Date(date).getFullYear()+"-"+mois+"-"+new Date().getDate()
        }
        else if(date_grid.length == 3){
            const mois = parseInt(new Date(date).getMonth())+1
            date = new Date(date).getFullYear()+"-"+mois+"-"+new Date().getDate()
        }
        else if(date_grid.length == 5){
            date = date_grid[date_grid.length-1].concat("-",mois_dot.indexOf(date_grid[3])+1,"-",date_grid[0])
        }
        else if(date_grid.length == 6){
            date = date_grid[date_grid.length-1].concat("-",mois_dot.indexOf(date_grid[1])+1,"-",date_grid[0])
            // console.log(date_grid)
        }
        return date
    }

    static time_plus_30_min(date){
        const duree_decalage = 30
        return this.format_date_time(new Date(date.getTime() + (60000 * duree_decalage)))[1]
    }

}