<!-- <script setup>
    import { RouterLink, RouterView } from 'vue-router'
</script> -->

<template>
    <header id="header" class="header fixed-top d-flex align-items-center header-scrolled">

        <div id="navbarSupportedContent">
            <ul>
                
                <div class="hori-selector">
                    <div class="left"></div>
                    <div class="right"></div>   
                </div>
                
                <li 
                    v-for="item in links" 
                    :key="item.id" 
                >
                    <RouterLink :to="{path: item.routerLink}">
                        <i :class="[item.icon]"></i>
                        {{item.linkName}}
                    </RouterLink>
                </li>
                <!-- <li class="doleance">
                    <RouterLink to="/boite-a-doleance">
                        <i class="bi bi-file-earmark-text"></i>
                        Boite à doléance
                    </RouterLink>
                </li>
                <li class="stage">
                    <RouterLink to="/demande-stage">
                        <i class="bi bi-envelope"></i>
                        Demande de stage
                    </RouterLink>
                </li>
    
                <li class="audience">
                    <RouterLink to="/demande-audience">
                        <i class="bi bi-people"></i>
                        Demande d'audience
                    </RouterLink>
                </li>
                <li class="login">
                    <RouterLink to="/login">
                        <i class="bi bi-box-arrow-in-right"></i>
                        Se connecter
                    </RouterLink>
                </li> -->
            </ul>
        </div>

    </header>
</template>

<script>
    import { RouterLink, RouterView } from 'vue-router'
export default {
    components:{
        RouterLink,
        RouterView
    },
    data() {
        return {
            links: [
                {
                    id: 1,
                    className: 'accueil',
                    linkName: 'Accueil',
                    icon: 'bi bi-house',
                    routerLink: '/'
                },
                {
                    id: 2,
                    className: 'doleance',
                    linkName: 'Boite à doléance',
                    icon: 'bi bi-file-earmark-text',
                    routerLink: '/boite-a-doleance'
                },
                {
                    id: 3,
                    className: 'stage',
                    linkName: 'Demande de stage',
                    icon: 'bi bi-envelope',
                    routerLink: '/demande-stage'
                },
                {
                    id: 4,
                    className: 'audience',
                    linkName: 'Demande d\'audience',
                    icon: 'bi bi-people',
                    routerLink: '/demande-audience'
                },
                {
                    id: 5,
                    className: 'login',
                    linkName: 'Se connecter',
                    icon: 'bi bi-box-arrow-in-right',
                    routerLink: '/login'
                },
            ],
            colorInit:'red'
        }
        
    },
}
</script>

<style scoped>
.header {
  box-shadow: none !important;
}

ul {
    margin: 0;
    padding: 0;
    display: flex;
    list-style: none;
    align-items: center;
    font-size: 17.5px;
    /* margin-left: 34rem */
}
ul li {
    position: relative;
    padding: 1rem 1rem 1rem 7.5rem;
    align-items: center;
}


</style>