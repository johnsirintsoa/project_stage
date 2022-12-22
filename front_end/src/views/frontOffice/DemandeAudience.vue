
<script>
    // import { createPopper } from '@popperjs/core';
    import '@fullcalendar/core/vdom'
    import FullCalendar from '@fullcalendar/vue3'
    import dayGridPlugin from '@fullcalendar/daygrid'
    import timeGridPlugin from '@fullcalendar/timegrid'
    import interactionPlugin from '@fullcalendar/interaction'
    import listPlugin from '@fullcalendar/list'
    import timeLine from '@fullcalendar/timeline'
    import { actual_events_public } from '../../controllers/FrontOffice/DemandeAudience'
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
              right: 'dayGridMonth,timeGridWeek,timeGridDay,listDay',
              // right: 'timeGridDay,listDay',

              
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
            slotMinTime: '08:00:00',
            slotMaxTime: '16:00:00'
            // eventResize: this.eventDragged,
            // eventDrop: this.eventDropped,
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
        // console.log(Function.initcap('hAGA'))
      },

      async mounted() {
        
      },
      methods: {
        async all_actual_events(){
          // return await actual_events()
          return await actual_events_public(this.audience.direction)  
        }, 
        async autorites_enfant(){
          return await AutoriteAPI.autorite_enfant()
        },
        handleWeekendsToggle() {
          this.calendarOptions.weekends = !this.calendarOptions.weekends // update a property
        },
        
        async promise_array_to_map(){
          const array = await this.all_actual_events()
          const map = new Map()

          array.forEach(element => {
            const id = [
              element.id_date_heure_disponible,
              element.id_date_heure_disponible_autorite
            ]
            // const id = element.id_date_heure_disponible_autorite
            const hd = element.hd 
            const hf = element.hf
            map.set(id,hd+' - '+hf)
            // console.log('Obejct '+element.id_heure_disponible+': '+element.heure_debut+' - '+element.heure_fin)
          });
          return map
        },

        async list_heure_dispo(id_dm_aud_public_heure_dispo){
          const hd =  await this.all_actual_events()
          let html_value = ''
          hd.forEach(element => {
            if(id_dm_aud_public_heure_dispo != null){
              html_value += `<option value=${element.id_heure_disponible} selected >${element.hd} - ${element.hf}</option>`
            }
            else{
              html_value += `<option value=${element.id_heure_disponible}>${element.hd} - ${element.hf}</option>`
            }
          });
          console.log(hd)
          return html_value
        },

        async handleEventClick(clickInfo) {
          // console.log(clickInfo.event.id)
          
          this.audience.id = clickInfo.event.id
          this.audience.nom = clickInfo.event.extendedProps.nom
          this.audience.prenom = clickInfo.event.extendedProps.prenom
          this.audience.motif = clickInfo.event.title
          this.audience.cin = clickInfo.event.extendedProps.cin
          this.audience.numero_telephone = clickInfo.event.extendedProps.numero_telephone
          this.audience.email = clickInfo.event.extendedProps.email
          this.audience.time_debut = clickInfo.event.extendedProps.heure_debut
          this.audience.time_fin = clickInfo.event.extendedProps.heure_fin
          this.audience.date_debut = clickInfo.event.extendedProps.date_disponible
          this.audience.date_fin = clickInfo.event.extendedProps.date_disponible

          if(clickInfo.event.id != ''){
            const sa = clickInfo.event.extendedProps.status_audience
            const id_dm_aud_public_heure_dispo = clickInfo.event.extendedProps.id_dm_aud_public_heure_dispo

            let id_date_heure_disponible = clickInfo.event.extendedProps.id_date_heure_disponible
            let id_date_heure_disponible_autorite = clickInfo.event.extendedProps.id_date_heure_disponible_autorite
            
            if(sa == 'Non validé'){
              console.log('On peut modifier ou supprimer')
              Swal.fire({
                title: 'Voulez vous modifier votre audience ?',
                width: 700,
                html: `<p>Nom: <input type="text" id="nom" class="swal2-input" value="${this.audience.nom}" placeholder="Nom" required></p>
                <p>Prénom: <input type="text" id="prenom" class="swal2-input" value="${this.audience.prenom}" placeholder="Prénom" required></p>
                <p>CIN: <input type="text" id="cin" class="swal2-input" value="${this.audience.cin}" placeholder="CIN" pattern="[0-9]{12}" required></p>
                <p>Tél: <input type="text" id="telephone" class="swal2-input" value="${this.audience.numero_telephone}" placeholder="Numéro de téléphone" pattern="[0-9]{10}"  required></p>
                <p>Mail: <input type="email" id="mail" class="swal2-input" value="${this.audience.email}" placeholder="Adresse éléctronique" required></p>
                <p style="text-align: left;padding: 3rem 3rem 3rem 3rem;">Motif: <textarea id="motif" class="swal2-textarea" placeholder="Saisissez votre motif " style="display: flex;">${this.audience.motif}</textarea></p>`,
                input: 'select',
                inputOptions: await this.promise_array_to_map(),
                inputValidator: (value) => {
                  const id = value.split(',')
                  id_date_heure_disponible = id[0]
                  id_date_heure_disponible_autorite = id[1]
                
                },
                preConfirm: () => {
                  this.audience.nom = Swal.getPopup().querySelector('#nom').value
                  this.audience.prenom = Swal.getPopup().querySelector('#prenom').value
                  this.audience.cin = Swal.getPopup().querySelector('#cin').value
                  this.audience.numero_telephone = Swal.getPopup().querySelector('#telephone').value
                  this.audience.email = Swal.getPopup().querySelector('#mail').value
                  this.audience.motif = Swal.getPopup().querySelector('#motif').value
                  
                  return { 
                    nom: this.audience.nom, 
                    prenom: Function.initcap(this.audience.prenom), 
                    cin: this.audience.cin,
                    numero_telephone: this.audience.numero_telephone,
                    email: this.audience.email,
                    motif: this.audience.motif,
                    id_audience: this.audience.id,
                    id_date_heure_disponible: id_date_heure_disponible,
                    id_dm_aud_public_heure_dispo: id_dm_aud_public_heure_dispo,
                    id_date_heure_disponible_autorite: id_date_heure_disponible_autorite
                  }
                },
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: 'Modifier',
                denyButtonText: `Supprimer`,
                cancelButtonText: 'Annuler',
              }).then(async (result) => {
                
                if (result.isConfirmed) {
                  const response = await DemandeAudiencePublicController.modifier(result.value)
                  if(response.message){
                    swal("Audience enregistrée", `${response.message}`, "success");
                  }
                  else{
                    swal("Audience n'est pas enregistrée", "Votre audience n'a pas été enregistrée", "error");
                  }
                  // Swal.fire('Saved!', '', 'success')
                } else if (result.isDenied) {
                  const response = await DemandeAudiencePublicController.supprimer(this.audience.id)
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
                      const response = await DemandeAudiencePublicController.supprimer(id_audience)
                      Swal.fire(
                        'Audience supprimée',
                        `Votre audience a bien été supprimée`,
                        'success'
                      )
                      // setInterval( () => {
                      //   window.location.reload()
                      // }, 1000)
                  }) 
                }
              })
            }
            else if (sa == 'Validé'){
              console.log(clickInfo.event.id)
              const id_audience = clickInfo.event.id
              const id_heure_disponible = clickInfo.event.extendedProps.id_heure_disponible
              Swal.fire({
                title: 'Supprimer une audience',
                text: "Voulez vous vraiment supprimer votre audience?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: 'Annuler',
                confirmButtonText: 'Supprimer!'
              }).then(async (result) => {
                if (result.isConfirmed) {
                  const infos_audience = {
                    id_aud_public: id_audience,
                    id_heure_dispo: id_heure_disponible
                  } 
                  console.log(infos_audience)
                  const response = await DemandeAudiencePublicController.supprimer(id_audience)
                  Swal.fire(
                    'Audience supprimé',
                    `Votre audience a bien été supprimée`,
                    'success'
                  )
                  // setInterval( () => {
                  //   window.location.reload()
                  // }, 1000)
                }
              }) 
            }
          }
          else{
            const start_date_time = Function.format_date_time(clickInfo.event.start)
            const end_date_time = Function.format_date_time(clickInfo.event.end)
            this.audience.date_debut = start_date_time[0]
            this.audience.date_fin = end_date_time[0]
            this.audience.time_debut = start_date_time[1]
            this.audience.time_fin = end_date_time[1]
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
                  prenom: Function.initcap(this.audience.prenom), 
                  cin: this.audience.cin,
                  numero_telephone: this.audience.numero_telephone,
                  email: this.audience.email,
                  motif: this.audience.motif,
                  session_navigateur: this.audience.session_navigateur,
                  date_audience: this.audience.date_debut,
                  heure_debut: this.audience.time_debut,
                  heure_fin: this.audience.time_fin,
                  id_date_heure_disponible_autorite: clickInfo.event.extendedProps.id_date_heure_disponible_autorite
                }
              }
            }).then(async (result) => {
              console.log(result)
              const response = await DemandeAudiencePublicController.ajouter(result.value)
              if(response.message){
                swal("Audience enregistrée", `${response.message}`, "success");
              }
              else{
                swal("Audience non enregistrée", "Votre audience n'a pas été enregistrée", "error");
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
        }
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
