<script setup>
    import { RouterLink, RouterView } from 'vue-router'
    // import HelloWorld from './components/HelloWorld.vue'
    import LoginComponent from '../components/profil/LoginComponent.vue';
</script>

<template>
    <main>
        <div class="container">

            <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

                            <div class="d-flex justify-content-center py-4">
                                <RouterLink to="/">
                                    <span class="d-none d-lg-block">MEF</span>
                                </RouterLink>
                            </div>

                            <LoginComponent/>

                        </div>
                    </div>
                </div>
            </section>

        </div>
    </main>
</template>

