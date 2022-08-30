<script setup>
// import DetailStage from '../../components/demande_de_stage/DetailStage.vue';
import EmailDemandeStage from '../../components/demande_de_stage/EmailDemandeStage.vue';
</script>
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
              <h2>{{detail_stage[0]['nom']}} {{detail_stage[0]['prenom']}}</h2>
            </div>
          </div>

        </div>

        <div class="col-xl-8">

          <div class="card">
            <div class="card-body pt-3">
              <div class="tab-content pt-2">

                <div class="tab-pane fade profile-overview active show" id="profile-overview" role="tabpanel">
                  <h5 class="card-title">Message</h5>
                  <p class="small fst-italic">{{detail_stage[0]['message']}}</p>

                  <h5 class="card-title">Détails profil</h5>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label ">Nom</div>
                    <div class="col-lg-9 col-md-8">{{detail_stage[0]['nom']}}</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">Prénom</div>
                    <div class="col-lg-9 col-md-8">{{detail_stage[0]['prenom']}}</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">Domaine</div>
                    <div class="col-lg-9 col-md-8">{{detail_stage[0]['nom_domaine']}}</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">CIN</div>
                    <div class="col-lg-9 col-md-8">{{detail_stage[0]['cin']}}</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">Numéro téléphone</div>
                    <div class="col-lg-9 col-md-8">{{detail_stage[0]['telephone']}}</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">Email</div>
                    <div class="col-lg-9 col-md-8">{{detail_stage[0]['e_mail']}}</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">Durée</div>
                    <div class="col-lg-9 col-md-8">{{detail_stage[0]['duree']}} mois</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">Curriculum vitae</div>
                    <div class="col-lg-9 col-md-8">
                        <div class="icon">
                            <i class="bx bxs-file-pdf" style="font-size: 2.0rem;color: #012970"></i>
                            <div class="label">{{detail_stage[0]['curriculum_vitae']}}</div>
                        </div>
                    </div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">Lettre de motivation</div>
                    <div class="col-lg-9 col-md-8">
                        <div class="icon">
                            <button type="hidden" @click="downloadFile()"><i class="bx bxs-file-pdf" style="font-size: 2.0rem;color: #012970"></i></button>
                            <div class="label">{{detail_stage[0]['lettre_motivation']}}</div>
                        </div>
                    </div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">Lettre d'introduction</div>
                    <div class="col-lg-9 col-md-8">
                        <div class="icon">
                            <i class="bx bxs-file-pdf" style="font-size: 2.0rem;color: #012970"></i>
                            <div class="label">{{detail_stage[0]['lettre_introduction']}}</div>
                        </div>
                    </div>
                  </div>

                  <EmailDemandeStage/>

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
import axios from 'axios';
import DemandeStageAPI from '../../api/demande_stage';
import { url } from 'inspector';
export default {
  data() {
    return {
      detail_stage: ''
    }
  },
  async created(){
    this.detail_stage = await DemandeStageAPI.detail(this.$route.params.id_demande_stage)
  },
  methods:{
    downloadFile() {
        // console.log('Hello world')
        // console.log(axios)
        axios({
          url: './back_end/uploads/lettre_motivation_1661518676270_Etats_Analyses.pdf', // download file link goes here
          method: 'GET',
          headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
          responseType: 'blob',
        }).then((res) => {
          var FILE = window.URL.createObjectURL(new Blob([res.data]));
        
          var docUrl = document.createElement('x');
          docUrl.href = FILE;
          docUrl.setAttribute('download', 'lettre_motivation_1661518676270_Etats_Analyses.pdf');
          document.body.appendChild(docUrl);
          docUrl.click();
        });
      },
    }
}
</script>
