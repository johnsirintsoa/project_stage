<script setup>
    import { RouterLink, RouterView } from 'vue-router'
</script>
<script >
    export default {
        props:{
            autorite: Object
        },
    }
</script>

<template>
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="">Demande audience</a></li>
                <li class="breadcrumb-item"><a href="">{{autorite.intitule_code}}</a></li>
                <li class="breadcrumb-item active">Calendrier évènementiel</li>
                <li class="breadcrumb" style="position: absolute; right: 30px;">
                    <RouterLink to='/autorite/evenements-calendrier' >
                        <a href="">Liste évènements</a>
                    </RouterLink></li>
            </ol>
            
        </nav> 
    </div>
    <RouterView />
   
</template>
