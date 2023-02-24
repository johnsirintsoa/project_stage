<script setup>
import FormStage from '../../components/demande_de_stage/FormStage.vue';
import NavBarFront from '../../components/header/NavBarFront.vue'
import FooterFront from '../../components/footer/FooterComponent.vue'
</script>

<template>
    <!-- header -->
    <NavBarFront/>

    <!-- body -->
    <main id="main" class="main">
        <div class="demande-stage">
            <h1>Demande de stage</h1>
            <div class="row">
                <div class="col-lg-12">
                    <FormStage/>
                </div>
            </div>
        </div>
    </main>

    <FooterFront/>

</template> 

<!-- <script>
import FormStage from '../../components/demande_de_stage/FormStage.vue';
import NavBarFront from '../../components/header/NavBarFront.vue'
import FooterFront from '../../components/footer/FooterComponent.vue'

export default {
    
    component:{
        FormStage,
        NavBarFront,
        FooterFront
    }
}
</script> -->

<style scoped>
@import url('./css/style.css');
    
</style>
