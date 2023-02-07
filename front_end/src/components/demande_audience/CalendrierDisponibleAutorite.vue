<script setup>
    import InputAutorite from './ChoisirAutorite.vue'
</script>

<template>

    <div  class='demo-app' >
        <div class='demo-app-main'>
            <InputAutorite
              @events="getEvents($event)"
              @autorite="getAutorite($event)"
            />

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

    <div class="popupToShow"></div>
    
    <teleport to=".popupToShow">
        <div v-if="showPopupAudience" class="popupShow">
            <p  @click="togglePopupAudience"><i class="ri-close-line" style="font-size: 35px;position: fixed; margin-left: 88%;"></i></p>
            <div class="card-body">
                
                 <div v-if="audience.id === '' ">
                    <h2 class="card-title">Ajouter une audience</h2>
                    <form class="row g-3" @submit.prevent="ajouter" autocomplete="off">

                        <div class="col-md-4">
                          <div class="form-floating">
                            <input type="text" class="form-control" id="floatingName" placeholder="Votre nom" required v-model="audience.nom">
                            <label for="floatingName">Votre nom</label>
                          </div>
                        </div>
                
                        <div class="col-md-4">
                            <div class="form-floating">
                              <input type="text" class="form-control" id="floatingName" placeholder="Votre prénom" required v-model="audience.prenom" >
                              <label for="floatingName">Votre prénom</label>
                            </div>
                        </div>
                
                        <div class="col-md-4">
                            <div class="form-floating">
                                <input 
                                  type="text" 
                                  class="form-control" 
                                  id="floatingName" 
                                  placeholder="Carte d'Itentité National" 
                                  required v-model="audience.cin"   
                                  minlength="12"
                                  maxlength="12"
                                >
                                <label for="floatingName">CIN</label>
                            </div>
                        </div>
                
                        <div class="col-md-6">
                          <div class="form-floating">
                            <input type="email" class="form-control" id="floatingEmail" placeholder="Votre mail" required v-model="audience.email">
                            <label for="floatingEmail">Votre mail</label>
                          </div>
                        </div>
                
                        <div class="col-md-6">
                          <div class="form-floating">
                            <input 
                              type="tel" 
                              class="form-control" 
                              id="floatingPassword" 
                              placeholder="Numéro téléphone" 
                              required v-model="audience.numero_telephone" 
                              pattern="[0-9]{3}[0-9]{2}[0-9]{3}[0-9]{2}"   
                              minlength="10"
                              maxlength="10"
                            >
                            <label for="floatingPassword">Numéro téléphone</label>
                          </div>
                        </div>
                
                        <div class="col-12">
                          <div class="form-floating">
                            <textarea class="form-control" placeholder="Motif" id="floatingTextarea" style="height: 100px;" required v-model="audience.motif" ></textarea>
                            <label for="floatingTextarea">Motif</label>
                          </div>
                        </div>
                
                        <div class="text-center">
                          <button type="submit" class="btn btn-success">Ajouter</button>
                          <button type="reset" class="btn btn-secondary" @click="reset">Annuler</button>
                        </div>
                    </form> 
                 </div>  
                 
                <div v-else>
                    <h2 class="card-title">Modifier ou suprpimer une audience</h2>
                    <form class="row g-3" @submit.prevent="" autocomplete="off">

                        <div class="col-md-4">
                          <div class="form-floating">
                            <input type="text" class="form-control" id="floatingName" placeholder="Votre nom" required v-model="audience.nom">
                            <label for="floatingName">Votre nom</label>
                          </div>
                        </div>
                
                        <div class="col-md-4">
                            <div class="form-floating">
                              <input type="text" class="form-control" id="floatingName" placeholder="Votre prénom" required v-model="audience.prenom" >
                              <label for="floatingName">Votre prénom</label>
                            </div>
                        </div>
                
                        <div class="col-md-4">
                            <div class="form-floating">
                                <input 
                                  type="text" 
                                  class="form-control" 
                                  id="floatingName" 
                                  placeholder="Carte d'Itentité National" 
                                  required v-model="audience.cin"   
                                  minlength="12"
                                  maxlength="12"
                                >
                                <label for="floatingName">CIN</label>
                            </div>
                        </div>
                
                        <div class="col-md-6">
                          <div class="form-floating">
                            <input type="email" class="form-control" id="floatingEmail" placeholder="Votre mail" required v-model="audience.email">
                            <label for="floatingEmail">Votre mail</label>
                          </div>
                        </div>
                
                        <div class="col-md-6">
                          <div class="form-floating">
                            <input 
                              type="tel" 
                              class="form-control" 
                              id="floatingPassword" 
                              placeholder="Numéro téléphone" 
                              required v-model="audience.numero_telephone" 
                              pattern="[0-9]{3}[0-9]{2}[0-9]{3}[0-9]{2}"   
                              minlength="10"
                              maxlength="10"
                            >
                            <label for="floatingPassword">Numéro téléphone</label>
                          </div>
                        </div>
                
                        <div class="col-12">
                          <div class="form-floating">
                            <textarea class="form-control" placeholder="Motif" id="floatingTextarea" style="height: 100px;" required v-model="audience.motif" ></textarea>
                            <label for="floatingTextarea">Motif</label>
                          </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-floating mb-3">
                                <select class="form-select" id="floatingSelect" aria-label="Autorité" required="" v-model="audience.id_date_heure_disponible_autorite">
                                    <option v-if="audience.actual_place" selected disabled>
                                        {{audience.actual_place["date_disponible"]}} {{audience.actual_place["heure_debut"]}} à {{audience.actual_place["heure_fin"]}}
                                    </option>

                                    <option v-for="(item, index) in audience.places_disponible" :key="item.id_date_heure_disponible_autorite" :value="item.id_date_heure_disponible_autorite">
                                        {{item.date_disponible}} {{item.heure_debut}} à {{item.heure_fin}}
                                    </option>
                                </select>
                                <label for="floatingSelect">Place</label>
                            </div>
                        </div>
                        
                        <div class="text-center">
                            <button type="submit" class="btn btn-warning" @click="modifier" >Modifier</button>
                            <button type="submit" class="btn btn-danger" @click="supprimer" >Supprimer</button>
                            <button type="reset" class="btn btn-secondary" @click="reset">Annuler</button>
                        </div>

                    </form> 
                </div>

            </div>
        </div>
    </teleport>

