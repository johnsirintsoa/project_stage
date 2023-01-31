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

            <li>
                <RouterLink to="/demande-audience">Demande d'audience</RouterLink>
            </li>
            <li>
                <RouterLink to="/login">Se connecter</RouterLink>
            </li>
        </ul>

    </header>
</template>

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

</style>