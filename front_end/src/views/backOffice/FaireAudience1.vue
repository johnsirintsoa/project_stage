<script setup>
  import HeaderNavbar from '../../components/header/HeaderBack.vue'
</script>

<script>
    // import { createPopper } from '@popperjs/core';
    import '@fullcalendar/core/vdom'
    import FullCalendar from '@fullcalendar/vue3'
    import dayGridPlugin from '@fullcalendar/daygrid'
    import timeGridPlugin from '@fullcalendar/timegrid'
    import interactionPlugin from '@fullcalendar/interaction'
    import listPlugin from '@fullcalendar/list'
    import timeLine from '@fullcalendar/timeline'
    import { faire_audience } from '../../func/event-utils'
    import DemandeAudience from '../../api/demande_audience'
    import DemandeAudienceAutorite from '../../api/demande_audience_autorite'
    import DemandeAudienceAutoriteController from '../../controllers/BackOffice/DemandeAudienceAutoriteController'
    import tippy from 'tippy.js';
    import 'tippy.js/dist/tippy.css'; // optional for styling
    import 'tippy.js/themes/light.css';
    import Function from '../../func/function';
    import swal from 'sweetalert';
    import Swal from 'sweetalert2';
    import AutoriteAPI from '../../api/autorite';
    import frLocale from '@fullcalendar/core/locales/fr';
    
    export default {
    
      components: {
        FullCalendar
      },
    
      data() {
        return {
          calendarOptions: {
            locale: frLocale,
            plugins: [
              dayGridPlugin,
              timeGridPlugin,
              listPlugin,
              timeLine, 
              interactionPlugin // needed for dateClick
            ],
            headerToolbar: {
              left: 'prev,next today',
              center: 'title',
              right: 'dayGridMonth,timeGridWeek,timeGridDay,listDay'
            },
            initialView: 'timeGridDay',  
            // initialEvents: INITIAL_EVENTS, // alternatively, use the `events` setting to fetch from a feed
            // initialEvents: this.actual_events, // alternatively, use the `events` setting to fetch from a feed
            // initialDate: '2022-10-21',
            initialEvents: this.all_actual_events,
            // editable: true,
            selectable: false,
            droppable: false,
            selectMirror: true,
            dayMaxEvents: true,
            weekends: false,
            // select: this.handleDateSelect,
            eventClick: this.handleEventClick,
            // eventsSet: this.handleEvents,
            eventDidMount: this.detailEvent,
            slotMinTime: '08:00:00',
            slotMaxTime: '16:00:00'
            // eventResize: this.eventDragged,
            // eventDrop: this.eventDropped
            /* you can update a remote database when these fire:
            eventAdd:
            eventChange:
            eventRemove:
            */
          },
          is_clicked: false,
          currentEvents: [],
          directions: [],
          audience:{
            direction: '',
            sender:'',
            motif:'',
            date_debut: '',
            date_fin: '',
            time_debut:'',
            time_fin:'',
            id:''
          }
        }
      },
    
      created(){
        const ses = JSON.parse(sessionStorage.getItem('administrateur'))
        this.audience.sender = ses.id_autorite_enfant
        this.audience.direction = window.location.pathname.split('/')[ window.location.pathname.split('/').length-1]
      },
      
      async mounted() {
        this.directions = await this.autorites_enfant()
        // console.log(new Date().getFullYear()+"-"+parseInt(new Date().getMonth())+1+"-"+new Date().getDate())
      },
    
      methods: {
  
        async all_actual_events(){
          const ses = JSON.parse(sessionStorage.getItem('administrateur'))
          // console.log(ses.autorite_enfant.id)
          const events = await faire_audience(this.audience.sender,this.audience.direction)
          return events
        }, 

        async autorites_enfant(){
          return await AutoriteAPI.autorite_enfant()
        },

        handleWeekendsToggle() {
          this.calendarOptions.weekends = !this.calendarOptions.weekends // update a property
        },

        async list_heure_dispo(id_dm_aud_autorite_date_heure_dispo){
          const hd =  await this.all_actual_events()
          let html_value = ''
          // console.log(id_dm_aud_autorite_date_heure_dispo)
          hd.forEach(element => {
            if(id_dm_aud_autorite_date_heure_dispo == null ){
              html_value += `<option value=${element.id_date_heure_disponible}-${element.id_date_heure_disponible_autorite}>${element.hd}-${element.hf}</option>`
            }
            else{
              html_value += `<option value=${element.id_date_heure_disponible}-${element.id_date_heure_disponible_autorite} selected >${element.hd}-${element.hf}</option>`
            }
          });
          // console.log(hd)
          return html_value
        },
        
        async handleDateSelect(selectInfo) {
          // let title = prompt('Please enter a new title for your event')
          let calendarApi = selectInfo.view.calendar
          this.is_clicked = true
          
          calendarApi.unselect() // clear date selection
          if(selectInfo.startStr.includes('T') || selectInfo.endStr.includes('T')){
            this.audience.date_debut = selectInfo.startStr.split('T')[0]
            this.audience.date_fin = selectInfo.endStr.split('T')[0]
            this.audience.time_debut = selectInfo.startStr.split('T')[1].split('+')[0]
            this.audience.time_fin = selectInfo.endStr.split('T')[1].split('+')[0]
          }else{
            this.audience.date_debut = selectInfo.startStr
            this.audience.date_fin = selectInfo.endStr
            this.audience.time_debut = "10:00:00"
            this.audience.time_fin = "11:00:00"
          }

          // console.log(selectInfo)

          const { value: formValues } = await Swal.fire({
              title: 'Audience autorité',
              html:
                  `<p align="left" style="margin-left: 1rem;">De <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"> <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"> </p>` +
                  `<p align="left" style="margin-left: 1.8rem;">à <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"> <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>` +
                  `<p align="left" style="margin:3.5rem 0px 0px 0rem;">Motif<textarea id="motif" class="swal2-textarea" placeholder="Saisissez votre motif" style="display: flex;"></textarea></p>`,
              showCancelButton: true,
              confirmButtonText: 'Valider',    
              focusConfirm: false,
              preConfirm: () => {
                return [
                  document.getElementById('date1').value,
                  document.getElementById('duree1').value,
                  document.getElementById('date2').value,
                  document.getElementById('duree2').value,
                  document.getElementById('motif').value
                ]
              }
          })

          if (formValues) {
            // console.log(formValues)
            this.audience.date_debut = formValues[0]
            this.audience.time_debut = formValues[1]
            this.audience.date_fin = formValues[2]
            this.audience.time_fin = formValues[3]
            this.audience.motif = formValues[4]

            console.log(formValues)

            const ses = JSON.parse(sessionStorage.getItem('administrateur'))
            // this.audience.direction = ses.autorite_enfant.id

            const audience = {
              date_debut: this.audience.date_debut,
              date_fin: this.audience.date_fin,
              time_debut: this.audience.time_debut,
              time_fin: this.audience.time_fin,
              id_autorite_enfant_sender: this.audience.sender,
              id_autorite_enfant_receiver: this.audience.direction,
              motif: this.audience.motif
            }
            const response = await DemandeAudienceAutorite.add_audience_autorite(audience)
            console.log(response)
            if(response.code == 'ER_BAD_FIELD_ERROR'){
              swal("Audience non enregistrée", "Veuillez remplir le formulaire", "error");
            }
            else if(response.message == 'pas disponible'){
              swal("Audience non enregistrée", "Cette place est occupé ou pas disponible.", "error");
            }
            else if(response.message == 'Jour férié et pas disponible'){
              swal("Audience non enregistrée", "On est férié et le directeur n'est pas disponible", "error");
            }
            else if(response.message == 'Jour férié'){
              swal("Audience non enregistrée", "On est férié", "error");
            }
            else if(response.message == "date fin invalid"){
              swal("Audience non enregistrée", "La date de fin d'événement doit être égal à la date de début", "warning");
            }
            else if(response.message == "formulaire vide"){
              swal("Audience non enregistrée", "Veuillez remplir le formulaire", "warning");
            }
            else if(response.affectedRows == 1){
              swal("Audience enregistrée", "Votre audience a bien été enregistrée", "success");
              setInterval( () => {
                window.location.reload()
              }, 1000)
              // this.$router.push({path: '/administrateur/demande-audience/autorite/faire-audience/', params: { id_autorite_enfant: this.audience.direction }});
            }
            else if(response.message == "time fin invalid"){
              swal("Audience non enregistrée", "L'heure fin doit être supérieur à l'heure début", "warning");
            }
            // Swal.fire(JSON.stringify(formValues))
          }
        },
    
        async handleEventClick(clickInfo) {
          const start_date_time = Function.format_date_time(clickInfo.event.start)
          const end_date_time = Function.format_date_time(clickInfo.event.end)
          console.log(clickInfo.event.extendedProps)
          // const autorite_sender = {
          //   id: clickInfo.event.extendedProps.id_autorite_sender,
          //   intitule: clickInfo.event.extendedProps.intitule_sender,
          //   intitule_code: clickInfo.event.extendedProps.intitule_code_sender,
          //   addresse_electronique: clickInfo.event.extendedProps.addresse_electronique_sender
          // }
          // this.audience.sender = autorite_sender
          this.audience.id = clickInfo.event.id
          this.audience.direction = this.audience.direction
          this.audience.motif = clickInfo.event.title
          this.audience.date_debut = start_date_time[0]
          this.audience.date_fin = end_date_time[0]
          this.audience.time_debut = start_date_time[1]
          this.audience.time_fin = end_date_time[1]
          
          const status = clickInfo.event.extendedProps.status_audience
          console.log(status)
          const id_dm_aud_autorite_date_heure_dispo = clickInfo.event.extendedProps.id_dm_aud_autorite_date_heure_dispo
          if (status != '' ){
            if (status == 'Validé' || status == 'Reporté'){
              const form = await Swal.fire({
                title: `Audience ${status}`,
                confirmButtonText: 'Supprimer',
                confirmButtonColor:'#dc3741',
                showCancelButton: true,
                cancelButtonText: 'Annuler',
                html:
                  `<p align="left" style="margin-left: 1rem;">De <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input" disabled > <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input" disabled > </p>` +
                  `<p align="left" style="margin-left: 1.8rem;" disabled >à <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input" disabled > <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input" disabled ></p>` +
                  `<p align="left" style="margin:3.5rem 0px 0px 0rem;" >Motif<textarea id="motif" class="swal2-textarea"  placeholder="Saisissez votre motif" disabled style="display: flex;">${this.audience.motif}</textarea></p>
                  <p align="left" style="margin:3.5rem 0px 0px 0rem;"> Vers 
                    <select class="swal2-select" id="heure_dispo" disabled style="display: flex; margin-top: -2rem;
      margin-left: 3.7rem; width: 23.4rem;">
                      ${await this.list_heure_dispo(id_dm_aud_autorite_date_heure_dispo)}
                    </select> </p>`,
                focusConfirm: false,
                preConfirm: () => {
                  return [
                    document.getElementById('date1').value,
                    document.getElementById('duree1').value,
                    document.getElementById('date2').value,
                    document.getElementById('duree2').value,
                    document.getElementById('motif').value,
                    document.getElementById('heure_dispo').value
                  ]
                }
              }).then(async (result) =>{
                if(result.isConfirmed){
                  const response = await DemandeAudienceAutoriteController.supprimer({id:this.audience.id})
                  if(response.message){
                    swal("Audience supprimée", `${response.message}`, "success");
                    // setInterval( () => {
                    //   window.location.reload()
                    // }, 1000)
                  }
                  else {
                    swal("Erreur", "Votre audience n'a pas été supprimée", "error");
                  }
                  // setInterval( () => {
                  //   window.location.reload()
                  // }, 1000)
                }
              }).catch((err) => {
                console.log(err)
              })            
            }
            else {
              const form = await Swal.fire({
                title: 'Modifier Audience',
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: 'Modifier',
                denyButtonText: `Supprimer`,
                cancelButtonText: 'Annuler',
                html:
                  `<p align="left" style="margin-left: 1rem;">De <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input" disabled > <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input" disabled > </p>` +
                  `<p align="left" style="margin-left: 1.8rem;" disabled >à <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input" disabled > <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input" disabled ></p>` +
                  `<p align="left" style="margin:3.5rem 0px 0px 0rem;" >Motif<textarea id="motif" class="swal2-textarea"  placeholder="Saisissez votre motif" style="display: flex;">${this.audience.motif}</textarea></p>
                  <p align="left" style="margin:3.5rem 0px 0px 0rem;"> Vers 
                    <select class="swal2-select" id="heure_dispo" style="display: flex; margin-top: -2rem;
      margin-left: 3.7rem; width: 23.4rem;">
                      ${await this.list_heure_dispo(id_dm_aud_autorite_date_heure_dispo)}
                    </select> </p>`,
                focusConfirm: false,
                preConfirm: () => {
                  return [
                    document.getElementById('date1').value,
                    document.getElementById('duree1').value,
                    document.getElementById('date2').value,
                    document.getElementById('duree2').value,
                    document.getElementById('motif').value,
                    document.getElementById('heure_dispo').value
                  ]
                }
              }).then(async (result) =>{
                if(result.isConfirmed){

                  
                  const audience_event = {
                    id_date_heure_disponible: result.value[5].split('-')[0],
                    id_date_heure_disponible_autorite: result.value[5].split('-')[1],
                    id_dm_aud_autorite_date_heure_dispo: clickInfo.event.extendedProps.id_dm_aud_autorite_date_heure_dispo, 
                    motif: result.value[4],
                    id_audience: this.audience.id
                  }     
                  console.log(audience_event)             
                  const response = await DemandeAudienceAutoriteController.modifier(audience_event)
                  if(response.message){
                    swal("Audience enregistrée", "Votre audience a bien été modifiée", "success");
                    setInterval( () => {
                      window.location.reload()
                    }, 1000)
                  }
                  else {
                    swal("Audience non enregistrée", "Votre audience n'a pas été enregistrée", "error");
                  }
                }
                else if(result.isDenied){ 
                  // const response = await DemandeAudienceAutoriteController.supprimer({id:this.audience.id})
                  Swal.fire({
                      title: 'Supprimer votre audience',
                      text: "Voulez vous vraiment supprimer votre audience?",
                      icon: 'warning',
                      showCancelButton: true,
                      confirmButtonColor: '#3085d6',
                      cancelButtonColor: '#d33',
                      cancelButtonText: 'Annuler',
                      confirmButtonText: 'Supprimer!'
                    }).then(async (result) => {
                        const response = await DemandeAudienceAutoriteController.supprimer({id:this.audience.id})
                        if(response.message){
                          swal("Audience supprimée", `${response.message}`, "success");
                          // setInterval( () => {
                          //   window.location.reload()
                          // }, 1000)
                        }
                        else {
                          swal("Erreur", "Votre audience n'a pas été supprimée", "error");
                        }
                        // setInterval( () => {
                        //   window.location.reload()
                        // }, 1000)
                    }) 
                }
              }).catch((err) => {
                console.log(err)
              }) 
            }
          } 
          else{
            const { value: formValues } = await Swal.fire({
              title: 'Ajouter une audience',
              html:
                  `<p align="left" style="margin-left: 1rem;">De <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input disabled"> <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input disabled"> </p>` +
                  `<p align="left" style="margin-left: 1.8rem; disabled">à <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input disabled"> <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input disabled"></p>` +
                  `<p align="left" style="margin:3.5rem 0px 0px 0rem;">Motif<textarea id="motif" class="swal2-textarea" placeholder="Saisissez votre motif" style="display: flex;"></textarea></p>`,
              showCancelButton: true,
              // width: 600,
              confirmButtonText: 'Ajouter',    
              focusConfirm: false,
              preConfirm: () => {
                return [
                  document.getElementById('date1').value,
                  document.getElementById('duree1').value,
                  document.getElementById('date2').value,
                  document.getElementById('duree2').value,
                  document.getElementById('motif').value
                ]
              }
            })

            if (formValues) {
              // console.log(formValues)
              this.audience.date_debut = formValues[0]
              this.audience.time_debut = formValues[1]
              this.audience.date_fin = formValues[2]
              this.audience.time_fin = formValues[3]
              this.audience.motif = formValues[4]

              console.log(formValues)

              const ses = JSON.parse(sessionStorage.getItem('administrateur'))
              // this.audience.direction = ses.autorite_enfant.id

              const audience = {
                heure_debut: this.audience.time_debut,
                heure_fin: this.audience.time_fin,
                id_autorite_sender: this.audience.sender,
                id_autorite_receiver: this.audience.direction,
                id_date_heure_disponible_autorite: clickInfo.event.extendedProps.id_date_heure_disponible_autorite,
                motif: this.audience.motif
              }
              console.log(audience)
              const response = await DemandeAudienceAutoriteController.ajouter(audience)
              // console.log(response)
              if(response.message){
                swal("Audience enregistrée", `${response.message}`, "success");
                // setInterval( () => {
                //   window.location.reload()
                // }, 1000)
              }
              
              else {
                swal("Audience non enregistrée", "Votre audience n'a pas été enregistrée", "error");
              }
              // Swal.fire(JSON.stringify(formValues))
            }
          }
        },
    
        handleEvents(events) {
          this.currentEvents = events
          // console.log(events)
          // console.log(events)
        },
    
        async eventDropped(event){
          const start_date_time = Function.format_date_time(event.event.start)
          const end_date_time = Function.format_date_time(event.event.end)
          // console.log(end_date_time)
          const autorite_sender = event.event.extendedProps.sender.id
          this.audience.id = event.event.id
          this.audience.direction = this.audience.direction
          this.audience.motif = event.event.title
          this.audience.date_debut = start_date_time[0]
          this.audience.date_fin = end_date_time[0]
          this.audience.time_debut = start_date_time[1]
          this.audience.time_fin = end_date_time[1]
          
          const type_audience = event.event.extendedProps.type_audience
          const action = event.event.extendedProps.action

          if(type_audience == 'Autorite' && action == 0){
            const form = await Swal.fire({
              title: 'Modifier Audience',
              showDenyButton: true,
              showCancelButton: true,
              confirmButtonText: 'Modifier',
              denyButtonText: `Supprimer`,
              html:
                `<p align="left" style="margin-left: 1rem;">De <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"> <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"> </p>` +
                `<p align="left" style="margin-left: 1.8rem;">à <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"> <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>` +
                `<p align="left" style="margin:3.5rem 0px 0px 0rem;">Motif<textarea id="motif" class="swal2-textarea"  placeholder="Saisissez votre motif" style="display: flex;">${this.audience.motif}</textarea></p>`,
              focusConfirm: false,
              preConfirm: () => {
                return[
                  document.getElementById('date1').value,
                  document.getElementById('duree1').value,
                  document.getElementById('date2').value,
                  document.getElementById('duree2').value,
                  document.getElementById('motif').value
                ]
              }
            }).then(async (result) =>{
              if(result.isConfirmed){
                const audience_event = {
                  date_debut: result.value[0],
                  date_fin: result.value[2], 
                  time_debut: result.value[1],
                  time_fin: result.value[3],
                  id_autorite_enfant_sender: autorite_sender,
                  id_autorite_enfant_receiver: this.audience.direction ,
                  motif: result.value[4],
                  id: this.audience.id
                }                  
                const response = await DemandeAudienceAutorite.update_audience_autorite(audience_event)
                if(response.code == 'ER_BAD_FIELD_ERROR'){
                  swal("Audience non enregistrée", "Veuillez remplir le formulaire", "error");
                }
                else if(response.message == 'pas disponible'){
                  swal("Audience non enregistrée", "Cette place est occupé ou pas disponible.", "error");
                }
                else if(response.message == 'Jour férié et pas disponible'){
                  swal("Audience non enregistrée", "On est férié et le directeur n'est pas disponible", "error");
                }
                else if(response.message == 'Jour férié'){
                  swal("Audience non enregistrée", "On est férié", "error");
                }
                else if(response.message == "date fin invalid"){
                  swal("Audience non enregistrée", "La date de fin d'événement doit être égal à la date de début", "warning");
                }
                else if(response.message == "formulaire vide"){
                  swal("Audience non enregistrée", "Veuillez remplir le formulaire", "warning");
                }
                else if(response.affectedRows == 1){
                  swal("Audience enregistrée", "Votre audience a bien été enregistrée", "success");
                  setInterval( () => {
                    window.location.reload()
                  }, 1000)
                }
                else if(response.message == "time fin invalid"){
                  swal("Audience non enregistrée", "L'heure fin doit être supérieur à l'heure début", "warning");
                }
              }
              else if(result.isDenied){                 
                await DemandeAudienceAutorite.delete_audience_autorite({id:this.audience.id})
                Swal.fire('Audience supprimer', 'Votre Audience a bien été supprimée', 'success')
                // setInterval( () => {
                //   window.location.reload()
                // }, 1000)
              }
            }).catch((err) => {
              console.log(err)
            }) 
    
          }
        },
    
        async eventDragged(event) {
          const start_date_time = Function.format_date_time(event.event.start)
          const end_date_time = Function.format_date_time(event.event.end)
          // console.log(end_date_time)
          const autorite_sender = event.event.extendedProps.sender.id
          this.audience.id = event.event.id
          this.audience.direction = this.audience.direction
          this.audience.motif = event.event.title
          this.audience.date_debut = start_date_time[0]
          this.audience.date_fin = end_date_time[0]
          this.audience.time_debut = start_date_time[1]
          this.audience.time_fin = end_date_time[1]
          
          const type_audience = event.event.extendedProps.type_audience
          const action = event.event.extendedProps.action

          if(type_audience == 'Autorite' && action == 0){
            const form = await Swal.fire({
              title: 'Modifier Audience',
              showDenyButton: true,
              showCancelButton: true,
              confirmButtonText: 'Modifier',
              denyButtonText: `Supprimer`,
              html:
                `<p align="left" style="margin-left: 1rem;">De <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"> <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"> </p>` +
                `<p align="left" style="margin-left: 1.8rem;">à <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"> <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>` +
                `<p align="left" style="margin:3.5rem 0px 0px 0rem;">Motif<textarea id="motif" class="swal2-textarea"  placeholder="Saisissez votre motif" style="display: flex;">${this.audience.motif}</textarea></p>`,
              focusConfirm: false,
              preConfirm: () => {
                return[
                  document.getElementById('date1').value,
                  document.getElementById('duree1').value,
                  document.getElementById('date2').value,
                  document.getElementById('duree2').value,
                  document.getElementById('motif').value
                ]
              }
            }).then(async (result) =>{
              // console.log(result)
              if(result.isConfirmed){
                const audience_event = {
                  date_debut: result.value[0],
                  date_fin: result.value[2], 
                  time_debut: result.value[1],
                  time_fin: result.value[3],
                  id_autorite_enfant_sender: autorite_sender,
                  id_autorite_enfant_receiver: this.audience.direction ,
                  motif: result.value[4],
                  id: this.audience.id
                }                  
                const response = await DemandeAudienceAutorite.update_audience_autorite(audience_event)
                if(response.code == 'ER_BAD_FIELD_ERROR'){
                  swal("Audience non enregistrée", "Veuillez remplir le formulaire", "error");
                }
                else if(response.message == 'pas disponible'){
                  swal("Audience non enregistrée", "Cette place est occupé ou pas disponible.", "error");
                }
                else if(response.message == 'Jour férié et pas disponible'){
                  swal("Audience non enregistrée", "On est férié et le directeur n'est pas disponible", "error");
                }
                else if(response.message == 'Jour férié'){
                  swal("Audience non enregistrée", "On est férié", "error");
                }
                else if(response.message == "date fin invalid"){
                  swal("Audience non enregistrée", "La date de fin d'événement doit être égal à la date de début", "warning");
                }
                else if(response.message == "formulaire vide"){
                  swal("Audience non enregistrée", "Veuillez remplir le formulaire", "warning");
                }
                else if(response.affectedRows == 1){
                  swal("Audience enregistrée", "Votre audience a bien été enregistrée", "success");
                  setInterval( () => {
                    window.location.reload()
                  }, 1000)
                }
                else if(response.message == "time fin invalid"){
                  swal("Audience non enregistrée", "L'heure fin doit être supérieur à l'heure début", "warning");
                }
              }
              else if(result.isDenied){                 
                await DemandeAudienceAutorite.delete_audience_autorite({id:this.audience.id})
                Swal.fire('Audience supprimer', 'Votre Audience a bien été supprimée', 'success')
                // setInterval( () => {
                //   window.location.reload()
                // }, 1000)
              }
            }).catch((err) => {
              console.log(err)
            }) 
    
          }     
        },
    
        detailEvent(info) {
          // console.log(info.event)
          
          if(info.event.extendedProps.id_autorite_sender){
            tippy(info.el, {
              theme:'light',
              content: `<p><strong>${info.event.title}</strong></p>
              <p> De ${Function.date_in_string(info.event.start)} à ${Function.date_in_string(info.event.end)}</p>
              <p>Autorité: <strong>${info.event.extendedProps.intitule_receiver}</strong></p>
              <p><span style="background-color: ${info.event.extendedProps.color_status};" class="dot"></span>  ${info.event.extendedProps.status_audience}</p>`,
              allowHTML: true,
              delay:[1000,0]
            });
          } 
        },
      }
    }
</script>

<template>
<HeaderNavbar/>
<main id="main-audience" class="main-audience">
    <div  class='demo-app' >
        <!-- <div  class='demo-app-sidebar'> -->
        
        <div class='demo-app-main'>
        <FullCalendar
            ref="fullCalendar"
            class='demo-app-calendar'
            :options='calendarOptions'
        >
            <template v-slot:eventContent='arg'>
            <b>{{ arg.timeText }}</b>
            <i>{{ arg.event.title }}</i>
            </template>
        </FullCalendar>
        </div>
    </div>
</main>
</template>
<style lang='css'>

@import url('./css/style.css');
</style>
    