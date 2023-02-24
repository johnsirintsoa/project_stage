<!-- <script setup>
    // MesAudiences V2
    import HeaderBM from '../../components/header/HeaderStructure.vue'
    import DetailContent from '../../components/demande_de_stage/DetailContent.vue'
    import FooterBack from '../../components/footer/FooterComponent.vue' 
</script> -->

<script>
import DemandeStage from '../../api/demande_stage'
import DemandeStageController from '../../controllers/StageController'
import Swal from 'sweetalert2';
import swal from 'sweetalert';

// components
import HeaderBM from '../../components/header/HeaderStructure.vue'
import DetailContent from '../../components/demande_de_stage/DetailContent.vue'
import FooterBack from '../../components/footer/FooterComponent.vue' 
    export default {
        components:{
            HeaderBM,
            DetailContent,
            FooterBack
        },
        data() {
            return {
                // id_demande_stage:'',
            }
        },
        async created() {
            const ses = JSON.parse(sessionStorage.getItem('structure'))
            const id_autorite = ses.child_id
            this.id_demande_stage = window.location.pathname.split('/')[ window.location.pathname.split('/').length-1]
            this.autorite = ses
        },

        methods: {
            getStructure(value){
                this.autorite = value
            }
        },

    }
</script>

<template>
    <HeaderBM
        @structure="getStructure"
    />

    <main id="main" class="main">
        <div class="demande-stage">
            <h1>Detail demande de stage</h1>
            <div class="row">
                <nav>
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><RouterLink to="/back-office/demande-stage">Demandes de stages</RouterLink></li>
                            <li class="breadcrumb-item "><RouterLink to="/back-office/demande-stage">Liste</RouterLink></li>
                        <li class="breadcrumb-item active">Détail</li>
                    </ol>
                </nav>
                <section class="section profile">
                    <div class="row">
                        <DetailContent 
                            :id_demande_stage="id_demande_stage"
                        />
                    </div>
                </section>
            </div>
        </div>
    </main>
    <FooterBack 
        numberMarginLeft="15"
    />
</template>