<!-- <script setup>
    import HeaderBM from '../../components/header/HeaderStructure.vue'
    import Filtre from '../../components/boite_a_doleance/FiltreDoleance.vue'
    import FooterBack from '../../components/footer/FooterComponent.vue' 
</script> -->

<template>
    <HeaderBM
        @structure="getStructure"
    />

    <main id="main" class="main">
        <div class="boite-a-doleance">
            <section class="section">
                <h1>Boite à doléances</h1>
                <div class="row">
                    <nav>
                        <ol class="breadcrumb">
                          <li class="breadcrumb-item"><a href="">Boite à doléances</a></li>
                          <li class="breadcrumb-item active">Liste</li>
                        </ol>
                    </nav>
                    <Filtre
                        v-model:date1="filter.date1"
                        v-model:date2="filter.date2"
                        v-model:type_doleance="filter.type_doleance"
                        v-model:nbr_filtre="filter.nbr_filtre"
                        v-model:autorite="autorite"
                        @rechercherDoleance="getData($event)"
                    />
                    <div class="col-lg-12">
                        <div class="card" v-for="doleance in doleances" :key="doleance._id">
                            <div class="card-body">
                                <div class="d-flex w-100 justify-content-between">
                                    <h5 class="card-title">{{ doleance['titre'] }}</h5>
                                    <small class="text-muted">{{ doleance['date_heure_publication']}}</small>
                                </div>
                                
                                <div v-if="doleance['type_doleance'] === 'Non anonyme'">
                                    <h6 class="card-subtitle mb-2 text-muted">{{ doleance['nom'] }} {{doleance['prenom']}}</h6>
                                </div>

                                <div v-else-if="doleance['type_doleance'] === 'Anonyme'">
                                    <h6 class="card-subtitle mb-2 text-muted">{{ doleance['type_doleance'] }}</h6>
                                </div>
                                {{ doleance['message']}}
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <FooterBack 
        numberMarginLeft="15"
    />
</template>

<script>
import DoleanceAPI from '../../api/doleance';
// Components
import HeaderBM from '../../components/header/HeaderStructure.vue'
import Filtre from '../../components/boite_a_doleance/FiltreDoleance.vue'
import FooterBack from '../../components/footer/FooterComponent.vue' 

export default {
    components:{
        HeaderBM,
        Filtre,
        FooterBack 
    },
    data(){
        return {
            doleances:[],
            directions:[],
            autorite:{},
            filter:{
                date1:this.date_actu(),
                date2:this.date_actu(),
                type_doleance: '2',
                nbr_filtre: '0'
            }
        };
    },
    async mounted() {
        const filtre = {
            date1: this.filter.date1,
            date2: this.filter.date2,
            type_doleance: this.filter.type_doleance,
            nbr_filtre: this.filter.nbr_filtre,
            id_autorite: this.autorite.child_id
        }
        console.log(filtre)
        this.doleances = await DoleanceAPI.filtre(filtre)
        // this.doleances = await DoleanceAPI.getAllDoleance();
        // this.directions = await DirectionAPI.getAllDirection();
        // console.log(new Date().toISOString().substring(0,10))
    },
    methods:{
        date_actu(){
          return new Date().toJSON().slice(0, 10)
        },
        async filtrer(){
            this.doleances = await DoleanceAPI.filter_doleance(this.filter.date_1,this.filter.date_2,this.filter.direction);
            // console.log(this.filter.date_1)
            // console.log(this.filter.date_2)
        },
        getData(value){
            console.log(value)
            this.doleances = value
        },

        getStructure(value){
            // console.log(value)
            this.autorite = value
        }
    }
}
</script>