<template>

  <div  class='demo-app'>
    <div class='demo-app-main'>
      <div v-if="sessionNavigateur && typeCalendrier ==='audiencePublic'" >
        <InputStructure
          :autoriteSession="autoriteSender"
          @getAutoriteClicked="getAutorite"
        />
        <!-- <ColorInfos
          :colorInfosPublic="dataColorInfos"
          :colorInfosAutorité="dataColorInfos"
        /> -->
      </div>
      <div v-else-if="autoriteSender && typeCalendrier === 'audienceAutorite'">
        <InputStructure
          :autoriteSession="autoriteSender"
          @getAutoriteClicked="getAutorite"
        />
        <!-- <ColorInfos
          :colorInfosPublic="dataColorInfos"
          :colorInfosAutorité="dataColorInfos"
        /> -->
      </div>

      <ColorInfos
        :colorInfosPublic="dataColorInfos"
        :colorInfosAutorité="dataColorInfos"
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

  <!-- <div class="popupToShow"></div> -->
  <!-- <div class="popupToShowDetailEvent"></div> -->
  
  
  <div v-if="typeCalendrier === 'audiencePublic'">
    <!-- si un agent souhaite demander une audience -->
    
    <div v-if="audience.isAgent">
      <teleport to=".popupToShow">
        <div v-if="showPopupAudience" class="popupShow">
            <p  @click="togglePopupAudience"><i class="ri-close-line" style="font-size: 35px;position: fixed; margin-left: 88%;"></i></p>
            <div class="card-body">
                
              <div v-if="audience.id === '' ">
                <h2 class="card-title">Ajouter une audience</h2>

                <form class="row g-3" @submit.prevent="ajouter" autocomplete="off">
  
                    <div class="col-md-12">
                      <div class="form-floating">
                        <input type="text" class="form-control" id="floatingInput" placeholder="Votre login" required v-model="audience.login_agent">
                        <label for="floatingEmail">Votre login</label>
                      </div>
                    </div>

                    <div class="col-md-12">
                      <div class="form-floating">
                        <input type="password" class="form-control" id="floatingInput" placeholder="Votre mot de passe" required v-model="audience.password_agent">
                        <label for="floatingEmail">Votre mot de passe</label>
                      </div>
                    </div>
            
                    <div class="col-md-6">
                      <div class="form-floating">
                        <input type="email" class="form-control" id="floatingEmail" placeholder="Votre mail" v-model="audience.email">
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
                          v-model="audience.numero_telephone" 
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
  
                    <div class="col-12">
                      <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="gridCheck1" v-model="audience.isAgent">
                        <label class="form-check-label" for="gridCheck1">
                          Agent
                        </label>
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
   
            </div>
        </div>
      </teleport>
    </div>

    <div v-else>
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
  
                    <div class="col-12">
                      <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="gridCheck1" v-model="audience.isAgent">
                        <label class="form-check-label" for="gridCheck1">
                          Agent
                        </label>
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
                  <h2 class="card-title">Modifier ou supprimer une audience</h2>
                  <div v-if="audience.id_agent > 0">
                    <form class="row g-3" @submit.prevent="" autocomplete="off">
  
                      <div class="col-md-12">
                        <div class="form-floating">
                          <input type="text" class="form-control" id="floatingInput" placeholder="Votre login"  v-model="audience.login_agent" required>
                          <label for="floatingEmail">Votre login</label>
                        </div>
                      </div>
  
                      <div class="col-md-12">
                        <div class="form-floating">
                          <input type="password" class="form-control" id="floatingInput" placeholder="Votre mot de passe"  v-model="audience.password_agent" required>
                          <label for="floatingEmail">Votre mot de passe</label>
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
  
                      <div class="col-sm-12" v-if="audience.status === 'Validé' || audience.status === 'Reporté'">
                          <div class="form-floating mb-3">
                            <select class="form-select" id="floatingSelect" aria-label="Autorité" required="" v-model="audience.actual_place">
                              <option v-if="audience.actual_place" selected disabled>
                                  {{audience.actual_place["date_disponible"]}} {{audience.actual_place["heure_debut"]}} à {{audience.actual_place["heure_fin"]}}
                              </option>
    
                              <option v-for="(item, index) in audience.places_disponible" :key="item" :value="item">
                                  {{item.date_disponible}} {{item.heure_debut}} à {{item.heure_fin}}
                              </option>
                          </select>
                          <label for="floatingSelect">Place</label>
                          </div>
                      </div>

