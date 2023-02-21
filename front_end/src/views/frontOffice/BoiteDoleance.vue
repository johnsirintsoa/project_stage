<script setup>
    import NavBarFront from '../../components/header/NavBarFront.vue'
    import FooterFront from '../../components/footer/FooterComponent.vue'
    import Formulaire from '../../components/boite_a_doleance/FormDoleance.vue'
    import DoleancePublic from '../../components/boite_a_doleance/MyDoleances.vue'
</script>

<script>
    export default {
        components:{
            Formulaire,
            DoleancePublic
        },
        data() {
            return {
                currentForm: 'Formulaire'
            }
        },
        methods: {
            doFormulaire(){
                this.currentForm = 'Formulaire'
            },

            doListe(){
                this.currentForm = 'DoleancePublic'
            }
        },
    }
</script>

<template>
    <NavBarFront/>
    <main id="main" class="main">
        <h1>Boite à doléance</h1>
        <div class="boite-a-doleance">
            
            <section class="section">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <ul class="nav nav-tabs nav-tabs-bordered d-flex" id="borderedTabJustified" role="tablist">
                                    <li class="nav-item flex-fill" role="presentation">
                                      <button class="nav-link w-100 active" id="home-tab" data-bs-toggle="tab" data-bs-target="#bordered-justified-home" type="button" role="tab" aria-controls="home" aria-selected="true" @click="doFormulaire">Formulaire</button>
                                    </li>
                                    <li class="nav-item flex-fill" role="presentation">
                                      <button class="nav-link w-100" id="profile-tab" data-bs-toggle="tab" data-bs-target="#bordered-justified-profile" type="button" role="tab" aria-controls="profile" aria-selected="false" tabindex="-1" @click="doListe">Vos doléances</button>
                                    </li>
                                </ul>
                                <div class="tab-content pt-2" id="myTabContent">
                                    <KeepAlive>
                                        <component :is="currentForm"></component>
                                    </KeepAlive>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <div class="popupToShow"></div>
        </div>
    </main>  
    <FooterFront/>
    
</template>

<style scoped>
    @import url('./css/style.css');

    input [type=radio]{
        padding-left: 2px ;
    }
</style>