<template>
    <div class="card">
        <div class="card-body">
        <h5 class="card-title">Formulaire :</h5>

        <form @submit.prevent="addDemandeStage" ref="formStage" enctype="multipart/form-data" >
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
                <input type="number" class="form-control" id="telephone" name="telephone" v-model="stage.telephone" required="">
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
                <input type="number" class="form-control" id="cin" name="cin" v-model="stage.cin" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">Durée de stage:</label>
            <div class="col-sm-12">
                <input type="number" class="form-control" id="duree" name="duree" v-model="stage.duree" required="">
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
            <div class="col-sm-12">
                <select class="form-select" id="autorite" name="autorite" v-model="stage.id_autorite_enfant" aria-label="Default select example" required="">
                    <option selected disabled value="">Direction</option>
                    <option v-for="(autorite,index)  in autorites"  :value="autorite.id" > {{autorite.intitule}}</option>
                </select>
            </div>
            <div class="invalid-feedback">
                Choisissez une direction
            </div>
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

            
            <div class="row mb-3">
            <label class="form-label"></label>
            
                <div>
                
                <button  type="submit" class="btn btn-primary" >Valider</button>
            </div>
            </div>

        </form>
        <!-- End General Form Elements -->

        </div>
    </div>
</template>
<script>
// import DemandeStageAPI from '../../api/demande_stage';
import axios from 'axios';
import DemandeStageAPI from '../../api/demande_stage';
import DomaineAPI from '../../api/domaine';
import AutoriteApi from '../../api/autorite';
import swal from 'sweetalert';

export default {
    data(){
        return{
            stage:{
                nom:'',
                prenom:'',
                telephone:'',
                e_mail:'',
                cin:'',
                duree:'',
                curriculum_vitae:'',
                lettre_motivation:'',
                lettre_introduction:'',
                message:'',
                id_autorite_enfant:'',
                id_domaine:''
            },
            domaines:'',
            autorites:'',
        }
    },
    async created() {
        // console.log(this.stage)
        this.domaines = await DomaineAPI.allDomaine();
        this.autorites = await AutoriteApi.autorite_enfant()
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
        async addDemandeStage(){
            const demande_stage = new FormData()
            demande_stage.append('nom',this.stage.nom)
            demande_stage.append('prenom',this.stage.prenom)
            demande_stage.append('telephone',this.stage.telephone)
            demande_stage.append('e_mail',this.stage.e_mail)
            demande_stage.append('cin',this.stage.cin)
            demande_stage.append('duree',this.stage.duree)
            demande_stage.append('curriculum_vitae', this.stage.curriculum_vitae )
            demande_stage.append('lettre_motivation', this.stage.lettre_motivation )
            demande_stage.append('lettre_introduction', this.stage.lettre_introduction)
            demande_stage.append('message',this.stage.message)
            demande_stage.append('id_domaine',this.stage.id_domaine)
            demande_stage.append('id_autorite_enfant',this.stage.id_autorite_enfant)


            // console.log('FORMULAIRE EXECUTE...')
            // console.log(demande_stage)
            // console.log(demande_stage.get('nom'))
            // console.log(demande_stage.get('prenom'))
            // console.log(demande_stage.get('telephone'))
            // console.log(demande_stage.get('e_mail'))
            // console.log(demande_stage.get('cin'))
            // console.log(demande_stage.get('duree'))
            // console.log(demande_stage.get('curriculum_vitae'))
            // console.log(demande_stage.get('lettre_motivation'))
            // console.log(demande_stage.get('lettre_introduction'))
            
            const response =  await DemandeStageAPI.addDemandeStage(demande_stage)
            swal("Demande de stage enregistrée", `Votre demande de stage a bien été ajoutée`, "success");
        }
    },
}
</script>
<style>
.disabled {
    opacity: 0.5;
    pointer-events: none;
}

</style>