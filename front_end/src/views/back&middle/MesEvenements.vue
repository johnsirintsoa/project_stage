<!-- <script setup>
    import HeaderStructure from '../../components/header/HeaderStructure.vue'
    import Calendrier from '../../components/demande_audience/Calendrier.vue';
    import FooterBack from '../../components/footer/FooterComponent.vue' 
</script> -->

<template>
    <HeaderStructure
        @structure="getStructure"
        :sipnnerActivated="spinner"
        @setCheckbox="getCheckBox"
    />
    <main id="main" class="main">
        <h1>Mon calendrier</h1>
        <section class="section">
            <div class="row">
                <Calendrier
                    :autoriteSender="autorite"
                    typeCalendrier="evenementiel"
                    @spinnerStatus="getSpinnerStatus"
                    :masqueEvenementFini="checkboxStatus"
                />
                <!-- <div  class='demo-app' >
                    <div class='demo-app-main'>

        
                    </div>
                </div> -->
            </div>
        </section>

    </main>
    <!-- <FooterBack 
        :styleFooterP="styleFooterP"
    /> -->
</template>

<script>
    import HeaderStructure from '../../components/header/HeaderStructure.vue'
    import Calendrier from '../../components/demande_audience/Calendrier.vue';
    import FooterBack from '../../components/footer/FooterComponent.vue' 
    export default{
        components:{
            HeaderStructure,
            Calendrier,
            FooterBack
        },

        data() {
            return {
                autorite:{},
                checkboxStatus: true,
                spinner: false
            }
        },
        methods: {
            getStructure(value){
                this.autorite = value
            },
            getSpinnerStatus(value){
                this.spinner = value
                // console.log(value)
            },
            getCheckBox(value){
                this.checkboxStatus = value
                // console.log(value)
            },
            // getMonCalendrierData(value){
            //     console.log(value)
            // }
        },
        computed:{
            styleFooterP(){
                return {
                    marginLeft: '21em'
                }
            }
        },
    }
</script>