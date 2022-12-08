
<script>
    // import { createPopper } from '@popperjs/core';
    import '@fullcalendar/core/vdom'
    import FullCalendar from '@fullcalendar/vue3'
    import dayGridPlugin from '@fullcalendar/daygrid'
    import timeGridPlugin from '@fullcalendar/timegrid'
    import interactionPlugin from '@fullcalendar/interaction'
    import listPlugin from '@fullcalendar/list'
    import timeLine from '@fullcalendar/timeline'
    import { actual_events_public_jour } from '../../controllers/FrontOffice/DemandeAudience'
    import DemandeAudience from '../../api/demande_audience_public'
    import tippy from 'tippy.js';
    import 'tippy.js/dist/tippy.css'; // optional for styling
    import 'tippy.js/themes/light.css';
    import Function from '../../func/function';
    import swal from 'sweetalert';
    import AutoriteAPI from '../../api/autorite';
    import Swal from 'sweetalert2';
    import frLocale from '@fullcalendar/core/locales/fr';
    import DemandeAudiencePublicController from '../../controllers/FrontOffice/DemandeAudience'

    
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
              // right: 'dayGridMonth,timeGridWeek,timeGridDay,listDay',
              right: 'timeGridDay,listDay',

              
            },
            // initialView: 'dayGridMonth',
            initialView: 'timeGridDay',
            // initialEvents: INITIAL_EVENTS, // alternatively, use the `events` setting to fetch from a feed
            // initialEvents: this.actual_events, // alternatively, use the `events` setting to fetch from a feed
            // initialDate: '2022-10-21',
            initialEvents: this.all_actual_events,
            // editable: true,
            // buttonIcons: false, // show the prev/next text
            weekNumbers: true,
            dayMaxEvents: true,
            // selectable: true,
            droppable: true,
            selectMirror: true,
            dayMaxEvents: true,
            weekends: false,
            select: this.handleDateSelect,
            eventClick: this.handleEventClick,
            // eventsSet: this.handleEvents,
            eventDidMount: this.detailEvent,
            eventResize: this.eventDragged,
            eventDrop: this.eventDropped,
            // Overlap: true
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
            direction: window.location.pathname.split('/')[ window.location.pathname.split('/').length-1],
            nom:'',
            prenom:'',  
            motif:'',
            cin:'',
            numero_telephone:'',
            email:'',
            date_debut: '',
            date_fin: '',
            time_debut:'',
            time_fin:'',
            session_navigateur:'',
            id:''
          }
        }
      },

      async created(){
        this.directions = await this.autorites_enfant()

        this.audience.session_navigateur = JSON.parse(sessionStorage.getItem('session_navigateur')).value
        // this.audience.session_navigateur = 'TEST123456789'
      },

      async mounted() {
        // this.directions = await this.autorites_enfant()
        // const init_events = this.calendarOptions.initialEvents
        // console.log(init_events)
        // Function.set_intial_events(this.audience.direction,init_events);
        // console.log(this.calendarOptions.initialEvents)
      },
      methods: {
        async all_actual_events(){
          // return await actual_events()
          return await actual_events_public_jour(this.audience.direction)  
        }, 
        async autorites_enfant(){
          return await AutoriteAPI.autorite_enfant()
        },
        handleWeekendsToggle() {
          this.calendarOptions.weekends = !this.calendarOptions.weekends // update a property
        },
        
        handleDateSelect(selectInfo) {
          // let title = prompt('Please enter a new title for your event')
          let calendarApi = selectInfo.view.calendar
          this.is_clicked = true
          this.audience.nom = ''
          this.audience.prenom = ''  
          this.audience.motif = ''
          this.audience.cin = ''
          this.audience.numero_telephone = ''
          // calendarApi.unselect() // clear date selection
          // console.log(selectInfo.startStr)
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
        },
    
        async handleEventClick(clickInfo) {
          // console.log(clickInfo.event.id)
          console.log(clickInfo.event)
          Swal.fire({
            title: 'Ajouter un audience',
            html: `<p>Nom: <input type="text" id="nom" class="swal2-input" placeholder="Nom" required></p>
            <p>Prénom: <input type="text" id="prenom" class="swal2-input" placeholder="Prénom" required></p>
            <p>CIN: <input type="text" id="cin" class="swal2-input" placeholder="CIN" pattern="[0-9]{12}" required></p>
            <p>Tél: <input type="text" id="telephone" class="swal2-input" placeholder="Numéro de téléphone" pattern="[0-9]{10}"  required></p>
            <p>Mail: <input type="email" id="mail" class="swal2-input" placeholder="Adresse éléctronique" required></p>
            <p style="text-align: left;padding: 3rem 3rem 3rem 3rem;">Motif: <textarea id="motif" class="swal2-textarea" placeholder="Saisissez votre motif " style="display: flex;"></textarea></p>`,
            inputAttributes: {
              input: 'text',
              required: 'true'
            },
            confirmButtonText: 'Ajouter',
            heightAuto: true,
            cancelButtonText: 'Annuler',
            showCancelButton: true,
            focusConfirm: false,
            preConfirm: () => {

              this.audience.nom = Swal.getPopup().querySelector('#nom').value
              this.audience.prenom = Swal.getPopup().querySelector('#prenom').value
              this.audience.cin = Swal.getPopup().querySelector('#cin').value
              this.audience.numero_telephone = Swal.getPopup().querySelector('#telephone').value
              this.audience.email = Swal.getPopup().querySelector('#mail').value
              this.audience.motif = Swal.getPopup().querySelector('#motif').value

              // if (!this.audience.nom || !this.audience.prenom || !this.audience.cin || !this.audience.numero_telephone || !this.audience.email || !this.audience.motif) {
              //   Swal.showValidationMessage(`Veuillez remplir le formulaire`)
              // }
              return { 
                nom: this.audience.nom, 
                prenom: this.audience.prenom, 
                cin: this.audience.cin,
                numero_telephone: this.audience.numero_telephone,
                email: this.audience.email,
                motif: this.audience.motif,
                session_navigateur: this.audience.session_navigateur,
                id_autorite: this.audience.direction,
                id_heure_dispo: clickInfo.event.extendedProps.id_heure_disponible
              }
            }
          }).then(async (result) => {
            console.log(result)
            const data = await DemandeAudiencePublicController.ajouter(result.value)
            console.log(data)
            // Swal.fire(`
            //   Login: ${result.value.login}
            //   Password: ${result.value.password}
            // `.trim())
          })
        },
    
        handleEvents(events) {
          // this.currentEvents = events
          // console.log(events)
          // console.log(events)
          // console.log(events)
        },

        async eventDropped(event){
          console.log(event.event)
          const start_date_time = Function.format_date_time(event.event.start)
          const end_date_time = Function.format_date_time(event.event.end)
          this.audience.id = event.event.id
          // this.audience.direction = event.event.extendedProps.id_autorite_enfant
          this.audience.motif = event.event.title
          this.audience.date_debut = start_date_time[0]
          this.audience.date_fin = end_date_time[0]
          this.audience.time_debut = start_date_time[1]
          this.audience.time_fin = end_date_time[1]
          this.audience.nom = event.event.extendedProps.nom 
          this.audience.prenom = event.event.extendedProps.prenom
          this.audience.cin = event.event.extendedProps.cin
          this.audience.numero_telephone = event.event.extendedProps.numero_telephone
          this.audience.email = event.event.extendedProps.email
      
          if(event.event.extendedProps.status_audience == 'Non validé'){
            const form = await Swal.fire({
              title: 'Modifier votre audience',
              html:
                  `<p align="left" style="margin-left: 2.6rem;">De <input type=Date style="width:10rem;" value="${this.audience.date_debut}" id="date1" class="swal2-input"> <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"> </p>` +
                  `<p align="left" style="margin-left: 3.4rem;">à <input type=Date style="width:10rem;" value="${this.audience.date_fin}" id="date2" class="swal2-input" > <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>` +
                  `<p align="left" style="margin:3.5rem 0px 0px 1.5rem;">Motif<textarea id="motif" class="swal2-textarea" placeholder="Saisissez votre motif" style="display: flex;padding-right: 6.3rem;">${this.audience.motif}</textarea></p>`+
                  `<p align="left" style="margin-left: 1.6rem;">Nom <input type=text value="${this.audience.nom}" id="nom" class="swal2-input" style="width:21.4rem"> </p>`+
                  `<p align="left" style="margin-left: 0px;">Prénom <input type=text value="${this.audience.prenom}" id="prenom" class="swal2-input" style="width:21.4rem"></p>` +
                  `<p align="left" style="margin-left: 32px;">CIN <input type=number value="${this.audience.cin}" id="cin" class="swal2-input" style="width:21.4rem"></p>` +
                  `<p align="left" style="margin-left: 38px;">Tél <input type=number value="${this.audience.numero_telephone}" id="numero_telephone" class="swal2-input" style="width:21.4rem"></p>` +
                  `<p align="left" style="margin-left: 29px;">mail <input type=email value="${this.audience.email}" id="email" class="swal2-input" style="width:21.4rem"></p>`,
              showCancelButton: true,
              confirmButtonText: 'Valider',    
              focusConfirm: false,
              preConfirm: () => {
                return [
                  document.getElementById('date1').value,
                  document.getElementById('duree1').value,
                  document.getElementById('date2').value,
                  document.getElementById('duree2').value,
                  document.getElementById('motif').value,
                  document.getElementById('nom').value, 
                  document.getElementById('prenom').value, 
                  document.getElementById('cin').value,  
                  document.getElementById('numero_telephone').value,                  
                  document.getElementById('email').value,                  
                ]
              }
            }).then( async(result) => {
              if(result.isConfirmed){
                console.log(result.value)
                const audience_event = {
                  date_event_debut: result.value[0],
                  date_event_fin: result.value[2], 
                  time_event_debut: result.value[1],
                  time_event_fin: result.value[3],
                  motif: result.value[4],
                  nom:result.value[5],                  
                  prenom:result.value[6],
                  cin:result.value[7],
                  numero_telephone:result.value[8],
                  email:result.value[9],
                  session_navigateur: this.audience.session_navigateur,
                  id_autorite_enfant: this.audience.direction,
                  id: this.audience.id
                }                
                const response = await DemandeAudiencePublicController.update(audience_event)
                if(response.message){
                  swal("Audience non enregistrée", `${response.message}`, "error");
                }
                else{
                  swal("Audience enregistrée", "Votre audience a bien été enregistrée", "success");
                }
              }
            }).catch((err) => {
              console.log(err)
            });
          } 
          
        },

        async eventDragged(event){
          console.log(event.event)
          const start_date_time = Function.format_date_time(event.event.start)
          const end_date_time = Function.format_date_time(event.event.end)
          this.audience.id = event.event.id
          // this.audience.direction = event.event.extendedProps.id_autorite_enfant
          this.audience.motif = event.event.title
          this.audience.date_debut = start_date_time[0]
          this.audience.date_fin = end_date_time[0]
          this.audience.time_debut = start_date_time[1]
          this.audience.time_fin = end_date_time[1]
          this.audience.nom = event.event.extendedProps.nom 
          this.audience.prenom = event.event.extendedProps.prenom
          this.audience.cin = event.event.extendedProps.cin
          this.audience.numero_telephone = event.event.extendedProps.numero_telephone
          this.audience.email = event.event.extendedProps.email
      
          if(event.event.extendedProps.status_audience == 'Non validé'){
            const form = await Swal.fire({
              title: 'Modifier votre audience',
              html:
                  `<p align="left" style="margin-left: 2.6rem;">De <input type=Date style="width:10rem;" value="${this.audience.date_debut}" id="date1" class="swal2-input"> <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"> </p>` +
                  `<p align="left" style="margin-left: 3.4rem;">à <input type=Date style="width:10rem;" value="${this.audience.date_fin}" id="date2" class="swal2-input" > <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>` +
                  `<p align="left" style="margin:3.5rem 0px 0px 1.5rem;">Motif<textarea id="motif" class="swal2-textarea" placeholder="Saisissez votre motif" style="display: flex;padding-right: 6.3rem;">${this.audience.motif}</textarea></p>`+
                  `<p align="left" style="margin-left: 1.6rem;">Nom <input type=text value="${this.audience.nom}" id="nom" class="swal2-input" style="width:21.4rem"> </p>`+
                  `<p align="left" style="margin-left: 0px;">Prénom <input type=text value="${this.audience.prenom}" id="prenom" class="swal2-input" style="width:21.4rem"></p>` +
                  `<p align="left" style="margin-left: 32px;">CIN <input type=number value="${this.audience.cin}" id="cin" class="swal2-input" style="width:21.4rem"></p>` +
                  `<p align="left" style="margin-left: 38px;">Tél <input type=number value="${this.audience.numero_telephone}" id="numero_telephone" class="swal2-input" style="width:21.4rem"></p>` +
                  `<p align="left" style="margin-left: 29px;">mail <input type=email value="${this.audience.email}" id="email" class="swal2-input" style="width:21.4rem"></p>`,
              showCancelButton: true,
              confirmButtonText: 'Valider',    
              focusConfirm: false,
              preConfirm: () => {
                return [
                  document.getElementById('date1').value,
                  document.getElementById('duree1').value,
                  document.getElementById('date2').value,
                  document.getElementById('duree2').value,
                  document.getElementById('motif').value,
                  document.getElementById('nom').value, 
                  document.getElementById('prenom').value, 
                  document.getElementById('cin').value,  
                  document.getElementById('numero_telephone').value,                  
                  document.getElementById('email').value,                  
                ]
              }
            }).then( async(result) => {
              if(result.isConfirmed){
                console.log(result.value)
                const audience_event = {
                  date_event_debut: result.value[0],
                  date_event_fin: result.value[2], 
                  time_event_debut: result.value[1],
                  time_event_fin: result.value[3],
                  motif: result.value[4],
                  nom:result.value[5],                  
                  prenom:result.value[6],
                  cin:result.value[7],
                  numero_telephone:result.value[8],
                  email:result.value[9],
                  session_navigateur: this.audience.session_navigateur,
                  id_autorite_enfant: this.audience.direction,
                  id: this.audience.id
                }                
                const response = await DemandeAudiencePublicController.update(audience_event)
                if(response.message){
                  swal("Audience non enregistrée", `${response.message}`, "error");
                }
                else{
                  swal("Audience enregistrée", "Votre audience a bien été enregistrée", "success");
                }
              }
            }).catch((err) => {
              console.log(err)
            });
          } 
        },

        detailEvent(info) {
          // console.log(info.event)
          
          if(info.event.extendedProps.status_audience){
            tippy(info.el, {
              theme:'light',
              content: `<p><strong>${info.event.title}</strong></p>
              <p> De ${Function.date_in_string(info.event.start)} à ${Function.date_in_string(info.event.end)}</p>
              <p><span style="background-color: ${info.event.extendedProps.color_status};" class="dot"></span>  ${info.event.extendedProps.status_audience}</p>`,
              allowHTML: true,
              delay:[1000,0]
            });
          }
        },

        remove_event(){
          this.is_clicked = false
          this.audience.motif = '',
          this.audience.date_debut = '',
          this.audience.date_fin = '',
          this.audience.time_debut = '',
          this.audience.time_fin = '',
          this.audience.id = ''
        },

        // add event
        async add_event(){
          const audience_event = {
            date_event_debut: this.audience.date_debut,
            date_event_fin: this.audience.date_fin, 
            time_event_debut: this.audience.time_debut,
            time_event_fin: this.audience.time_fin,
            motif: this.audience.motif,
            id_autorite_enfant: this.audience.direction,
            nom: this.audience.nom,
            prenom :this.audience.prenom,
            cin : this.audience.cin,
            numero_telephone :this.audience.numero_telephone,
            email: this.audience.email,
            session_navigateur: this.audience.session_navigateur
            // session_navigateur: JSON.parse(sessionStorage.getItem("session_navigateur")).value
          }

          const response = await DemandeAudiencePublicController.add(audience_event)
          if(response.message){
            swal("Audience non enregistrée", `${response.message}`, "error");
                        // window.location.reload()
          }
          else{
            swal("Audience enregistrée", "Votre audience a bien été enregistrée", "success");
            setInterval( () => {
              window.location.reload()
            }, 1000)
          }
          // console.log(response)
          // const response =  await DemandeAudience.add_event(audience_event)
          // console.log(audience_event)
          // console.log(response)
          // if(response.code == 'ER_BAD_FIELD_ERROR'){
          //   swal("Audience non enregistrée", "Veuillez remplir le formulaire", "error");
          // }
          // else if(response.message == 'pas disponible'){
          //   swal("Audience non enregistrée", "Cette place est occupé ou pas disponible.", "error");
          // }
          // else if(response.message == 'Jour férié et pas disponible'){
          //   swal("Audience non enregistrée", "On est férié et le directeur n'est pas disponible", "error");
          // }
          // else if(response.message == 'Jour férié'){
          //   swal("Audience non enregistrée", "On est férié", "error");
          // }
          // else if(response.message == "date fin invalid"){
          //   swal("Audience non enregistrée", "La date de fin d'événement doit être égal à la date de début", "warning");
          // }
          // else if(response.message == "formulaire vide"){
          //   swal("Audience non enregistrée", "Veuillez remplir le formulaire", "warning");
          // }
          // else if(response.affectedRows == 1){
          //   swal("Audience enregistrée", "Votre audience a bien été enregistrée", "success");
          //   // window.location.reload()
          //   // setInterval( () => {
          //   //   window.location.reload()
          //   // }, 1000)
          // }
          // else if(response.message == "time fin invalid"){
          //   swal("Audience non enregistrée", "L'heure fin doit être supérieur à l'heure début", "warning");
          // }
          // setInterval( () => {
          //   window.location.reload()
          // }, 1000)
        },
      }
    }
