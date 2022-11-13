
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
        initialView: 'timeGridWeek',  
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
        eventDrop: this.eventDropped
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

  created(){
    const ses = JSON.parse(sessionStorage.getItem('autorite'))
    this.audience.direction = ses.autorite_enfant.id
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
    
    handleDateSelect(selectInfo) {
      // let title = prompt('Please enter a new title for your event')
      let calendarApi = selectInfo.view.calendar
      this.is_clicked = true

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

      // console.log(clickInfo.event.end)

      const start_date_time = Function.format_date_time(clickInfo.event.start)
      const end_date_time = Function.format_date_time(clickInfo.event.end)
      // console.log(end_date_time)
      this.audience.id = clickInfo.event.id
      this.audience.direction = this.audience.direction
      this.audience.motif = clickInfo.event.title
      this.audience.date_debut = start_date_time[0]
      this.audience.date_fin = end_date_time[0]
      this.audience.time_debut = start_date_time[1]
      this.audience.time_fin = end_date_time[1]
      
      const type_audience = clickInfo.event.extendedProps.type_audience
      const action = clickInfo.event.extendedProps.action
      // const type_audience = clickInfo.event
      // console.log(this.audience.time_debut)
      // console.log(action)
      // console.log(type_audience)
      // console.log(clickInfo.event.extendedProps.sender.id)
      if(type_audience == 'Public' && action == 0){
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
            date_debut: this.audience.date_debut,
            date_fin: this.audience.date_fin, 
            time_debut: this.audience.time_debut,
            time_fin: this.audience.time_fin,
            id_autorite_enfant: this.audience.direction,
            motif: this.audience.motif,
            id: this.audience.id
          }
          await DemandeAudience.valider_public(audience_event)
          Swal.fire('Succès',
              'Validation effectuée avec succès',
              'success')
          // setInterval( () => {
          //     window.location.reload()
          //   }, 1000)
        }
      }
      else if(type_audience == 'Autorite' && action == 0){
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
          await DemandeAudience.valider_autorite(audience_event)
          Swal.fire('Succès',
              'Validation effectuée avec succès',
              'success')
          setInterval( () => {
              window.location.reload()
            }, 1000)
        }
      }
      else if(type_audience == 'Public' && action == 1){
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
                date_debut: result.value[0],
                date_fin: result.value[1], 
                time_debut: result.value[2],
                time_fin: result.value[3],
                id_autorite_enfant: this.audience.direction ,
                motif: this.audience.motif,
                id: this.audience.id
              }                  
              await DemandeAudience.reporter_public_maintenant(audience_event)
              Swal.fire('Succès','Vous avez reporté avec succès','success')
              // setInterval( () => {
              //   window.location.reload()
              // }, 1000)
            }
            else if(result.isDenied){
              // console.log(audience.sender)
              const audience_event = {
                date_debut: this.audience.date_debut,
                date_fin: this.audience.date_fin,
                time_debut: this.audience.time_debut,
                time_fin: this.audience.time_fin,
                id_autorite_enfant: this.audience.direction,
                motif: this.audience.motif,
                id: this.audience.id_audience
              }                  
              await DemandeAudience.reporter_public_plus_tard(audience_event)
              Swal.fire('Audience reporter plus tard', '', 'info')
              setInterval( () => {
                window.location.reload()
              }, 1000)
            }
          }).catch((err) => {
            console.log(err)
          })

        // if (formValues) {
        //   Swal.fire(JSON.stringify(formValues))
        // }        
      }
      else if(type_audience == 'Autorite' && action == 1){
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

      // console.log(start_date_time)

      this.audience.id = event.event.id
      this.audience.direction = this.audience.direction
      this.audience.motif = event.event.title
      this.audience.date_debut = start_date_time[0]
      this.audience.date_fin = end_date_time[0]
      this.audience.time_debut = start_date_time[1]
      this.audience.time_fin = end_date_time[1]

      // console.log(event.event.extendedProps)

      if(event.event.extendedProps.type_audience == 'Public'){
        if(event.event.extendedProps.action == 1){
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
                date_debut: result.value[0],
                date_fin: result.value[1], 
                time_debut: result.value[2],
                time_fin: result.value[3],
                id_autorite_enfant: this.audience.direction ,
                motif: this.audience.motif,
                id: this.audience.id
              }                  
              await DemandeAudience.reporter_public_maintenant(audience_event)
              Swal.fire('Succès','Vous avez reporté avec succès','success')
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
                id_autorite_enfant: this.audience.direction,
                motif: this.audience.motif,
                id: this.audience.id
              }                  
              await DemandeAudience.reporter_public_plus_tard(audience_event)
              Swal.fire('Audience reporter plus tard', '', 'info')
              setInterval( () => {
                window.location.reload()
              }, 1000)
            }
          }).catch((err) => {
            console.log(err)
          })
        }
        else if(event.event.extendedProps.action == 0){
          console.log('event dropped...')
          // console.log(this.audience.date_debut)
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
          console.log(this.audience)
          if (formValues) {
            this.audience.date_debut = formValues[0]
            this.audience.date_fin = formValues[1]
            this.audience.time_debut = formValues[2]
            this.audience.time_fin = formValues[3]
            // console.log(this.audience)
            const audience_event = {
              date_debut: this.audience.date_debut,
              date_fin: this.audience.date_fin, 
              time_debut: this.audience.time_debut,
              time_fin: this.audience.time_fin,
              id_autorite_enfant: this.audience.direction,
              motif: this.audience.motif,
              id: this.audience.id
            }
            await DemandeAudience.valider_public(audience_event)
            Swal.fire('Succès',
                'Validation effectuée avec succès',
                'success')
            setInterval( () => {
                window.location.reload()
              }, 1000)
          }
        }
      }
      else if(event.event.extendedProps.type_audience == 'Autorite'){
        if(event.event.extendedProps.action == 0){
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
            await DemandeAudience.valider_autorite(audience_event)
            Swal.fire('Succès',
              'Validation effectuée avec succès',
              'success')
            setInterval( () => {
              window.location.reload()
            }, 1000)
  
          }
        }
        else if(event.event.extendedProps.action == 1){
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
      // console.log(event.event.extendedProps)

      if(event.event.extendedProps.type_audience == 'Public'){
        if(event.event.extendedProps.action == 1){
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
                date_debut: result.value[0],
                date_fin: result.value[1], 
                time_debut: result.value[2],
                time_fin: result.value[3],
                id_autorite_enfant: this.audience.direction ,
                motif: this.audience.motif,
                id: this.audience.id
              }                  
              await DemandeAudience.reporter_public_maintenant(audience_event)
              Swal.fire('Succès','Vous avez reporté avec succès','success')
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
                id_autorite_enfant: this.audience.direction,
                motif: this.audience.motif,
                id: this.audience.id
              }                  
              await DemandeAudience.reporter_public_plus_tard(audience_event)
              Swal.fire('Audience reporter plus tard', '', 'info')
              setInterval( () => {
                window.location.reload()
              }, 1000)
            }
          }).catch((err) => {
            console.log(err)
          })
        }
        else if(event.event.extendedProps.action == 0){
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
              date_debut: this.audience.date_debut,
              date_fin: this.audience.date_fin, 
              time_debut: this.audience.time_debut,
              time_fin: this.audience.time_fin,
              id_autorite_enfant: this.audience.direction,
              motif: this.audience.motif,
              id: this.audience.id
            }
            await DemandeAudience.valider_public(audience_event)
            Swal.fire('Succès',
                'Validation effectuée avec succès',
                'success')
            setInterval( () => {
                window.location.reload()
              }, 1000)
          }
        }
      }
      else if(event.event.extendedProps.type_audience == 'Autorite'){
        if(event.event.extendedProps.action == 0){
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
            await DemandeAudience.valider_autorite(audience_event)
            Swal.fire('Succès',
              'Validation effectuée avec succès',
              'success')
            setInterval( () => {
              window.location.reload()
            }, 1000)
  
          }
        }
        else if(event.event.extendedProps.action == 1){
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
            
    },

    detailEvent(info) {
      // console.log(info.event)
      
      if(info.event.extendedProps.sender != undefined){
        tippy(info.el, {
          theme:'light',
          content: `<p><strong>${info.event.title}</strong></p>
          <p> De ${Function.date_in_string(info.event.start)} à ${Function.date_in_string(info.event.end)}</p>
          <p>Autorité: <strong>${info.event.extendedProps.sender.intitule}</strong></p>`,
          allowHTML: true,
        });
      } else if(info.event.extendedProps.status_audience == 'Occupé') {
        tippy(info.el, {
          theme:'light',
          content: `<p><strong>${info.event.title}</strong></p>
          <p> De ${Function.date_in_string(info.event.start)} à ${Function.date_in_string(info.event.end)}</p>`,
          // <p>${info.event.extendedProps.status_audience}</p>`,
          allowHTML: true,
        });
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
#main-audience{
    margin-top: 20px;
    margin-left: 300px;
}
h2 {
  margin: 0;
  font-size: 16px;
}

ul {
  margin: 0;
  padding: 0 0 0 1.5em;
}

li {
  margin: 1.5em 0;
  padding: 0;
}

b { /* used for event dates/times */
  margin-right: 3px;
}

.demo-app {
  display: flex;
  min-height: 100%;
  font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  font-size: 14px;
}

.demo-app-sidebar {
  width: 300px;
  line-height: 1.5;
  background: #eaf9ff;
  border-right: 1px solid #d3e2e8;
}

.demo-app-sidebar-section {
  padding: 2em;
}

.demo-app-main {
  flex-grow: 1;
  padding: 3em;
  z-index: 1;
}

.fc { /* the calendar root */
  /* max-width: 1100px; */
  margin: 0 auto;
}
footer{
  background:#ccc;
  position:fixed;
  bottom:0;
  width:100%;
  padding-top:50px;
  height:50px;
  z-index: 2;
}
#button-add-event {
  float: right;
  margin-top: -3%;
  margin-right: 10px;
}

/* Popup */
.button {
border: none;
color: #FFF;
background: #42b983;
appearance: none;
font: inherit;
font-size: 1.8rem;
padding: .5em 1em;
border-radius: .3em;
cursor: pointer;
}

.modal {
position: absolute;
position: fixed;
top: 0;
right: 0;
bottom: 0;
left: 0;
margin: auto;
text-align: center;
width: fit-content;
height: fit-content;
max-width: 22em;
padding: 2rem;
border-radius: 1rem;
box-shadow: 0 5px 5px rgba(0, 0, 0, 0.2);
background: #FFF;
z-index: 9999;
transform: none;
}
.modal h1 {
margin: 0 0 1rem;
}


/* ---------------------------------- */
.fade-enter-active,
.fade-leave-active {
transition: opacity .4s linear;
}

.fade-enter,
.fade-leave-to {
opacity: 0;
}

.pop-enter-active,
.pop-leave-active {
transition: transform 0.4s cubic-bezier(0.5, 0, 0.5, 1), opacity 0.4s linear;
}

.pop-enter,
.pop-leave-to {
opacity: 0;
transform: scale(0.3) translateY(-50%);
}

</style>
