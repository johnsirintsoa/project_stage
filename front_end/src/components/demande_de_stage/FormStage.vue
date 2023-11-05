<!-- <script setup>
    import structure from '../tStructureComponent/Tstructure.vue'
    import spinnerLoading from '../loading/SpinnerHeader.vue'

</script> -->

<template>
    <div class="card">
        <div class="card-body">
        <h5 class="card-title">Formulaire :</h5>

        <!-- <form @submit.prevent="addDemandeStage" ref="formStage" enctype="multipart/form-data" >
            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">Nom:</label>
            <div class="col-sm-12">
                <input type="text" class="form-control" id="nom" name="nom" v-model="stage.nom" required="" >
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">Prénom:</label>
            <div class="col-sm-12">
                <input type="text" class="form-control" id="prenom" name="prenom" v-model="stage.prenom" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">Téléphone:</label>
            <div class="col-sm-12">
                <input 
                    type="tel" 
                    class="form-control" 
                    id="telephone" 
                    name="telephone" 
                    v-model="stage.telephone" 
                    required
                    pattern="[0-9]{3}[0-9]{2}[0-9]{3}[0-9]{2}"
                    minlength="10"
                    maxlength="10"
                >
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationCustomUsername" class="form-label">Email</label>
            <div class="col-sm-12">
                <input type="email" class="form-control" id="email" name="email" v-model="stage.e_mail" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">CIN:</label>
            <div class="col-sm-12">
                <input 
                    type="text"
                    class="form-control"
                    id="cin"
                    name="cin"
                    v-model="stage.cin"
                    pattern="[0-9]{12}"
                    minlength="12"
                    maxlength="12"
                >
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">Durée de stage:</label>
            <div class="col-sm-12">
                <input type="number" class="form-control" id="duree" name="duree" v-model="stage.duree" required>
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">Votre message:</label>
            <div class="col-sm-12">
                <textarea class="form-control" style="height: 100px" id="message" name="message" v-model="stage.message" required=""></textarea>
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationCustom02" class="form-label">Domaine:</label>
            <div class="col-sm-12">
                <select class="form-select" id="domaine" name="domaine" v-model="stage.id_domaine" aria-label="Default select example" required="">
                    <option selected disabled value="">Domaine</option>
                    <option v-for="(domaine,index)  in domaines"  :value="domaine.id" > {{domaine.nom_domaine}}</option>
                </select>
            </div>
            <div class="invalid-feedback">
                Entrez un domaine
            </div>
            </div>

            <div class="row mb-3">
                <label for="validationCustom02" class="form-label">Direction:</label>
                <structure
                    @getAutoriteClicked="getAutorite"
                /> 
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">CV:</label>
            <div class="col-sm-12">
                <input type="file" @change="selectCV($event)" ref="file_cv" id="curriculum_vitae" name="curriculum_vitae" class="form-control"  required="">
            </div>
            </div>
            
            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">Lettre de motivation:</label>
            <div class="col-sm-12">
                <input type="file" @change="selectLM($event)"  ref="file_lm" class="form-control"  id="lettre_motivation" name="lettre_motivation" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">Lettre d'introduction: </label>
            <div class="col-sm-12">
                <input type="file" @change="selectLI($event)" ref="file_li" class="form-control" id="lettre_introduction" name="lettre_introduction" required="" >
            </div>
            </div>

            <spinnerLoading 
                :sipnnerActivated="sipnnerActivated"
            />
            
            <div class="row mb-3">

                <div class="text-center">
                    
                    <button  type="submit" class="btn btn-primary" style="width: 50%;">Valider</button>
                </div>
            </div>

        </form> -->
        
        <form class="row g-3" @submit.prevent="addDemandeStage" ref="formStage" enctype="multipart/form-data">
            <div class="col-md-4">
              <label for="inputName5" class="form-label">Nom:</label>
              <input type="text" class="form-control" placeholder="Nom" v-model="stage.nom" required="" >
              <!-- <input type="text" class="form-control" placeholder="Nom" id="nom" name="nom" v-model="stage.nom" required="" > -->
            </div>

            <div class="col-md-4">
              <label for="inputEmail5" class="form-label">Prénom:</label>
              <input type="text" class="form-control" placeholder="Prénom" id="prenom" name="prenom" v-model="stage.prenom" required="">
            </div>

            <div class="col-md-4">
                <label for="inputEmail5" class="form-label">Etablissement:</label>
                <input type="text" class="form-control"  placeholder="Etablissement" id="etablissement" name="prenom" v-model="stage.etablissement" 
                    @mouseover="showInfos('etablissement','Si vous êtes étudiants, veuillez remplir le champ ci-dessous')"

                >
              </div>
            
            <div class="col-md-4">
              <label for="validationDefault01" class="form-label">Téléphone:</label>
              <div class="col-sm-12">
                  <input 
                    placeholder="0341234567"
                      type="tel" 
                      class="form-control" 
                      id="telephone" 
                      name="telephone" 
                      v-model="stage.telephone" 
                      required
                      pattern="[0-9]{3}[0-9]{2}[0-9]{3}[0-9]{2}"
                      minlength="10"
                      maxlength="10"
                  >
              </div>
            </div>
            <div class="col-md-4">
                <label for="validationCustomUsername" class="form-label">Email:
                </label>
                <div class="col-sm-12">
                    <input type="email" placeholder="example@gmail.com" class="form-control" v-model="stage.e_mail" required="">
                    <!-- <input type="email" placeholder="example@gmail.com" class="form-control" id="email" name="email" v-model="stage.e_mail" required=""> -->
                </div>
            </div>
            <div class="col-md-4">
                <label for="validationDefault01" class="form-label">CIN:</label>
                <div class="col-sm-12">
                    <input 
                        type="text"
                        placeholder="Numéro CIN"
                        class="form-control"
                        id="cin"
                        name="cin"
                        v-model="stage.cin"
                        pattern="[0-9]{12}"
                        minlength="12"
                        maxlength="12"
                    >
                </div>
            </div>

            <div class="col-md-1">            
                <label for="validationDefault01" class="form-label">Durée(mois):</label>
                <div class="col-sm-12">
                    <input type="number" class="form-control" id="duree" min="0" name="duree" v-model="stage.duree" required>
                </div>
            </div>

            <div class="col-md-2">
                <label for="validationCustom02" class="form-label">Domaine:</label>
                <div class="col-sm-12">
                    <select class="form-select" id="domaine" name="domaine" v-model="stage.id_domaine" aria-label="Default select example" required="">
                        <option selected disabled value="">Domaine</option>
                        <option v-for="(domaine,index)  in domaines"  :value="domaine.id" > {{domaine.nom_domaine}}</option>
                    </select>
                </div>
            </div>

            <div class="col-md-3">
                <label for="validationDefault01" class="form-label">CV:</label>
                <div class="col-sm-12">
                    <input type="file" @change="selectCV($event)" ref="file_cv" id="curriculum_vitae" name="curriculum_vitae" class="form-control"  required="">
                </div>
            </div>

            <div class="col-md-3">
                <label for="validationDefault01" class="form-label">Lettre de motivation:</label>
                <div class="col-sm-12">
                    <input type="file" @change="selectLM($event)"  ref="file_lm" class="form-control"  id="lettre_motivation" name="lettre_motivation" required="">
                </div>
            </div>

            <div class="col-md-3">
                <label for="validationDefault01" class="form-label">Lettre d'introduction: </label>
                <div class="col-sm-12">
                    <input type="file" @change="selectLI($event)" ref="file_li" class="form-control" id="lettre_introduction" name="lettre_introduction" required="" >
                </div>
            </div>

            <div class="col-md-12">
                <label for="validationDefault01" class="form-label">Votre message:</label>
                <div class="col-sm-12">
                    <textarea class="form-control" placeholder="Saisissez ici vos motifs" style="height: 100px" id="message" name="message" v-model="stage.message" required=""></textarea>
                </div>
            </div>

            <div class="col-md-12">
                <label for="validationCustom02" class="form-label">Direction:</label>
                <structure
                    @getAutoriteClicked="getAutorite"
                /> 
            </div>

            <spinnerLoading 
                :sipnnerActivated="sipnnerActivated"
            />

            <div class="text-center">
              <button type="submit" class="btn btn-primary">Ajouter</button>
              <button type="reset" @change="viderChamp" class="btn btn-secondary">Annuler</button>
            </div>
        </form>

        </div>
    </div>
