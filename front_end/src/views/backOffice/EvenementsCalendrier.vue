<script setup>
    import HeaderNavbar from '../../components/header/HeaderBack.vue'
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
                    <li class="breadcrumb-item"><a href="">Demande audience</a></li>
                    <li class="breadcrumb-item"><a href="">{{autorite.intitule_code}}</a></li>
                    <li class="breadcrumb-item active">Calendrier évènementiel</li>
                </ol>
            </nav>
            <Liste/>
        </div>
    </main>  
    
</template>