<!--   
                      <div class="col-md-12" v-else>
                        <div class="form-floating mb-3">
                          
                          <select class="form-select" id="floatingSelect" aria-label="Autorité" required="" v-model="audience.actual_place">
                            <option v-if="audience.actual_place" selected disabled>
                                {{audience.actual_place["date_disponible"]}} {{audience.actual_place["heure_debut"]}} à {{audience.actual_place["heure_fin"]}}
                            </option>
  
                            <option v-for="(item, index) in audience.places_disponible" :key="item" :value="item">
                                {{item.date_disponible}} {{item.heure_debut}} à {{item.heure_fin}}
                            </option>
                          </select>
                        <label for="floatingSelect">Place</label>
                        </div>
                      </div> -->

                      <div class="col-sm-12" v-else>
                        <select class="form-select" multiple="" aria-label="multiple select example" required="" v-model="audience.actual_place">
                          <option v-if="audience.actual_place" selected disabled>
                            {{audience.actual_place["date_disponible"]}} {{audience.actual_place["heure_debut"]}} à {{audience.actual_place["heure_fin"]}}
                          </option>

                          <option v-for="(item, index) in audience.places_disponible" :key="item" :value="item">
                              {{item.date_disponible}} {{item.heure_debut}} à {{item.heure_fin}}
                          </option>
                        </select>
                        <label for="floatingSelect">Place</label>

                      </div>

                      
                      <SpinnerPopup
                        :sipnnerActivated="sipnnerActivated"
                      />
  
                      <div class="text-center" v-if="audience.status === 'Validé' || audience.status === 'Reporté'">
                        <button type="submit" class="btn btn-danger" @click="supprimer" >Supprimer</button>
                        <button type="reset" class="btn btn-secondary" @click="reset">Annuler</button>
                      </div>
      
                      <div class="text-center" v-else>
                        <button type="submit" class="btn btn-warning" @click="modifier" >Modifier</button>
                        <button type="submit" class="btn btn-danger" @click="supprimer" >Supprimer</button>
                        <button type="reset" class="btn btn-secondary" @click="reset">Annuler</button>
                      </div>
  
                    </form>   
                  </div>
  
                  <div v-else>
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
  
                      <div class="col-md-12" v-if="audience.status === 'Validé' || audience.status === 'Reporté'">
                          <div class="form-floating mb-3">
                            <select class="form-select" id="floatingSelect" aria-label="Autorité" required="" v-model="audience.actual_place" disabled>
                              <option v-if="audience.actual_place" selected disabled>
                                  {{audience.actual_place["date_disponible"]}} {{audience.actual_place["heure_debut"]}} à {{audience.actual_place["heure_fin"]}}
                              </option>
    
                              <option v-for="(item, index) in audience.places_disponible" :key="item" :value="item">
                                  {{item.date_disponible}} {{item.heure_debut}} à {{item.heure_fin}}
                              </option>
                          </select>
                          <label for="floatingSelect">Place</label>
                          </div>
                      </div>
  
                      <div class="col-md-12" v-else>
                        <div class="form-floating mb-3">
                          
                          <select class="form-select" id="floatingSelect" aria-label="Autorité" required="" v-model="audience.actual_place">
                            <option v-if="audience.actual_place" selected disabled>
                                {{audience.actual_place["date_disponible"]}} {{audience.actual_place["heure_debut"]}} à {{audience.actual_place["heure_fin"]}}
                            </option>
  
                            <option v-for="(item, index) in audience.places_disponible" :key="item" :value="item">
                                {{item.date_disponible}} {{item.heure_debut}} à {{item.heure_fin}}
                            </option>
                          </select>
                        <label for="floatingSelect">Place</label>
                        </div>
                      </div>

                      
                      <SpinnerPopup
                        :sipnnerActivated="sipnnerActivated"
                      />
  
                      <div class="text-center" v-if="audience.status === 'Validé' || audience.status === 'Reporté'">
                        <button type="submit" class="btn btn-danger" @click="supprimer" >Supprimer</button>
                        <button type="reset" class="btn btn-secondary" @click="reset">Annuler</button>
                      </div>
      
                      <div class="text-center" v-else>
                        <button type="submit" class="btn btn-warning" @click="modifier" >Modifier</button>
                        <button type="submit" class="btn btn-danger" @click="supprimer" >Supprimer</button>
                        <button type="reset" class="btn btn-secondary" @click="reset">Annuler</button>
                      </div>
  
                    </form>                     
                  </div>
              </div>
              
            </div>
        </div>
      </teleport>
    </div>

    <!-- si un visiteur externe souhaite demander une audience -->

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

                <div class="col-md-12" v-if="audience.status === 'Validé' || audience.status === 'Reporté'">
                    <div class="form-floating mb-3">
                        <select class="form-select" id="floatingSelect" aria-label="Autorité" required="" v-model="audience.id_date_heure_disponible_autorite" disabled>
                            <option v-if="audience.actual_place" selected disabled>
                                {{audience.actual_place["date_disponible"].split('T')[0]}} {{audience.actual_place["heure_debut"]}} à {{audience.actual_place["heure_fin"]}}
                            </option>

                            <option v-for="(item, index) in audience.places_disponible" :key="item.id_date_heure_disponible_autorite" :value="item.id_date_heure_disponible_autorite">
                                {{item.date_disponible}} {{item.heure_debut}} à {{item.heure_fin}}
                            </option>
                        </select>
                        <label for="floatingSelect">Place</label>
                    </div>
                </div>

                <div class="col-md-12" v-else>
                  <div class="form-floating mb-3">
                      <select class="form-select" id="floatingSelect" aria-label="Autorité" required="" v-model="audience.actual_place">
                          <option v-if="audience.actual_place" selected disabled>
                              {{audience.actual_place["date_disponible"]}} {{audience.actual_place["heure_debut"]}} à {{audience.actual_place["heure_fin"]}}
                          </option>

                          <option v-for="(item, index) in audience.places_disponible" :key="item" :value="item">
                              {{item.date_disponible}} {{item.heure_debut}} à {{item.heure_fin}}
                          </option>
                      </select>
                      <label for="floatingSelect">Place</label>
                  </div>
                </div>
                
                <SpinnerPopup
                  :sipnnerActivated="sipnnerActivated"
                />


                <div class="text-center" v-if="audience.status === 'Validé' || audience.status === 'Reporté'">
                    <button type="submit" class="btn btn-danger" @click="supprimer" >Supprimer</button>
                    <button type="reset" class="btn btn-secondary" @click="reset">Annuler</button>
                </div>

                <div class="text-center" v-else>
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
    <teleport to=".popupToShowDetailEvent">
      <div v-if="showPopupAudience" class="popupShowDetailEvent">
        <p  @click="togglePopupAudience"><i class="ri-close-line" style="font-size: 35px;position: fixed; margin-left: 88%;"></i></p>
        
        <div class="card-body">
          <h2 class="card-title">Détail audience public</h2>

          <form @submit.prevent="setActionEvenement">
            <div class="row">

              <div class="row d-flex justify-content-center">
                <!-- <div class="col-xl-4">
      
                  <div class="card">
                    <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
        
                      <img src="../../assets/img/profile-img.jpg" alt="Profile" class="rounded-circle">
                    </div>
                  </div>
        
                </div> -->

                <div class="col-md-12">
        
                  <div class="card">
                    <div class="card-body pt-3">
                      <!-- Bordered Tabs -->
    
                      <div class="tab-content pt-2">
        
                        <div class="tab-pane fade show active profile-overview" id="profile-overview" role="tabpanel">
                          <h5 class="card-title">Message</h5>
                          <p class="small fst-italic">
                            {{audience.motif}}
                          </p>
        
                          <h5 class="card-title">Détails </h5>
        
                          <div class="row">
                            <!-- <div class="col-lg-3 col-md-4 label ">Début: </div> -->
                            <div class="row mb-2">
                              <label for="inputDate" class="col-lg-3 col-md-4 label">Début:</label>
                              <div class="col-sm-4">
                                <input type="date" class="input-popup" v-model="audience.date_debut" min="Monday" max="required" required>
                              </div>
                              à
                              <div class="col-sm-4">
                                <input type="time"  class="input-popup" v-model="audience.time_debut" min="08:00" max="16:00" required>
                              </div>
                            </div>
                          </div>

                          <div class="row">
                            <!-- <div class="col-lg-3 col-md-4 label ">Début: </div> -->
                            <div class="row mb-2">
                              <label for="inputDate" class="col-lg-3 col-md-4 label">Fin:</label>
                              <div class="col-sm-4">
                                <input type="date" class="input-popup" v-model="audience.date_fin">
                              </div> à 
                              <div class="col-sm-4">
                                <input type="time" class="input-popup" v-model="audience.time_fin" min="08:00" max="16:00" required>
                              </div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label ">Nom: </div>
                              <div class="col-lg-9 col-md-8">{{audience.nom}}</div>
                            </div>
                          </div>
        
                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label">Prénom:</div>
                              <div class="col-lg-9 col-md-8">{{audience.prenom}}</div>
                            </div>
                          </div>
        
        
                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label">Téléphone:</div>
                              <div class="col-lg-9 col-md-8">{{audience.numero_telephone}}</div>
                            </div>
                          </div>
        
                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label">Mail:</div>
                              <div class="col-lg-9 col-md-8">{{audience.email}}</div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label">Status:</div>
                              <div class="col-lg-9 col-md-8">
                                <span class="badge bg-dark" v-if="audience.status === 'Reporté'">{{audience.status}}</span>
                                <span class="badge bg-danger" v-else-if="audience.status === 'Non validé'">{{audience.status}}</span>
                                <span class="badge bg-success" v-else-if="audience.status === 'Validé'">{{audience.status}}</span>
                                <span class="badge bg-light text-dark" v-else>{{audience.status}}</span>
                                <!-- <span class="badge bg-secondary" style="margin-left: 1%" v-if="evenement.est_termine === '1'">Terminé</span> -->
                              </div>
                            </div>

                          </div>

                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label"> Etat:</div>
                              <div class="col-lg-9 col-md-8">
                                <input class="form-check-input" type="checkbox" v-model="terminerEvenement" id="gridCheck1"> Terminer
                              </div>
                            </div>
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
                <button type="submit" class="btn btn-success" @click="setEtatAction(1)"  v-if="audience.status === 'Non validé'" >
                  Valider
                </button>
            
                <button type="submit" class="btn btn-warning" @click="setEtatAction(4)"  v-if="audience.status === 'Validé'" >
                  Modifier
                </button>

                <button type="submit" class="btn btn-dark" @click="setEtatAction(2)"  v-if="audience.status === 'Validé' || audience.status === 'Non validé'" >
                  Reporter
                </button>

                <button type="submit" class="btn btn-success" @click="setEtatAction(3)"  v-if="audience.status === 'Reporté'" >
                  Revalider
                </button>
              </div>


            </div>
          </form>

        </div>


      </div>
    </teleport>
  </div>

  <div v-else-if="typeCalendrier ==='evenementiel' && audience.typeEvenement ==='Agent' ">
    <teleport to=".popupToShowDetailEvent">
      <div v-if="showPopupAudience" class="popupShowDetailEvent">
        <p  @click="togglePopupAudience"><i class="ri-close-line" style="font-size: 35px;position: fixed; margin-left: 88%;"></i></p>
        <div class="card-body">
          <h2 class="card-title">Détail audience agent</h2>
          
          <form @submit.prevent="setActionEvenement">
            <div class="row">

              <div class="row d-flex justify-content-center">
                <!-- <div class="col-md-6">
      
                  <div class="card">
                    <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
        
                      <img src="../../assets/img/profile-img.jpg" alt="Profile" class="rounded-circle">
                    </div>
                  </div>
        
                </div> -->
        
                <div class="col-md-12">
        
                  <div class="card">
                    <div class="card-body pt-3">
                      <!-- Bordered Tabs -->
    
                      <div class="tab-content pt-2">
        
                        <div class="tab-pane fade show active profile-overview" id="profile-overview" role="tabpanel">
                          <h5 class="card-title">Motif</h5>
                          <p class="small fst-italic">
                            {{audience.motif}}
                          </p>
        
                          <h5 class="card-title">Détails </h5>

                          <div class="row">
                            <!-- <div class="col-lg-3 col-md-4 label ">Début: </div> -->
                            <div class="row mb-2">
                              <label for="inputDate" class="col-lg-3 col-md-4 label">Début:</label>
                              <div class="col-sm-4">
                                <input type="date" class="input-popup" v-model="audience.date_debut">
                              </div>
                              à
                              <div class="col-sm-4">
                                <input type="time" class="input-popup" v-model="audience.time_debut">
                              </div>
                            </div>
                          </div>

                          <div class="row">
                            <!-- <div class="col-lg-3 col-md-4 label ">Début: </div> -->
                            <div class="row mb-2">
                              <label for="inputDate" class="col-lg-3 col-md-4 label">Fin:</label>
                              <div class="col-sm-4">
                                <input type="date" class="input-popup" v-model="audience.date_fin">
                              </div> à 
                              <div class="col-sm-4">
                                <input type="time" class="input-popup" v-model="audience.time_fin">
                              </div>
                            </div>
                          </div>
        
                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label ">Nom:</div>
                              <div class="col-lg-9 col-md-8">{{audience.nom}}</div>
                            </div>
                          </div>
        
                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label">Prénom:</div>
                              <div class="col-lg-9 col-md-8">{{audience.prenom}}</div>
                            </div>
                          </div>
        
        
                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label">Tél:</div>
                              <div class="col-lg-9 col-md-8">{{audience.numero_telephone}}</div>
                            </div>
                          </div>
        
                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label">Mail:</div>
                              <div class="col-lg-9 col-md-8">{{audience.email}}</div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label">Fonction:</div>
                              <div class="col-lg-9 col-md-8">{{audience.poste_agent}}</div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label">Path:</div>
                              <div class="col-lg-9 col-md-8">{{audience.path_agent}}</div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label">Status:</div>
                              <div class="col-lg-9 col-md-8">
                                <span class="badge bg-dark" v-if="audience.status === 'Reporté'">{{audience.status}}</span>
                                <span class="badge bg-danger" v-else-if="audience.status === 'Non validé'">{{audience.status}}</span>
                                <span class="badge bg-success" v-else-if="audience.status === 'Validé'">{{audience.status}}</span>
                                <span class="badge bg-light text-dark" v-else>{{audience.status}}</span>
                              </div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label"> Etat:</div>
                              <div class="col-lg-9 col-md-8">
                                <input class="form-check-input" type="checkbox" v-model="terminerEvenement" id="gridCheck1"> Terminer
                              </div>
                            </div>
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
                <button type="submit" class="btn btn-success" @click="setEtatAction(1)" v-if="audience.status === 'Non validé'" >
                  Valider
                </button>
                <button type="submit" class="btn btn-warning" @click="setEtatAction(4)"  v-if="audience.status === 'Validé'" >
                  Modifier
                </button>
                <button type="submit" class="btn btn-dark" @click="setEtatAction(2)" v-if="audience.status === 'Validé' || audience.status === 'Non validé'" >
                  Reporter
                </button>
                <button type="submit" class="btn btn-success" @click="setEtatAction(3)" v-if="audience.status === 'Reporté'" >
                  Revalider
                </button>
              </div>

            </div>
          </form>
        </div>
      </div>
    </teleport>
  </div>

  <div v-else-if="typeCalendrier ==='evenementiel' && audience.typeEvenement ==='Autorité' ">
    <teleport to=".popupToShowDetailEvent">
      <div v-if="showPopupAudience" class="popupShowDetailEvent">
        <p  @click="togglePopupAudience"><i class="ri-close-line" style="font-size: 35px;position: fixed; margin-left: 88%;"></i></p>
        <div class="card-body">
          <h2 class="card-title">Détail audience autorité</h2>

          <form @submit.prevent="setActionEvenement">
            <div class="row">
              <div class="row d-flex justify-content-center">
                <!-- <div class="col-md-6">
    
                  <div class="card">
                    <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
        
                      <img src="../../assets/img/profile-img.jpg" alt="Profile" class="rounded-circle">
                    </div>
                  </div>
      
                </div> -->
  
                <div class="col-md-12">
  
                  <div class="card">
                    <div class="card-body">
                      <div class="tab-content pt-2">
        
                        <div class="tab-pane fade show active profile-overview" id="profile-overview" role="tabpanel">
                          <h5 class="card-title">Motif</h5>
                          <p class="small fst-italic">{{audience.motif}}</p>
        
                          <h5 class="card-title">Détails</h5>
        
                          <div class="row">
                            <!-- <div class="col-lg-3 col-md-4 label ">Début: </div> -->
                            <div class="row mb-2">
                              <label for="inputDate" class="col-lg-3 col-md-4 label">Début:</label>
                              <div class="col-sm-4">
                                <input type="date" class="input-popup" v-model="audience.date_debut">
                              </div>
                              à
                              <div class="col-sm-4">
                                <input type="time" class="input-popup" v-model="audience.time_debut">
                              </div>
                            </div>
                          </div>

                          <div class="row">
                            <!-- <div class="col-lg-3 col-md-4 label ">Début: </div> -->
                            <div class="row mb-2">
                              <label for="inputDate" class="col-lg-3 col-md-4 label">Fin:</label>
                              <div class="col-sm-4">
                                <input type="date" class="input-popup" v-model="audience.date_fin">
                              </div> à 
                              <div class="col-sm-4">
                                <input type="time" class="input-popup" v-model="audience.time_fin">
                              </div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label ">Autorité: </div>
                              <div class="col-lg-9 col-md-8">{{audience.structure}}</div>
                            </div>

                          </div>
        
                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label">Tél:</div>
                              <div class="col-lg-9 col-md-8">{{audience.numero_telephone}}</div>
                            </div>
                          </div>
        
                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label">Mail:</div>
                              <div class="col-lg-9 col-md-8">{{audience.email}}</div>
                            </div>
                          </div>
  
                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label">Status:</div>
                              <div class="col-lg-9 col-md-8">
                                <span class="badge bg-dark" v-if="audience.status === 'Reporté'">{{audience.status}}</span>
                                <span class="badge bg-danger" v-else-if="audience.status === 'Non validé'">{{audience.status}}</span>
                                <span class="badge bg-success" v-else-if="audience.status === 'Validé'">{{audience.status}}</span>
                                <span class="badge bg-light text-dark" v-else>{{audience.status}}</span>
                              </div>
                            </div>
                          </div>

                          <div class="row">
                            <div class="row mb-2">
                              <div class="col-lg-3 col-md-4 label"> Etat:</div>
                              <div class="col-lg-9 col-md-8">
                                <input class="form-check-input" type="checkbox" v-model="terminerEvenement" id="gridCheck1"> Terminer
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
                    <button type="submit" class="btn btn-success" @click="setEtatAction(1)" v-if="audience.status === 'Non validé'" >
                      Valider
                    </button>
                    <button type="submit" class="btn btn-warning" @click="setEtatAction(4)"  v-if="audience.status === 'Validé'" >
                      Modifier
                    </button>
                    <button type="submit" class="btn btn-dark" @click="setEtatAction(2)" v-if="audience.status === 'Validé' || audience.status === 'Non validé'" >
                      Reporter
                    </button>
                    <button type="submit" class="btn btn-success" @click="setEtatAction(3)" v-if="audience.status === 'Reporté'" >
                      Revalider
                    </button>
                  </div>
        
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
    </teleport>
  </div>

  <div v-else-if="typeCalendrier ==='evenementiel' && audience.typeEvenement ==='Entretien' ">
    <teleport to=".popupToShowDetailEvent">
      <div v-if="showPopupAudience" class="popupShowDetailEvent">
        <p  @click="togglePopupAudience"><i class="ri-close-line" style="font-size: 35px;position: fixed; margin-left: 88%;"></i></p>
        <div class="card-body">
          <h2 class="card-title">Détail entretien</h2>
            <form @submit.prevent="setActionEvenement">
              <div class="row">

                <!-- <div class="col-xl-4">
        
                  <div class="card">
                    <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
        
                      <img src="../../assets/img/profile-img.jpg" alt="Profile" class="rounded-circle">
                    </div>
                  </div>
        
                </div> -->
                <div class="row d-flex justify-content-center">
                  <div class="col-md-12">

                    <div class="card">
                      <div class="card-body">
                        <div class="tab-content pt-2">
          
                          <div class="tab-pane fade show active profile-overview" id="profile-overview" role="tabpanel">
                            <h5 class="card-title">Message</h5>
                            <p class="small fst-italic">{{audience.motif}}</p>
          
                            <h5 class="card-title">Détails</h5>
          
                            <div class="row">
                              <div class="row mb-2">
                                <label for="inputDate" class="col-lg-3 col-md-4 label">Début:</label>
                                <div class="col-sm-4">
                                  <input type="date" class="input-popup" v-model="audience.date_debut">
                                </div>
                                à
                                <div class="col-sm-4">
                                  <input type="time" class="input-popup" v-model="audience.time_debut">
                                </div>
                              </div>
                            </div>

                            <div class="row">
                              <div class="row mb-2">
                                <label for="inputDate" class="col-lg-3 col-md-4 label">Fin:</label>
                                <div class="col-sm-4">
                                  <input type="date" class="input-popup" v-model="audience.date_fin">
                                </div> à 
                                <div class="col-sm-4">
                                  <input type="time" class="input-popup" v-model="audience.time_fin">
                                </div>
                              </div>
                            </div>

                            <div class="row">
                              <div class="row mb-2">
                                <div class="col-lg-3 col-md-4 label ">Nom: </div>
                                <div class="col-lg-9 col-md-8">{{audience.nom}}</div>
                              </div>
                            </div>
    
                            <div class="row">
                              <div class="row mb-2">
                                <div class="col-lg-3 col-md-4 label ">Prénom: </div>
                                <div class="col-lg-9 col-md-8">{{audience.prenom}}</div>
                              </div>
                            </div>
          
                            <div class="row">
                              <div class="row mb-2">
                                <div class="col-lg-3 col-md-4 label">Tél:</div>
                                <div class="col-lg-9 col-md-8">{{audience.numero_telephone}}</div>
                              </div>
                            </div>
          
                            <div class="row">
                              <div class="row mb-2">
                                <div class="col-lg-3 col-md-4 label">Mail:</div>
                                <div class="col-lg-9 col-md-8">{{audience.email}}</div>
                              </div>
                            </div>
    
                            <div class="row">
                              <div class="row mb-2">
                                <div class="col-lg-3 col-md-4 label">Status:</div>
                                <div class="col-lg-9 col-md-8">
                                  <span class="badge bg-dark" v-if="audience.status === 'Reporté'">{{audience.status}}</span>
                                  <span class="badge bg-danger" v-else-if="audience.status === 'Non validé'">{{audience.status}}</span>
                                  <span class="badge bg-success" v-else-if="audience.status === 'Validé'">{{audience.status}}</span>
                                  <span class="badge bg-light text-dark" v-else>{{audience.status}}</span>
                                </div>
                              </div>
                            </div>
    
                            <div class="row">
                              <div class="row mb-2">
                                <div class="col-lg-3 col-md-4 label"> Etat:</div>
                                <div class="col-lg-9 col-md-8">
                                  <input class="form-check-input" type="checkbox" v-model="terminerEvenement" id="gridCheck1"> Terminer
                                </div>
                              </div>
                            </div>

                            <div class="row">
                              <div class="row mb-2">
                                <div class="col-lg-3 col-md-4 label">
                                  <RouterLink :to="{name: 'back-office-detail-demande-stage',params:{id_demande_stage: audience.id_evenement}}">
                                    Voir plus
                                  </RouterLink> 
                                </div>
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
                    <button type="submit" class="btn btn-warning" @click="setEtatAction(4)"  v-if="audience.status === 'Validé'" >
                      Modifier
                    </button>
                    <button type="submit" class="btn btn-dark" @click="setEtatAction(2)" v-if="audience.status === 'Validé' || audience.status === 'Non validé'" >
                      Reporter
                    </button>
                    <button type="submit" class="btn btn-success" @click="setEtatAction(3)" v-if="audience.status === 'Reporté'" >
                      Revalider
                    </button>
                  </div>
                </div>

              </div>
            </form>
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
    import DemandeAudienceAgentAPI from '../../api/demande_audience_agent'
    import nonDispoAPI from '../../api/NonDispo'
    import AutoriteApi from '../../api/autorite'
    import AgentApi from '../../api/agent'
    import EntretienApi from '../../api/entretien_stage'
    import EvenementApi from '../../api/evenement'

    import DemandeAudiencePublicAPI from '../../api/demande_audience_public'
    import Swal from 'sweetalert2';
    import swal from 'sweetalert';
    import Function from '../../func/function';
    // import tippy from 'tippy.js';
    // import 'tippy.js/dist/tippy.css';
    // import 'tippy.js/themes/light.css';
    import ColorInfos from '../instruction/ColorInformation.vue'
    import InputStructure from '../tStructureComponent/Tstructure.vue';
    import SpinnerPopup from '../loading/SpinnerPopup.vue'

    // import moment from 'moment'
    import moment from 'moment-timezone'
    moment.tz.setDefault('Indian/Antananarivo')

    export default{
      components: {
          FullCalendar,
          InputStructure,
          SpinnerPopup,
          ColorInfos
      },
        
      props:{
        sessionNavigateur: String,
        autoriteSender: Object,
        typeCalendrier: String,
        masqueEvenementFini: Boolean
      },

      // emits:['monCalendrier'],

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
                  // initialView: 'timeGridDay',
                  initialView: 'timeGridWeek',
                  initialDate:'2023-11-06',
                  datesSet: this.setMonCalendrier,

                  // initialEvents: this.all_actual_events,
                  weekNumbers: true,
                  dayMaxEvents: true,
                  dayMaxEvents: true,
                  weekends: false,
                  contentHeight: 420,
                  selectable:true,
                  selectMirror: true,
                  select: this.handleDateSelect,
                  eventClick: this.handleEventClick,
                  eventResize: this.eventDragged,
                  eventDrop: this.eventDropped,
                  // eventDidMount: this.detailEvent,
                  slotMinTime: '08:00:00',
                  slotMaxTime: '16:00:00',
                  allDaySlot: false,
                  schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives'
              },
              showPopupAudience: false,
              sipnnerActivated: false,
              audience: {
                  // direction: this.autorite,
                isAgent:false,
                login_agent: '',
                password_agent:'',
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
              },
              date_debut_next:'',
              date_fin_previous:'',
              masqueEvenement: true,
              terminerEvenement: false,
              // boolean pour les bouttons
              etatAction: 0,
              // estValide: false,
              // estReporte: false,
              // estRevalide: false
              // spinnerStatus:''                 
          }
      },
      
      watch:{
        'audience.autoriteReceiver': async function(value){
          // console.log(value)
          this.setEvents(value)
        },
        'terminerEvenement': async function(value){
          this.setEvenementTerminer(value)
          this.refreshData()
          // this.togglePopupAudience()
          // this.terminerEvenement = false
          // this.showPopupAudience = false
          

          // this.terminerEvenement = false
          
        },
        date_debut_next: function (value){
          if(this.typeCalendrier === 'evenementiel')
            this.setCalendrierCheckBox()

          // console.log(this.date_fin_previous)
        },

        // date_debut_next: function (value){
        //   // console.log(value)
        //   if(this.typeCalendrier === 'evenementiel')
        //     this.setCalendrierCheckBox()

        //   // console.log(this.date_fin_previous)
        // },

        masqueEvenementFini: function(newVal,oldVal){
          // this.estTermine = newVal
          this.setMasqueEvent(newVal)
          this.setCalendrierCheckBox()
          // console.log(`valeur init: ${oldVal} `)
          // console.log(`Valeur final: ${newVal}`)
        }
        
      },

      emits:['spinnerStatus'],

      methods: {
        async setMonCalendrier(infos){
          const date_debut = moment(infos.startStr).format("YYYY-MM-DD")
          const date_fin = moment(infos.endStr).format("YYYY-MM-DD")
          this.date_debut_next = date_debut
          this.date_fin_previous = date_fin
          // const id = this.autoriteSender.child_id
          // this.calendarOptions.events = await AutoriteApi.calendrier({
          //   id_autorite: id,
          //   masque_event_ended: this.masqueEvenement,
          //   date_debut: this.date_debut_next,
          //   date_fin: this.date_fin_previous
          // })
        },


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

        async setEvenementTerminer(value){
          this.$emit('spinnerStatus', true)
          await EvenementApi.setTerminer({
            id_evenement: this.audience.id_evenement,
            type_evenement: this.audience.typeEvenement,
            est_termine: value
          })
          this.$emit('spinnerStatus', false)

          // console.log()
        },

        async setMasqueEvent(value){
          this.masqueEvenement = value
          // console.log(this.estTermine)
        },

        async setCalendrierCheckBox(){
          const id = this.autoriteSender.child_id
          this.calendarOptions.events = await AutoriteApi.calendrier({
            id_autorite: id,
            masque_event_ended: this.masqueEvenement,
            date_debut: this.date_debut_next,
            date_fin: this.date_fin_previous
          })
          this.calendarOptions.events.push({
            start: '1970-01-01T00:00:00',
            end: moment(new Date()).format("YYYY-MM-DDThh:mm:ss"),
            overlap: false,
            display: 'background',
            color: '#c8cacb9c'
          })
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

        async refreshData(){
          if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
            const id = this.autoriteSender.child_id
            this.calendarOptions.events = await AutoriteApi.calendrier({
              id_autorite: id,
              masque_event_ended: this.masqueEvenement,
              date_debut: this.date_debut_next,
              date_fin: this.date_fin_previous
            })
            this.showPopupAudience = false
          } 
        },         

        async ajouter(){

          if(this.typeCalendrier === 'audiencePublic'){
            if(this.audience.isAgent){
              const data = await AgentApi.login({nom_utilisateur: this.audience.login_agent,mot_de_passe: this.audience.password_agent})
              if(data.message){
                swal("Echec d'authentification", `${data.message}`, "error");
              }
              else 
              {
                const audience = {
                  id_agent: data.id_candidat,
                  nom: data.nom,
                  prenom: data.prenom,
                  // poste_agent: data.poste,
                  path_agent: data.path,
                  // login_agent: data.login,
                  // password_agent: data.password,
                  // prenom: Function.initcap(this.audience.prenom), 
                  numero_telephone: this.audience.numero_telephone,
                  email: this.audience.email,
                  motif: Function.specialChar(this.audience.motif),
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
                const response = await DemandeAudienceAgentAPI.ajouter(audience)
                // console.log(data)
                if(response.message){
                  this.togglePopupAudience()
                  this.sipnnerActivated = false
                  swal("Audience enregistrée", `${response.message}`, "success");
                  
                }
                else{
                    this.sipnnerActivated = false
                    swal("Audience non enregistrée", "Votre audience n'a pas été enregistrée", "error");
                }
                this.calendarOptions.events = await actual_events_public(this.audience.autoriteReceiver.child_id)
              }
            }
            else {
              const audience = {
                nom: this.audience.nom, 
                prenom: this.audience.prenom, 
                // prenom: Function.initcap(this.audience.prenom), 
                cin: this.audience.cin,
                numero_telephone: this.audience.numero_telephone,
                email: this.audience.email,
                motif: Function.specialChar(this.audience.motif),
                session_navigateur: this.audience.session_navigateur,
                date_debut: this.audience.date_debut,
                date_fin: this.audience.date_fin,
                heure_debut: this.audience.time_debut,
                heure_fin: this.audience.time_fin,
                session_navigateur: this.sessionNavigateur,
                id_date_heure_disponible_autorite: this.audience.id_date_heure_disponible_autorite,
                autoriteReceiver: this.audience.autoriteReceiver
              }
              // console.log(audience)
              this.sipnnerActivated = true
              const response = await DemandeAudiencePublicController.ajouter(audience)
              if(response.message){
                  this.togglePopupAudience()
                  this.sipnnerActivated = false
                  swal("Audience enregistrée", `${response.message}`, "success");
                  
              }
              else{
                  this.sipnnerActivated = false
                  swal("Audience non enregistrée", "Votre audience n'a pas été enregistrée", "error");
              }
              this.calendarOptions.events = await actual_events_public(this.audience.autoriteReceiver.child_id)
            }
          }
          else if(this.autoriteSender && this.typeCalendrier === 'audienceAutorite'){
            
            const audience = {
              motif: Function.specialChar(this.audience.motif),
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
            // this.sipnnerActivated = true
            this.$emit('spinnerStatus', true)
            const response = await DemandeAudienceAutoriteAPI.ajouter(audience)
            if(response.message){
              this.togglePopupAudience()
              swal("Audience enregistrée", `${response.message}`, "success");
              // this.sipnnerActivated = false
              this.$emit('spinnerStatus', false)
            }
            else{
                // this.sipnnerActivated = false
                this.$emit('spinnerStatus', false)
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
            if(this.audience.id_agent > 0){
              let data = await AgentApi.login({nom_utilisateur: this.audience.login_agent,mot_de_passe: this.audience.password_agent})
              if(data.message){
                swal("Echec d'authentification", `${data.message}`, "error");
              }
              else if(data.id_candidat != this.audience.id_agent) {
                swal("Echec d'authentification", `Vous n'etes pas l'agent exact`, "error");
              }
              else {
                const audience = {
                  id_audience : this.audience.id,
                  nom: data.nom, 
                  path_agent: data.path,
                  prenom: data.prenom, 

                  numero_telephone: this.audience.numero_telephone,
                  email: this.audience.email,
                  date_debut: this.audience.actual_place.date_disponible,
                  date_fin: this.audience.actual_place.date_disponible,
                  heure_debut: this.audience.actual_place.heure_debut,
                  heure_fin: this.audience.actual_place.heure_fin,
                  motif: Function.specialChar(this.audience.motif),
                  id_date_heure_disponible : this.audience.id_date_heure_disponible,
                  id_date_heure_disponible_autorite : this.audience.actual_place.id_date_heure_disponible_autorite,
                  id_dm_aud_public_heure_dispo : this.audience.id_dm_aud_public_heure_dispo,
                  autoriteReceiver: this.audience.autoriteReceiver

                }
                  // console.log(audience)
                this.sipnnerActivated = true
                const response = await DemandeAudienceAgentAPI.modifier(audience)
                if(response.message){
                  this.togglePopupAudience()
                  this.sipnnerActivated = false
                  swal("Audience modifiée", `${response.message}`, "success");
                }
                else{
                  swal("Audience n'a pas modifiée", "Votre audience n'a pas été modifiée", "error");
                }
              }
            }
            else{
              const audience = {
                id_audience : this.audience.id,
                nom: this.audience.nom, 
                prenom: Function.initcap(this.audience.prenom), 
                cin: this.audience.cin,
                numero_telephone: this.audience.numero_telephone,
                email: this.audience.email,
                date_debut: this.audience.actual_place.date_disponible,
                date_fin: this.audience.actual_place.date_disponible,
                heure_debut: this.audience.actual_place.heure_debut,
                heure_fin: this.audience.actual_place.heure_fin,
                motif: Function.specialChar(this.audience.motif),
                id_date_heure_disponible : this.audience.id_date_heure_disponible,
                id_date_heure_disponible_autorite : this.audience.actual_place.id_date_heure_disponible_autorite,
                id_dm_aud_public_heure_dispo : this.audience.id_dm_aud_public_heure_dispo,
                autoriteReceiver: this.audience.autoriteReceiver

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
            }
            this.calendarOptions.events = await actual_events_public(this.audience.autoriteReceiver.child_id)
          }
          else if(this.autoriteSender && this.typeCalendrier === 'audienceAutorite'){

            const audience = {
              motif: Function.specialChar(this.audience.motif),
              date_debut: this.audience.actual_place.date_disponible,
              date_fin: this.audience.actual_place.date_disponible,
              heure_debut: this.audience.actual_place.heure_debut,
              heure_fin: this.audience.actual_place.heure_fin,
              id_autorite_sender: this.autoriteSender.child_id,
              id_autorite_receiver: this.audience.autoriteReceiver.child_id,
              id_date_heure_disponible_autorite: this.audience.actual_place.id_date_heure_disponible_autorite,
              id_dm_aud_autorite_date_heure_dispo : this.audience.id_dm_aud_autorite_date_heure_dispo,
              autoriteSender: this.autoriteSender,
              autoriteReceiver: this.audience.autoriteReceiver,
              email: this.autoriteSender.email,
              numero_telephone: this.autoriteSender.phone,
              sigle: this.autoriteSender.sigle,
              child_libelle: this.autoriteSender.child_libelle,
              id_audience: this.audience.id
            }

            // const audience = {
            //   motif: Function.specialChar(this.audience.motif),
            //   id_date_heure_disponible_autorite : this.audience.id_date_heure_disponible_autorite,
            //   id_dm_aud_autorite_date_heure_dispo : this.audience.id_dm_aud_autorite_date_heure_dispo,
            //   email: this.audience.email,
            //   numero_telephone: this.audience.numero_telephone,
            //   id_audience: this.audience.id
            // }
            // this.sipnnerActivated = false
            this.$emit('spinnerStatus', true)
            const response = await DemandeAudienceAutoriteAPI.modifier(audience)
            if(response.message){
              this.togglePopupAudience()
              // this.sipnnerActivated = false
              this.$emit('spinnerStatus', false)
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
            if(this.audience.id_agent > 0){
              let data = await AgentApi.login({nom_utilisateur: this.audience.login_agent,mot_de_passe: this.audience.password_agent})
              if(data.id_candidat == this.audience.id_agent){
                this.togglePopupAudience()
                const response = await DemandeAudiencePublicController.supprimer(this.audience.id)
                swal(
                    'Audience supprimée',
                    `Votre audience a bien été supprimée`,
                    'success'
                )
                this.calendarOptions.events = await actual_events_public(this.audience.autoriteReceiver.child_id)         
              }
              else if (data.message){
                swal(
                    'Audience supprimée',
                    `${data.message}`,
                    'error'
                )
              }
              else {
                swal("Echec d'authentification", `Vous n'etes pas l'agent exact`, "error");
              }
            }
            else {
              const response = await DemandeAudiencePublicController.supprimer(this.audience.id)

              swal(
                  'Audience supprimée',
                  `Votre audience a bien été supprimée`,
                  'success'
              )
              this.togglePopupAudience()
              this.calendarOptions.events = await actual_events_public(this.audience.autoriteReceiver.child_id)
            }           
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
            // console.log(new Date())

              const arg = {
                id_dm_aud_public_date_heure_dispo: this.audience.id,
                id_audience: this.audience.id_evenement,
                date_debut: this.audience.date_debut,
                date_fin: this.audience.date_fin,
                heure_debut: this.audience.time_debut,
                heure_fin: this.audience.time_fin,
                id_autorite: this.autoriteSender.child_id,
                type_audience: this.audience.typeEvenement,
                autorite: {
                  id_autorite: this.autoriteSender.child_id,
                  intitule: this.autoriteSender.child_libelle,
                  intitule_code: this.autoriteSender.sigle
                },
                envoyeur: {
                  nom: this.audience.nom,
                  prenom: this.audience.prenom,
                  addresse_electronique: this.audience.email,
                  motif: this.audience.motif
                }
              }
              // console.log('Cool ca marche...')
              // this.sipnnerActivated = true
              this.$emit('spinnerStatus', true)
              const response = await DemandeAudiencePublicAPI.valider_public(arg)
              if(response.message){
                  this.togglePopupAudience()
                  // this.sipnnerActivated = false
                  this.$emit('spinnerStatus', false)
                  swal("Audience validée", `${response.message}`, "success");
              }
              else{
                  swal("Audience non validée", "Votre audience n'a pas été validée", "error");
              }
              this.refreshData()
              // this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: this.autoriteSender.child_id})

          }
          else if(this.typeCalendrier ==='evenementiel' && this.audience.typeEvenement ==='Agent'){
            const arg = {
              id_dm_aud_public_date_heure_dispo: this.audience.id,
              id_audience: this.audience.id_evenement,
              date_debut: this.audience.date_debut,
              date_fin: this.audience.date_fin,
              heure_debut: this.audience.time_debut,
              heure_fin: this.audience.time_fin,
              id_autorite: this.autoriteSender.child_id,
              type_audience: this.audience.typeEvenement,
              autorite: {
                id_autorite: this.autoriteSender.child_id,
                intitule: this.autoriteSender.child_libelle,
                intitule_code: this.autoriteSender.sigle
              },
              envoyeur: {
                nom: this.audience.nom,
                prenom: this.audience.prenom,
                addresse_electronique: this.audience.email,
                motif: this.audience.motif
              }
            }
            // this.sipnnerActivated = true
            this.$emit('spinnerStatus', true)
            const response = await DemandeAudiencePublicAPI.valider_public(arg)
            if(response.message){
                this.togglePopupAudience()
                // this.sipnnerActivated = false
                this.$emit('spinnerStatus', false)
                swal("Audience validée", `${response.message}`, "success");
            }
            else{
                swal("Audience non validée", "Votre audience n'a pas été validée", "error");
            }
            this.refreshData()
          }
          else if (this.typeCalendrier ==='evenementiel' && this.audience.typeEvenement ==='Autorité'){
            const arg = {
              envoyeur: this.evenement.envoyeur,
              autorite: this.evenement.autorite,
              id_autorite: this.evenement.id_autorite,
              date_debut : this.audience.date_debut,
              date_fin : this.audience.date_fin,
              heure_debut : this.audience.time_debut,
              heure_fin : this.audience.time_fin,
              id_dm_aud_aut_date_heure_dispo: this.evenement.id_dm_aud_aut_date_heure_dispo,
              id_audience: this.evenement.id_audience,
              motif: this.evenement.motif
            }
            
            this.$emit('spinnerStatus', true)
            const response = await DemandeAudienceAutoriteAPI.valider(arg)
            if(response.message){
              this.togglePopupAudience()
              // this.sipnnerActivated = false
              this.$emit('spinnerStatus', false)
              swal("Audience validée", `${response.message}`, "success");
            }
            if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
              const id = this.autoriteSender.child_id
              this.refreshData()
              // this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
            }
          }
          else if (this.typeCalendrier ==='evenementiel' && this.audience.typeEvenement ==='Entretien'){
            const arg = {
              id_entretien_stage: this.audience.id,
              id_demande_stage: this.audience.id_evenement,
              date_debut: this.audience.date_debut,
              date_fin: this.audience.date_fin,
              heure_debut: this.audience.time_debut,
              heure_fin: this.audience.time_fin,
              id_autorite: this.autoriteSender.child_id,
              type_audience: this.audience.typeEvenement,
              autorite: {
                id_autorite: this.autoriteSender.child_id,
                intitule: this.autoriteSender.child_libelle,
                intitule_code: this.autoriteSender.sigle
              },
              stagiaire: {
                nom: this.audience.nom,
                prenom: this.audience.prenom,
                addresse_electronique: this.audience.email,
                motif: this.audience.motif
              }
            }

            // this.sipnnerActivated = true
            this.$emit('spinnerStatus', true)
            const response = await EntretienApi.modifier_calendrier(arg)
            if(response.data){
              this.togglePopupAudience()
              // this.sipnnerActivated = false
              this.$emit('spinnerStatus', false)
              swal("Entretien modifié", `Entretien a bien été modifié`, "success");
            }
            if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
              const id = this.autoriteSender.child_id
              this.refreshData()
              // this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
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
                addresse_electronique: this.audience.email,
                motif: this.audience.motif
              }
            }
            // console.log('Reporte worked...')
            // this.sipnnerActivated = true
            this.$emit('spinnerStatus', true)
            const response = await DemandeAudiencePublicAPI.reporter_public_plus_tard(arg)
            if(response.message){
                this.togglePopupAudience()
                // this.sipnnerActivated = false
                this.$emit('spinnerStatus', false)
                swal("Audience reportée", `${response.message}`, "success");
            }
            else{
                swal("Audience non enregistrée", "Votre audience n'a pas été enregistrée", "error");
            }
            this.refreshData()
            // this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: this.autoriteSender.child_id})
          }
          else if(this.typeCalendrier ==='evenementiel' && this.audience.typeEvenement ==='Agent'){
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
                addresse_electronique: this.audience.email,
                motif: this.audience.motif
              }
            }
            // this.sipnnerActivated = true
            this.$emit('spinnerStatus', true)
            const response = await DemandeAudiencePublicAPI.reporter_public_plus_tard(arg)
            if(response.message){
                this.togglePopupAudience()
                // this.sipnnerActivated = false
                this.$emit('spinnerStatus', false)
                swal("Audience reportée", `${response.message}`, "success");
            }
            else{
                swal("Audience non enregistrée", "Votre audience n'a pas été enregistrée", "error");
            }
            this.refreshData()
            // this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: this.autoriteSender.child_id})
          }
          else if(this.typeCalendrier ==='evenementiel' && this.audience.typeEvenement ==='Entretien'){
            const arg = {
              id_entretien_stage: this.audience.id,
              id_demande_stage: this.audience.id_evenement,
              date_debut: this.audience.date_debut,
              date_fin: this.audience.date_fin,
              heure_debut: this.audience.time_debut,
              heure_fin: this.audience.time_fin,
              id_autorite: this.autoriteSender.child_id,
              type_audience: this.audience.typeEvenement,
              autorite: {
                id_autorite: this.autoriteSender.child_id,
                intitule: this.autoriteSender.child_libelle,
                intitule_code: this.autoriteSender.sigle
              },
              stagiaire: {
                nom: this.audience.nom,
                prenom: this.audience.prenom,
                addresse_electronique: this.audience.email,
                motif: this.audience.motif
              }
            }
            // const arg = {
            //   autorite: autoriteS,
            //   stage: {
            //     id: this.audience.id_evenement,
            //     addresse_electronique: this.audience.email,
            //     nom: this.audience.nom,
            //     prenom: this.audience.prenom
            //   }
            // }
            // this.sipnnerActivated = true
            this.$emit('spinnerStatus', true)
            const response = await EntretienApi.reporter(arg)
            if(response.data){
                this.togglePopupAudience()
                // this.sipnnerActivated = false
                this.$emit('spinnerStatus', false)
                swal("Entretien reportée", `${response.message}`, "success");
            }
            else{
                swal("Entretien non enregistrée", "L'entretien n'a pas été reporté", "error");
            }
            this.refreshData()
            // this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: this.autoriteSender.child_id})
          }
          else if (this.typeCalendrier ==='evenementiel' && this.audience.typeEvenement ==='Autorité'){
            this.$emit('spinnerStatus', true)
            const response = await DemandeAudienceAutoriteAPI.reporter_by_click(this.evenement)
            if(response.message){
              this.togglePopupAudience()
              // this.sipnnerActivated = false
              this.$emit('spinnerStatus', false)
              swal("Audience reportée", `${response.message}`, "success");
            }
            else {
              swal("Audience non reportée", `Votre audience n'a pas été reportée`, "error");
            }
            if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
              this.refreshData()
              // const id = this.autoriteSender.child_id
              // this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: this.autoriteSender.child_id})
            }
          }
        },
        


        setEtatAction(value){
          this.etatAction = value
        },



        async setActionEvenement(){


          const dateTimeDebut = moment(this.audience.date_debut+'T'+this.audience.time_debut)
          const date_debut = dateTimeDebut.format("YYYY-MM-DD")
          const heure_debut = dateTimeDebut.format("hh:mm:ss")

          const dateTimeFin = moment(this.audience.date_fin+'T'+this.audience.time_fin)
          const date_fin = dateTimeFin.format("YYYY-MM-DD")
          const heure_fin = dateTimeFin.format("hh:mm:ss")

          const currentDateTime = moment(new Date()).tz('Indian/Antananarivo')
          const currentDate = currentDateTime.format("YYYY-MM-DD")
          const currentTime = currentDateTime.format("hh:mm:ss")


          // console.log(`Get millisencod date_debut and current time: ${} and ${currentDateTime.format('x')}`)

          // Gestion d'erreur horaire
          if(date_debut < currentDate){
            swal("Erreur de la date début", 'La date du début est inférieure à la date actuelle', "error");
            console.log('Erreur 1')
            // this.resetEtat()

            // console.log('Date début est inférieure actuelle')

          }
          else if(date_fin < currentDate){
            swal(
              'Erreur de la date fin',
              'La date fin est inférieure à la date actuelle',
              'error'
            )
            // this.resetEtat()
          }
          else if( dateTimeDebut.format('x') < currentDateTime.format('x') ){
            swal("Erreur d'horaire", 'L\'heure du début est inférieure à l\'heure actuelle', "error");
            // this.resetEtat()
            // console.log('Heure début est inférieure')
          }
          else if(dateTimeFin.format('x') < currentDateTime.format('x')){
            swal("Erreur d'horaire", 'L\'heure fin est inférieure à l\'heure actuelle', "error");
            // this.resetEtat()
            // console.log("Heure fin est inférieure actuelle...")
          }
          else if(dateTimeDebut.format('x') > dateTimeFin.format('x')){
            swal("Erreur d'horaire", 'L\'heure du début est supérieur à l\'heure fin', "error");
            // this.resetEtat()
            // console.log('Date début est supérieure au date fin')
          }
          else if(dateTimeDebut.day() == 6 || dateTimeDebut.day() == 0){
            swal("Erreur de la date début", 'Les week-ends sont pas permis', "error");
          }

          else if(dateTimeFin.day() == 6 || dateTimeFin.day() == 0){
            swal("Erreur de la date fin", 'Les week-ends sont pas permis', "error");
          }
          else {
            if(this.etatAction == 1){
              this.valider()
            }else if(this.etatAction == 2){
              this.reporter()
            }else if(this.etatAction == 3){
              this.valider()
              // console.log('Revalider un event...')
            }else if(this.etatAction == 4){
              this.valider()
            }
          }

          // Gestion d'eurreur horaire


          // this.resetEtat()
          // if()
        },

        togglePopupAudience(){
            this.showPopupAudience = !this.showPopupAudience
        },

        async handleDateSelect(selectInfo){
          this.$emit('spinnerStatus', true)
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
            // if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
            //   const id = this.autoriteSender.child_id
            //   this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
            // }
            // const id = this.autoriteSender.child_id
            // this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
              this.refreshData()
          }
          
          this.$emit('spinnerStatus', false)
        },

        async eventDropped(event){
          this.$emit('spinnerStatus', true)
          const start_date_time = Function.format_date_time(event.event.start)
          const end_date_time = Function.format_date_time(event.event.end)  

          // evenement
          this.evenement.id_autorite = this.autoriteSender.child_id
          this.evenement.date_debut = start_date_time[0]
          this.evenement.date_fin = end_date_time[0]
          this.evenement.heure_debut = start_date_time[1]
          this.evenement.heure_fin = end_date_time[1]
          this.evenement.motif = event.event.extendedProps.motif  

          this.evenement.autorite = {
            intitule: this.autoriteSender.child_libelle,
            intitule_code: this.autoriteSender.sigle,
          }

          const type = event.event.extendedProps.type_audience
          const status = event.event.extendedProps.status_audience
          
          if(type === 'Public'){
            this.evenement.envoyeur = {
              nom: event.event.extendedProps.nom,
              prenom: event.event.extendedProps.prenom,
              addresse_electronique: event.event.extendedProps.email,
              numero_telephone: event.event.extendedProps.numero_telephone,
              motif: event.event.extendedProps.motif
            }
          }
          else if(type === 'Agent'){
            this.evenement.envoyeur = {
              nom: event.event.extendedProps.nom,
              prenom: event.event.extendedProps.prenom,
              addresse_electronique: event.event.extendedProps.email,
              numero_telephone: event.event.extendedProps.numero_telephone,
              motif: event.event.extendedProps.motif
            }
          }
          else if(type === 'Autorité'){
            this.evenement.envoyeur = {
              intitule: event.event.extendedProps.child_libelle,
              intitule_code: event.event.extendedProps.sigle,
              addresse_electronique: event.event.extendedProps.addresse_electronique_sender_externe,
              numero_telephone: event.event.extendedProps.numero_telephone,
              motif: event.event.extendedProps.motif
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
              // this.refreshData()
              const id = this.autoriteSender.child_id
              this.calendarOptions.events = await AutoriteApi.calendrier({
                id_autorite: id,
                masque_event_ended: this.masqueEvenement,
                date_debut: this.date_debut_next,
                date_fin: this.date_fin_previous
              })
            }
          }

          else if(type === 'Public'){
            this.evenement.id_dm_aud_public_date_heure_dispo = event.event.id
            this.evenement.id_audience = event.event.extendedProps.id_evenement
            if(status === 'Non validé'){
              // this.$emit('spinnerStatus', true)
              const response = await DemandeAudiencePublicAPI.valider_public(this.evenement)
            }
            else if (status === 'Validé'){
              // this.$emit('spinnerStatus', true)
              const response = await DemandeAudiencePublicAPI.reporter_public_maintenant(this.evenement)
            }
            else if (status === 'Reporté'){
              // this.$emit('spinnerStatus', true)
              const response = await DemandeAudiencePublicAPI.revalider_public(this.evenement)
            }
            if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
              this.refreshData()
              // const id = this.autoriteSender.child_id
              // this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
            }

          }
          else if(type === 'Agent'){
            this.evenement.id_dm_aud_public_date_heure_dispo = event.event.id
            this.evenement.id_audience = event.event.extendedProps.id_evenement
            if(status === 'Non validé'){
              // this.$emit('spinnerStatus', true)
              const response = await DemandeAudiencePublicAPI.valider_public(this.evenement)
            }
            else if (status === 'Validé'){
              // this.$emit('spinnerStatus', true)
              const response = await DemandeAudiencePublicAPI.reporter_public_maintenant(this.evenement)
            }
            else if (status === 'Reporté'){
              // this.$emit('spinnerStatus', true)
              const response = await DemandeAudiencePublicAPI.revalider_public(this.evenement)
            }
            if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
              this.refreshData()
              // const id = this.autoriteSender.child_id
              // this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
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
              this.refreshData()
              // const id = this.autoriteSender.child_id
              // this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
            }
          }

          else if(type === 'Entretien'){
            // console.log(event.event.id)
            this.evenement.id_entretien_stage = event.event.id
            this.evenement.id_demande_stage = event.event.extendedProps.id_evenement
            this.evenement.stagiaire = {
              nom: event.event.extendedProps.nom,
              prenom: event.event.extendedProps.prenom,
              addresse_electronique: event.event.extendedProps.email,
              numero_telephone: event.event.extendedProps.numero_telephone
            }

            const response = await EntretienApi.modifier_calendrier(this.evenement)
            if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
              this.refreshData()
              // const id = this.autoriteSender.child_id
              // this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
            }
          }
          this.$emit('spinnerStatus', false)
        },

        async eventDragged(event){
          console.log('etirer')
 
          this.$emit('spinnerStatus', true)
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
              addresse_electronique: event.event.extendedProps.email,
              numero_telephone: event.event.extendedProps.numero_telephone,
              motif: event.event.extendedProps.motif
            }
          }
          else if(type === 'Agent'){
            this.evenement.envoyeur = {
              nom: event.event.extendedProps.nom,
              prenom: event.event.extendedProps.prenom,
              addresse_electronique: event.event.extendedProps.email,
              numero_telephone: event.event.extendedProps.numero_telephone,
              motif: event.event.extendedProps.motif
            }
          }
          else if(type === 'Autorité') {
            this.evenement.envoyeur = {
              intitule: event.event.extendedProps.child_libelle,
              intitule_code: event.event.extendedProps.sigle,
              addresse_electronique: event.event.extendedProps.addresse_electronique_sender_externe,
              numero_telephone: event.event.extendedProps.numero_telephone,
              motif: event.event.extendedProps.motif
            }
          }

          if(type === 'Pas disponible'){
            this.evenement.id_pas_dispo = event.event.id,
            this.evenement.id_date_heure_non_dispo = event.event.extendedProps.id_evenement
            
            const response = await nonDispoAPI.modifier_non_disponible(this.evenement)
            
            if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
              this.refreshData()
              // const id = this.autoriteSender.child_id
              // this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
            }
          
          }

          else if(type === 'Public'){
            this.evenement.id_dm_aud_public_date_heure_dispo = event.event.id
            this.evenement.id_audience = event.event.extendedProps.id_evenement
            if(status === 'Non validé'){
              // console.log(event.event.extendedProps)
              // this.$emit('spinnerStatus', true)
              const response = await DemandeAudiencePublicAPI.valider_public(this.evenement)
            }
            else if (status === 'Validé'){
              // this.$emit('spinnerStatus', true)
              const response = await DemandeAudiencePublicAPI.reporter_public_maintenant(this.evenement)
            }
            else if (status === 'Reporté'){
              // this.$emit('spinnerStatus', true)
              const response = await DemandeAudiencePublicAPI.revalider_public(this.evenement)
            }
            if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
              const id = this.autoriteSender.child_id
              this.calendarOptions.events = await AutoriteApi.calendrier({
                id_autorite: id,
                masque_event_ended: this.masqueEvenement,
                date_debut: this.date_debut_next,
                date_fin: this.date_fin_previous
              })
            }
          }
          else if(type === 'Agent'){
            this.evenement.id_dm_aud_public_date_heure_dispo = event.event.id
            this.evenement.id_audience = event.event.extendedProps.id_evenement
            if(status === 'Non validé'){
              // console.log(event.event.extendedProps)
              // this.$emit('spinnerStatus', true)
              const response = await DemandeAudiencePublicAPI.valider_public(this.evenement)
            }
            else if (status === 'Validé'){
              // this.$emit('spinnerStatus', true)
              const response = await DemandeAudiencePublicAPI.reporter_public_maintenant(this.evenement)
            }
            else if (status === 'Reporté'){
              // this.$emit('spinnerStatus', true)
              const response = await DemandeAudiencePublicAPI.revalider_public(this.evenement)
            }
            if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
              const id = this.autoriteSender.child_id
              this.calendarOptions.events = await AutoriteApi.calendrier({
                id_autorite: id,
                masque_event_ended: this.masqueEvenement,
                date_debut: this.date_debut_next,
                date_fin: this.date_fin_previous
              })
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
              this.calendarOptions.events = await AutoriteApi.calendrier({
                id_autorite: id,
                masque_event_ended: this.masqueEvenement,
                date_debut: this.date_debut_next,
                date_fin: this.date_fin_previous
              })
            }
          }

          else if(type === 'Entretien'){
            // console.log(event.event.id)
            this.evenement.id_entretien_stage = event.event.id
            this.evenement.id_demande_stage = event.event.extendedProps.id_evenement
            this.evenement.stagiaire = {
              nom: event.event.extendedProps.nom,
              prenom: event.event.extendedProps.prenom,
              addresse_electronique: event.event.extendedProps.email,
              numero_telephone: event.event.extendedProps.numero_telephone
            }

            const response = await EntretienApi.modifier_calendrier(this.evenement)
            if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
              const id = this.autoriteSender.child_id
              this.calendarOptions.events = await AutoriteApi.calendrier({
                id_autorite: id,
                masque_event_ended: this.masqueEvenement,
                date_debut: this.date_debut_next,
                date_fin: this.date_fin_previous
              })
            }
          }
          this.$emit('spinnerStatus', false)
        },
        
        async handleEventClick(event){

          // console.log(event.event.extendedProps)

          // this.spinnerStatus = 'enabled'

          const start_date_time = Function.format_date_time(event.event.start)
          const end_date_time = Function.format_date_time(event.event.end)  

          // evenement
          this.audience.isAgent = false
          this.audience.id_agent = event.event.extendedProps.id_agent
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
            // const place_formated = {
            //   date_disponible: this.audience.places_disponible[0]["date_disponible"].split('T')[0],
            //   heure_debut: this.audience.places_disponible[0]["heure_debut"],
            //   heure_fin: this.audience.places_disponible[0]["heure_fin"],
            //   id_date_heure_disponible_autorite: 
            // }
            this.audience.actual_place = this.audience.places_disponible[0]
          }

          // Terminer un évènement
          if(this.typeCalendrier == 'evenementiel' ){
            if(event.event.extendedProps.est_termine == 1){
              this.terminerEvenement = true
            }
            else {
              this.terminerEvenement = false
            }
          }


          if(this.typeCalendrier === 'evenementiel' && this.audience.typeEvenement ==='Autorité'){
            // console.log('A modifier et ajouter...')
            this.audience.structure = `${event.event.extendedProps.child_libelle} (${event.event.extendedProps.sigle})`
            this.evenement.envoyeur = {
              intitule: event.event.extendedProps.child_libelle,
              intitule_code: event.event.extendedProps.sigle,
              addresse_electronique: event.event.extendedProps.email,
              numero_telephone: event.event.extendedProps.numero_telephone
            }
            this.evenement.autorite = {
              id: this.autoriteSender.child_id,
              intitule_code: this.autoriteSender.sigle,
              intitule: this.autoriteSender.child_libelle,
              addresse_electronique: this.autoriteSender.email
            }
            this.evenement.id_autorite = this.autoriteSender.child_id
            this.evenement.date_debut = this.audience.date_debut
            this.evenement.date_fin = this.audience.date_fin
            this.evenement.heure_debut = this.audience.time_debut
            this.evenement.heure_fin = this.audience.time_fin

            this.evenement.id_dm_aud_aut_date_heure_dispo = event.event.id
            this.evenement.id_audience = event.event.extendedProps.id_evenement
            this.evenement.motif = event.event.extendedProps.motif

          }

          if(this.typeCalendrier === 'evenementiel' && this.audience.typeEvenement ==='Agent'){
            this.audience.poste_agent = event.event.extendedProps.poste
            this.audience.path_agent = event.event.extendedProps.path
            console.log('Agent')
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
              this.$emit('spinnerStatus', true)
              // this.sipnnerActivated = true
              await nonDispoAPI.supprimer_non_disponible({
                id_date_heure_non_dispo: this.audience.id_evenement
              })
              this.refreshData()
              this.$emit('spinnerStatus', false)
              // const id = this.autoriteSender.child_id
              // this.calendarOptions.events = await AutoriteApi.calendrier({id_autorite: id})
              this.count = 0
            }
          }

          // controle unitaire des infos
          if(this.typeCalendrier == 'evenementiel'){
            this.setDateTimeDetailEvenement(event.event.extendedProps)
          }
          // this.controlDate()
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
        },

        setDateTimeDetailEvenement(info){
          this.audience.date_debut = new Date(info.date_debut).toJSON().slice(0,10)
          this.audience.date_fin = new Date(info.date_fin).toJSON().slice(0,10)
          this.audience.time_debut = info.heure_debut
          this.audience.time_fin = info.heure_fin

          // if(new Date(info.date_fin) < new Date()){
          //   // initialiser date actuel

          //   // console.log('Date inférieure...')
          //   // if(dateVar.getTime(info.heure_fin) < dateVar.getTime(new Date())){
          //   //   console.log('Heure inférieure')
          //   // }
          // } else if (new Date(info.date_fin) > new Date()){
          //   console.log('Date supérieure')
          // }
          // else {
          //   console.log('Date ne change pas')
          // }
        },

        controlDate(){
          const dateTimeDebut = new Date(this.audience.date_debut+'T'+this.audience.time_debut)
          const dateTimeFin = new Date(this.audience.date_fin+'T'+this.audience.time_fin)
          if(new Date(this.audience.date_debut) < new Date()){

            console.log('Date début est inférieure actuelle')

          }
          else if(new Date(this.audience.date_fin) < new Date()){
            console.log('Date fin est  inférieure')
          }
          else if(dateTimeDebut.getTime() < new Date().getTime()){
            console.log('Heure début est inférieure')
          }
          else if(dateTimeFin.getTime() < new Date().getTime()){
            console.log("Heure fin est inférieure actuelle...")
          }
          else if(new Date(this.audience.date_debut) > new Date(this.audience.date_fin)){
            console.log('Date début est supérieure au date fin')
          }
        },

        date_actu(){
          return new Date().toJSON().slice(0, 10)
        },


      },

      async created(){
        // if(this.autoriteSender)

        if(this.typeCalendrier === 'audiencePublic'){
          this.calendarOptions.selectable = false
          this.dataColorInfos = [
            {
              color: '#407DFF',
              infos: 'Audience validé'
            },
            {
              color: '#FF0018',
              infos: 'Audience non validé'
            },
            {
              color: '#0AA913',
              infos: 'Autorité disponible'
            },
            {
              color: '#000000',
              infos: 'Audience reporté '
            }
          ]
        }
        else if(this.typeCalendrier === 'audienceAutorite'){
          this.calendarOptions.selectable = false
          this.dataColorInfos = [
            {
              color: '#407DFF',
              infos: 'Audience validé'
            },
            {
              color: '#FF0018',
              infos: 'Audience non validé'
            },
            {
              color: '#0AA913',
              infos: 'Autorité disponible'
            },
            {
              color: '#000000',
              infos: 'Audience reporté '
            }
          ]
        }
        else if(this.typeCalendrier === 'evenementiel'){
          this.dataColorInfos = [
            {
              color: '#FF0018',
              infos: 'Audience autorité'
            },
            {
              color: '#532006',
              // color: '#993300',
              infos: 'Audience agent'
            },
            {
              color: '#0AA913',
              infos: 'Audience public'
            },
            {
              color: '#000000',
              infos: 'Autorité pas disponible '
            },
            {
              color: '#FFA500',
              infos: 'Entretien stagiaire'
            },
            

            
          ]
          // if(this.autoriteSender){
          //   this.$emit('monCalendrier',true)    
          // }
          // if(this.autoriteSender){
          //   const id = this.autoriteSender.child_id
          //   this.calendarOptions.events = await AutoriteApi.calendrier({
          //     id_autorite: id,
          //     masque_event_ended: this.masqueEvenement
          //   })
          // }
        }
      },

      // async mounted() {
      //   if(this.autoriteSender && this.typeCalendrier === 'evenementiel'){
      //     // console.log('Updated ve...')
      //     const id = this.autoriteSender.child_id
      //     this.calendarOptions.events = await AutoriteApi.calendrier({
      //       id_autorite: id,
      //       masque_event_ended: this.masqueEvenement,
      //       date_debut: this.date_debut_next,
      //       date_fin: this.date_fin_previous
      //     })
      //   } 
      // },

    }
</script>

<style>
  .text-center button{
    margin-left: 5px
  }
  .form-select:disabled {
    background-color: #fafafa !important;
  }
  .fc-event{
    cursor: pointer;
  }
  .input-popup {
    display: block;
    width: 100%;
    padding: 0.075rem 0.25rem;
    font-size: 15px;
  }


</style>