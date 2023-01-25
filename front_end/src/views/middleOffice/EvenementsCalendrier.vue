<script setup>
    import HeaderNavbar from '../../components/header/HeaderMiddle.vue'
    // Liste
    import Liste from '../../components/evenements_calendrier/Liste.vue'
    // ChampsRecherche
</script>

<script>
    export default {
        async created() {
          const profil = JSON.parse(sessionStorage.getItem('autorite'));
          this.autorite = profil
        },
    }
</script>

<template>
    <HeaderNavbar/>

    <main id="main" class="main">
        <div class="demande-stage">
            <h1>Evènements calendrier</h1>
            <nav>
                <ol class="breadcrumb">
                  <li class="breadcrumb-item"><a href="">Evènements calendrier</a></li>
                  <li class="breadcrumb-item"><a href="">{{autorite.intitule_code}}</a></li>
                  <li class="breadcrumb-item">
                    <RouterLink to='/autorite/demande-audience/mes-evenements' >
                        <a href="">Calendrier évènementiel</a>
                    </RouterLink>
                </li>
                  <li class="breadcrumb-item active">Liste</li>
                </ol>
            </nav>
            <Liste/>
        </div>
    </main>  
</template>