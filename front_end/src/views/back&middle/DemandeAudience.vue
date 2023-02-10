<script setup>
    import HeaderNavbar from '../../components/header/HeaderStructure.vue'
    import InputAutoriteEvent from '../../components/demande_audience/ChoisirAutorite.vue'
    import Calendrier from '../../components/demande_audience/Calendrier.vue';
    // import Calendrier from '../../components/demande_audience/CalendrierDisponibleAutorite.vue'

</script>

<template>
    <HeaderNavbar
        @structure="getStructure"
    />


    <main id="main" class="main">
        <h1>Demande Audience</h1>
        
        <div  class='demo-app' >
            <div class='demo-app-main'>
                <Calendrier
                    typeCalendrier="audienceAutorite"
                    :autoriteSender="autorite"
                />

            </div>
        </div>

        <div class="popupToShow"></div>

    
    </main>
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

    export default{
        components: {
            FullCalendar
        },

        data() {
            return {
                autorite: {},
                autorite_receiver: {}               
            }
        },
        methods: {
            getStructure(value){
                this.autorite = value
            },
            
        },
    }
</script>

<style lang='css'>
    @import url('./css/style.css');
</style>