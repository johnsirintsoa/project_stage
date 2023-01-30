<script setup>
    import { RouterLink, RouterView } from 'vue-router'
    // import HelloWorld from './components/HelloWorld.vue'
</script>

<template>
    <header id="header" class="header fixed-top d-flex align-items-center header-scrolled">

        <ul>
            <li>
                <RouterLink to="/">Accueil</RouterLink>
            </li>
            <li>
                <RouterLink to="/boite-a-doleance">Boite à doléance</RouterLink>
            </li>
            <li>
                <RouterLink to="/demande-stage">Demande de stage</RouterLink>
            </li>
            <li @click="toggleShow" class="anchor"> 
                Demande d'audience
                <div v-if="showMenu" class='menu'>
                    
                    <div class='menu-item' v-for="a in autorites" @click='chooseAutorite(a)'>
                        <RouterLink 
                            to="/demande-audience"
                        >
                            {{a.intitule}}
                        </RouterLink>
                    </div>
                    
                </div>
                <!-- <RouterLink to="/demande-audience/autorite">Demande d'audience</RouterLink> -->
            </li>
            <li>
                <RouterLink to="/login">Se connecter</RouterLink>
            </li>
        </ul>

    </header>
</template>

<script>
    import AutoriteApi from '../../api/autorite'
    export default{
        data() {
            return {
                showMenu:false,
                autorites:'',
                // autorite:''
            }
        },
        emit:['autoriteFromDropDown'],
        methods: {
            toggleShow() {
                this.showMenu = !this.showMenu;
            },
            chooseAutorite(item) {
                this.$emit('autoriteFromDropDown',item)
            }
        },
        async created() {
            this.autorites = await AutoriteApi.liste()
            // console.log(this.autorites)
        },
    }
</script>

<style scoped>

:root {
    --sidebar-bg-color: #dacd3c;
    --sidebar-item-hover: #ded571;
    --sidebar-item-active: #baae31;
}

.navbar{
    /* color: white; */
    justify-content: center;
    margin: auto;
    position: relative;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: space-between;
}
ul {
    margin: 0;
    margin-left: 4rem;
    padding: 0;
    display: flex;
    list-style: none;
    align-items: center;
    font-size: 20px;
    /* margin-left: 30rem */
}
ul li {
    position: relative;
    padding: 4rem;
    align-items: center;
}

.anchor {
    display: flex;
    align-items: center;
    justify-content: center;
    border: 1px solid transparent;
    /* padding: .75rem 2rem; */
    font-size: 1.25rem;
    border-radius: .25rem;
    transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
    color: #4154f1;
        /* background-color: #27AE60;
        border-color: #27AE60; */
    }
    
    .anchor::after {
        display: inline-block;
        width: 0;
        height: 0;
        margin-left: .5em;
        vertical-align: .255em;
        content: "";
        border-top: .3em solid;
        border-right: .28em solid transparent;
        border-bottom: 0;
        border-left: .28em solid transparent;
    }
    
    .anchor:hover {
        color: #6373f6;
        /* background-color: #229954; */
        /* border-color: #229954; */
        cursor: pointer;
    }
    
    .menu {
        background-color: #fff;
        background-clip: padding-box;
        border: 1px solid rgba(0,0,0,.15);
        border-radius: .25rem;
        color: #212529;
        cursor: pointer;
        display: flex;
        flex-direction: column;
        font-size: 1rem;
        list-style: none;
        margin: 8.125rem 0 0;
        /* padding: .5rem 0; */
        position: absolute;
        text-align: left;
    }
    
    .menu-item {
        color: #212529;
        width: auto;
        padding: .25rem 1.5rem;
        transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
    }
    
    .menu-item:hover {
        background-color: #F4F6F6;
        cursor: pointer;
    }
</style>