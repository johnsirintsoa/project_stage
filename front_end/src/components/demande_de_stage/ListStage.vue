<script setup>
import { RouterLink, RouterView } from 'vue-router'

</script>
<template>
    <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="">Demandes de stages</a></li>
          <li class="breadcrumb-item active">Liste</li>

        </ol>
    </nav>
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Demandes de stages</h5>

            <!-- Table with hoverable rows -->
            <table class="table table-hover">
            <thead>
                <tr>
                <th scope="col">#</th>
                <th scope="col">Nom et prénom</th>
                <th scope="col">Domaine</th>
                <th scope="col">Durée</th>
                <th scope="col">Status</th>
                <th scope="col">Action</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="(stage,index) in stages" >
                <th scope="row">{{stage['id']}}</th>
                <td>{{stage['fullName']}}</td>
                <td>{{stage['nom_domaine']}}</td>
                <td>{{stage['duree']}}</td>
                <td>
                    <span class="badge bg-success" v-if="stage['demande_status'] == 'valide'">{{stage['demande_status']}}</span>
                    <span class="badge bg-warning text-dark" v-else >{{stage['demande_status']}}</span>
                </td>
                <!-- <td>
                    <RouterLink :to="{name: 'backDetailDemandeStage',params:{id_demande_stage:stage['id']}}">
                    
                        <button type="button" class="btn btn-info">
                            <i class="bi bi-info-circle"></i>
                        </button>
                    </RouterLink>
                </td> -->
                <td>
                    <button type="button" @click="get_stage(index)" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#verticalycentered"> 
                        <i class="bx bx-mail-send"></i>
                    </button>
                    <div class="modal fade" id="verticalycentered" tabindex="-1" style="display: none;" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-body">
                            <div class="card">
                                <div class="card-body">
                                <h5 class="card-title">Valider Stage</h5>

                                <!-- Vertical Form -->
                                <form class="row g-3" ref="form" @submit.prevent="sendEmail">
                                    <div class="col-12">
                                    <label for="inputName4" class="form-label">Nom et prénom</label>
                                    <input type="text" class="form-control"  v-model="stage_email.nom" name="username" id="inputName4" disabled>
                                    </div>
                                    <div class="col-12">
                                    <label for="inputEmail4" class="form-label">Email</label>
                                    <input type="text" class="form-control" v-model="stage_email.email" name="usermail" id="inputEmail4" disabled>
                                    </div>
                                    <div class="col-12">

                                    <div class="col-12">
                                    <label for="inputName4" class="form-label">CV</label>
                                    <button type="hidden" @click="getFile(stage_email.curriculum_vitae)">
                                    <div class="icon">
                                        <i class="bx bxs-file-pdf" style="font-size: 2.0rem;color: #012970"></i>
                                        <div class="label">{{stage_email.curriculum_vitae}}</div>
                                    </div>
                                    </button>
                                    </div>

                                    <div class="col-12">
                                    <label for="inputName4" class="form-label">Lettre de motivation</label>
                                    <button type="hidden" @click="getFile(stage_email.lettre_motivation)">
                                    <div class="icon">
                                        <i class="bx bxs-file-pdf" style="font-size: 2.0rem;color: #012970"></i>
                                        <div class="label">{{stage_email.lettre_motivation}}</div>
                                    </div>
                                    </button>
                                    </div>

                                    <div class="col-12">
                                    <label for="inputName4" class="form-label">Lettre d'introduction</label>
                                    <button type="hidden" @click="getFile(stage_email.lettre_introduction)">
                                    <div class="icon">
                                        <i class="bx bxs-file-pdf" style="font-size: 2.0rem;color: #012970"></i>
                                        <div class="label">{{stage_email.lettre_introduction}}</div>
                                    </div>
                                    </button>
                                    </div>

                                    <label for="inputPassword4" class="form-label">Date de l'entretien</label>
                                    <input type="datetime-local" class="form-control" v-model="stage_email.date_entretien" name="date_entretien" id="inputPassword4">
                                    </div>
                                    <div class="text-center">
                                        <button type="submit" value="Send" class="btn btn-success">Send</button>
                                        <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    </div>
                                </form><!-- Vertical Form -->

                                </div>
                            </div>
                            </div>
                        </div>
                        </div>
                    </div>
                </td>
                </tr>
                <!-- <tr>
                <th scope="row">1</th>
                <td>Brandon Jacob</td>
                <td>Designer</td>
                <td>28</td>
                <td><span class="badge bg-warning text-dark">en attente</span></td>
                <td>
                    <RouterLink to="/administrateur/demande-stage/1">
                        <button type="button" class="btn btn-info">
                            <i class="bi bi-info-circle"></i>
                        </button>
                    </RouterLink>
                    <button type="button" class="btn btn-success">
                        <i class="bi bi-check-circle"></i>
                    </button>
                </td>
                </tr> -->

            </tbody>
            </table>
            <!-- End Table with hoverable rows -->

        </div>
        <RouterView />
    </div>
</template>

<script>
import emailjs from 'emailjs-com';
import DemandeStageAPI from '../../api/demande_stage';
export default {
    data() {
        return {
            stage_email:{
                nom:'',
                email:'',
                curriculum_vitae:'',
                lettre_motivation:'',
                lettre_introduction:'',
                date_entretien:''
            },
            stages: '',
        }
    },
    async created(){
        this.stages = await DemandeStageAPI.all_status()
    },
    methods:{
        get_stage(index){
            this.stage_email.nom = this.stages[index]['fullName']
            this.stage_email.email = this.stages[index]['e_mail']
            this.stage_email.curriculum_vitae = this.stages[index]['curriculum_vitae']
            this.stage_email.lettre_motivation = this.stages[index]['lettre_motivation']
            this.stage_email.lettre_introduction = this.stages[index]['lettre_introduction']
        },
        async sendEmail() {
            const send_stage = new FormData()
            send_stage.append('username',this.stage_email.nom+" "+this.stage_email.prenom)
            send_stage.append('usermail',this.stage_email.email)
            send_stage.append('date_entretien',this.stage_email.date_entretien)

            await DemandeStageAPI.sendMail(send_stage);
        },
        async getFile(file_name){
            await DemandeStageAPI.getFile(file_name)
            // console.log(file_name)
        }
    }
}
</script>