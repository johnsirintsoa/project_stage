<script setup>
    import HeaderNavbar from '../../components/header/HeaderMiddle.vue'
    // Liste
    import Liste from '../../components/evenements_calendrier/Liste.vue'
    // ChampsRecherche
</script>

<template>
    <HeaderNavbar/>

    <main id="main" class="main">
        <div class="demande-stage">
            <h1>Evènements calendrier</h1>
            <nav>
                <ol class="breadcrumb">
                  <li class="breadcrumb-item"><a href="">Evènements calendrier</a></li>
                  <li class="breadcrumb-item active">Liste</li>
                </ol>
            </nav>
            <Liste/>
        </div>
    </main>  
</template>