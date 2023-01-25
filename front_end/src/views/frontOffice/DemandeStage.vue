<script setup>
import FormStage from '../../components/demande_de_stage/FormStage.vue';
import NavBarFront from '../../components/header/NavBarFront.vue'
import FooterFront from '../../components/footer/FooterFront.vue'
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
        </div><!-- End #main -->
    </main>

    <FooterFront/>

</template> 

<style scoped>
@import url('./css/style.css');
    
</style>
