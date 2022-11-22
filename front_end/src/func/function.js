// import DemandeAudiencePublic from '../api/demande_audience_public'
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

    // static set_intial_events(id_autorite,initialEvents){
    //     // fullcalendar button left
    //     const parDom1 = document.getElementsByClassName("fc-toolbar-chunk")
    //     const parDom2 = parDom1[2].getElementsByClassName("fc-button-group")
    //     const dayGridDom = parDom2[0].getElementsByClassName("fc-dayGridMonth-button fc-button fc-button-primary")
    //     const timeGridWeekDom = parDom2[0].getElementsByClassName("fc-timeGridWeek-button fc-button fc-button-primary")
    //     const timeGridDayDom = parDom2[0].getElementsByClassName("fc-timeGridDay-button fc-button fc-button-primary")
    //     const listDayGridDom = parDom2[0].getElementsByClassName("fc-listDay-button fc-button fc-button-primary")
    //     // fullcalendar button left

    //     // fullcalendar button right
    //     const parDom3 = parDom1[0].getElementsByClassName("fc-button-group")
    //     const precedentButton = parDom3[0].getElementsByClassName("fc-prev-button fc-button fc-button-primary")
    //     const nextButton = parDom3[0].getElementsByClassName("fc-next-button fc-button fc-button-primary")
    //     const todayGridDom = parDom1[0].getElementsByClassName("fc-today-button fc-button fc-button-primary")
    //     // fullcalendar button right

    //     dayGridDom[0].addEventListener("click",async ()=>{
    //         console.log('DayGridMonth clicked...')
    //         let date_html = parDom1[1].getElementsByClassName("fc-toolbar-title")[0].innerHTML
    //         const date_du_jour = this.format_date_html(date_html)
    //         const audience_by_jour = {
    //             id_autorite:id_autorite,
    //             date_du_jour:date_du_jour
    //         }
    //         const data = await DemandeAudiencePublic.audience_public_mois(audience_by_jour)
    //         console.log(data)
    //         // this.format_date_html(date_html)
    //     })

    //     timeGridWeekDom[0].addEventListener("click",async ()=>{
    //         let date_html = parDom1[1].getElementsByClassName("fc-toolbar-title")[0].innerHTML
    //         console.log('timeGridWeek clicked...')
    //         // this.format_date_html(date_html)
    //         const date_actu = this.format_date_html(date_html)
    //         console.log(date_actu)
    //         const audience_by_jour = {
    //             id_autorite: id_autorite,
    //             date_du_jour: date_actu
    //         }
    //         // console.log('timeGridWeek clicked...')
    //         const data = await DemandeAudiencePublic.audience_public_semaine(audience_by_jour)
    //         console.log(data)
    //     })

    //     timeGridDayDom[0].addEventListener("click",async ()=>{
    //         let date_html = parDom1[1].getElementsByClassName("fc-toolbar-title")[0].innerHTML
    //         console.log('timeGridDay clicked...')
    //         const date_actu = this.format_date_html(date_html)
    //         console.log(date_actu)
    //         const audience_by_jour = {
    //             id_autorite:id_autorite,
    //             date_du_jour:date_actu
    //         }
    //         const data = await DemandeAudiencePublic.audience_public_jour(audience_by_jour)
    //         initialEvents = data
    //         console.log(data)
    //     })

    //     listDayGridDom[0].addEventListener("click",async ()=>{
    //         let date_html = parDom1[1].getElementsByClassName("fc-toolbar-title")[0].innerHTML
    //         console.log('listDayGrid clicked...')
    //         // this.format_date_html(date_html)
    //         const date_du_jour = this.format_date_html(date_html)
    //         const audience_by_jour = {
    //             id_autorite:id_autorite,
    //             date_du_jour:date_du_jour
    //         }
    //         const data = await DemandeAudiencePublic.audience_public_jour(audience_by_jour)
    //         console.log(data)
    //     })

    //     todayGridDom[0].addEventListener("click",()=>{
    //         let date_html = parDom1[1].getElementsByClassName("fc-toolbar-title")[0].innerHTML
    //         console.log('todayGridDom clicked...')
    //         this.format_date_html(date_html)
    //     })

    //     precedentButton[0].addEventListener("click",()=>{
    //         let date_html = parDom1[1].getElementsByClassName("fc-toolbar-title")[0].innerHTML
    //         console.log('precedentButton clicked...')
    //         this.format_date_html(date_html)
    //     })

    //     nextButton[0].addEventListener("click",()=>{
    //         let date_html = parDom1[1].getElementsByClassName("fc-toolbar-title")[0].innerHTML
    //         console.log('nextButton clicked...')
    //         this.format_date_html(date_html)
    //     })
    // }
}