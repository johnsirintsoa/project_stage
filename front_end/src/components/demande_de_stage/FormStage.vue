<template>
    <div class="card">
        <div class="card-body">
        <h5 class="card-title">Formulaire :</h5>

        <!-- General Form Elements -->
        <form enctype="multipart/form-data">
            <div class="row mb-3">
            <label for="validationDefault01" class="col-sm-2 col-form-label">Nom:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" v-model="stage.nom" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="col-sm-2 col-form-label">Prénom:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" v-model="stage.prenom" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="col-sm-2 col-form-label">Téléphone:</label>
            <div class="col-sm-10">
                <input type="number" class="form-control" v-model="stage.telephone" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationCustomUsername" class="col-sm-2 col-form-label">Email</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" v-model="stage.e_mail" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="col-sm-2 col-form-label">CIN:</label>
            <div class="col-sm-10">
                <input type="number" class="form-control" v-model="stage.cin" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="col-sm-2 col-form-label">Durée de stage:</label>
            <div class="col-sm-10">
                <input type="number" class="form-control" v-model="stage.duree" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="col-sm-2 col-form-label">Votre message:</label>
            <div class="col-sm-10">
                <textarea class="form-control" style="height: 100px" v-model="stage.message" required=""></textarea>
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationCustom02" class="col-sm-2 col-form-label">Domaine:</label>
            <div class="col-sm-10">
                <select class="form-select" v-model="stage.id_domaine" aria-label="Default select example" required="">
                    <option selected disabled value="">Domaine</option>
                    <option v-for="(domaine,index)  in domaines"  :value="index+1" > {{domaine.nom_domaine}}</option>
                    <!-- <span>Selected: {{ stage.id_domaine }}</span> -->
                </select>
            </div>
            <div class="invalid-feedback">
                Entrez un domaine
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="col-sm-2 col-form-label">CV:</label>
            <div class="col-sm-10">
                <input type="file" @change="selectCV" ref="file" class="form-control" id="formFile" required="">
            </div>
            </div>
            
            <div class="row mb-3">
            <label for="validationDefault01" class="col-sm-2 col-form-label">Lettre de motivation:</label>
            <div class="col-sm-10">
                <input class="form-control" @change="selectLM" type="file" id="formFile" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="col-sm-2 col-form-label">Lettre d'introduction: </label>
            <div class="col-sm-10">
                <input class="form-control" @change="selectLI" type="file" id="formFile" required="">
            </div>
            </div>

            
            <div class="row mb-3">
            <label class="col-sm-2 col-form-label"></label>
            <div class="col-sm-10" v-if="this.stage.nom === '' || this.stage.prenom === '' || this.stage.prenom === '' || this.stage.telephone === '' || this.stage.e_mail === '' || this.stage.cin === '' || this.stage.duree === '' || this.stage.message === '' || this.stage.curriculum_vitae === '' || this.stage.lettre_motivation === '' || this.stage.lettre_introduction  === ''" >
                
                <button class="btn btn-primary" type="submit" @click="addDemandeStage" disabled>Valider</button>
            </div>
            <div class="col-sm-10" v-else >
                
                <button class="btn btn-primary" type="submit" @click="addDemandeStage" >Valider</button>
            </div>
            </div>

        </form><!-- End General Form Elements -->

        </div>
    </div>
</template>
<script>
import DemandeStageAPI from '../../api/demande_stage';
import DomaineAPI from '../../api/domaine';

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
                id_domaine:''
            },
            domaines:'',
            response:''
        }
    },
    async created() {
        this.domaines = await DomaineAPI.allDomaine();
        console.log(this.response)
        
        // console.log(this.domaines)
        // console.log(this.stage)
        // console.log(this.doleance)
    },
    methods: {
        async addDemandeStage(){
            const demande_stage = new FormData()
            demande_stage.append('nom',this.stage.nom)
            demande_stage.append('prenom',this.stage.prenom)
            demande_stage.append('e_mail',this.stage.e_mail)
            demande_stage.append('cin',this.stage.cin)
            demande_stage.append('telephone',this.stage.telephone)
            demande_stage.append('duree',this.stage.duree)
            demande_stage.append('curriculum_vitae',this.stage.curriculum_vitae)
            demande_stage.append('lettre_motivation',this.stage.lettre_motivation)
            demande_stage.append('lettre_introduction',this.stage.lettre_introduction)
            demande_stage.append('message',this.stage.message)
            demande_stage.append('id_domaine',this.stage.id_domaine)

            // const demande_stage = {
            //     nom: this.nom,
            //     prenom: this.prenom,
            //     e_mail: this.e_mail,
            //     cin: this.cin,
            //     telephone:this.telephone,
            //     duree: this.duree,
            //     curriculum_vitae: this.curriculum_vitae,
            //     lettre_motivation: this.lettre_motivation,
            //     lettre_introduction: this.lettre_introduction,
            //     message: this.message,
            //     domaine: this.domaine
            // }
            try {
                // console.log(demande_stage)
                const response = await DemandeStageAPI.addDemandeStage(demande_stage)
                this.response = response
                // this.nom = "",
                // prenom = "",
                // e_mail = "",
                // cin = "",
                // numero_telephone = "",
                // titre = "",
                // message = "",
                // direction = ""
            } catch (error) {
                console.log(error)
            }
        },
        selectCV(){
            this.stage.curriculum_vitae = this.$refs.file.files[0]
        },
        selectLM(){
            this.stage.lettre_motivation = this.$refs.file.files[0]
        },
        selectLI(){
            this.stage.lettre_introduction = this.$refs.file.files[0]
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