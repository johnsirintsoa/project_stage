<script>
    import DemandeStage from '../../api/demande_stage'
    import DemandeStageController from '../../controllers/StageController'
    import Swal from 'sweetalert2';
    import swal from 'sweetalert';
    export default{
        props:{
            id_demande_stage:String,
            stage:Object
        },

        data() {
            return {
                detail:''
            }
        },

        async created() {
            this.detail = await DemandeStageController.detail({
                id_demande_stage: this.id_demande_stage
            })
        },

        methods: {

            async getFile(file_name){
                await DemandeStage.getFile(file_name)
            },

            async updateDuree(){
                const { value: DUREE } = await Swal.fire({
                    title:'Prolonger durée de stage:',
                    input: 'number',
                    inputLabel: `Durée (mois):`,
                    // inputPlaceholder: 'Enter the URL',
                    inputValue: 0
                })
                if (DUREE) {
                    const arg = {
                        duree_en_plus: DUREE,
                        id_entretien_stage: this.detail.id_entretien_stage
                    }
                    const response = await DemandeStage.prolonger(arg)
                    if(response.message){
                        Swal.fire({
                            title: 'Error',
                            text: response.message,
                            icon: 'error',
                            confirmButtonText: 'Ok'
                        })
                    }
                    else{
                        Swal.fire('Prolongement avec succès',`Durée de stage prolongé de ${DUREE} mois`,'success')
                        this.detail = await DemandeStageController.detail({
                            id_demande_stage: this.id_demande_stage
                        })
                    }
                }
            }
        },
    }

</script>

<template>

    <!-- <div class="col-xl-4">

        <div class="card">
          <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">

            <img src="assets/img/profile-img.jpg" alt="Profile" class="rounded-circle">
            <h2>Kevin Anderson</h2>
            <h3>Web Designer</h3>
            <div class="social-links mt-2">
              <a href="#" class="twitter"><i class="bi bi-twitter"></i></a>
              <a href="#" class="facebook"><i class="bi bi-facebook"></i></a>
              <a href="#" class="instagram"><i class="bi bi-instagram"></i></a>
              <a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
            </div>
          </div>
        </div>

    </div> -->

    <div class="col-xl-4">

        <div class="card">
            
            
            <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">
            <img src="../../assets/img/profile-img.jpg" alt="Profile" class="rounded-circle">
            <h2>{{this.detail.nom}} {{this.detail.prenom}}</h2>
            </div>
        </div>

    </div>

    <div class="col-xl-8">
        <div class="card">
            <div class="card-body pt-3">
            <div class="tab-content pt-2">

                <div class="tab-pane fade profile-overview active show" id="profile-overview" role="tabpanel">
                <h5 class="card-title">Message</h5>
                <p class="small fst-italic">{{this.detail.message}}</p>

                <h5 class="card-title">Détails profil</h5>

                <div class="row">
                    <div class="col-lg-3 col-md-4 label ">Nom</div>
                    <div class="col-lg-9 col-md-8">{{this.detail.nom}}</div>
                </div>

                <div class="row">
                    <div class="col-lg-3 col-md-4 label">Prénom</div>
                    <div class="col-lg-9 col-md-8">{{this.detail.prenom}}</div>
                </div>

                <div class="row" v-if="detail.etablissement">
                    <div class="col-lg-3 col-md-4 label">Etablissement</div>
                    <div class="col-lg-9 col-md-8">{{this.detail.etablissement}}</div>
                </div>

                <div class="row">
                    <div class="col-lg-3 col-md-4 label">Domaine</div>
                    <div class="col-lg-9 col-md-8">{{this.detail.nom_domaine}}</div>
                </div>

                <div class="row" v-if="detail.cin">
                    <div class="col-lg-3 col-md-4 label">CIN</div>
                    <div class="col-lg-9 col-md-8">{{this.detail.cin}}</div>
                </div>

                <div class="row">
                    <div class="col-lg-3 col-md-4 label">Numéro téléphone</div>
                    <div class="col-lg-9 col-md-8">{{this.detail.telephone}}</div>
                </div>

                <div class="row">
                    <div class="col-lg-3 col-md-4 label">Email</div>
                    <div class="col-lg-9 col-md-8">{{this.detail.e_mail}}</div>
                </div>

                <div class="row">
                    <div class="col-lg-3 col-md-4 label">Durée</div>
                    <div class="col-lg-9 col-md-8">{{this.detail.duree}} mois</div>
                </div>

                <div class="row">
                    <div class="col-lg-3 col-md-4 label">Curriculum vitae</div>
                    <div class="col-lg-9 col-md-8">
                        <div class="icon">
                            <a @click.prevent="getFile(this.detail.curriculum_vitae)" >
                            <i class="bx bxs-file-pdf" style="font-size: 2.0rem;color: #012970"></i>
                            <div class="label-cv">
                                {{this.detail.curriculum_vitae}}
                            </div>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-3 col-md-4 label">Lettre de motivation</div>
                    <div class="col-lg-9 col-md-8">
                        <div class="icon">
                            <a @click.prevent="getFile(this.detail.lettre_motivation)" >
                            <i class="bx bxs-file-pdf" style="font-size: 2.0rem;color: #012970"></i>
                            <div class="label-lm">
                                {{this.detail.lettre_motivation}}
                            </div>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-lg-3 col-md-4 label">Lettre d'introduction</div>
                    <div class="col-lg-9 col-md-8">
                        <a @click.prevent="getFile(this.detail.lettre_introduction)" >
                        <div class="icon">
                            <i class="bx bxs-file-pdf" style="font-size: 2.0rem;color: #012970"></i>
                            <div class="label-li">{{this.detail.lettre_introduction}}</div>
                        </div>
                        </a>
                    </div>
                </div>
                <div class="row" v-if="this.detail.id_entretien_stage > 0 ">
                    <!-- <div class="col-lg-3 col-md-4 label">Lettre d'introduction</div> -->
                    <div class="col-lg-9 col-md-8">
                        <div class="icon">
                            <div class="label-li">
                                <button  type="button" class="btn btn-primary" @click="updateDuree()">Prolonger</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- <EmailDemandeStage/> -->

                </div>
                
                

            </div>
            
            <!-- End Bordered Tabs -->

            </div>
        </div>
    </div>
    
</template>
<style>
    .icon{
        cursor: pointer;
    }
</style>