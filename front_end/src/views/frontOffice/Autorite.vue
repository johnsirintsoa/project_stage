<script setup>
    import { RouterLink, RouterView } from 'vue-router'
    import NavBarFront from '../../components/header/NavBarFront.vue'
    // import HelloWorld from './components/HelloWorld.vue'
</script>
<template>

    <!-- header -->
    <NavBarFront/>
    <!-- body -->
    <main>
        <div class="autorite-enfant">
            <ul>
                <li v-for="autorite in autorites">
                    <!-- <RouterLink to="/demande-audience/autorite">{{autorite.intitule}}</RouterLink> -->
                    <RouterLink :to="{ name: 'front-demande-audience-autorite-enfant', params: { id_autorite_enfant: autorite.id }}">{{autorite.intitule}}</RouterLink>
                </li>
            </ul>
        </div>
    </main>
</template>
<script>
    import AutoriteAPI from '../../api/autorite';
    export default {
        data(){
            return{
                autorites: this.autorites_enfants(),
            }
        },
        async created() {
            this.autorites = await this.autorites_enfants()
        },
        methods:{
            async autorites_enfants(){
                return await AutoriteAPI.autorite_enfant()
            }
        }
    }
</script>