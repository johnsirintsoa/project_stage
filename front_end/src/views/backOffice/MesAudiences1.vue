<script setup>
  // Mes Audience V1
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
    import { actual_events_autorite} from '../../func/event-utils'
    import DemandeAudience from '../../api/demande_audience'
    import EntretienDemandeStage from '../../api/entretien_stage'
    import NonDispoAutoriteDate from '../../api/pas_dispo_date'
    import NonDispoAutoriteJour from '../../api/pas_dispo_jour'
    import tippy from 'tippy.js';
    import 'tippy.js/dist/tippy.css'; // optional for styling
    import 'tippy.js/themes/light.css';
    import Function from '../../func/function';
    import swal from 'sweetalert';
    import Swal from 'sweetalert2';
    import AutoriteAPI from '../../api/autorite';
    import frLocale from '@fullcalendar/core/locales/fr';
    import dm_autorite_controller from '../../controllers/BackOffice/DemandeAudienceAutoriteController'
    import dm_public_controller from '../../controllers/BackOffice/DemandeAudiencePublicController'
    

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
            selectable: true,
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
            slotMinTime: '08:00:00',
            slotMaxTime: '16:00:00'
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
            motif:'',
            date_debut: '',
            date_fin: '',
            time_debut:'',
            time_fin:'',
            id:''
          }
        }
      },
    
      async created(){
        const ses = JSON.parse(sessionStorage.getItem('administrateur'))
        this.audience.direction = ses.id_autorite_enfant
      },
      
      async mounted() {
        this.directions = await this.autorites_enfant()
        // console.log(new Date().getFullYear()+"-"+parseInt(new Date().getMonth())+1+"-"+new Date().getDate())
      },
    
      methods: {
    

        async all_actual_events(){
          return await actual_events_autorite(this.audience.direction)  
        }, 

        async autorites_enfant(){
          return await AutoriteAPI.autorite_enfant()
        },

        handleWeekendsToggle() {
          this.calendarOptions.weekends = !this.calendarOptions.weekends // update a property
        },

        swal_voir_detail(obj){
          console.log(obj)
        },

        swal_reporting(obj){
          console.log(obj)
        },

        liste_evenements_inclus(response){
          let html_value = ''
          console.log(response)
          response.forEach(element => {
            console.log(element)
            html_value +=
              `<tr>
                <td>${element.id}</td>
                <td>${element.title}</td>
                <td>${element.type_evenement}</td>
                <td>${element.status_evenement}</td>
              </tr>`
          });
          return html_value
        },

        async handleDateSelect(selectInfo) {
          // let title = prompt('Please enter a new title for your event')
          let calendarApi = selectInfo.view.calendar
          this.is_clicked = true
    
          // calendarApi.unselect() // clear date selection
          // console.log(selectInfo)
          if(selectInfo.startStr.includes('T') || selectInfo.endStr.includes('T')){
            this.audience.date_debut = selectInfo.startStr.split('T')[0]
            this.audience.date_fin = selectInfo.endStr.split('T')[0]
            this.audience.time_debut = selectInfo.startStr.split('T')[1].split('+')[0]
            this.audience.time_fin = selectInfo.endStr.split('T')[1].split('+')[0]
          }
          else{
            this.audience.date_debut = selectInfo.startStr
            this.audience.date_fin = selectInfo.endStr
            this.audience.time_debut = "10:00:00"
            this.audience.time_fin = "11:00:00"
          }
          const inputOptions = new Promise((resolve) => {
            setTimeout(() => {
              resolve({
                'today': `Aujourd'hui`,
                'per_day': 'Autre jour'
              })
            }, 0)
          })

          const { value: type_de_disponibilite } = await Swal.fire({
            title: 'Choisissez entre',
            input: 'radio',
            inputOptions: inputOptions,

            inputValidator: (value) => {
              if (!value) {
                return 'Vous devez en choisir un'
              }
            }
          })
          if (type_de_disponibilite == 'today') { 
            const { value: formValues } = await Swal.fire({
              title: 'Je suis pas disponible',
              html:
                  `<p align="left" style="margin-left: 1rem;">De <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"> <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"> </p>` +
                  `<p align="left" style="margin-left: 1.8rem;">à <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"> <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>`, 
              showCancelButton: true,
              confirmButtonText: 'Valider',    
              focusConfirm: false,
              preConfirm: () => {
                return [
                  document.getElementById('date1').value,
                  document.getElementById('duree1').value,
                  document.getElementById('date2').value,
                  document.getElementById('duree2').value,
                ]
              }
            })

            if (formValues) {
              // console.log(formValues)
              this.audience.date_debut = formValues[0]
              this.audience.time_debut = formValues[1]
              this.audience.date_fin = formValues[2]
              this.audience.time_fin = formValues[3]

              // console.log(formValues)

              const ses = JSON.parse(sessionStorage.getItem('administrateur'))
              // this.audience.direction = ses.autorite_enfant.id

              const audience = {
                date_debut: this.audience.date_debut,
                date_fin: this.audience.date_fin,
                time_debut: this.audience.time_debut,
                time_fin: this.audience.time_fin,
                id_autorite: this.audience.direction,
                id: this.audience.id
              }    
              const response = await NonDispoAutoriteDate.add_non_disponible_date(audience)
              console.log(response)
              if(response.length > 0){
                const data = await Swal.fire({
                  title:'Evénements inclus',
                  width:600,
                  html: `
                  <div class="card">
                    <div class="card-body">
                      <table class="table table-hover">
                        <thead>
                          <tr>
                            <th scope="col"></th>
                            <th scope="col">Motif</th>
                            <th scope="col">Type</th>
                            <th scope="col">Status</th>
                          </tr>
                        </thead>
                        <tbody>
                          ${this.liste_evenements_inclus(response)}
                        </tbody>
                      </table>

                    </div>
                  </div>`,
                  confirmButtonText:'Valider',
                  showCancelButton:true,
                  cancelButtonText:'Annuler',
                  
                }).then(async (result) => {
                  if(result.isConfirmed){
                    const response = await NonDispoAutoriteDate.insert(audience)
                    swal("Evènement enregistré", "L'évènement a bien été enregistré", "success");
                    setInterval( () => {
                      window.location.reload()
                    }, 1000)
                  }
                }).catch((err) => {
                  console.log(err)
                })
              }
              else {
                swal("Evènement enregistré", "L'évènement a bien été enregistré", "success");
                setInterval( () => {
                  window.location.reload()
                }, 1000)
              }
            } 
          }
          else if(type_de_disponibilite == 'per_day'){
            console.log(new Date(this.audience.date_debut).getDay())
            let checked1 = ''
            let checked2 = ''
            let checked3 = ''
            let checked4 = ''
            let checked5 = ''
            if(new Date(this.audience.date_debut).getDay() == 1){
              checked1 = 'checked'
            }
            else if(new Date(this.audience.date_debut).getDay() == 2){
              checked2 = 'checked'
            }
            else if(new Date(this.audience.date_debut).getDay() == 3){
              checked3 = 'checked'
            }
            else if(new Date(this.audience.date_debut).getDay() == 4){
              checked4 = 'checked'
            }
            else if(new Date(this.audience.date_debut).getDay() == 5){
              checked5 = 'checked'
            }
            const { value: formValues } = await Swal.fire({
                title: 'Je suis pas disponible',
                html:
                    `<p align="left" style="margin-left: 2rem;">De <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"> <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>` +
                    `<p align="left" style="margin-left: 0rem;margin-top: 3rem;" >chaque 
                      <div id="swal2-radio" class="swal2-radio" style="display: flex;margin-top: -2.4rem;margin-left: 1.5rem;">
                        <label><input type="radio" id="1" name="swal2-radio" value="Monday" ${checked1}><span class="swal2-label">L</span></label>
                        <label><input type="radio" id="2" name="swal2-radio" value="Tuesday" ${checked2}><span class="swal2-label">M</span></label>
                        <label><input type="radio" id="3" name="swal2-radio" value="Wednesday" ${checked3}><span class="swal2-label">M</span></label>
                        <label><input type="radio" id="4" name="swal2-radio" value="Thursday" ${checked4}><span class="swal2-label">J</span></label>
                        <label><input type="radio" id="5" name="swal2-radio" value="Friday" ${checked5}><span class="swal2-label">V</span></label>
                      </div>
                    </p>`,
                showCancelButton: true,
                confirmButtonText: 'Valider',    
                focusConfirm: false,
                preConfirm: () => {
                  let jour_checked = ''
                  for (let index = 1; index <= 5 ; index++) {
                    const jour = document.getElementById(index)
                    if(jour.checked == true){
                      jour_checked = jour.value
                      break
                    }
                  }
                  return [
                    document.getElementById('duree1').value,
                    document.getElementById('duree2').value,
                    jour_checked
                  ]
                }
            })
            if (formValues) {
              const audience = {
                time_non_dispo_jour_debut: this.audience.time_debut,
                time_non_dispo_jour_fin: this.audience.time_fin,
                jour_date: formValues[2],
                id_autorite: this.audience.direction
              }
              const response = await NonDispoAutoriteJour.add_non_disponible_jour(audience)
              // console.log(response)
              if(response.length > 0){
                const data = await Swal.fire({
                  title:'Evénements inclus',
                  width:800,
                  html: `
                  <div class="card">
                    <div class="card-body">
                      <table class="table table-hover">
                        <thead>
                          <tr>
                            <th scope="col"></th>
                            <th scope="col">Motif</th>
                            <th scope="col">Type</th>
                            <th scope="col">Status</th>
                          </tr>
                        </thead>
                        <tbody>
                          ${this.liste_evenements_inclus(response)}
                        </tbody>
                      </table>

                    </div>
                  </div>`,
                  confirmButtonText:'Valider',
                  showCancelButton:true,
                  cancelButtonText:'Annuler'
                }).then(async (result) => {
                  if(result.isConfirmed){
                    const response = await NonDispoAutoriteJour.insert(audience)
                    swal("Evènement enregistré", "L'évènement a bien été enregistré", "success");
                    setInterval( () => {
                      window.location.reload()
                    }, 1000)
                  }
                }).catch((err) => {
                  console.log(err)
                })
              }
              else {
                swal("Evènement enregistré", "L'évènement a bien été enregistré", "success");
                setInterval( () => {
                  window.location.reload()
                }, 1000)
              }        
            }
          } 
        },
    
        async handleEventClick(clickInfo) {
          
          const start_date_time = Function.format_date_time(clickInfo.event.start)
          const end_date_time = Function.format_date_time(clickInfo.event.end)
          // console.log(end_date_time)
          this.audience.id = clickInfo.event.id
          this.audience.direction = this.audience.direction
          this.audience.motif = clickInfo.event.extendedProps.motif
          this.audience.date_debut = start_date_time[0]
          this.audience.date_fin = end_date_time[0]
          this.audience.time_debut = start_date_time[1]
          this.audience.time_fin = end_date_time[1]
          
          const type_audience = clickInfo.event.extendedProps.type_audience
          const action = clickInfo.event.extendedProps.status_audience

          console.log(clickInfo.event.title)
          // Swal.fire({
          //   title:`${clickInfo.event.title}`,
          //   html: `<p>Nom: <input type="text" id="nom" class="swal2-input" placeholder="Nom" required disabled></p>
          //   <p>Prénom: <input type="text" id="prenom" class="swal2-input" placeholder="Prénom" required disabled></p>
          //   <p>CIN: <input type="text" id="cin" class="swal2-input" placeholder="CIN" pattern="[0-9]{12}" required disabled></p>
          //   <p>Tél: <input type="text" id="telephone" class="swal2-input" placeholder="Numéro de téléphone" pattern="[0-9]{10}"  required disabled></p>
          //   <p>Mail: <input type="email" id="mail" class="swal2-input" placeholder="Adresse éléctronique" required disabled></p>
          //   <p style="text-align: left;padding: 3rem 3rem 3rem 3rem;">Motif: <textarea id="motif" class="swal2-textarea" placeholder="Saisissez votre motif " style="display: flex;" disabled></textarea></p>`
          // })
          if(type_audience == 'Public' && action == 'Non validé'){
              const { value: formValues } = await Swal.fire({
                title: 'Validation',
                showCancelButton: true,
                confirmButtonText: 'Valider',
                html:
                  `<p>Date début: <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"></p>` +
                  `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                  `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"></p>`+
                  `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>`,
                focusConfirm: false,
                preConfirm: () => {
                  return[
                    document.getElementById('date1').value,
                    document.getElementById('date2').value,
                    document.getElementById('duree1').value,
                    document.getElementById('duree2').value
                  ]
                }
              })
    
            if (formValues) {
              this.audience.date_debut = formValues[0]
              this.audience.date_fin = formValues[1]
              this.audience.time_debut = formValues[2]
              this.audience.time_fin = formValues[3]

              console.log(clickInfo.event)
              const audience_event = {
                // IN id_dm_aud_public_date_heure_dispo int,IN id_audience INT,IN date_debut date,IN date_fin date,IN heure_debut time,in heure_fin time, IN id_autorite INT
                id_dm_aud_public_date_heure_dispo: clickInfo.event.id,
                autorite: clickInfo.event.extendedProps.autorite,
                sender: clickInfo.event.extendedProps.sender,
                date_debut: this.audience.date_debut,
                date_fin: this.audience.date_fin, 
                heure_debut: this.audience.time_debut,
                heure_fin: this.audience.time_fin,
                id_autorite: this.audience.direction,
                motif: this.audience.motif,
                id: this.audience.id
              }
              const response = await dm_public_controller.valider(audience_event)
              if(response.data){
                Swal.fire('Succès',`${response.message}`,'success')
                // setInterval( () => {
                //   window.location.reload()
                // }, 1000)
              }
              else{
                Swal.fire('Error',`${response.message}`,'error')
              }
            }
          }
          else if(type_audience == 'Autorité' && action == 'Non validé'){
            const { value: formValues } = await Swal.fire({
              title: 'Validation',
              showCancelButton: true,
              confirmButtonText: 'Valider',
              html:
              `<p>Date début: <input type=Date value="${this.audience.date_debut}"  id="date1" class="swal2-input"></p>` +
              `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
              `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"></p>`+
              `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>`,
              focusConfirm: false,
              preConfirm: () => {
                return[
                  document.getElementById('date1').value,
                  document.getElementById('date2').value,
                  document.getElementById('duree1').value,
                  document.getElementById('duree2').value
                ]
              }
            })
    
            if (formValues) {
              // console.log(JSON.stringify(formValues))
              this.audience.date_debut = formValues[0]
              this.audience.date_fin = formValues[1]
              this.audience.time_debut = formValues[2]
              this.audience.time_fin = formValues[3]
              // console.log(this.audience)
              const audience_event = {
                autorite: clickInfo.event.extendedProps.autorite,
                sender: clickInfo.event.extendedProps.sender,
                date_debut: this.audience.date_debut,
                date_fin: this.audience.date_fin, 
                time_debut: this.audience.time_debut,
                time_fin: this.audience.time_fin,
                id_autorite_enfant_receiver: this.audience.direction,
                id_autorite_enfant_sender: clickInfo.event.extendedProps.sender.id,
                motif: this.audience.motif,
                id: this.audience.id
              }
              // console.log(audience_event)
              const response = await dm_autorite_controller.valider(audience_event)
              if(response.data){
                Swal.fire('Succès',`${response.message}`,'success')
                // setInterval( () => {
                //   window.location.reload()
                // }, 1000)
              }
              else{
                Swal.fire('Error',`${response.message}`,'error')
              }
            }
          }
          else if(type_audience == 'Public' && action == 'Validé'){
            const form = await Swal.fire({
              title: 'A reporter',
              showDenyButton: true,
              showCancelButton: true,
              confirmButtonText: 'Maintenant',
              denyButtonText:'Plus tard',
              html:
                `<p>Date début: <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"></p>` +
                `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"></p>`+
                `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>`,
              focusConfirm: false,
              preConfirm: () => {
                return [
                  document.getElementById('date1').value,
                  document.getElementById('date2').value,
                  document.getElementById('duree1').value,
                  document.getElementById('duree2').value
                ]
              }
            }).then(async (result) => {
                if(result.isConfirmed){
                  const audience_event = {
                    autorite: clickInfo.event.extendedProps.autorite,
                    sender: clickInfo.event.extendedProps.sender,
                    date_debut: result.value[0],
                    date_fin: result.value[1], 
                    time_debut: result.value[2],
                    time_fin: result.value[3],
                    id_autorite_enfant: this.audience.direction ,
                    motif: this.audience.motif,
                    id: this.audience.id
                  }                
                  const response = await dm_public_controller.reporter_maintenant(audience_event)
                  if(response.data){
                    Swal.fire('Succès',`${response.message}`,'success')
                    setInterval( () => {
                      window.location.reload()
                    }, 1000)
                  }
                  else{
                    Swal.fire('Error',`${response.message}`,'error')
                  }
                  
                }
                else if(result.isDenied){
                  // console.log(audience.sender)
                  const audience_event = {
                    autorite: clickInfo.event.extendedProps.autorite,
                    sender: clickInfo.event.extendedProps.sender,
                    date_debut: this.audience.date_debut,
                    date_fin: this.audience.date_fin,
                    time_debut: this.audience.time_debut,
                    time_fin: this.audience.time_fin,
                    id_autorite_enfant: this.audience.direction,
                    motif: this.audience.motif,
                    id: this.audience.id
                  }                  
                  const response = await dm_public_controller.reporter_plus_tard(audience_event)
                  if(response.data){
                    Swal.fire('Succès',`${response.message}`,'success')
                    setInterval( () => {
                      window.location.reload()
                    }, 1000)
                  }
                  else{
                    Swal.fire('Error',`${response.message}`,'error')
                  }
                }
              }).catch((err) => {
                console.log(err)
              })
    
            // if (formValues) {
            //   Swal.fire(JSON.stringify(formValues))
            // }        
          }
          else if(type_audience == 'Autorite' && action == 'Validé'){
            const { value: formValues } = await Swal.fire({
              title: 'A reporter',
              showDenyButton: true,
              showCancelButton: true,
              confirmButtonText: 'Maintenant',
              denyButtonText:'Plus tard',
              html:
                `<p>Date début: <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"></p>` +
                `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"></p>`+
                `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>`,
              focusConfirm: false,
              preConfirm: () => {
                return[
                  document.getElementById('date1').value,
                  document.getElementById('date2').value,
                  document.getElementById('duree1').value,
                  document.getElementById('duree2').value
                ]
              } 
            }).then(async (result) => {
              // console.log(result)
              if(result.isConfirmed){
                const audience_event = {
                  
                  date_debut: result.value[0],
                  date_fin: result.value[1], 
                  time_debut: result.value[2],
                  time_fin: result.value[3],
                  id_autorite_enfant_receiver: this.audience.direction ,
                  id_autorite_enfant_sender: clickInfo.event.extendedProps.sender.id,
                  motif: this.audience.motif,
                  id: this.audience.id
                }                  
                await DemandeAudience.reporter_autorite_maintenant(audience_event)
                Swal.fire('Succès','Vous avez reportée avec succès','success')
                setInterval( () => {
                  window.location.reload()
                }, 1000)
              }
              else if(result.isDenied){
                // console.log(audience.sender)
                const audience_event = {
                  date_debut: this.audience.date_debut,
                  date_fin: this.audience.date_fin,
                  time_debut: this.audience.time_debut,
                  time_fin: this.audience.time_fin,
                  id_autorite_enfant_receiver: this.audience.direction,
                  id_autorite_enfant_sender: clickInfo.event.extendedProps.sender.id,
                  motif: this.audience.motif,
                  id: this.audience.id
                }                  
                await DemandeAudience.reporter_autorite_plus_tard(audience_event)
                Swal.fire('Audience reporter plus tard', '', 'info')
                setInterval( () => {
                  window.location.reload()
                }, 1000)
              }
            }).catch((err) => {
              console.log(err)
            });                                    
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
          this.audience.id = event.event.id
          this.audience.direction = this.audience.direction
          this.audience.motif = event.event.title
          this.audience.date_debut = start_date_time[0]
          this.audience.date_fin = end_date_time[0]
          this.audience.time_debut = start_date_time[1]
          this.audience.time_fin = end_date_time[1]
          console.log(event.event.extendedProps)
    
          if(event.event.extendedProps.type_audience == 'Public'){
            if(event.event.extendedProps.status_audience == 'Validé'){
              const form = await Swal.fire({
                title: 'A reporter',
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: 'Maintenant',
                denyButtonText:'Plus tard',
                html:
                  `<p>Date début: <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"></p>` +
                  `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                  `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"></p>`+
                  `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>`,
                focusConfirm: false,
                preConfirm: () => {
                  return [
                    document.getElementById('date1').value,
                    document.getElementById('date2').value,
                    document.getElementById('duree1').value,
                    document.getElementById('duree2').value
                  ]
                }
              }).then(async (result) => {
                if(result.isConfirmed){
                  const audience_event = {
                    autorite: event.event.extendedProps.autorite,
                    sender: event.event.extendedProps.sender,
                    date_debut: result.value[0],
                    date_fin: result.value[1], 
                    time_debut: result.value[2],
                    time_fin: result.value[3],
                    id_autorite_enfant: this.audience.direction ,
                    motif: this.audience.motif,
                    id: this.audience.id
                  }                
                  const response = await dm_public_controller.reporter_maintenant(audience_event)
                  if(response.data){
                    Swal.fire('Succès',`${response.message}`,'success')
                    setInterval( () => {
                      window.location.reload()
                    }, 1000)
                  }
                  else{
                    Swal.fire('Error',`${response.message}`,'error')
                  }
                  
                }
                else if(result.isDenied){
                  // console.log(audience.sender)
                  const audience_event = {
                    autorite: event.event.extendedProps.autorite,
                    sender: event.event.extendedProps.sender,
                    date_debut: this.audience.date_debut,
                    date_fin: this.audience.date_fin,
                    time_debut: this.audience.time_debut,
                    time_fin: this.audience.time_fin,
                    id_autorite_enfant: this.audience.direction,
                    motif: this.audience.motif,
                    id: this.audience.id
                  }                  
                  const response = await dm_public_controller.reporter_plus_tard(audience_event)
                  if(response.data){
                    Swal.fire('Succès',`${response.message}`,'success')
                    // setInterval( () => {
                    //   window.location.reload()
                    // }, 1000)
                  }
                  else{
                    Swal.fire('Error',`${response.message}`,'error')
                  }
                }
              }).catch((err) => {
                console.log(err)
              })
            }
            else if(event.event.extendedProps.status_audience == 'Non validé'){
              // console.log('Pas encore validé...')
              const { value: formValues } = await Swal.fire({
                title: 'Validation',
                showCancelButton: true,
                confirmButtonText: 'Valider',
                html:
                  `<p>Date début: <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"></p>` +
                  `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                  `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"></p>`+
                  `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>`,
                focusConfirm: false,
                preConfirm: () => {
                  return [
                    document.getElementById('date1').value,
                    document.getElementById('date2').value,
                    document.getElementById('duree1').value,
                    document.getElementById('duree2').value
                  ]
                }
              })
              if (formValues) {
                this.audience.date_debut = formValues[0]
                this.audience.date_fin = formValues[1]
                this.audience.time_debut = formValues[2]
                this.audience.time_fin = formValues[3]
                // console.log(this.audience)
                const audience_event = {
                  //IN id_dm_aud_public_date_heure_dispo int,IN id_audience INT,IN date_debut date,IN date_fin date,IN heure_debut time,in heure_fin time, IN id_autorite INT
                  autorite: event.event.extendedProps.autorite,
                  sender: event.event.extendedProps.sender,
                  date_debut: this.audience.date_debut,
                  date_fin: this.audience.date_fin, 
                  heure_debut: this.audience.time_debut,
                  heure_fin: this.audience.time_fin,
                  id_autorite_enfant: this.audience.direction,
                  motif: this.audience.motif,
                  id: this.audience.id
                }
                const response = await dm_public_controller.valider(audience_event)
                if(response.data){
                  Swal.fire('Succès',`${response.message}`,'success')
                  // setInterval( () => {
                  //   window.location.reload()
                  // }, 1000)
                }
                else{
                  Swal.fire('Error',`${response.message}`,'error')
                }
              }
            }
          }
          else if(event.event.extendedProps.type_audience == 'Autorité'){
            if(event.event.extendedProps.status_audience == 'Non validé'){
              const { value: formValues } = await Swal.fire({
                title: 'Validation',
                showCancelButton: true,
                confirmButtonText: 'Valider',
                html:
                `<p>Date début: <input type=Date value="${this.audience.date_debut}"  id="date1" class="swal2-input"></p>` +
                `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"></p>`+
                `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>`,
                focusConfirm: false,
                preConfirm: () => {
                  return[
                    document.getElementById('date1').value,
                    document.getElementById('date2').value,
                    document.getElementById('duree1').value,
                    document.getElementById('duree2').value
                  ]
                }
              })
    
              if (formValues) {
                  // console.log(JSON.stringify(formValues))
                this.audience.date_debut = formValues[0]
                this.audience.date_fin = formValues[1]
                this.audience.time_debut = formValues[2]
                this.audience.time_fin = formValues[3]
                // console.log(this.audience)
                const audience_event = {
                  autorite: event.event.extendedProps.autorite,
                  sender: event.event.extendedProps.sender,
                  date_debut: this.audience.date_debut,
                  date_fin: this.audience.date_fin, 
                  time_debut: this.audience.time_debut,
                  time_fin: this.audience.time_fin,
                  id_autorite_enfant_receiver: this.audience.direction,
                  id_autorite_enfant_sender: event.event.extendedProps.sender.id,
                  motif: this.audience.motif,
                  id: this.audience.id
                }
                const response = await dm_autorite_controller.valider(audience_event)
                if(response.data){
                  Swal.fire('Succès',`${response.message}`,'success')
                  setInterval( () => {
                    window.location.reload()
                  }, 1000)
                }
                else{
                  Swal.fire('Error',`${response.message}`,'error')
                }
              }
            }
            else if(event.event.extendedProps.status_audience == 'Validé'){
              const form = await Swal.fire({
              title: 'A reporter',
              showDenyButton: true,
              showCancelButton: true,
              confirmButtonText: 'Maintenant',
              denyButtonText:'Plus tard',
              html:
                `<p>Date début: <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"></p>` +
                `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"></p>`+
                `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>`,
              focusConfirm: false,
              preConfirm: () => {
                return[
                  document.getElementById('date1').value,
                  document.getElementById('date2').value,
                  document.getElementById('duree1').value,
                  document.getElementById('duree2').value
                ]
              } 
            }).then(async (result) => {
              // console.log(result)
              if(result.isConfirmed){
                const audience_event = {
                  autorite: event.event.extendedProps.autorite,
                  sender: event.event.extendedProps.sender,
                  date_debut: result.value[0],
                  date_fin: result.value[1], 
                  time_debut: result.value[2],
                  time_fin: result.value[3],
                  id_autorite_enfant_receiver: this.audience.direction ,
                  id_autorite_enfant_sender: event.event.extendedProps.sender.id,
                  motif: this.audience.motif,
                  id: this.audience.id
                }                  
                const response = await dm_autorite_controller.reporter_maintenant(audience_event)
                if(response.data){
                  Swal.fire('Succès',`${response.message}`,'success')
                  setInterval( () => {
                    window.location.reload()
                  }, 1000)
                }
                else{
                  Swal.fire('Error',`${response.message}`,'error')
                }
              }
              else if(result.isDenied){
                // console.log(audience.sender)
                const audience_event = {
                  autorite: event.event.extendedProps.autorite,
                  sender: event.event.extendedProps.sender,
                  date_debut: this.audience.date_debut,
                  date_fin: this.audience.date_fin,
                  time_debut: this.audience.time_debut,
                  time_fin: this.audience.time_fin,
                  id_autorite_enfant_receiver: this.audience.direction,
                  id_autorite_enfant_sender: event.event.extendedProps.sender.id,
                  motif: this.audience.motif,
                  id: this.audience.id
                }                  
                const response = await dm_autorite_controller.reporter_plus_tard(audience_event)
                if(response.data){
                  Swal.fire('Succès',`${response.message}`,'success')
                  setInterval( () => {
                    window.location.reload()
                  }, 1000)
                }
                else{
                  Swal.fire('Error',`${response.message}`,'error')
                }
              }
              }).catch((err) => {
                console.log(err)
              });           
            }
          }
          else if(event.event.extendedProps.type_audience == 'Entretien'){
            const data = await Swal.fire({
              title: 'A reporter',
              showDenyButton: true,
              showCancelButton: true,
              confirmButtonText: 'Maintenant',
              denyButtonText:'Plus tard',
              html:
                `<p align="left" style="margin-left: 1rem;">De <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"> <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"> </p>` +
                `<p align="left" style="margin-left: 1.8rem;">à <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"> <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>` ,  
              focusConfirm: false,
              preConfirm: () => {
                return [
                  document.getElementById('date1').value,
                  document.getElementById('date2').value,
                  document.getElementById('duree1').value,
                  document.getElementById('duree2').value
                ]
              }
            }).then(async (result) => {
              if(result.isConfirmed){
                const audience_event = {
                  autorite: event.event.extendedProps.autorite,
                  nom: event.event.extendedProps.stagiaire.nom,
                  prenom: event.event.extendedProps.stagiaire.prenom,
                  telephone: event.event.extendedProps.stagiaire.numero_telephone,
                  e_mail: event.event.extendedProps.stagiaire.email,
                  cin: event.event.extendedProps.stagiaire.cin,
                  date_debut: result.value[0],
                  date_fin: result.value[1], 
                  time_debut: result.value[2],
                  time_fin: result.value[3],
                  id_autorite_enfant_receiver: this.audience.direction ,
                  id: this.audience.id
                }    
                console.log(audience_event)              
                const response = await EntretienDemandeStage.update_entretien_stage(audience_event)
                if(response.code == 'ER_BAD_FIELD_ERROR'){
                  swal("Entretien non enregistrée", "Veuillez remplir le formulaire", "error");
                }
                else if(response.message == 'pas disponible'){
                  swal("Entretien non enregistrée", "Cette place est occupé ou pas disponible.", "error");
                }
                else if(response.message == 'Jour férié et pas disponible'){
                  swal("Entretien non enregistrée", "On est férié et le directeur n'est pas disponible", "error");
                }
                else if(response.message == 'Jour férié'){
                  swal("Entretien non enregistrée", "On est férié", "error");
                }
                else if(response.message == "date fin invalid"){
                  swal("Entretien non enregistrée", "La date de fin d'événement doit être égal à la date de début", "warning");
                }
                else if(response.message == "formulaire vide"){
                  swal("Entretien non enregistrée", "Veuillez remplir le formulaire", "warning");
                }
                else if(response.affectedRows == 1){
                  swal("Entretien enregistrée", "Votre audience a bien été enregistrée", "success");
                  setInterval( () => {
                    window.location.reload()
                  }, 1000)
                  // this.$router.push({path: '/administrateur/demande-audience/autorite/faire-audience/', params: { id_autorite_enfant: this.audience.direction }});
                }
                else if(response.message == "time fin invalid"){
                  swal("Entretien non enregistrée", "L'heure fin doit être supérieur à l'heure début", "warning");
                }
              }
              else if(result.isDenied){
                Swal.fire({
                  title: 'Reporter un entretien',
                  text: "Cette entretien sera considérée comme stage en attente",
                  icon: 'warning',
                  showCancelButton: true,
                  confirmButtonColor: '#3085d6',
                  cancelButtonColor: '#d33',
                  cancelButtonText: 'Annuler',
                  confirmButtonText: 'Supprimer!'
                }).then(async (result) => {
                  if (result.isConfirmed) {
                    const audience_event = {
                      autorite: event.event.extendedProps.autorite,
                      nom: event.event.extendedProps.stagiaire.nom,
                      prenom: event.event.extendedProps.stagiaire.prenom,
                      telephone: event.event.extendedProps.stagiaire.numero_telephone,
                      e_mail: event.event.extendedProps.stagiaire.email,
                      cin: event.event.extendedProps.stagiaire.cin,
                      id_entretien: event.event.id
                    } 
                    console.log(audience_event)
                    const response = await EntretienDemandeStage.delete_entretien_stage(audience_event)
                    Swal.fire(
                      'Entretien supprimé',
                      `Entretien avec ${audience_event.nom} ${audience_event.prenom} a été reporté`,
                      'success'
                    )
                    // setInterval( () => {
                    //   window.location.reload()
                    // }, 1000)
                  }
                })       
              }
            }).catch((err) => {
              console.log(err)
            })
          }
           
          
        },
    
        async eventDragged(event){
          
          const start_date_time = Function.format_date_time(event.event.start)
          const end_date_time = Function.format_date_time(event.event.end)
          this.audience.id = event.event.id
          this.audience.direction = this.audience.direction
          this.audience.motif = event.event.title
          this.audience.date_debut = start_date_time[0]
          this.audience.date_fin = end_date_time[0]
          this.audience.time_debut = start_date_time[1]
          this.audience.time_fin = end_date_time[1]
          console.log(event.event)
    
          if(event.event.extendedProps.type_audience == 'Public'){
            // console.log(event.event.extendedProps.status_audience)
            if(event.event.extendedProps.status_audience == 'Validé'){
              const form = await Swal.fire({
                title: 'A reporter',
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: 'Maintenant',
                denyButtonText:'Plus tard',
                html:
                  `<p>Date début: <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"></p>` +
                  `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                  `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"></p>`+
                  `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>`,
                focusConfirm: false,
                preConfirm: () => {
                  return [
                    document.getElementById('date1').value,
                    document.getElementById('date2').value,
                    document.getElementById('duree1').value,
                    document.getElementById('duree2').value
                  ]
                }
              }).then(async (result) => {
                if(result.isConfirmed){
                  const audience_event = {
                    autorite: event.event.extendedProps.autorite,
                    sender: event.event.extendedProps.sender,
                    date_debut: result.value[0],
                    date_fin: result.value[1], 
                    time_debut: result.value[2],
                    time_fin: result.value[3],
                    id_autorite_enfant: this.audience.direction ,
                    motif: this.audience.motif,
                    id: this.audience.id
                  }                
                  const response = await dm_public_controller.reporter_maintenant(audience_event)
                  if(response.data){
                    Swal.fire('Succès',`${response.message}`,'success')
                    setInterval( () => {
                      window.location.reload()
                    }, 1000)
                  }
                  else{
                    Swal.fire('Error',`${response.message}`,'error')
                  }
                  
                }
                else if(result.isDenied){
                  // console.log(audience.sender)
                  const audience_event = {
                    autorite: event.event.extendedProps.autorite,
                    sender: event.event.extendedProps.sender,
                    date_debut: this.audience.date_debut,
                    date_fin: this.audience.date_fin,
                    time_debut: this.audience.time_debut,
                    time_fin: this.audience.time_fin,
                    id_autorite_enfant: this.audience.direction,
                    motif: this.audience.motif,
                    id: this.audience.id
                  }                  
                  const response = await dm_public_controller.reporter_plus_tard(audience_event)
                  if(response.data){
                    Swal.fire('Succès',`${response.message}`,'success')
                    setInterval( () => {
                      window.location.reload()
                    }, 1000)
                  }
                  else{
                    Swal.fire('Error',`${response.message}`,'error')
                  }
                }
              }).catch((err) => {
                console.log(err)
              })
            }
            else if(event.event.extendedProps.status_audience == 'Non validé'){
              console.log('event dropped...')
              const { value: formValues } = await Swal.fire({
                title: 'Validation',
                showCancelButton: true,
                confirmButtonText: 'Valider',
                html:
                  `<p>Date début: <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"></p>` +
                  `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                  `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"></p>`+
                  `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>`,
                focusConfirm: false,
                preConfirm: () => {
                  return[
                    document.getElementById('date1').value,
                    document.getElementById('date2').value,
                    document.getElementById('duree1').value,
                    document.getElementById('duree2').value
                  ]
                }
              })
              if (formValues) {
                this.audience.date_debut = formValues[0]
                this.audience.date_fin = formValues[1]
                this.audience.time_debut = formValues[2]
                this.audience.time_fin = formValues[3]
                // console.log(this.audience)
                const audience_event = {
                  
                  autorite: event.event.extendedProps.autorite,
                  sender: event.event.extendedProps.sender,
                  date_debut: this.audience.date_debut,
                  date_fin: this.audience.date_fin, 
                  time_debut: this.audience.time_debut,
                  time_fin: this.audience.time_fin,
                  id_autorite_enfant: this.audience.direction,
                  motif: this.audience.motif,
                  id: this.audience.id
                }
                const response = await dm_public_controller.valider(audience_event)
                if(response.data){
                  Swal.fire('Succès',`${response.message}`,'success')
                  // setInterval( () => {
                  //   window.location.reload()
                  // }, 1000)
                }
                else{
                  Swal.fire('Error',`${response.message}`,'error')
                }
              }
            }
          }
          else if(event.event.extendedProps.type_audience == 'Autorité'){
            if(event.event.extendedProps.status_audience == 'Non validé'){
              const { value: formValues } = await Swal.fire({
                title: 'Validation',
                showCancelButton: true,
                confirmButtonText: 'Valider',
                html:
                `<p>Date début: <input type=Date value="${this.audience.date_debut}"  id="date1" class="swal2-input"></p>` +
                `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"></p>`+
                `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>`,
                focusConfirm: false,
                preConfirm: () => {
                  return[
                    document.getElementById('date1').value,
                    document.getElementById('date2').value,
                    document.getElementById('duree1').value,
                    document.getElementById('duree2').value
                  ]
                }
              })
    
              if (formValues) {
                  // console.log(JSON.stringify(formValues))
                this.audience.date_debut = formValues[0]
                this.audience.date_fin = formValues[1]
                this.audience.time_debut = formValues[2]
                this.audience.time_fin = formValues[3]
                // console.log(this.audience)
                const audience_event = {
                  autorite: event.event.extendedProps.autorite,
                  sender: event.event.extendedProps.sender,
                  date_debut: this.audience.date_debut,
                  date_fin: this.audience.date_fin, 
                  time_debut: this.audience.time_debut,
                  time_fin: this.audience.time_fin,
                  id_autorite_enfant_receiver: this.audience.direction,
                  id_autorite_enfant_sender: event.event.extendedProps.sender.id,
                  motif: this.audience.motif,
                  id: this.audience.id
                }
                // console.log(audience_event)
                const response = await dm_autorite_controller.valider(audience_event)
                if(response.data){
                  Swal.fire('Succès',`${response.message}`,'success')
                  setInterval( () => {
                    window.location.reload()
                  }, 1000)
                }
                else{
                  Swal.fire('Error',`${response.message}`,'error')
                }
      
              }
            }
            else if(event.event.extendedProps.status_audience == 'Validé'){
              const form = await Swal.fire({
              title: 'A reporter',
              showDenyButton: true,
              showCancelButton: true,
              confirmButtonText: 'Maintenant',
              denyButtonText:'Plus tard',
              html:
                `<p>Date début: <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"></p>` +
                `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"></p>`+
                `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>`,
              focusConfirm: false,
              preConfirm: () => {
                return[
                  document.getElementById('date1').value,
                  document.getElementById('date2').value,
                  document.getElementById('duree1').value,
                  document.getElementById('duree2').value
                ]
              } 
            }).then(async (result) => {
              // console.log(result)
              if(result.isConfirmed){
                const audience_event = {
                  autorite: event.event.extendedProps.autorite,
                  sender: event.event.extendedProps.sender,
                  date_debut: result.value[0],
                  date_fin: result.value[1], 
                  time_debut: result.value[2],
                  time_fin: result.value[3],
                  id_autorite_enfant_receiver: this.audience.direction ,
                  id_autorite_enfant_sender: event.event.extendedProps.sender.id,
                  motif: this.audience.motif,
                  id: this.audience.id
                }                  
                await DemandeAudience.reporter_autorite_maintenant(audience_event)
                Swal.fire('Succès','Vous avez reportée avec succès','success')
                setInterval( () => {
                  window.location.reload()
                }, 1000)
              }
              else if(result.isDenied){
                // console.log(audience.sender)
                const audience_event = {
                  date_debut: this.audience.date_debut,
                  date_fin: this.audience.date_fin,
                  time_debut: this.audience.time_debut,
                  time_fin: this.audience.time_fin,
                  id_autorite_enfant_receiver: this.audience.direction,
                  id_autorite_enfant_sender: event.event.extendedProps.sender.id,
                  motif: this.audience.motif,
                  id: this.audience.id
                }                  
                await DemandeAudience.reporter_autorite_plus_tard(audience_event)
                Swal.fire('Audience reporter plus tard', '', 'info')
                setInterval( () => {
                  window.location.reload()
                }, 1000)
              }
              }).catch((err) => {
                console.log(err)
              });           
            }
          }
          else if(event.event.extendedProps.type_audience == 'Entretien'){
            const data = await Swal.fire({
              title: 'A reporter',
              showDenyButton: true,
              showCancelButton: true,
              confirmButtonText: 'Maintenant',
              denyButtonText:'Plus tard',
              html:
                `<p align="left" style="margin-left: 1rem;">De <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"> <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input"> </p>` +
                `<p align="left" style="margin-left: 1.8rem;">à <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"> <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input"></p>` ,  
              focusConfirm: false,
              preConfirm: () => {
                return [
                  document.getElementById('date1').value,
                  document.getElementById('date2').value,
                  document.getElementById('duree1').value,
                  document.getElementById('duree2').value
                ]
              }
            }).then(async (result) => {
              if(result.isConfirmed){
                const audience_event = {
                  autorite: event.event.extendedProps.autorite,
                  nom: event.event.extendedProps.stagiaire.nom,
                  prenom: event.event.extendedProps.stagiaire.prenom,
                  telephone: event.event.extendedProps.stagiaire.numero_telephone,
                  e_mail: event.event.extendedProps.stagiaire.email,
                  cin: event.event.extendedProps.stagiaire.cin,
                  date_debut: result.value[0],
                  date_fin: result.value[1], 
                  time_debut: result.value[2],
                  time_fin: result.value[3],
                  id_autorite_enfant_receiver: this.audience.direction ,
                  id: this.audience.id
                }    
                console.log(audience_event)              
                const response = await EntretienDemandeStage.update_entretien_stage(audience_event)
                if(response.code == 'ER_BAD_FIELD_ERROR'){
                  swal("Entretien non enregistrée", "Veuillez remplir le formulaire", "error");
                }
                else if(response.message == 'pas disponible'){
                  swal("Entretien non enregistrée", "Cette place est occupé ou pas disponible.", "error");
                }
                else if(response.message == 'Jour férié et pas disponible'){
                  swal("Entretien non enregistrée", "On est férié et le directeur n'est pas disponible", "error");
                }
                else if(response.message == 'Jour férié'){
                  swal("Entretien non enregistrée", "On est férié", "error");
                }
                else if(response.message == "date fin invalid"){
                  swal("Entretien non enregistrée", "La date de fin d'événement doit être égal à la date de début", "warning");
                }
                else if(response.message == "formulaire vide"){
                  swal("Entretien non enregistrée", "Veuillez remplir le formulaire", "warning");
                }
                else if(response.affectedRows == 1){
                  swal("Entretien enregistrée", "Votre audience a bien été enregistrée", "success");
                  setInterval( () => {
                    window.location.reload()
                  }, 1000)
                  // this.$router.push({path: '/administrateur/demande-audience/autorite/faire-audience/', params: { id_autorite_enfant: this.audience.direction }});
                }
                else if(response.message == "time fin invalid"){
                  swal("Entretien non enregistrée", "L'heure fin doit être supérieur à l'heure début", "warning");
                }
              }
              else if(result.isDenied){
                Swal.fire({
                  title: 'Reporter un entretien',
                  text: "Cette entretien sera considérée comme stage en attente",
                  icon: 'warning',
                  showCancelButton: true,
                  confirmButtonColor: '#3085d6',
                  cancelButtonColor: '#d33',
                  cancelButtonText: 'Annuler',
                  confirmButtonText: 'Supprimer!'
                }).then(async (result) => {
                  if (result.isConfirmed) {
                    const audience_event = {
                      autorite: event.event.extendedProps.autorite,
                      nom: event.event.extendedProps.stagiaire.nom,
                      prenom: event.event.extendedProps.stagiaire.prenom,
                      telephone: event.event.extendedProps.stagiaire.numero_telephone,
                      e_mail: event.event.extendedProps.stagiaire.email,
                      cin: event.event.extendedProps.stagiaire.cin,
                      id_entretien: event.event.id
                    } 
                    console.log(audience_event)
                    const response = await EntretienDemandeStage.delete_entretien_stage(audience_event)
                    Swal.fire(
                      'Entretien supprimé',
                      `Entretien avec ${audience_event.nom} ${audience_event.prenom} a été reporté`,
                      'success'
                    )
                    // setInterval( () => {
                    //   window.location.reload()
                    // }, 1000)
                  }
                })       
              }
            }).catch((err) => {
              console.log(err)
            })
          }    
        },
    
        detailEvent(info) {
          // console.log(info)
          if(info.event.extendedProps.type_audience == 'Public'){
            tippy(info.el, {
                theme:'light',
                content: `
                  <p><strong>${info.event.extendedProps.motif}</strong></p>
                  <p>De ${Function.date_in_string(info.event.start)} à ${Function.date_in_string(info.event.end)}</p>
                  <p>Nom: ${info.event.extendedProps.nom}</p>
                  <p>Prénom: ${info.event.extendedProps.prenom}</p>
                  <p>CIN: ${info.event.extendedProps.cin}</p>  
                  <p>Numéro téléphone: ${info.event.extendedProps.numero_telephone}</p>  
                  <p>mail: ${info.event.extendedProps.addresse_electronique_sender_externe}</p>  
                  <p><span style="background-color: ${info.event.extendedProps.color_status};" class="dot"></span>  ${info.event.extendedProps.status_audience}</p>`,
                allowHTML: true,
                delay: [500,0]
              });              
            }
          else if(info.event.extendedProps.type_audience == 'Autorité'){
            tippy(info.el, {
              theme:'light',
              content: `<p><strong>${info.event.extendedProps.motif}</strong></p>
              <p> De ${Function.date_in_string(info.event.start)} à ${Function.date_in_string(info.event.end)}</p>
              <p>Venant de la <strong>${info.event.extendedProps.intitule_autorite_sender} (${info.event.extendedProps.intitule_code_sender})</strong></p>
              <p> <span style="background-color: ${info.event.extendedProps.color_status};" class="dot"></span>  ${info.event.extendedProps.status_audience}</p>`,
              allowHTML: true,
              delay: [500,0]

            })
          }
          else if(info.event.extendedProps.type_audience == 'Entretien'){
            tippy(info.el, {
              theme:'light',
              content: `<p><strong>${info.event.extendedProps.motif}</strong></p>
              <p> De ${Function.date_in_string(info.event.start)} à ${Function.date_in_string(info.event.end)}</p>
              <p>Nom: ${info.event.extendedProps.nom}</p>
              <p>Prénom: ${info.event.extendedProps.prenom}</p>
              <p>CIN: ${info.event.extendedProps.cin}</p>  
              <p>Numéro téléphone: ${info.event.extendedProps.numero_telephone}</p>  
              <p>mail: ${info.event.extendedProps.addresse_electronique_sender_externe}</p>  
              <p><span style="background-color: ${info.event.extendedProps.color_status};" class="dot"></span>  ${info.event.extendedProps.status_audience}</p>`,
              allowHTML: true,
              delay: [500,0]

            })
          }
        },
    
        // add event
        async add_event(){
          const audience_event = {
            date_event_debut: this.audience.date_debut,
            date_event_fin: this.audience.date_fin, 
            time_event_debut: this.audience.time_debut,
            time_event_fin: this.audience.time_fin,
            // id_demande_stage: 35,
            motif: this.audience.motif,
            id_autorite_enfant: this.audience.direction
            // session_navigateur: JSON.parse(sessionStorage.getItem("session_navigateur")).value
          }
          const response =  await DemandeAudience.add_event(audience_event)
          // console.log(audience_event)
          console.log(response)
          if(response.code == 'ER_BAD_FIELD_ERROR'){
            swal("Audience non enregistrée", "Veuillez remplir le formulaire", "error");
          }
          else if(response[0][0].message == 'pas disponible'){
            swal("Audience non enregistrée", "Cette place est occupé ou pas disponible.", "error");
          }
          else if(response[0][0].message == 'Jour férié et pas disponible'){
            swal("Audience non enregistrée", "On est férié et le directeur n'est pas disponible", "error");
          }
          else if(response[0][0].message == 'Jour férié'){
            swal("Audience non enregistrée", "On est férié", "error");
          }
          else{
            swal("Audience enregistrée", "Votre audience a bien été enregistrée", "success");
          }
          // setInterval( () => {
          //   window.location.reload()
          // }, 1000)
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
    