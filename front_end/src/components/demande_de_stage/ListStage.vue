<script setup>
import { RouterLink, RouterView } from 'vue-router'
import Swal from 'sweetalert2';
import swal from 'sweetalert';
import EntretienDemandeStage from '../../api/entretien_stage'
import func from '../../func/function'

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
                <th scope="row">{{stage['id_demande_stage']}}</th>
                <td>{{stage['nom']}}</td>
                <td>{{stage['prenom']}}</td>
                <td>{{stage['nom_domaine']}}</td>
                <td>{{stage['duree']}}</td>
                <td>
                    <span class="badge bg-success" v-if="stage['demande_status'] == 'validé'">{{stage['demande_status']}}</span>
                    <span class="badge bg-warning text-dark" v-else >{{stage['demande_status']}}</span>
                </td>
                <td>
                    <RouterLink :to="{name: 'back-detail-demande-stage',params:{id_demande_stage:stage['id_demande_stage']}}">
                    
                        <button type="button" class="btn btn-info">
                            <i class="bi bi-info-circle"></i>
                        </button>
                    </RouterLink>
                    <button type="button" v-if="stage['demande_status'] == 'validé'" @click="getDemandeStage(stage)" class="btn btn-warning"> 
                        <i class="ri-edit-2-line"></i>
                    </button>
                    <button type="button" v-else-if="stage['demande_status'] == 'en attente'" @click="getDemandeStage(stage)" class="btn btn-success"> 
                        <i class="bi bi-check-circle"></i>
                    </button>
                </td>
                </tr>
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
import EntretienStage from '../../api/entretien_stage';
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
        const ses = JSON.parse(sessionStorage.getItem('administrateur'))
        const id_autorite = ses.autorite_enfant.id
        // console.log(id_autorite)
        this.stages = await DemandeStageAPI.all_status(id_autorite)
        console.log(func.format_date_time(new Date())[1].substring(0,5))
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
        },

        async getDemandeStage(stage){
            console.log(stage)
            if(stage.date_debut){
              const data = await Swal.fire({
                title: `Faire un entretien`,
                html:
                  `<p align="left" style="margin-left: 1rem;">De <input type=Date value="${stage.date_debut}" id="date1" class="swal2-input"> <input type=time value="${stage.time_debut}" id="duree1" class="swal2-input"> </p>
                    <p align="left" style="margin-left: 1.8rem;">à <input type=Date value="${stage.date_fin}"  id="date2" class="swal2-input"> <input type=time value="${stage.time_fin}" id="duree2" class="swal2-input"></p>` ,
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: 'Maintenant',
                denyButtonText:'Plus tard',
                footer: `<a href="#">Voir mes audiences</a>`,
                preConfirm: () => {
                  return [
                    document.getElementById('date1').value,
                    document.getElementById('date2').value,
                    document.getElementById('duree1').value,
                    document.getElementById('duree2').value
                  ]
                }
              }).then(async (result) => {
                if(result.isConfirmed){
                  const ses = JSON.parse(sessionStorage.getItem('administrateur'))
                  const id_autorite = ses.autorite_enfant.id
                  const audience_event = {
                    autorite: stage.autorite,
                    nom: stage.nom,
                    prenom: stage.prenom,
                    telephone: stage.telephone,
                    e_mail: stage.e_mail,
                    cin: stage.cin,
                    date_debut: result.value[0],
                    date_fin: result.value[1], 
                    time_debut: result.value[2],
                    time_fin: result.value[3],
                    id_autorite_enfant_receiver: id_autorite ,
                    id: stage.id_entretien_demande_stage
                  }                  
                  const response = await EntretienDemandeStage.update_entretien_stage(audience_event)
                  if(response.code == 'ER_BAD_FIELD_ERROR'){
                    swal("Entretien non enregistrée", "Veuillez remplir le formulaire", "error");
                  }
                  else if(response.message == 'pas disponible'){
                    swal("Entretien non enregistrée", "Cette place est occupé ou pas disponible.", "error");
                  }
                  else if(response.message == 'Jour férié et pas disponible'){
                    swal("Entretien non enregistrée", "On est férié et le directeur n'est pas disponible", "error");
                  }
                  else if(response.message == 'Jour férié'){
                    swal("Entretien non enregistrée", "On est férié", "error");
                  }
                  else if(response.message == "date fin invalid"){
                    swal("Entretien non enregistrée", "La date de fin d'événement doit être égal à la date de début", "warning");
                  }
                  else if(response.message == "formulaire vide"){
                    swal("Entretien non enregistrée", "Veuillez remplir le formulaire", "warning");
                  }
                  else if(response.affectedRows == 1){
                    swal("Entretien enregistrée", "Votre audience a bien été enregistrée", "success");
                    setInterval( () => {
                      window.location.reload()
                    }, 1000)
                    // this.$router.push({path: '/administrateur/demande-audience/autorite/faire-audience/', params: { id_autorite_enfant: this.audience.direction }});
                  }
                  else if(response.message == "time fin invalid"){
                    swal("Entretien non enregistrée", "L'heure fin doit être supérieur à l'heure début", "warning");
                  }
                  else if(response.message == "Validation non validé et envoyé"){
                    swal("Entretien non enregistrée", `${response.message}`, "warning");
                  }
                }
                else if(result.isDenied){
                  Swal.fire({
                    title: 'Reporter un entretien',
                    text: "Cette entretien sera considérée comme stage en attente",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    cancelButtonText: 'Annuler',
                    confirmButtonText: 'Supprimer!'
                  }).then(async (result) => {
                    const audience_event = {
                      autorite: stage.autorite,
                      nom: stage.nom,
                      prenom: stage.prenom,
                      telephone: stage.telephone,
                      e_mail: stage.e_mail,
                      cin: stage.cin,
                      id_entretien: stage.id_entretien_demande_stage
                    } 
                    if (result.isConfirmed) {
                      const response = await EntretienDemandeStage.delete_entretien_stage(audience_event)
                      Swal.fire(
                        'Entretien supprimé',
                        `Entretien avec ${stage.nom} ${stage.prenom} a été reporté`,
                        'success'
                      )
                      setInterval( () => {
                        window.location.reload()
                      }, 1000)
                    }
                  })       
                }               
              }).catch((err) => {
                console.log(err)
              })
            }
            else{
              const { value: formValues } = await Swal.fire({
                  title: `Faire un entretien`,
                  width: 550,
                  html:
                    `<p align="left" style="margin-left: 1rem;">De <input type=Date value="${new Date().toISOString().substring(0,10)}" id="date1" class="swal2-input"> <input type=time id="duree1" value="${func.format_date_time(new Date())[1].substring(0,5)}" class="swal2-input"> </p>` +
                    `<p align="left" style="margin-left: 1.8rem;">à <input type=Date value="${new Date().toISOString().substring(0,10)}" id="date2" class="swal2-input"> <input type=time  id="duree2" value="${func.time_plus_30_min(new Date()).substring(0,5)}" class="swal2-input"></p>` ,

                      // `<p align="left" style="margin-left: 1rem;">De <input type=Date value="${new Date().toISOString().substring(0,10)}" id="date1" class="swal2-input"> <input type=time id="duree1" value="${func.format_date_time(new Date())[1].substring(0,5)}" class="swal2-input"> </p>` +
                      // `<p align="left" style="margin-left: 1.8rem;">à <input type=Date value="${new Date().toISOString().substring(0,10)}" id="date2" class="swal2-input"> <input type=time  id="duree2" value="${func.time_plus_30_min(new Date()).substring(0,5)}" class="swal2-input"></p>` ,
                  showCancelButton: true,
                  confirmButtonText: 'Valider',    
                  focusConfirm: false,
                  footer: `<a href="#">Voir mes audiences</a>`,
                  preConfirm: () => {
                    return [
                      document.getElementById('date1').value,
                      document.getElementById('duree1').value,
                      document.getElementById('date2').value,
                      document.getElementById('duree2').value
                    ]
                  }
              })

              if (formValues) {

                const ses = JSON.parse(sessionStorage.getItem('administrateur'))
                const id_autorite_enfant = ses.autorite_enfant.id
                // this.audience.direction = ses.autorite_enfant.id

                const infos_stage = {
                  autorite: stage.autorite,
                  nom: stage.nom,
                  prenom: stage.prenom,
                  telephone: stage.telephone,
                  e_mail: stage.e_mail,
                  cin: stage.cin,
                  date_debut: formValues[0],
                  time_debut: formValues[1],
                  date_fin: formValues[2],
                  time_fin: formValues[3],
                  id_autorite_enfant: id_autorite_enfant,
                  id_demande_stage: stage.id_demande_stage
                }

                console.log(infos_stage)

                const response = await EntretienStage.add_entretien_stage(infos_stage)
                console.log(response)
                if(response.code == 'ER_BAD_FIELD_ERROR'){
                  swal("Entretien non enregistrée", "Veuillez remplir le formulaire", "error");
                }
                else if(response.message == 'pas disponible'){
                  swal("Entretien non enregistrée", "Cette place est occupé ou pas disponible.", "error");
                }
                else if(response.message == 'Jour férié et pas disponible'){
                  swal("Entretien non enregistrée", "On est férié et le directeur n'est pas disponible", "error");
                }
                else if(response.message == 'Jour férié'){
                  swal("Entretien non enregistrée", "On est férié", "error");
                }
                else if(response.message == "date fin invalid"){
                  swal("Entretien non enregistrée", "La date de fin d'événement doit être égal à la date de début", "warning");
                }
                else if(response.message == "formulaire vide"){
                  swal("Entretien non enregistrée", "Veuillez remplir le formulaire", "warning");
                }
                else if(response.affectedRows == 1){
                  swal("Entretien enregistrée", `L'entretien avec ${stage.nom} ${stage.prenom} a bien été enregistrée`, "success");
                  setInterval( () => {
                    window.location.reload()
                  }, 1000)
                  // this.$router.push({path: '/administrateur/demande-audience/autorite/faire-audience/', params: { id_autorite_enfant: this.audience.direction }});
                }
                else if(response.message == "time fin invalid"){
                  swal("Entretien non enregistrée", "L'heure fin doit être supérieur à l'heure début", "warning");
                }
                // Swal.fire(JSON.stringify(formValues))
              }
            }

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