<template>
    <HeaderNavbar
        @structure="getStructure"
        :sipnnerActivated="spinner"
    />

    <main id="main" class="main">
        <h1>Demande Audience</h1>
        
        <div  class='demo-app' >
            <div class='demo-app-main'>
                <Calendrier
                    typeCalendrier="audienceAutorite"
                    :autoriteSender="autorite"
                    @spinnerStatus="getSpinnerStatus"
                />

            </div>
        </div>

        <div class="popupToShow"></div>
    </main>

    <FooterBack 
        :styleFooterP="styleFooterP"
    />
</template>

<script>
    import '@fullcalendar/core/vdom'
    import FullCalendar from '@fullcalendar/vue3'
    import dayGridPlugin from '@fullcalendar/daygrid'
    import timeGridPlugin from '@fullcalendar/timegrid'
    import interactionPlugin from '@fullcalendar/interaction'
    import listPlugin from '@fullcalendar/list'
    import timeLine from '@fullcalendar/timeline'
    import frLocale from '@fullcalendar/core/locales/fr';
    import {useRoute} from "vue-router";

    import HeaderNavbar from '../../components/header/HeaderStructure.vue'
    import InputAutoriteEvent from '../../components/demande_audience/ChoisirAutorite.vue'
    import Calendrier from '../../components/demande_audience/Calendrier.vue';
    import FooterBack from '../../components/footer/FooterComponent.vue' 

    export default{
        components: {
            FullCalendar,
            HeaderNavbar,
            InputAutoriteEvent,
            Calendrier,
            FooterBack
        },

        data() {
            return {
                autorite: {},
                colorData:[],
                autorite_receiver: {}, 
                spinner: false              
            }
        },
        computed:{
            styleFooterP(){
                return {
                    marginLeft: '21em'
                }
            },
        },
        methods: {
            getStructure(value){
                this.autorite = value
            },
            getSpinnerStatus(value){
                this.spinner = value
            }
        },
    }
</script>

<style lang='css'>
    @import url('./css/style.css');
</style>