</template>

<script>
    import '@fullcalendar/core/vdom'
    import FullCalendar from '@fullcalendar/vue3'
    import dayGridPlugin from '@fullcalendar/daygrid'
    import timeGridPlugin from '@fullcalendar/timegrid'
    import interactionPlugin from '@fullcalendar/interaction'
    import listPlugin from '@fullcalendar/list'
    import timeLine from '@fullcalendar/timeline'
    import frLocale from '@fullcalendar/core/locales/fr';
    import { actual_events_public } from '../../controllers/FrontOffice/DemandeAudience'
    import DemandeAudiencePublicController from '../../controllers/FrontOffice/DemandeAudience'
    import AutoriteApi from '../../api/autorite'
    import swal from 'sweetalert';
    import Function from '../../func/function';

    export default{
        components: {
            FullCalendar
        },
        
        props:{
          autorite_sender: Object,
          autorite_receiver: Object
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
                    },
                    initialView: 'timeGridDay',
                    // initialEvents: this.all_actual_events,
                    weekNumbers: true,
                    dayMaxEvents: true,
                    dayMaxEvents: true,
                    weekends: false,
                    contentHeight: 500,
                    select: this.handleDateSelect,
                    eventClick: this.handleEventClick,
                    eventDidMount: this.detailEvent,
                    slotMinTime: '08:00:00',
                    slotMaxTime: '16:00:00'
                },
                showPopupAudience: false,
                audience: {
                    // direction: this.autorite,
                    autorite:'',
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
                    id:'',
                    id_date_heure_disponible_autorite:''
                }                
            }
        },
        
        methods: {
            async places(arg){
                return await AutoriteApi.place_disponible(arg)
            },

            getEvents(value){
              // console.log(value)
                this.calendarOptions.events = value
            },

            getAutorite(value){
              this.audience.autorite = value
            },


            async ajouter(){
                const audience = {
                    nom: this.audience.nom, 
                    prenom: Function.initcap(this.audience.prenom), 
                    cin: this.audience.cin,
                    numero_telephone: this.audience.numero_telephone,
                    email: this.audience.email,
                    motif: this.audience.motif,
                    session_navigateur: this.audience.session_navigateur,
                    date_debut: this.audience.date_debut,
                    date_fin: this.audience.date_fin,
                    heure_debut: this.audience.time_debut,
                    heure_fin: this.audience.time_fin,
                    id_date_heure_disponible_autorite: this.audience.id_date_heure_disponible_autorite
                }
                const response = await DemandeAudiencePublicController.ajouter(audience)
                if(response.message){
                    swal("Audience enregistrée", `${response.message}`, "success");
                }
                else{
                    swal("Audience non enregistrée", "Votre audience n'a pas été enregistrée", "error");
                }
            },
            async modifier(){
                // console.log(this.audience)
                const audience = {
                    id_audience : this.audience.id,
                    nom: this.audience.nom, 
                    prenom: Function.initcap(this.audience.prenom), 
                    cin: this.audience.cin,
                    numero_telephone: this.audience.numero_telephone,
                    email: this.audience.email,
                    motif: this.audience.motif,
                    id_date_heure_disponible : this.audience.id_date_heure_disponible,
                    id_date_heure_disponible_autorite : this.audience.id_date_heure_disponible_autorite,
                    id_dm_aud_public_heure_dispo : this.audience.id_dm_aud_public_heure_dispo,
                    id_date_heure_disponible_autorite: this.audience.id_date_heure_disponible_autorite
                }
                const response = await DemandeAudiencePublicController.modifier(audience)
                if(response.message){
                  swal("Audience modifiée", `${response.message}`, "success");
                }
                else{
                  swal("Audience n'a pas modifiée", "Votre audience n'a pas été modifiée", "error");
                }
            },
            async supprimer(){
                const response = await DemandeAudiencePublicController.supprimer(this.audience.id)
                swal(
                    'Audience supprimée',
                    `Votre audience a bien été supprimée`,
                    'success'
                )
            },
            togglePopupAudience(){
                this.showPopupAudience = !this.showPopupAudience
            },
            // async all_actual_events(){
            //     // console.log('Ato amin actual events venant initial')
            //     const data = actual_events_public(this.autorite.id)
            //     data.then((result) => {
            //         this.calendarOptions.events = result
            //     }).catch((err) => {
            //         console.log(err)
            //     })
            // },
            // async all_actual_events(){
            //     return await actual_events_public(this.autorite.id)  
            // }, 

            async handleEventClick(event){
                // Show the popup
                this.togglePopupAudience()

                // Set date_debut,date_fin, heure_debut, heure_fin
                this.audience.nom = event.event.extendedProps.nom, 
                this.audience.prenom = event.event.extendedProps.prenom, 
                this.audience.cin = event.event.extendedProps.cin,
                this.audience.numero_telephone = event.event.extendedProps.numero_telephone,
                this.audience.email = event.event.extendedProps.email,
                this.audience.motif = event.event.extendedProps.motif, 
                this.audience.id = event.event.id
                this.audience.date_debut =  event.event.extendedProps.date_disponible
                this.audience.date_fin = event.event.extendedProps.date_disponible
                this.audience.time_debut = event.event.extendedProps.hd
                this.audience.time_fin = event.event.extendedProps.hf

                this.audience.id_date_heure_disponible = event.event.extendedProps.id_date_heure_disponible
                this.audience.id_date_heure_disponible_autorite = event.event.extendedProps.id_date_heure_disponible_autorite
                this.audience.id_dm_aud_public_heure_dispo =  event.event.extendedProps.id_dm_aud_public_heure_dispo
                // console.log(event.event.extendedProps) 
                this.audience.places_disponible =  await this.places({
                    id_date_heure_disponible_autorite: this.audience.id_date_heure_disponible_autorite,
                    id_autorite: this.audience.autorite.id 
                })
                // console.log(this.audience.places_disponible)
                this.audience.actual_place = this.audience.places_disponible[0]
                console.log(this.audience.actual_place)
            }

        },

        async created() {
            this.audience.session_navigateur = JSON.parse(sessionStorage.getItem('session_navigateur')).value
        },

    }
</script>

<!-- <style lang='css'>
    @import url('./css/style.css');    
  </style> -->