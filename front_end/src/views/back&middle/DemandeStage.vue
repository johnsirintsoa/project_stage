<script setup>
    import ListStage from '../../components/demande_de_stage/ListStage.vue';
    import HeaderBM from '../../components/header/HeaderStructure.vue'
    import BarresRecherche from '../../components/demande_de_stage/BarresRecherche.vue'
    import PopupEntretien from '../../components/demande_de_stage/FaireEntretien.vue'
    // import HeaderNavbar from '../../components/header/HeaderBack.vue'
</script>
    
<template>
    <HeaderBM
        @structure="getStructure"
    />

    <main id="main" class="main">
        <div class="demande-stage">
            <h1>Demandes de stages</h1>
            <div class="row">
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="">Demandes de stages</a></li>
                        <li class="breadcrumb-item active">Liste</li>
                    </ol>
                </nav>

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
                                        <!-- <PopupEntretien 
                                            :stage="stage" 
                                            :autorite="autorite" 
                                        /> -->
                                        <div v-if="stage['id'] !== undefined">
                                            <RouterLink :to="{name: 'back-office-detail-demande-stage',params:{id_demande_stage:stage['id']}}">
                                                <button type="button" class="btn btn-info">
                                                    <i class="bi bi-info-circle"></i>
                                                </button>
                                            </RouterLink> 
                                        </div>

                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <RouterView />
                </div>
            </div>
        </div>
    </main>
</template> 

<script>
    import StageController from '../../controllers/StageController'
    export default{
        data() {
            return {
                showPopup: false,
                date1:this.date_actu(),
                date2:this.date_actu(),
                nom:'',
                prenom:'',
                domaine: null,
                autorite:{},
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
        
        async mounted(){
            const filtre = {
                date1: this.date1,
                date2: this.date2,
                nom: this.nom,
                prenom: this.prenom,
                id_domaine: this.domaine,
                id_autorite: this.autorite.child_id
            }
            this.stages = await StageController.filtre(filtre)
        },
        methods: {
            getStructure(value){
                this.autorite = value
            },
            date_actu(){
                return new Date().toJSON().slice(0, 10)
            },
            getDataStages(data){
                this.stages = data
            },
            detailStage(value){
                this.showPopup = true
                console.log(value)
            },
            togglePopup(){
                this.showPopup = !this.showPopup
            }
        },
    }
</script>