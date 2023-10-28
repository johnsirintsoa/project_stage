<template>
    <NavBarFront/>
    <main id="main" class="main" >
        <h1>Boîte à doléance</h1>
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
                                        <button class="nav-link w-100" id="doleance-temp" data-bs-toggle="tab" data-bs-target="#bordered-justified-profile" type="button" role="tab" aria-controls="profile" aria-selected="false" tabindex="-1" 
                                            @click="doListe"
                                            @mouseover="showInfosTemp"
                                        >
                                        Doléances temporaires
                                        </button>
                                    </li>
                                </ul>
                                <div class="tab-content pt-2" id="myTabContent">
                                    <KeepAlive>
                                        <component :is="currentView"></component>
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

<script>
    import NavBarFront from '../../components/header/NavBarFront.vue'
    import FooterFront from '../../components/footer/FooterComponent.vue'
    import Formulaire from '../../components/boite_a_doleance/FormDoleance.vue'
    import DoleancePublic from '../../components/boite_a_doleance/MyDoleances.vue'

    import tippy from 'tippy.js';
    import 'tippy.js/dist/tippy.css'; // optional for styling
    // import 'tippy.js/themes/light.css';

    export default {
        components:{
            NavBarFront,
            FooterFront,
            Formulaire,
            DoleancePublic
        },
        data() {
            return {
                currentView: 'Formulaire'
            }
        },
        methods: {
            doFormulaire(){
                this.currentView = 'Formulaire'
            },

            doListe(){
                this.currentView = 'DoleancePublic'
            },
            showInfosTemp(){
                tippy('#doleance-temp', {
                    theme:'light',
                    content: `<p>Vous trouverez ici vos doléances il y a 2 minutes plus tôt.</p>`,
                    allowHTML: true,
                    delay:[200,0]
                });
            }
        },
    }
</script>

<style scoped>
    @import url('./css/style.css');
    /* #main{
        margin-left: 9em !important;
        margin-right: 9em;
    } */
    input [type=radio]{
        padding-left: 2px ;
    }
</style>