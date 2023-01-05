<script setup>
import FormStage from '../../components/demande_de_stage/FormStage.vue';
import NavBarFront from '../../components/header/NavBarFront.vue'
</script>
<template>
    <!-- header -->
    <NavBarFront/>

    <!-- body -->
    <main id="main" class="main">
        <div class="demande-stage">
            <h1>Demande de stage</h1>
            <div class="row">
                <div class="col-lg-8">
                    <FormStage/>
                </div>
                <div class="col-lg-4">
                    
                </div>
            </div>
        </div><!-- End #main -->
    </main>
</template> 