</template>

<script>
// import DemandeStageAPI from '../../api/demande_stage';
import structure from '../tStructureComponent/Tstructure.vue'
import spinnerLoading from '../loading/SpinnerPopup.vue'
import axios from 'axios';
import DemandeStageAPI from '../../api/demande_stage';
import DomaineAPI from '../../api/domaine';
import AutoriteApi from '../../api/autorite';
import swal from 'sweetalert';
import Function from '../../func/function'

import tippy from 'tippy.js';
import 'tippy.js/dist/tippy.css'; 

export default {
    components:{
        structure,
        spinnerLoading
    },
    data(){
        return{
            sipnnerActivated: false,
            stage: {
                nom:'',
                prenom:'',
                telephone:'',
                e_mail:'',
                cin:'',
                duree:'1',
                curriculum_vitae:'',
                lettre_motivation:'',
                lettre_introduction:'',
                message:'',
                id_autorite_enfant:'',
                id_domaine:'',
                etablissement: ''
            },
            domaines:'',
            autorites:'',
        }
    },
    async created() {
        // console.log(this.stage)
        this.domaines = await DomaineAPI.allDomaine();
        // this.autorites = await AutoriteApi.liste()
        // console.log(this.domaines.)
    },
    methods: {
        selectCV(event){
            // this.stage.curriculum_vitae = this.$refs.file_cv.files[0]
            this.stage.curriculum_vitae = event.target.files[0]

        },
        selectLM(event){
            // this.stage.lettre_motivation = this.$refs.file_lm.files[0]
            this.stage.lettre_motivation = event.target.files[0]

        },
        selectLI(event){
            // this.stage.lettre_introduction = this.$refs.file_li.files[0]
            this.stage.lettre_introduction = event.target.files[0]

        },

        getAutorite(value){
            this.stage.id_autorite_enfant = value.child_id
            this.stage.autorite = value.child_libelle
            this.stage.sigle = value.sigle
            this.stage.autoriteEmail = value.email
            // console.log(value)
        },

        showInfos(idName,content){
            tippy(`#${idName}`, {
                theme:'light',
                content: `<p>${content}</p>`,
                allowHTML: true,
                delay:[200,0]
            });
        },

        viderChamp(){
            this.stage.nom = '',
            this.stage.prenom = '',
            this.stage.telephone = '',
            this.stage.e_mail = '',
            this.stage.cin = '',
            this.stage.duree = '1',
            this.stage.curriculum_vitae = '',
            this.stage.lettre_motivation = '',
            this.stage.lettre_introduction = '',
            this.stage.message = '',
            this.stage.id_autorite_enfant = '',
            this.stage.id_domaine = '',
            this.stage.etablissement = ''
        },
        async addDemandeStage(){
            this.sipnnerActivated = true
            const demande_stage = new FormData()
            demande_stage.append('nom',Function.specialChar(this.stage.nom))
            demande_stage.append('prenom',Function.specialChar(this.stage.prenom))
            demande_stage.append('etablissement',Function.specialChar(this.stage.etablissement))
            demande_stage.append('telephone',this.stage.telephone)
            demande_stage.append('e_mail',this.stage.e_mail)
            demande_stage.append('cin',this.stage.cin)
            demande_stage.append('duree',this.stage.duree)
            demande_stage.append('curriculum_vitae', this.stage.curriculum_vitae )
            demande_stage.append('lettre_motivation', this.stage.lettre_motivation )
            demande_stage.append('lettre_introduction', this.stage.lettre_introduction)
            demande_stage.append('message',Function.specialChar(this.stage.message))
            demande_stage.append('id_domaine',this.stage.id_domaine)
            demande_stage.append('id_autorite_enfant',this.stage.id_autorite_enfant)
            demande_stage.append('autorite',this.stage.autorite)
            demande_stage.append('autoriteSigle',this.stage.sigle)
            demande_stage.append('autoriteEmail',this.stage.autoriteEmail)

            
            const response =  await DemandeStageAPI.addDemandeStage(demande_stage)
            this.sipnnerActivated = false
            // console.log(response)
            // response.then((result) => {
            //     swal("Demande de stage enregistrée", `Votre demande de stage a bien été ajoutée`, "success");
            //     this.sipnnerActivated = false
            // }).catch((err) => {
            //     console.log(err)
            //     swal("Demande de stage non envoyée", `Votre demande de stage n'a pas été envoyée`, "error");
            //     this.sipnnerActivated = false
            // });
            // console.log(response)
            swal("Demande de stage enregistrée", `Votre demande de stage a bien été ajoutée`, "success");
            this.sipnnerActivated = false
            this.viderChamp()
        }
    },
}

</script>

<style>
.disabled {
    opacity: 0.5;
    pointer-events: none;
}
.text-center button{
      margin-left: 5px
    }

</style>