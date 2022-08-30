<template>
    <div class="card">
        <div class="card-body">
        <h5 class="card-title">Formulaire :</h5>

        <form enctype="multipart/form-data">
            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">Nom:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="nom" name="nom" v-model="stage.nom" required="" >
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">Prénom:</label>
            <div class="col-sm-10">
                <input type="text" class="form-control" id="prenom" name="prenom" v-model="stage.prenom" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">Téléphone:</label>
            <div class="col-sm-10">
                <input type="number" class="form-control" id="telephone" name="telephone" v-model="stage.telephone" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationCustomUsername" class="form-label">Email</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" id="email" name="email" v-model="stage.e_mail" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">CIN:</label>
            <div class="col-sm-10">
                <input type="number" class="form-control" id="cin" name="cin" v-model="stage.cin" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">Durée de stage:</label>
            <div class="col-sm-10">
                <input type="number" class="form-control" id="duree" name="duree" v-model="stage.duree" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">Votre message:</label>
            <div class="col-sm-10">
                <textarea class="form-control" style="height: 100px" id="message" name="message" v-model="stage.message" required=""></textarea>
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationCustom02" class="form-label">Domaine:</label>
            <div class="col-sm-10">
                <select class="form-select" id="domaine" name="domaine" v-model="stage.id_domaine" aria-label="Default select example" required="">
                    <option selected disabled value="">Domaine</option>
                    <option v-for="(domaine,index)  in domaines"  :value="index+1" > {{domaine.nom_domaine}}</option>
                </select>
            </div>
            <div class="invalid-feedback">
                Entrez un domaine
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">CV:</label>
            <div class="col-sm-10">
                <input type="file" @change="selectCV" ref="file_cv" id="curriculum_vitae" name="curriculum_vitae" class="form-control"  required="">
            </div>
            </div>
            
            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">Lettre de motivation:</label>
            <div class="col-sm-10">
                <input type="file" @change="selectLM"  ref="file_lm" class="form-control"  id="lettre_motivation" name="lettre_motivation" required="">
            </div>
            </div>

            <div class="row mb-3">
            <label for="validationDefault01" class="form-label">Lettre d'introduction: </label>
            <div class="col-sm-10">
                <input type="file" @change="selectLI" ref="file_li" class="form-control" id="lettre_introduction" name="lettre_introduction" required="" >
            </div>
            </div>

            
            <div class="row mb-3">
            <label class="form-label"></label>
            
                <div>
                
                <button  class="btn btn-primary" @click="addDemandeStage">Valider</button>
            </div>
            </div>

        </form>
        <!-- End General Form Elements -->

        </div>
    </div>
</template>
<script>
const baseURL = "http://localhost:3000/api/stage";
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
            stageResult:null
        }
    },
    async created() {
        console.log(this.stage)
        console.log(this.stageResult)
        this.domaines = await DomaineAPI.allDomaine();
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
        // async addDemandeStage(){
        //     try {
        //         // console.log(demande_stage)
        //         const response = await DemandeStageAPI.addDemandeStage(this.stage)
        //     } catch (error) {
        //         console.log(error)
        //     }
        // }
        // addDemandeStage(){
        //     const formData = new FormData()
        //     formData.append('imagesArray', this.imagesArray, this.imagesArray.name)
        //     formData.append('nom',this.stage.nom)
        //     formData.append('prenom',this.stage.prenom)
        //     formData.append('telephone',this.stage.telephone)
        //     formData.append('e_mail',this.stage.e_mail)
        //     formData.append('cin',this.stage.cin)
        //     formData.append('duree',this.stage.duree)
        //     formData.append('curriculum_vitae',this.stage.curriculum_vitae)
        //     formData.append('lettre_motivation',this.stage.lettre_motivation)
        //     formData.append('lettre_introduction',this.stage.lettre_introduction)
        //     formData.append('message',this.stage.message)
        //     formData.append('id_domaine',this.stage.id_domaine)    
        //     this.formaData = formData
        //         formData.append('imagesArray', this.imagesArray, this.imagesArray.name)
        //         console.log('hello world')
        //     axios.post('http://localhost:3000/api/stage/add', formData, {
        //     }).then((response) => {
        //         console.log(response)
        //     })
        // }
        async addDemandeStage(){
            try {
                const res = await fetch(baseURL.concat('/add'), {
                method: "post",
                headers: {
                    "Content-Type": "application/json",
                    "x-access-token": "token-value",
                },
                body: JSON.stringify(this.stage),
                });
                if (!res.ok) {
                    const message = `An error has occured: ${res.status} - ${res.statusText}`;
                    throw new Error(message);
                }
                const data = await res.json();
                const result = {
                status: res.status + "-" + res.statusText,
                headers: {
                    "Content-Type": res.headers.get("Content-Type"),
                    "Content-Length": res.headers.get("Content-Length"),
                },
                data: data,
                };
                this.stageResult = this.fortmatResponse(result);
            } catch (err) {
                this.stageResult = err.message;
            }
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