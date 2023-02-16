<script setup>
    // import InputAutorite from './ChoisirAutorite.vue'
  import InputStructure from '../tStructureComponent/Tstructure.vue';
  import SpinnerPopup from '../loading/SpinnerPopup.vue'
</script>

<template>

  

  <div  class='demo-app'>
    <div class='demo-app-main'>
      <div v-if="sessionNavigateur && typeCalendrier ==='audiencePublic'" >
        <InputStructure
          :autoriteSession="autoriteSender"
          @getAutoriteClicked="getAutorite"
        />
      </div>
      <div v-else-if="autoriteSender && typeCalendrier === 'audienceAutorite'">
        <InputStructure
          :autoriteSession="autoriteSender"
          @getAutoriteClicked="getAutorite"
        />
      </div>


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
  
  
  <div v-if="typeCalendrier === 'audiencePublic'">
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
                            v-model="audience.cin"   
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
          
                  <SpinnerPopup
                    :sipnnerActivated="sipnnerActivated"
                  />

                  <div class="text-center">
                    <button type="submit" class="btn btn-success"  >Ajouter</button>
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
                              v-model="audience.cin"   
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
                    
                    <SpinnerPopup
                      :sipnnerActivated="sipnnerActivated"
                    />

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
  </div>

  <div v-else-if="typeCalendrier ==='audienceAutorite' ">
    <teleport to=".popupToShow">
      <div v-if="showPopupAudience" class="popupShow">
        <p  @click="togglePopupAudience"><i class="ri-close-line" style="font-size: 35px;position: fixed; margin-left: 88%;"></i></p>
        <div class="card-body">
            
          <div v-if="audience.id === '' ">
            <h2 class="card-title">Ajouter une audience</h2>
            <form class="row g-3" @submit.prevent="ajouter" autocomplete="off">

                <div class="col-12">
                  <div class="form-floating">
                    <textarea class="form-control" placeholder="Motif" id="floatingTextarea" style="height: 100px;" required v-model="audience.motif" ></textarea>
                    <label for="floatingTextarea">Motif</label>
                  </div>
                </div>
                
                <SpinnerPopup
                  :sipnnerActivated="sipnnerActivated"
                />

                <div class="text-center">
                  <button type="submit" class="btn btn-success">Ajouter</button>
                  <button type="reset" class="btn btn-secondary" @click="reset">Annuler</button>
                </div>
            </form> 
          </div>  
          
          <div v-else>
              <h2 class="card-title">Modifier ou suprpimer une audience</h2>
              <form class="row g-3" @submit.prevent="" autocomplete="off">
          
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
                
                <SpinnerPopup
                  :sipnnerActivated="sipnnerActivated"
                />

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
  </div>

  <div v-else-if="typeCalendrier ==='evenementiel' && audience.typeEvenement ==='Public' ">
    <teleport to=".popupToShow">
      <div v-if="showPopupAudience" class="popupShow">
        <p  @click="togglePopupAudience"><i class="ri-close-line" style="font-size: 35px;position: fixed; margin-left: 88%;"></i></p>
        <div class="card-body">
          <h2 class="card-title">Détail audience public</h2>
          
          <div class="row">

            <div class="col-xl-4">
    
              <div class="card">
                <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
    
                  <img src="../../assets/img/profile-img.jpg" alt="Profile" class="rounded-circle">
                </div>
              </div>
    
            </div>
    
            <div class="col-xl-8">
    
              <div class="card">
                <div class="card-body pt-3">
                  <!-- Bordered Tabs -->

                  <div class="tab-content pt-2">
    
                    <div class="tab-pane fade show active profile-overview" id="profile-overview" role="tabpanel">
                      <h5 class="card-title">Message</h5>
                      <p class="small fst-italic">
                        {{audience.motif}}. {{audience.dateAudience}}
                      </p>
    
                      <h5 class="card-title">Détails </h5>
    
                      <div class="row">
                        <div class="col-lg-3 col-md-4 label ">Nom </div>
                        <div class="col-lg-9 col-md-8">{{audience.nom}}</div>
                      </div>
    
                      <div class="row">
                        <div class="col-lg-3 col-md-4 label">Prénom</div>
                        <div class="col-lg-9 col-md-8">{{audience.prenom}}</div>
                      </div>
    
    
                      <div class="row">
                        <div class="col-lg-3 col-md-4 label">Tél:</div>
                        <div class="col-lg-9 col-md-8">{{audience.numero_telephone}}</div>
                      </div>
    
                      <div class="row">
                        <div class="col-lg-3 col-md-4 label">Mail:</div>
                        <div class="col-lg-9 col-md-8">{{audience.email}}</div>
                      </div>
                      <div class="row">
                        <div class="col-lg-3 col-md-4 label">Status:</div>
                        <div class="col-lg-9 col-md-8">
                          <span class="badge bg-dark" v-if="audience.status === 'Reporté'">{{audience.status}}</span>
                          <span class="badge bg-danger" v-else-if="audience.status === 'Non validé'">{{audience.status}}</span>
                          <span class="badge bg-success" v-else-if="audience.status === 'Validé'">{{audience.status}}</span>
                          <span class="badge bg-light text-dark" v-else>{{audience.status}}</span>
                        </div>
                      </div>
                      
    
                    </div>

                    
        
    
                  </div>
    
                </div>
                
              </div>
    
            </div>

            <SpinnerPopup
              :sipnnerActivated="sipnnerActivated"
            />
            
            <div class="text-center" >
              <button type="submit" class="btn btn-success" @click="valider" v-if="audience.status === 'Non validé'" >
                Valider
              </button>
              <button type="submit" class="btn btn-dark" @click="reporter" v-if="audience.status === 'Validé' || audience.status === 'Non validé'" >
                Reporter
              </button>
            </div>

          </div>

        </div>
      </div>
    </teleport>
  </div>

  <div v-else-if="typeCalendrier ==='evenementiel' && audience.typeEvenement ==='Autorité' ">
    <teleport to=".popupToShow">
      <div v-if="showPopupAudience" class="popupShow">
        <p  @click="togglePopupAudience"><i class="ri-close-line" style="font-size: 35px;position: fixed; margin-left: 88%;"></i></p>
        <div class="card-body">
          <h2 class="card-title">Détail audience autorité</h2>
            <div class="row">
              <div class="col-12">

                <div class="card">
                  <div class="card-body">
                    <div class="tab-content pt-2">
      
                      <div class="col-12">
                        <h5 class="card-title">Message</h5>
                        <p class="small fst-italic">{{audience.motif}}</p>
                        <p class="small fst-italic">{{audience.dateAudience}}</p>
      
                        <h5 class="card-title">Détails</h5>
      
                        <div class="row">
                          <div class="col-lg-3 col-md-4 label ">Autorité: </div>
                          <div class="col-lg-9 col-md-8">{{audience.structure}}</div>
                        </div>
      
                        <div class="row">
                          <div class="col-lg-3 col-md-4 label">Tél:</div>
                          <div class="col-lg-9 col-md-8">{{audience.numero_telephone}}</div>
                        </div>
      
                        <div class="row">
                          <div class="col-lg-3 col-md-4 label">Mail:</div>
                          <div class="col-lg-9 col-md-8">{{audience.email}}</div>
                        </div>

                        <div class="row">
                          <div class="col-lg-3 col-md-4 label">Status:</div>
                          <div class="col-lg-9 col-md-8">
                            <span class="badge bg-dark" v-if="audience.status === 'Reporté'">{{audience.status}}</span>
                            <span class="badge bg-danger" v-else-if="audience.status === 'Non validé'">{{audience.status}}</span>
                            <span class="badge bg-success" v-else-if="audience.status === 'Validé'">{{audience.status}}</span>
                            <span class="badge bg-light text-dark" v-else>{{audience.status}}</span>
                          </div>
                        </div>


      
                      </div>
                    </div>
      
                  </div>
                </div>

                <SpinnerPopup
                  :sipnnerActivated="sipnnerActivated"
                />
                
                <div class="text-center" >
                  <button type="submit" class="btn btn-success" @click="valider" v-if="audience.status === 'Non validé'" >
                    Valider
                  </button>
                  <button type="submit" class="btn btn-dark" @click="reporter" v-if="audience.status === 'Validé' || audience.status === 'Non validé'" >
                    Reporter
                  </button>
                </div>
      
              </div>
            </div>
        </div>
      </div>
    </teleport>
  </div>

  <div v-else-if="typeCalendrier ==='evenementiel' && audience.typeEvenement ==='Entretien' ">
    <teleport to=".popupToShow">
      <div v-if="showPopupAudience" class="popupShow">
        <p  @click="togglePopupAudience"><i class="ri-close-line" style="font-size: 35px;position: fixed; margin-left: 88%;"></i></p>
        <div class="card-body">
          <h2 class="card-title">Détail entretien</h2>
            <div class="row">
              <div class="col-12">

                <div class="card">
                  <div class="card-body">
                    <div class="tab-content pt-2">
      
                      <div class="col-12">
                        <h5 class="card-title">Message</h5>
                        <p class="small fst-italic">{{audience.motif}}</p>
                        <p class="small fst-italic">{{audience.dateAudience}}</p>
      
                        <h5 class="card-title">Détails</h5>
      
                        <div class="row">
                          <div class="col-lg-3 col-md-4 label ">Nom: </div>
                          <div class="col-lg-9 col-md-8">{{audience.nom}}</div>
                        </div>

                        <div class="row">
                          <div class="col-lg-3 col-md-4 label ">Prénom: </div>
                          <div class="col-lg-9 col-md-8">{{audience.prenom}}</div>
                        </div>
      
                        <div class="row">
                          <div class="col-lg-3 col-md-4 label">Tél:</div>
                          <div class="col-lg-9 col-md-8">{{audience.numero_telephone}}</div>
                        </div>
      
                        <div class="row">
                          <div class="col-lg-3 col-md-4 label">Mail:</div>
                          <div class="col-lg-9 col-md-8">{{audience.email}}</div>
                        </div>

                        <div class="row">
                          <div class="col-lg-3 col-md-4 label">Status:</div>
                          <div class="col-lg-9 col-md-8">
                            <span class="badge bg-dark" v-if="audience.status === 'Reporté'">{{audience.status}}</span>
                            <span class="badge bg-danger" v-else-if="audience.status === 'Non validé'">{{audience.status}}</span>
                            <span class="badge bg-success" v-else-if="audience.status === 'Validé'">{{audience.status}}</span>
                            <span class="badge bg-light text-dark" v-else>{{audience.status}}</span>
                          </div>
                        </div>

                        <div class="row">
                          <div class="col-lg-3 col-md-4 label">
                            <RouterLink :to="{name: 'back-office-detail-demande-stage',params:{id_demande_stage: audience.id_evenement}}">
                              Voir plus
                            </RouterLink> 
                          </div>
                        </div>
      
                      </div>
    
                    </div>

                    <SpinnerPopup
                      :sipnnerActivated="sipnnerActivated"
                    />
                    
                    <div class="text-center" >
                      <button type="submit" class="btn btn-dark" @click="reporter" v-if="audience.status === 'Validé' || audience.status === 'Non validé'" >
                        Reporter
                      </button>
                    </div>
      
                  </div>
                </div>
      
              </div>
            </div>
        </div>
      </div>
    </teleport>
  </div>
  <!-- <RouterView /> -->

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
    import DemandeAudienceAutoriteAPI from '../../api/demande_audience_autorite'
    import nonDispoAPI from '../../api/NonDispo'
    import AutoriteApi from '../../api/autorite'
    import EntretienApi from '../../api/entretien_stage'
    import DemandeAudiencePublicAPI from '../../api/demande_audience_public'
    import swal from 'sweetalert';
    import Function from '../../func/function';
    import tippy from 'tippy.js';
    import 'tippy.js/dist/tippy.css'; // optional for styling
    import 'tippy.js/themes/light.css';

    export default{
      components: {
          FullCalendar
      },
        
      props:{
        sessionNavigateur: String,
        autoriteSender: Object,
        typeCalendrier:String
      },

      data() {
          return {
            count: 0,
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
                  selectable:true,
                  selectMirror: true,
                  select: this.handleDateSelect,
                  eventClick: this.handleEventClick,
                  eventResize: this.eventDragged,
                  eventDrop: this.eventDropped,
                  // eventDidMount: this.detailEvent,
                  slotMinTime: '08:00:00',
                  slotMaxTime: '16:00:00'
              },
              showPopupAudience: false,
              sipnnerActivated: false,
              audience: {
                  // direction: this.autorite,
                autoriteReceiver:'',
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
                id_date_heure_disponible_autorite:'',
                typeEvenement:''
              },
              evenement:{
                id_autorite:'',
                date_debut:'',
                date_fin:'',
                heure_debut:'',
                heure_fin:''
              }                
          }
      },
      
      emits:['sipnnerActivated'],
      watch:{
        'audience.autoriteReceiver': async function(value){
          // console.log(value)
          this.setEvents(value)
        },
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
            this.audience.autoriteReceiver = value
          },

          async setEvents(value){
            if(this.sessionNavigateur){
              console.log('Audience Structure public')
              this.calendarOptions.events = await actual_events_public(value.child_id)
            }
            else if(this.autoriteSender){
              console.log('Audience Structure Structure')
              this.calendarOptions.events = await DemandeAudienceAutoriteAPI.faire_audience(
                {
                  id_autorite_sender: this.autoriteSender.child_id,
                  id_autorite: value.child_id
                }
              )
            }
          },

          async ajouter(){
            if(this.typeCalendrier === 'audiencePublic'){
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
                  session_navigateur: this.sessionNavigateur,
                  id_date_heure_disponible_autorite: this.audience.id_date_heure_disponible_autorite,
                  autoriteReceiver: this.audience.autoriteReceiver
              }
              this.sipnnerActivated = true
              const response = await DemandeAudiencePublicController.ajouter(audience)
              if(response.message){
                  this.togglePopupAudience()
                  this.sipnnerActivated = false
                  swal("Audience enregistrée", `${response.message}`, "success");
                  
              }
              else{
                  swal("Audience non enregistrée", "Votre audience n'a pas été enregistrée", "error");
              }
              this.calendarOptions.events = await actual_events_public(this.audience.autoriteReceiver.child_id)
            }
            else if(this.autoriteSender && this.typeCalendrier === 'audienceAutorite'){
              
              const audience = {
                motif: this.audience.motif,
                date_debut: this.audience.date_debut,
                date_fin: this.audience.date_fin,
                heure_debut: this.audience.time_debut,
                heure_fin: this.audience.time_fin,
                id_autorite_sender: this.autoriteSender.child_id,
                id_autorite_receiver: this.audience.autoriteReceiver.child_id,
                id_date_heure_disponible_autorite: this.audience.id_date_heure_disponible_autorite,
                autoriteSender: this.autoriteSender,
                autoriteReceiver: this.audience.autoriteReceiver,
                email: this.autoriteSender.email,
                numero_telephone: this.autoriteSender.phone,
                sigle: this.autoriteSender.sigle,
                child_libelle: this.autoriteSender.child_libelle
              }
              this.sipnnerActivated = true
              const response = await DemandeAudienceAutoriteAPI.ajouter(audience)
              if(response.message){
                this.togglePopupAudience()
                swal("Audience enregistrée", `${response.message}`, "success");
                this.sipnnerActivated = false
              }
              else{
                  swal("Audience non enregistrée", "Votre audience n'a pas été enregistrée", "error");
              }
              this.calendarOptions.events = await DemandeAudienceAutoriteAPI.faire_audience(
                {
                  id_autorite_sender: this.autoriteSender.child_id,
                  id_autorite: this.audience.autoriteReceiver.child_id
                }
              )
            }
          },

          async modifier(){
            if(this.typeCalendrier === 'audiencePublic'){
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
              // console.log(audience)
              this.sipnnerActivated = true
              const response = await DemandeAudiencePublicController.modifier(audience)
              if(response.message){
                this.togglePopupAudience()
                this.sipnnerActivated = false
                swal("Audience modifiée", `${response.message}`, "success");
              }
              else{
                swal("Audience n'a pas modifiée", "Votre audience n'a pas été modifiée", "error");
              }
              this.calendarOptions.events = await actual_events_public(this.audience.autoriteReceiver.child_id)
            }
            else if(this.autoriteSender && this.typeCalendrier === 'audienceAutorite'){
              const audience = {
                motif: this.audience.motif,
                id_date_heure_disponible_autorite : this.audience.id_date_heure_disponible_autorite,
                id_dm_aud_autorite_date_heure_dispo : this.audience.id_dm_aud_autorite_date_heure_dispo,
                email: this.audience.email,
                numero_telephone: this.audience.numero_telephone,
                id_audience: this.audience.id
              }
              this.sipnnerActivated = false
              const response = await DemandeAudienceAutoriteAPI.modifier(audience)
              if(response.message){
                this.togglePopupAudience()
                this.sipnnerActivated = false
                swal("Audience modifiée", `${response.message}`, "success");
              }
              else{
                swal("Audience n'a pas modifiée", "Votre audience n'a pas été modifiée", "error");
              }
              this.calendarOptions.events = await DemandeAudienceAutoriteAPI.faire_audience(
                {
                  id_autorite_sender: this.autoriteSender.child_id,
                  id_autorite: this.audience.autoriteReceiver.child_id
                }
              )
            }

          },

          async supprimer(){
            if(this.typeCalendrier === 'audiencePublic'){
              this.togglePopupAudience()
              const response = await DemandeAudiencePublicController.supprimer(this.audience.id)
              swal(
                  'Audience supprimée',
                  `Votre audience a bien été supprimée`,
                  'success'
              )
              this.calendarOptions.events = await actual_events_public(this.audience.autoriteReceiver.child_id)
            }
            else if(this.typeCalendrier === 'audienceAutorite'){
              this.togglePopupAudience()
              const response = await DemandeAudienceAutoriteAPI.supprimer({id: this.audience.id})
              swal(
                  'Audience supprimée',
                  `Votre audience a bien été supprimée`,
                  'success'
              )
            }
            this.calendarOptions.events = await DemandeAudienceAutoriteAPI.faire_audience(
                {
                  id_autorite_sender: this.autoriteSender.child_id,
                  id_autorite: this.audience.autoriteReceiver.child_id
                }
              )
          },

          async valider(){
            if(this.typeCalendrier ==='evenementiel' && this.audience.typeEvenement ==='Public'){
              const arg = {
                id_dm_aud_public_date_heure_dispo: this.audience.id,
                id_audience: this.audience.id_evenement,
                date_debut: this.audience.date_debut,
                date_fin: this.audience.date_fin,
                heure_debut: this.audience.time_debut,
                heure_fin: this.audience.time_fin,
                id_autorite: this.autoriteSender.child_id,
                autorite: {
                  id_autorite: this.autoriteSender.child_id,
                  intitule: this.autoriteSender.child_libelle,
                  intitule_code: this.autoriteSender.sigle
                },
                envoyeur: {
                  nom: this.audience.nom,
                  prenom: this.audience.prenom,
                  addresse_electronique: this.audience.email
                }
              }
              this.sipnnerActivated = true
              const response = await DemandeAudiencePublicAPI.valider_public(arg)
              if(response.message){
                  this.togglePopupAudience()
                  this.sipnnerActivated = false
                  swal("Audience validée", `${response.message}`, "success");
              }
              else{
                  swal("Audience non validée", "Votre audience n'a pas été validée", "error");
              }
              this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: this.autoriteSender.child_id})
            }
            else if (this.typeCalendrier ==='evenementiel' && this.audience.typeEvenement ==='Autorité'){
              if(this.audience.status === 'Non validé'){
                this.sipnnerActivated = true
                const response = await DemandeAudienceAutoriteAPI.valider(this.evenement)
                if(response.message){
                  this.togglePopupAudience()
                  this.sipnnerActivated = false
                  swal("Audience validée", `${response.message}`, "success");
                }
              }
              if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
                const id = this.autoriteSender.child_id
                this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
              }
            }
          },

          async reporter(){
            const autoriteS = {
              id_autorite: this.autoriteSender.child_id,
              intitule: this.autoriteSender.child_libelle,
              intitule_code: this.autoriteSender.sigle
            }
            if(this.typeCalendrier ==='evenementiel' && this.audience.typeEvenement ==='Public'){
              const arg = {
                id_dm_aud_public_date_heure_dispo: this.audience.id,
                id_audience: this.audience.id_evenement,
                date_debut: this.audience.date_debut,
                date_fin: this.audience.date_fin,
                heure_debut: this.audience.time_debut,
                heure_fin: this.audience.time_fin,
                autorite: autoriteS,
                envoyeur: {
                  nom: this.audience.nom,
                  prenom: this.audience.prenom,
                  addresse_electronique: this.audience.email
                }
              }
              this.sipnnerActivated = true
              const response = await DemandeAudiencePublicAPI.reporter_public_plus_tard(arg)
              if(response.message){
                  this.togglePopupAudience()
                  this.sipnnerActivated = false
                  swal("Audience reportée", `${response.message}`, "success");
              }
              else{
                  swal("Audience non enregistrée", "Votre audience n'a pas été enregistrée", "error");
              }
              this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: this.autoriteSender.child_id})
            }
            else if(this.typeCalendrier ==='evenementiel' && this.audience.typeEvenement ==='Entretien'){
              const arg = {
                autorite: autoriteS,
                stage: {
                  id: this.audience.id_evenement,
                  addresse_electronique: this.audience.email,
                  nom: this.audience.nom,
                  prenom: this.audience.prenom
                }
              }
              this.sipnnerActivated = true
              const response = await EntretienApi.supprimer(arg)
              if(response.message){
                  this.togglePopupAudience()
                  this.sipnnerActivated = false
                  swal("Entretien reportée", `${response.message}`, "success");
              }
              else{
                  swal("Entretien non enregistrée", "L'entretien n'a pas été reporté", "error");
              }
              this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: this.autoriteSender.child_id})
            }
            else if (this.typeCalendrier ==='evenementiel' && this.audience.typeEvenement ==='Autorité'){
              if(this.audience.status === 'Validé'){
                this.sipnnerActivated = true
                const response = await DemandeAudienceAutoriteAPI.reporter_by_click(this.evenement)
                if(response.message){
                  this.togglePopupAudience()
                  this.sipnnerActivated = false
                  swal("Audience reportée", `${response.message}`, "success");
                }
                else {
                  swal("Audience non reportée", `Votre audience n'a pas été reportée`, "error");
                }
              }
              if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
                // const id = this.autoriteSender.child_id
                this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: this.autoriteSender.child_id})
              }
            }
          },
          
          togglePopupAudience(){
              this.showPopupAudience = !this.showPopupAudience
          },

          async handleDateSelect(selectInfo){
            if(this.autoriteSender && this.typeCalendrier){
              let calendarApi = selectInfo.view.calendar
              const start_date_time = Function.format_date_time(selectInfo.start)
              const end_date_time = Function.format_date_time(selectInfo.end  )   
              
              this.evenement.id_autorite = this.autoriteSender.child_id
              this.evenement.date_debut = start_date_time[0]
              this.evenement.date_fin = end_date_time[0]
              this.evenement.heure_debut = start_date_time[1]
              this.evenement.heure_fin = end_date_time[1]

              this.evenement.autorite = {
                intitule: this.autoriteSender.child_libelle,
                intitule_code: this.autoriteSender.sigle
              }
              const data = await nonDispoAPI.ajouter_non_disponible(this.evenement)
              if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
                const id = this.autoriteSender.child_id
                this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
              }
              const id = this.autoriteSender.child_id
              this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
            }
          },

          async eventDropped(event){
            const start_date_time = Function.format_date_time(event.event.start)
            const end_date_time = Function.format_date_time(event.event.end)  

            // evenement
            this.evenement.id_autorite = this.autoriteSender.child_id
            this.evenement.date_debut = start_date_time[0]
            this.evenement.date_fin = end_date_time[0]
            this.evenement.heure_debut = start_date_time[1]
            this.evenement.heure_fin = end_date_time[1]

            this.evenement.autorite = {
              intitule: this.autoriteSender.child_libelle,
              intitule_code: this.autoriteSender.sigle
            }

            const type = event.event.extendedProps.type_audience
            const status = event.event.extendedProps.status_audience
            
            if(type === 'Public'){
              this.evenement.envoyeur = {
                nom: event.event.extendedProps.nom,
                prenom: event.event.extendedProps.prenom,
                addresse_electronique: event.event.extendedProps.addresse_electronique_sender_externe,
                numero_telephone: event.event.extendedProps.numero_telephone
              }
            }
            else if(type === 'Autorité'){
              this.evenement.envoyeur = {
                intitule: event.event.extendedProps.child_libelle,
                intitule_code: event.event.extendedProps.sigle,
                addresse_electronique: event.event.extendedProps.addresse_electronique_sender_externe,
                numero_telephone: event.event.extendedProps.numero_telephone
              }
            }

            if(type === 'Pas disponible'){
              this.evenement.id_pas_dispo = event.event.id,
              this.evenement.id_date_heure_non_dispo = event.event.extendedProps.id_evenement
              
              this.evenement.autorite = {
                intitule: this.autoriteSender.child_libelle,
                intitule_code: this.autoriteSender.sigle
              }
              const response = await nonDispoAPI.modifier_non_disponible(this.evenement)

              if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
                const id = this.autoriteSender.child_id
                this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
              }
            }

            else if(type === 'Public'){
              this.evenement.id_dm_aud_public_date_heure_dispo = event.event.id
              this.evenement.id_audience = event.event.extendedProps.id_evenement
              if(status === 'Non validé'){
                const response = await DemandeAudiencePublicAPI.valider_public(this.evenement)
              }
              else if (status === 'Validé'){
                const response = await DemandeAudiencePublicAPI.reporter_public_maintenant(this.evenement)
              }
              else if (status === 'Reporté'){
                const response = await DemandeAudiencePublicAPI.revalider_public(this.evenement)
              }
              if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
                const id = this.autoriteSender.child_id
                this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
              }

            }

            else if(type === 'Autorité'){
              // console.log(event.event.extendedProps)
              this.evenement.id_dm_aud_aut_date_heure_dispo = event.event.id
              this.evenement.id_audience = event.event.extendedProps.id_evenement
              if(status === 'Non validé'){
                const response = await DemandeAudienceAutoriteAPI.valider(this.evenement)
              }
              else if (status === 'Validé'){
                const response = await DemandeAudienceAutoriteAPI.reporter_maintenant(this.evenement)
              }
              else if (status === 'Reporté'){
                const response = await DemandeAudienceAutoriteAPI.revalider(this.evenement)
              }
              if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
                const id = this.autoriteSender.child_id
                this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
              }
            }

            else if(type === 'Entretien'){
              // console.log(event.event.id)
              this.evenement.id_entretien_stage = event.event.id
              this.evenement.id_demande_stage = event.event.extendedProps.id_evenement

              const response = await EntretienApi.modifier_calendrier(this.evenement)
              if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
                const id = this.autoriteSender.child_id
                this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
              }
            }
          },

          async eventDragged(event){
            const start_date_time = Function.format_date_time(event.event.start)
            const end_date_time = Function.format_date_time(event.event.end)  
            
            // evenement
            this.evenement.id_autorite = this.autoriteSender.child_id
            this.evenement.date_debut = start_date_time[0]
            this.evenement.date_fin = end_date_time[0]
            this.evenement.heure_debut = start_date_time[1]
            this.evenement.heure_fin = end_date_time[1] 


            this.evenement.autorite = {
              intitule: this.autoriteSender.child_libelle,
              intitule_code: this.autoriteSender.sigle
            }

            const type = event.event.extendedProps.type_audience
            const status = event.event.extendedProps.status_audience
            
            if(type === 'Public'){
              this.evenement.envoyeur = {
                nom: event.event.extendedProps.nom,
                prenom: event.event.extendedProps.prenom,
                addresse_electronique: event.event.extendedProps.addresse_electronique_sender_externe,
                numero_telephone: event.event.extendedProps.numero_telephone
              }
            }
            else if(type === 'Autorité') {
              this.evenement.envoyeur = {
                intitule: event.event.extendedProps.child_libelle,
                intitule_code: event.event.extendedProps.sigle,
                addresse_electronique: event.event.extendedProps.addresse_electronique_sender_externe,
                numero_telephone: event.event.extendedProps.numero_telephone
              }
            }

            if(type === 'Pas disponible'){
              this.evenement.id_pas_dispo = event.event.id,
              this.evenement.id_date_heure_non_dispo = event.event.extendedProps.id_evenement

              const response = await nonDispoAPI.modifier_non_disponible(this.evenement)
              
              if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
                const id = this.autoriteSender.child_id
                this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
              }
            
            }

            else if(type === 'Public'){
              this.evenement.id_dm_aud_public_date_heure_dispo = event.event.id
              this.evenement.id_audience = event.event.extendedProps.id_evenement
              if(status === 'Non validé'){
                // console.log(event.event.extendedProps)
                const response = await DemandeAudiencePublicAPI.valider_public(this.evenement)
              }
              else if (status === 'Validé'){
                const respons = await DemandeAudiencePublicAPI.reporter_public_maintenant(this.evenement)
              }
              else if (status === 'Reporté'){
                const respons = await DemandeAudiencePublicAPI.revalider_public(this.evenement)
              }
              if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
                const id = this.autoriteSender.child_id
                this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
              }
            }

            else if(type === 'Autorité'){
              // console.log(event.event.extendedProps)
              this.evenement.id_dm_aud_aut_date_heure_dispo = event.event.id
              this.evenement.id_audience = event.event.extendedProps.id_evenement
              if(status === 'Non validé'){
                const response = await DemandeAudienceAutoriteAPI.valider(this.evenement)
              }
              else if (status === 'Validé'){
                const response = await DemandeAudienceAutoriteAPI.reporter_maintenant(this.evenement)
              }
              else if (status === 'Reporté'){
                const response = await DemandeAudienceAutoriteAPI.revalider(this.evenement)
              }
              if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
                const id = this.autoriteSender.child_id
                this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
              }
            }

            else if(type === 'Entretien'){
              // console.log(event.event.id)
              this.evenement.id_entretien_stage = event.event.id
              this.evenement.id_demande_stage = event.event.extendedProps.id_evenement

              const response = await EntretienApi.modifier_calendrier(this.evenement)
              if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
                const id = this.autoriteSender.child_id
                this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
              }
            }
          },
          
          async handleEventClick(event){

            console.log(event.event.extendedProps )

            const start_date_time = Function.format_date_time(event.event.start)
            const end_date_time = Function.format_date_time(event.event.end)  
            
            // evenement
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
            this.audience.typeEvenement = event.event.extendedProps.type_audience
            this.audience.status = event.event.extendedProps.status_audience
            this.audience.id_evenement = event.event.extendedProps.id_evenement

            this.audience.id_date_heure_disponible = event.event.extendedProps.id_date_heure_disponible
            this.audience.id_date_heure_disponible_autorite = event.event.extendedProps.id_date_heure_disponible_autorite
            this.audience.id_dm_aud_public_heure_dispo =  event.event.extendedProps.id_dm_aud_public_heure_dispo
            this.audience.id_dm_aud_autorite_date_heure_dispo = event.event.extendedProps.id_dm_aud_autorite_date_heure_dispo


            if(this.typeCalendrier !=='evenementiel'){
              this.audience.places_disponible =  await this.places({
                id_date_heure_disponible_autorite: this.audience.id_date_heure_disponible_autorite,
                id_autorite: this.audience.autoriteReceiver.child_id 
              })
              this.audience.actual_place = this.audience.places_disponible[0]
            }

            if(this.typeCalendrier === 'evenementiel' && this.audience.typeEvenement ==='Autorité'){
              this.audience.structure = `${event.event.extendedProps.child_libelle} (${event.event.extendedProps.sigle})`
              this.evenement.envoyeur = {
                intitule: event.event.extendedProps.child_libelle,
                intitule_code: event.event.extendedProps.sigle,
                addresse_electronique: event.event.extendedProps.email
              }
              this.evenement.autorite = {
                id: this.autoriteSender.child_id,
                intitule_code: this.autoriteSender.sigle,
                intitule: this.autoriteSender.child_libelle,
                addresse_electronique: this.autoriteSender.email
              }
              this.evenement.id_autorite = this.autoriteSender.child_id
              this.evenement.date_debut = start_date_time[0]
              this.evenement.date_fin = end_date_time[0]
              this.evenement.heure_debut = start_date_time[1]
              this.evenement.heure_fin = end_date_time[1] 

              this.evenement.id_dm_aud_aut_date_heure_dispo = event.event.id
              this.evenement.id_audience = event.event.extendedProps.id_evenement
            }

            if(this.audience.id !== ''){
              this.audience.date_debut = event.event.extendedProps.date_debut
              this.audience.date_fin = event.event.extendedProps.date_fin
              this.audience.time_debut = event.event.extendedProps.heure_debut
              this.audience.time_fin = event.event.extendedProps.heure_fin
              // this.audience.email = event.event.extendedProps.addresse_electronique_sender_externe
              this.audience.dateAudience = `${Function.date_in_string(event.event.start)} à ${Function.date_in_string(event.event.end)}`
            }

            // Show a popup typeEvenement is not Pas disponible 
            if(this.audience.typeEvenement !== 'Pas disponible'){
              this.togglePopupAudience()
            }

            if(this.audience.typeEvenement == 'Pas disponible'){
              this.count++
              if(this.count == 2){
                // this.sipnnerActivated = true
                await nonDispoAPI.supprimer_non_disponible({
                  id_date_heure_non_dispo: this.audience.id_evenement
                })
                const id = this.autoriteSender.child_id
                this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
                this.count = 0
              }
            }
          },

          detailEvent(info) {
            if(info.event.extendedProps.status_audience){
              tippy(info.el, {
                theme:'light',
                content: `<p><strong>${info.event.title}</strong></p>
                <p><span style="background-color: ${info.event.extendedProps.color_status};" class="dot"></span>  ${info.event.extendedProps.status_audience}</p>`,
                allowHTML: true,
                delay:[500,0]
              });
            }
          }

      },

      async created(){
        // if(this.autoriteSender)
        if(this.typeCalendrier === 'audiencePublic'){
          this.calendarOptions.selectable = false
        }
        else if(this.typeCalendrier === 'audienceAutorite'){
          this.calendarOptions.selectable = false
        }
      },

      async mounted() {
        if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
          const id = this.autoriteSender.child_id
          this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
        } 
      },

    }
</script>