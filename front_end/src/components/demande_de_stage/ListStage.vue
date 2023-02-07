<template>


    <BarresRecherche
        v-model:date1="date1"
        v-model:date2="date2"
        v-model:nom="nom"
        v-model:prenom="prenom"
        v-model:domaine="domaine" 
        v-model:autorite="autorite" 
        @rechercherStages="getDataStages($event)"
    />



    <div class="card">
        <div class="card-body">

            <!-- Table with hoverable rows -->
            <table class="table table-hover">
            <thead>
                <tr>
                <th scope="col"></th>
                <th scope="col">Nom</th>
                <th scope="col">Prénom</th>
                <th scope="col">Domaine</th>
                <th scope="col">Durée(mois)</th>
                <th scope="col">Status</th>
                <th scope="col">Action</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(stage,index) in stages" >
                <th scope="row">{{stage['id']}}</th>
                <td>{{stage['nom']}}</td>
                <td>{{stage['prenom']}}</td>
                <td>{{stage['nom_domaine']}}</td>
                <td>{{stage['duree']}}</td>
                <td>
                    <span class="badge bg-danger" v-if="stage['demande_status'] == 'Validé'">{{stage['demande_status']}}</span>
                    <span class="badge bg-success" v-else >{{stage['demande_status']}}</span>
                </td>
                <td>
                    <PopupEntretien 
                        :stage="stage" 
                        :autorite="autorite" 
                    />
                    <RouterLink :to="{name: 'back-detail-demande-stage',params:{id_demande_stage:stage['id']}}">
                        <button type="button" class="btn btn-info">
                            <i class="bi bi-info-circle"></i>
                        </button>
                    </RouterLink> 
                    <!-- <button type="button" v-if="stage['demande_status'] === 'Validé'" @click="getDemandeStage(stage)" class="btn btn-warning"> 
                        <i class="ri-edit-2-line"></i>
                    </button>
                    <button type="button" v-else-if="stage['demande_status'] === 'Non validé'" @click="getDemandeStage(stage)" class="btn btn-success"> 
                        <i class="bi bi-check-circle"></i>
                    </button> -->
                </td>
                </tr>
            </tbody>
            </table>

        </div>
        <RouterView />
    </div>
</template>

<script>

import Swal from 'sweetalert2';
import swal from 'sweetalert';
import EntretienDemandeStage from '../../api/entretien_stage'
import func from '../../func/function'
import PopupEntretien from './FaireEntretien.vue'
import BarresRecherche from './BarresRecherche.vue'
import emailjs from 'emailjs-com';
import DemandeStageAPI from '../../api/demande_stage';
import StageController from '../../controllers/StageController'
import EntretienStage from '../../api/entretien_stage';

export default {

    data() {
        return {
            date1:this.date_actu(),
            date2:this.date_actu(),
            nom:'',
            prenom:'',
            domaine: null,
            stage_email:{
                nom:'',
                email:'',
                curriculum_vitae:'',
                lettre_motivation:'',
                lettre_introduction:'',
                date_entretien:''
            },
            stages: ''
        }
    },

    async created(){

        const ses = JSON.parse(sessionStorage.getItem('administrateur'))
        this.autorite = ses
        const filtre = {
          date1: this.date1,
          date2: this.date2,
          nom: this.nom,
          prenom: this.prenom,
          id_domaine: this.domaine,
          id_autorite_enfant: ses.id_autorite_enfant
        }
        
        this.stages = await StageController.filtre(filtre)
        // console.log(this.stages[0])
    },



    methods:{
        get_stage(index){
            this.stage_email.nom = this.stages[index]['fullName']
            this.stage_email.email = this.stages[index]['e_mail']
            this.stage_email.curriculum_vitae = this.stages[index]['curriculum_vitae']
            this.stage_email.lettre_motivation = this.stages[index]['lettre_motivation']
            this.stage_email.lettre_introduction = this.stages[index]['lettre_introduction']
        },
        // async sendEmail() {
        //     const send_stage = new FormData()
        //     send_stage.append('username',this.stage_email.nom+" "+this.stage_email.prenom)
        //     send_stage.append('usermail',this.stage_email.email)
        //     send_stage.append('date_entretien',this.stage_email.date_entretien)

        //     await DemandeStageAPI.sendMail(send_stage);
        // },
        async getFile(file_name){
            await DemandeStageAPI.getFile(file_name)
            // console.log(file_name)
        },

        date_actu(){
          return new Date().toJSON().slice(0, 10)
        },

        getDataStages(data){
            this.stages = data
        },
        
        async rechercher(){
            const ses = JSON.parse(sessionStorage.getItem('administrateur'))
            const filtre = {
                date1: this.date1,
                date2: this.date2,
                nom: this.nom,
                prenom: this.prenom,
                id_domaine: this.domaine,
                id_autorite_enfant: this.autorite.id_autorite_enfant
            }
            this.stages = await StageController.filtre(filtre)            
        }
   
    }
}
</script>

<style>
/*
  Sweet Alert 2 
*/
    .swal2-input, .swal2-file, .swal2-textarea, .swal2-select, .swal2-radio, .swal2-checkbox {
        margin: 1em 0em 0px 1rem;
    /* padding: 0px 0px 0px 0px; */
    }

    .swal2-textarea{
        padding-right: 8.5rem;
        display: flex;
        margin-left: 60px;
        margin-top: -2.5rem;
    }
/*
  Sweet Alert 2
*/
</style>