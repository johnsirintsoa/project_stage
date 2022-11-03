
<script setup>
import { RouterLink, RouterView } from 'vue-router'
// import HelloWorld from './components/HelloWorld.vue'
</script>

<template>
    <!-- ======= Sidebar ======= -->
    <aside id="sidebar" class="sidebar">

        <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-heading">Pages</li>

        <li class="nav-item">
            <RouterLink to="/autorite/" :class="{ disabled: active }">
            <a class="nav-link collapsed">
            <i class="bi bi-person"></i>
            <span>Home</span>
            </a>
            </RouterLink>
        </li><!-- End Profile Page Nav -->

        <li class="nav-item" >
            <RouterLink to="/autorite/boite-a-doleance" :class="{ disabled: active }">
            <a class="nav-link collapsed" >
            <i class="bi bi-question-circle"></i>
            <span>Doléance</span>
            </a>
            </RouterLink>
        </li><!-- End F.A.Q Page Nav -->

        <li class="nav-item">
            <RouterLink to="/autorite/demande-stage" :class="{ disabled: active }">
            <a class="nav-link collapsed" href="">
            <i class="bi bi-envelope"></i>
            <span>Stage</span>
            </a>
            </RouterLink>
        </li><!-- End Contact Page Nav -->

        <li class="nav-item">
            <RouterLink to="/autorite/demande-emploi" :class="{ disabled: active }" >
            <a class="nav-link collapsed" href="">
            <i class="bi bi-card-list"></i>
            <span>Emploi</span>
            </a>
            </RouterLink>
        </li><!-- End Register Page Nav -->

        <li class="nav-item">
            <RouterLink :to="{name:'middle-demande-audience', params:{id_autorite_enfant: this.id_autorite}}" :class="{ disabled: active }">
            <a class="nav-link collapsed" href="">
            <i class="bi bi-box-arrow-in-right"></i>
            <span>Audience</span>
            </a>
            </RouterLink>
        </li>
        <!-- End Login Page Nav -->


        </ul>

    </aside><!-- End Sidebar-->
    <RouterView/>
</template>

<script>
export default {
    data(){
        return {
            active : false,
            id_autorite: 0
        }
    },
    mounted(){
        const autorite = JSON.parse(sessionStorage.getItem('autorite'))
        if(autorite != null){
            this.id_autorite = autorite.autorite_enfant.id
        }
    },
    created(){
        const autorite = JSON.parse(sessionStorage.getItem('autorite'))
        // this.id_autorite = autorite.autorite_enfant.id
        // console.log(this.id_autorite)
        if(autorite != null) {
            this.$router.push({name:'middle-demande-audience', params:{id_autorite_enfant: autorite.autorite_enfant.id}});
        }else{
            this.$router.push('/autorite/');
            this.active = true
        }
        // this.$router.push({name:'middle-demande-audience', params:{id_autorite_enfant: 1}});
    },
}
</script>

