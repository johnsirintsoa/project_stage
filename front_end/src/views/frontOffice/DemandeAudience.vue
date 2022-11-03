
<script>
    // import { createPopper } from '@popperjs/core';
    import '@fullcalendar/core/vdom'
    import FullCalendar from '@fullcalendar/vue3'
    import dayGridPlugin from '@fullcalendar/daygrid'
    import timeGridPlugin from '@fullcalendar/timegrid'
    import interactionPlugin from '@fullcalendar/interaction'
    import listPlugin from '@fullcalendar/list'
    import timeLine from '@fullcalendar/timeline'
    import { actual_events_public} from '../../func/event-utils'
    import DemandeAudience from '../../api/demande_audience'
    import tippy from 'tippy.js';
    import 'tippy.js/dist/tippy.css'; // optional for styling
    import 'tippy.js/themes/light.css';
    import Function from '../../func/function';
    import swal from 'sweetalert';
    import AutoriteAPI from '../../api/autorite';

    
    export default {
    
      components: {
        FullCalendar
      },
    
      data() {
        return {
          calendarOptions: {
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
            initialDate: '2022-10-21',
            initialEvents: this.all_actual_events,
            // editable: true,
            selectable: true,
            droppable: true,
            selectMirror: true,
            dayMaxEvents: true,
            weekends: false,
            select: this.handleDateSelect,
            // eventClick: this.handleEventClick,
            // eventsSet: this.handleEvents,
            // eventDidMount: this.detailEvent,
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
            direction: window.location.pathname.split('/')[ window.location.pathname.split('/').length-1],
            motif:'',
            date_debut: '',
            date_fin: '',
            time_debut:'',
            time_fin:'',
            id:''
          }
        }
      },
      async mounted() {
        this.directions = await this.autorites_enfant()
        // this.calendarOptions.initialEvents = await actual_events(1)
        
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
          // console.log(clickInfo.event.id)
          // console.log(clickInfo)
          const audience_id = clickInfo.event.id
          if (confirm(`Voulez-vous vraiment supprimer cette évenement '${clickInfo.event.title}'`)) {
            clickInfo.event.remove()
            await DemandeAudience.delete_event(audience_id)
          }
        },
    
        handleEvents(events) {
          this.currentEvents = events
          // console.log(events)
          // console.log(events)
        },

        async eventDropped(event){
          const start_date_time = Function.foramt_date_time(event.event.start)
          const end_date_time = Function.foramt_date_time(event.event.end)
          this.audience.id = event.event.id
          this.audience.direction = event.event.extendedProps.id_autorite_enfant
          this.audience.motif = event.event.title
          this.audience.date_debut = start_date_time[0]
          this.audience.date_fin = end_date_time[0]
          this.audience.time_debut = start_date_time[1]
          this.audience.time_fin = end_date_time[1]

          const audience_event = {
            date_event_debut: this.audience.date_debut,
            date_event_fin: this.audience.date_fin, 
            time_event_debut: this.audience.time_debut,
            time_event_fin: this.audience.time_fin,
            motif: this.audience.motif,
            id_direction: this.audience.direction,
            id: this.audience.id
          }
          // const res = await DemandeAudience.update_event(audience_event)
          swal({
            title: "Etes vous sure?",
            text: "Vous modifierez l'audience",
            icon: "warning",
            buttons: true,
            dangerMode: true,
          })
          .then(async (willDelete) => {
            if (willDelete) {
              swal("Votre audience a bien été modifiée", {
                icon: "success",
              });
              const res = await DemandeAudience.update_event(audience_event)
              setInterval( () => {
                window.location.reload()
              }, 1000)
            }
            
          });
          
        },
        eventDragged(event){
          const start_date_time = Function.foramt_date_time(event.event.start)
          const end_date_time = Function.foramt_date_time(event.event.end)

          this.audience.id = event.event.id
          this.audience.direction = event.event.extendedProps.id_autorite_enfant
          this.audience.motif = event.event.title
          this.audience.date_debut = start_date_time[0]
          this.audience.date_fin = end_date_time[0]
          this.audience.time_debut = start_date_time[1]
          this.audience.time_fin = end_date_time[1]
          

          const audience_event = {
            date_event_debut: this.audience.date_debut,
            date_event_fin: this.audience.date_fin, 
            time_event_debut: this.audience.time_debut,
            time_event_fin: this.audience.time_fin,
            motif: this.audience.motif,
            id_direction: this.audience.direction,
            id: this.audience.id
          }

          swal({
            title: "Etes vous sure?",
            text: "Vous modifierez l'audience",
            icon: "warning",
            buttons: true,
            dangerMode: true,
          })
          .then(async (willDelete) => {
            if (willDelete) {
              swal("Votre audience a bien été modifiée", {
                icon: "success",
              });
              const res = await DemandeAudience.update_event(audience_event)
              setInterval( () => {
                window.location.reload()
              }, 1000)
            }
            
          });
          
        },

        detailEvent(info) {
          // console.log(info)
          
          tippy(info.el, {
            theme:'light',
            content: `<p><strong>${info.event.title}</strong></p>
            <p> De ${Function.date_in_string(info.event.start)} à ${Function.date_in_string(info.event.end)}</p>`,
            // <p>${info.event.extendedProps.status_audience}</p>`,
            allowHTML: true,
          });
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
        // add test event
        // async add_event_test(){

        //   const audience_event = {
        //     date_x_debut: this.audience.date_debut,
        //     date_x_fin: this.audience.date_fin,
        //     time_x_debut: this.audience.time_debut,
        //     time_x_fin: this.audience.time_fin
        //   }
        //   const response =  await DemandeAudience.add_event_test(audience_event)
        //   console.log(response)
        //   if(response.code == 'ER_BAD_FIELD_ERROR'){
        //     swal("Audience non enregistrée", "Veuillez remplir le formulaire", "error");
        //   }else if(response.code == 'ER_PARSE_ERROR'){
        //     swal("Audience non enregistrée", "Veuillez vérifier votreformulaire", "error");
        //   }else{
        //     swal("Audience enregistrée", "Votre audience a bien été enregistrée", "success");
        //   }
        //   // setInterval( () => {
        //   //   window.location.reload()
        //   // }, 1000)
        // }
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
                      <li>Motif: <input v-model="audience.motif" placeholder="motif..." /></li>
                      <li>De <input type="date" v-model="audience.date_debut"  />  <input type="time" v-model="audience.time_debut"  /></li>
                      <li>à <input type="date" v-model="audience.date_fin"  />  <input type="time" v-model="audience.time_fin"  /></li>
                      <!-- <li>Type audience: <input v-model="audience.type_audience" placeholder="Type d'audience..." /></li> -->
                      <li> <button type="button" @click="add_event()">Valider</button></li>
                      </ul>
                  </form>
                  <!-- <h2>Instructions</h2>
                  <ul>
                  <li>Select dates and you will be prompted to create a new event</li>
                  <li>Drag, drop, and resize events</li>
                  <li>Click an event to delete it</li>
                  </ul> -->
              </div>
              <div class='demo-app-sidebar-section'>
                  <label>
                  <input
                      type='checkbox'
                      :checked='calendarOptions.weekends'
                      @change='handleWeekendsToggle'
                  />
                  toggle weekends
                  </label>
              </div>
            <div class='demo-app-sidebar-section'>
                <!-- <h2>All Events ({{ currentEvents.length }})</h2> -->

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
            <div class="collapse" id="collapseExample">
              <div class="card card-body">
                Some placeholder content for the collapse component. This panel is hidden by default but revealed when the user activates the relevant trigger.
              </div>
            </div>
            </div>
        </div>
    </main>
</template>
<style lang='css'>
    #main-audience{
        margin-top: 0px;
        margin-left: 0px;
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
