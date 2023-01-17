<script setup>
    // MesAudiences V2
    import HeaderNavbar from '../../components/header/HeaderBack.vue'
    import DetailContent from '../../components/demande_de_stage/DetailContent.vue'
</script>

<script>
import DemandeStage from '../../api/demande_stage'
import DemandeStageController from '../../controllers/StageController'
import Swal from 'sweetalert2';
import swal from 'sweetalert';
    export default {
        data() {
            return {
                // id_demande_stage:'',
            }
        },
        async created() {
            const ses = JSON.parse(sessionStorage.getItem('administrateur'))
            const id_autorite = ses.id_autorite_enfant
            this.id_demande_stage = window.location.pathname.split('/')[ window.location.pathname.split('/').length-1]
            this.autorite = ses
        },

    }
</script>

<template>
    <HeaderNavbar/>
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
                        <DetailContent 
                            :id_demande_stage="id_demande_stage"
                        />
                    </div>
                </section>
                <!-- <DetailStage/> -->
            </div>
        </div><!-- End #main -->
    </main>
</template>