</script>
<template>
    <main id="main-audience" class="main-audience">
        <div  class='demo-app' >
            <!-- <div  class='demo-app-sidebar'> -->
            <div v-if="is_clicked" class='demo-app-sidebar'>
              <div class='demo-app-sidebar-section'>
                  <h1>Prendre un rendez-vous</h1>
                  <form class="form-audience">
                      <ul>
                      <li id="li_date_time_debut">De <input id="date_debut" name="date_debut" type="date" required v-model="audience.date_debut"  />  <input id="time_debut" name="time_debut" type="time" required v-model="audience.time_debut"  /></li>
                      <li id="li_date_time_fin">à <input id="date_fin" name="date_fin" type="date" required v-model="audience.date_fin"  />  <input id="time_fin" name="time_fin" type="time" required v-model="audience.time_fin"  /></li>
                      <li id="li_motif"> Motif <textarea id="input_motif" name="motif" required v-model="audience.motif" placeholder="Motif"></textarea></li>
                      <li id="li_nom">Nom <input id="nom" name="nom" type="text" required v-model="audience.nom"  placeholder="Nom"/></li>
                      <li id="li_prenom">Prénom <input id="prenom" name="prenom" type="text" required v-model="audience.prenom" placeholder="Prénom"/></li>
                      <!-- <li id="li_prenom">Prénom</li> -->
                      <li id="li_cin">CIN <input id="cin" name="cin" type="text" required v-model="audience.cin" placeholder="CIN"/></li>
                      <li id="li_telephone">Tél <input id="numero_telephone" name="numero_telephone" type="text" required v-model="audience.numero_telephone" placeholder="Numéro de téléphone"/></li>
                      <li id="li_email">email <input id="email" name="email" type="email" required v-model="audience.email" placeholder="Addresse email"/></li>
                      <!-- <li>Type audience: <input v-model="audience.type_audience" placeholder="Type d'audience..." /></li> -->
                      <li id="li_button_event"> 
                        <button type="button" class="btn btn-light" @click="remove_event()">Annuler</button>
                        <button type="button" class="btn btn-primary" @click="add_event()">Valider</button>
                      </li>
                      </ul>
                  </form>
              </div>
            <div class='demo-app-sidebar-section'>
                <ul>
                <li v-for='event in currentEvents' :key='event.id'>
                    <b>{{ event.startStr }}</b>
                    <b>{{ event.endStr }}</b>
                    <i>{{ event.title }}</i>
                </li>
                </ul>
            </div>
            </div>
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
    <div id="test">
      Hello world
    </div>
</template>
<style lang='css'>
  @import url('./css/style.css');    
</style>
