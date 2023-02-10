<script setup>
import ListStage from '../../components/demande_de_stage/ListStage.vue';
// import HeaderNavbar from '../../components/header/HeaderBack.vue'
</script>

<template>
    <HeaderNavbar/>
    <main id="main" class="main">
        <div class="demande-stage">
            <h1>Demandes de stages</h1>
            <div class="row">
                <ListStage/>
            </div>
        </div><!-- End #main -->
    </main>
</template> 