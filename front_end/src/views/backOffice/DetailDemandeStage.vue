<template>
    <main id="main" class="main">
        <div class="demande-stage">
            <h1>Detail demande de stage</h1>
            <div class="row">
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><RouterLink to="/administrateur/demande-stage">Demandes de stages</RouterLink></li>
                            <li class="breadcrumb-item "><RouterLink to="/administrateur/demande-stage">Liste</RouterLink></li>
                        <li class="breadcrumb-item active">Détail</li>
                    </ol>
                </nav>
                <section class="section profile">
                    <div class="row">
                        <div class="col-xl-4">

                        <div class="card">
                            <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">

                            <!-- <img src="assets/img/profile-img.jpg" alt="Profile" class="rounded-circle"> -->
                            <h2>{{this.details_profil.nom}} {{this.details_profil.prenom}}</h2>
                            </div>
                        </div>

                        </div>

                        <div class="col-xl-8">

                        <div class="card">
                            <div class="card-body pt-3">
                            <div class="tab-content pt-2">

                                <div class="tab-pane fade profile-overview active show" id="profile-overview" role="tabpanel">
                                <h5 class="card-title">Message</h5>
                                <p class="small fst-italic">{{this.details_profil.message}}</p>

                                <h5 class="card-title">Détails profil</h5>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label ">Nom</div>
                                    <div class="col-lg-9 col-md-8">{{this.details_profil.nom}}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Prénom</div>
                                    <div class="col-lg-9 col-md-8">{{this.details_profil.prenom}}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Domaine</div>
                                    <div class="col-lg-9 col-md-8">{{this.details_profil.nom_domaine}}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">CIN</div>
                                    <div class="col-lg-9 col-md-8">{{this.details_profil.cin}}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Numéro téléphone</div>
                                    <div class="col-lg-9 col-md-8">{{this.details_profil.telephone}}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Email</div>
                                    <div class="col-lg-9 col-md-8">{{this.details_profil.e_mail}}</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Durée</div>
                                    <div class="col-lg-9 col-md-8">{{this.details_profil.duree}} mois</div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Curriculum vitae</div>
                                    <div class="col-lg-9 col-md-8">
                                        <div class="icon">
                                            <a @click.prevent="getFile(this.details_profil.curriculum_vitae)" >
                                            <i class="bx bxs-file-pdf" style="font-size: 2.0rem;color: #012970"></i>
                                            <div class="label-cv">
                                                {{this.details_profil.curriculum_vitae}}
                                            </div>
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Lettre de motivation</div>
                                    <div class="col-lg-9 col-md-8">
                                        <div class="icon">
                                            <a @click.prevent="getFile(this.details_profil.lettre_motivation)" >
                                            <i class="bx bxs-file-pdf" style="font-size: 2.0rem;color: #012970"></i>
                                            <div class="label-lm">
                                                {{this.details_profil.lettre_motivation}}
                                            </div>
                                            </a>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-lg-3 col-md-4 label">Lettre d'introduction</div>
                                    <div class="col-lg-9 col-md-8">
                                        <a @click.prevent="getFile(this.details_profil.lettre_introduction)" >
                                        <div class="icon">
                                            <i class="bx bxs-file-pdf" style="font-size: 2.0rem;color: #012970"></i>
                                            <div class="label-li">{{this.details_profil.lettre_introduction}}</div>
                                        </div>
                                        </a>
                                    </div>
                                </div>
                                <div class="row" v-if="this.details_profil.id_entretien_stage > 0 ">
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
                    </div>
                </section>
                <!-- <DetailStage/> -->
            </div>
        </div><!-- End #main -->
    </main>
</template>
<script>
import DemandeStage from '../../api/demande_stage'
import Swal from 'sweetalert2';
import swal from 'sweetalert';
    export default {
        data() {
            return {
                id_demande_stage:'',
                details_profil:''
            }
        },
        async created() {
            const ses = JSON.parse(sessionStorage.getItem('administrateur'))
            const id_autorite = ses.autorite_enfant.id
            const id_demande_stage = window.location.pathname.split('/')[ window.location.pathname.split('/').length-1]

            this.details_profil = await DemandeStage.detail(id_autorite,id_demande_stage)
            console.log(this.details_profil)
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
                        id_entretien_stage: this.details_profil.id_entretien_stage
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
                    }
                }
            }
        },
    }
</script>