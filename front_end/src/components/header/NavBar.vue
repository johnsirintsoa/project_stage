<script setup>
    import { RouterLink, RouterView } from 'vue-router'
    // import HelloWorld from './components/HelloWorld.vue'
</script>
<template>
    <header>
    <div class="navbar">
        <ul>
            <li>
                <RouterLink to="/">Home</RouterLink>
            </li>
            <li>
                <RouterLink to="/boite-a-doleance">Boite</RouterLink>
            </li>
            <li>
                <RouterLink to="/demande-stage">Stage</RouterLink>
            </li>
            <li>
                <RouterLink to="/demande-emploi">Emploi</RouterLink>
            </li>
            <li>
                <RouterLink to="/demande-audience">Audience</RouterLink>
            </li>
        </ul>
    
    </div>
    </header>
</template>
<style>
    :root {
        --sidebar-bg-color: #dacd3c;
        --sidebar-item-hover: #ded571;
        --sidebar-item-active: #baae31;
    }
</style>
<style scoped>
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
.navbar ul {
    margin: 0;
    padding: 0;
    display: flex;
    list-style: none;
    align-items: center;
}
.navbar li {
    position: relative;
    padding: 1rem;
    align-items: center;
}
</style>