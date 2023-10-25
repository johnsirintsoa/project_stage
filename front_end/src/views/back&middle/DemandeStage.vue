<template>
    <HeaderBM
        @structure="getStructure"
        :sipnnerActivated="spinnerActivated"
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
                    v-model:etablissement="etablissement"
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
                                <th scope="col">Etablissement</th>
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
                                    <td>{{stage['etablissement']}}</td>
                                    <td>{{stage['duree']}}</td>
                                    <td>
                                        <span class="badge bg-success" v-if="stage['demande_status'] == 'Validé'">{{stage['demande_status']}}</span>
                                        <span class="badge bg-dark" v-else-if="stage['demande_status'] == 'Reporté'" >{{stage['demande_status']}}</span>
                                        <span class="badge bg-danger" v-else-if="stage['demande_status'] == 'Non validé'" >{{stage['demande_status']}}</span>
                                    </td>
                                    <td>
                                        <!-- <PopupEntretien 
                                            :stage="stage" 
                                            :autorite="autorite" 
                                        /> -->
                                        <button type="button" v-if="stage['demande_status'] === 'Validé'" @click="modifierEntretien(stage)" class="btn btn-warning"> 
                                            <i class="ri-edit-2-line"></i>
                                        </button>
                                    
                                        <button type="button" v-else-if="stage['demande_status'] === 'Non validé'" @click="ajouterEntretien(stage)" class="btn btn-success"> 
                                            <i class="bi bi-check-circle"></i>
                                        </button>
                                    
                                        <button type="button" v-if="stage['demande_status'] === 'Reporté'" @click="modifierEntretien(stage)" class="btn btn-warning"> 
                                            <i class="ri-edit-2-line"></i>
                                        </button>

                                        <RouterLink :to="{name: 'back-office-detail-demande-stage',params:{id_demande_stage:stage['id']}}" v-if="stage['id'] !== undefined">
                                            <button type="button" class="btn btn-info">
                                                <i class="bi bi-info-circle"></i>
                                            </button>
                                        </RouterLink> 

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
    
    <FooterBack 
        :styleFooterP="styleFooterP"
    />

</template> 

<script>
    import StageController from '../../controllers/StageController'
    import AutoriteController from '../../controllers/AutoriteController'
    import EntretienController from '../../controllers/EntretienController'
    import Swal from 'sweetalert2';
    import swal from 'sweetalert';

    // components
    import ListStage from '../../components/demande_de_stage/ListStage.vue';
    import HeaderBM from '../../components/header/HeaderStructure.vue'
    import BarresRecherche from '../../components/demande_de_stage/BarresRecherche.vue'
    import FooterBack from '../../components/footer/FooterComponent.vue' 

    export default {
        components:{
            ListStage,
            HeaderBM,
            BarresRecherche,
            FooterBack
        },
        data() {
            return {
                spinnerActivated: false,
                showPopup: false,
                date1:this.date_actu(),
                date2:this.date_actu(),
                nom:'',
                etablissement:'',
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
        computed:{
            styleFooterP(){
                return {
                    marginLeft: '21em'
                }
            }
        },
        async unmounted(){
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
            async places(stage){
                const data = await AutoriteController.place_disponible({
                    id_date_heure_disponible_autorite: stage.id_date_heure_disponible_autorite,
                    id_autorite: this.autorite.child_id
                })
                return data
            },
            async placesMap(stage){
                const resultMap = new Map()
                const data = await this.places(stage)

                data.forEach(element => {
                    const key = element.id_date_heure_disponible_autorite
                    const value = `${element.date_disponible} à ${element.heure_debut} - ${element.heure_fin}`
                    resultMap.set(key,value)
                });
                return resultMap
            },

            async ajouterEntretien(stage){
                const { value: place } = await Swal.fire({
                    title: 'Faire une entretien',
                    input: 'select',
                    inputOptions: await this.placesMap(stage),             
                    inputPlaceholder: 'Choisissez une place disponible',
                    confirmButtonText: 'Ajouter',
                    cancelButtonText: 'Annuler',
                    showCancelButton: true,
                    inputValidator: (value) => {
                        console.log(value)
                    },
                })

                if (place) {
                    // Swal.fire(`You selected: ${place}`)
                    this.spinnerActivated = true
                    const response = await EntretienController.ajouter({
                        stage: stage,
                        autorite: this.autorite,
                        id_date_heure_disponible_autorite: place
                    }).then(async(result) => {
                        // console.log(result)
                        if(result.data.message){
                            const filtre = {
                                date1: this.date1,
                                date2: this.date2,
                                nom: this.nom,
                                prenom: this.prenom,
                                id_domaine: this.domaine,
                                id_autorite: this.autorite.child_id
                            }
                            this.stages = await StageController.filtre(filtre)
                            this.spinnerActivated = false
                            swal("Entretien enregistrée", `${result.data.message}`, "success");
                        }
                    }).catch((err) => {
                        console.log(err)
                    });
                }
            },  

            async modifierEntretien(arg){
            // console.log(arg)
            const data = await this.placesMap(arg)
            const place = await Swal.fire({
                title: `Modifier l'entretien`,
                input: 'select',
                inputOptions: data,             
                // inputPlaceholder: 'Choisissez une place disponible',
                inputValue: data.get(arg.id_date_heure_disponible_autorite),
                confirmButtonText: 'Modifier',
                denyButtonText:'Supprimer',
                cancelButtonText: 'Annuler',
                showDenyButton: true,
                showCancelButton: true,
                // inputValidator: (value) => {
                //     console.log(value)
                // },
            }).then(async (result) => {
                const place = result.value
                if(result.isConfirmed){
                    this.spinnerActivated = true
                    const response = await EntretienController.modifier({
                        stage: arg,
                        autorite: this.autorite,
                        id_date_heure_disponible_autorite: place
                    }).then(async(result) => {
                        if(result.data.message){
                            const filtre = {
                                date1: this.date1,
                                date2: this.date2,
                                nom: this.nom,
                                prenom: this.prenom,
                                id_domaine: this.domaine,
                                id_autorite: this.autorite.child_id
                            }
                            this.spinnerActivated = false
                            this.stages = await StageController.filtre(filtre)
                            swal("Entretien modifié", `${result.data.message}`, "success");
                        }
                    }).catch((err) => {
                        console.log(err)
                    });
                }else if(result.isDenied){
                    Swal.fire({
                        title: 'Reporter un entretien',
                        text: "Cette entretien sera considérée comme stage non validé",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        cancelButtonText: 'Annuler',
                        confirmButtonText: 'Supprimer!'
                    }).then(async (result) => {

                        if (result.isConfirmed) {
                            this.spinnerActivated = true
                            const response = await EntretienController.supprimer({
                                stage: arg,
                                autorite: this.autorite,
                            }).then(async(result) => {
                                if(result.data.message){
                                    const filtre = {
                                        date1: this.date1,
                                        date2: this.date2,
                                        nom: this.nom,
                                        prenom: this.prenom,
                                        id_domaine: this.domaine,
                                        id_autorite: this.autorite.child_id
                                    }
                                    this.spinnerActivated = false
                                    this.stages = await StageController.filtre(filtre)
                                    swal("Entretien Supprimé", `${result.data.message}`, "success");
                                }
                            }).catch((err) => {
                                console.log(err)
                            });
                        }
                    }).catch((err) => {
                        console.log(err)
                    })
                }
            }).catch((err) => {
                console.log(err)
            });
        },

            getStructure(value){
                // console.log(value)
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