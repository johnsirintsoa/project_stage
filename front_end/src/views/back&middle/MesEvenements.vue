<!-- <script setup>
    import HeaderStructure from '../../components/header/HeaderStructure.vue'
    import Calendrier from '../../components/demande_audience/Calendrier.vue';
    import FooterBack from '../../components/footer/FooterComponent.vue' 
</script> -->

<template>
    <HeaderStructure
        @structure="getStructure"
        :sipnnerActivated="spinner"
    />
    <main id="main" class="main">
        <h1>Mes évènements</h1>
        
        <div  class='demo-app' >
            <div class='demo-app-main'>
                <Calendrier
                    :autoriteSender="autorite"
                    typeCalendrier="evenementiel"
                    @spinnerStatus="getSpinnerStatus"
                />

            </div>
        </div>
    </main>
    <FooterBack 
        :styleFooterP="styleFooterP"
    />
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
            }
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