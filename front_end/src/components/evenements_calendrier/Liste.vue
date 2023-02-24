<!-- <script setup>
    import ChampsRecherche from '../../components/evenements_calendrier/ChampsRecherche.vue'
    import PopupAction from '../../components/evenements_calendrier/PopupAction.vue'
</script> -->

<script>
    import AutoriteController from '../../controllers/AutoriteController'
    export default {
        components:{
            ChampsRecherche,
            PopupAction
        },
        data() {
            return {
                champs:{
                    date_debut:this.date_actu(),
                    date_fin:this.date_actu(),
                    type_evenement:'',
                    status:null,
                    autorite:'',
                },
                
                evenements:''
            }
        },
        async created() {
            if(sessionStorage.getItem('autorite') || sessionStorage.getItem('administrateur')){
                const ses = JSON.parse(sessionStorage.getItem('autorite'))
                this.champs.autorite = ses;
            }
            this.evenements = await AutoriteController.filtre_calendrier(this.champs)
            
        },
        methods: {
            date_actu(){
                return new Date().toJSON().slice(0, 10)
            },
            getData(data){
                this.evenements = data
            }
        },
    }
</script>

<template>

    <ChampsRecherche
        v-model:date_debut="champs.date_debut"
        v-model:date_fin="champs.date_fin"
        v-model:type_evenement="champs.type_evenement"
        v-model:status="champs.status"
        v-model:autorite="champs.autorite"
        @dataRechercher="getData($event)"
    />

    <div class="card">
        <div class="card-body">

            <!-- Table with hoverable rows -->
            <table class="table table-hover .datatable">
            <thead>
                <tr>
                <th scope="col"></th>
                <th scope="col">Type</th>
                <th scope="col">Date début</th>
                <th scope="col">Date fin</th>
                <th scope="col">Heure début</th>
                <th scope="col">Heure fin</th>
                <th scope="col">Status</th>
                <th scope="col">Action</th>
                </tr>
            </thead>
            <tbody>
                    <tr v-for="(event,index) in evenements" >
                    <th scope="row">{{event['id']}}</th>
                    <td>{{event['type_evenement']}}</td>
                    <td>{{event['date_debut']}}</td>
                    <td>{{event['date_fin']}}</td>
                    <td>{{event['heure_debut']}}</td>
                    <td>{{event['heure_fin']}}</td>
                    <td>
                        <span class="badge badge bg-danger" v-if="event['status'] == 'Validé'">{{event['status']}}</span>
                        <span class="badge bg-success" v-if="event['status'] == 'Non validé'">{{event['status']}}</span>
                        <span class="badge bg-dark" v-if="event['status'] == 'Reporté'" >{{event['status']}}</span>
                    </td>
                    <td>
                        <PopupAction
                            :evenement="event"
                            :autorite="champs.autorite"
                        />
                    </td>


                    <!-- <td>
                        <PopupEntretien 
                            :stage="stage" 
                            :autorite="autorite" 
                        />
                        <RouterLink :to="{name: 'back-detail-demande-stage',params:{id_demande_stage:stage['id']}}">
                            <button type="button" class="btn btn-info">
                                <i class="bi bi-info-circle"></i>
                            </button>
                        </RouterLink> 
                        <button type="button" v-if="stage['demande_status'] === 'Validé'" @click="getDemandeStage(stage)" class="btn btn-warning"> 
                            <i class="ri-edit-2-line"></i>
                        </button>
                        <button type="button" v-else-if="stage['demande_status'] === 'Non validé'" @click="getDemandeStage(stage)" class="btn btn-success"> 
                            <i class="bi bi-check-circle"></i>
                        </button>
                    </td> -->
                    </tr>
            </tbody>
            </table>

        </div>
    </div>
    
</template>