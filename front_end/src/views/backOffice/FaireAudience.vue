<script setup>
    // import HeaderNavbar from '../../components/header/HeaderBack.vue'
    import {useRoute} from "vue-router";
    import NavAudiences from '../../components/NavBar/NavAudiences.vue'
</script>

<script>
    import '@fullcalendar/core/vdom'
    import FullCalendar from '@fullcalendar/vue3'
    import dayGridPlugin from '@fullcalendar/daygrid'
    import timeGridPlugin from '@fullcalendar/timegrid'
    import interactionPlugin from '@fullcalendar/interaction'
    import listPlugin from '@fullcalendar/list'
    import timeLine from '@fullcalendar/timeline'
    import { faire_audience } from '../../func/event-utils'
    import DemandeAudience from '../../api/demande_audience'
    import DemandeAudienceAutorite from '../../api/demande_audience_autorite'
    import DemandeAudienceAutoriteController from '../../controllers/BackOffice/DemandeAudienceAutoriteController'
    import tippy from 'tippy.js';
    import 'tippy.js/dist/tippy.css'; // optional for styling
    import 'tippy.js/themes/light.css';
    import Function from '../../func/function';
    import swal from 'sweetalert';
    import Swal from 'sweetalert2';
    import AutoriteAPI from '../../api/autorite';
    import frLocale from '@fullcalendar/core/locales/fr';

    

    export default {
        components: {
        FullCalendar
        },

        data() {
            return {
                calendarOptions: {
                    locale: frLocale,
                    plugins: [
                        dayGridPlugin,
                        timeGridPlugin,
                        listPlugin,
                        timeLine, 
                        interactionPlugin // needed for dateClick
                    ],
                    headerToolbar: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'dayGridMonth,timeGridWeek,timeGridDay,listDay'
                    },
                    initialView: 'timeGridDay', 
                    contentHeight: 450,
                    initialEvents: this.actual_events,
                    selectable: false,
                    droppable: false,
                    selectMirror: true,
                    dayMaxEvents: true,
                    weekends: false,
                    eventClick: this.handleEventClick,
                    eventDidMount: this.detailEvent,
                    slotMinTime: '08:00:00',
                    slotMaxTime: '16:00:00'
                },
                autorite_sender:'',
                audience :{
                    date_debut:'',
                    date_fin: '',
                    heure_debut:'',
                    heure_fin:'',
                    motif:'',
                    id:''
                }                
            }
            
        },
        async created(){
            const ses = JSON.parse(sessionStorage.getItem('administrateur'))
            const route = useRoute()
            this.autorite = {
                intitule_code: route.params.intitule_code,
                id_autorite: route.params.id_autorite_enfant
            }
            this.id_autorite_sender = ses.id_autorite_enfant
            this.id_autorite_receiver = window.location.pathname.split('/')[ window.location.pathname.split('/').length-1]
        },

        methods: {
            async actual_events(){
                const events = await faire_audience(this.id_autorite_sender,this.id_autorite_receiver)
                return events
            },

            async list_heure_dispo(){
                const hd =  await this.actual_events()
                let html_value = ''
                // console.log(id_dm_aud_autorite_date_heure_dispo)
                hd.forEach(element => {
                    if(element.id_dm_aud_autorite_date_heure_dispo == null ){
                        html_value += `<option value=${element.id_date_heure_disponible}-${element.id_date_heure_disponible_autorite}>${element.date_disponible} à ${element.hd} - ${element.hf}</option>`
                    } 
                })
                return html_value
            },         

            async handleEventClick(clickInfo){
                const start_date_time = Function.format_date_time(clickInfo.event.start)
                const end_date_time = Function.format_date_time(clickInfo.event.end)                
                console.log(clickInfo.event.extendedProps)
                // Instance autorité

                this.audience.id = clickInfo.event.id
                this.audience.motif = clickInfo.event.title
                this.audience.date_debut = start_date_time[0]
                this.audience.date_fin = end_date_time[0]
                this.audience.heure_debut = start_date_time[1]
                this.audience.heure_fin = end_date_time[1]

                const type = clickInfo.event.extendedProps.type_audience
                const status = clickInfo.event.extendedProps.status_audience

                const id_dm_aud_autorite_date_heure_dispo = clickInfo.event.extendedProps.id_dm_aud_autorite_date_heure_dispo
                
                if(status != ''){
                    if (status == 'Validé' || status == 'Reporté'){
                        const form = await Swal.fire({
                            title: `Audience ${status}`,
                            confirmButtonText: 'Supprimer',
                            confirmButtonColor:'#dc3741',
                            showCancelButton: true,
                            cancelButtonText: 'Annuler',
                            html:
                            `<p align="left" style="margin-left: 1rem;">De <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input" disabled > <input type=time value="${this.audience.time_debut}" id="duree1" class="swal2-input" disabled > </p>` +
                            `<p align="left" style="margin-left: 1.8rem;" disabled >à <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input" disabled > <input type=time value="${this.audience.time_fin}" id="duree2" class="swal2-input" disabled ></p>` +
                            `<p align="left" style="margin:3.5rem 0px 0px 0rem;" >Motif<textarea id="motif" class="swal2-textarea"  placeholder="Saisissez votre motif" disabled style="display: flex;">${this.audience.motif}</textarea></p>
                            <p align="left" style="margin:3.5rem 0px 0px 0rem;"> Vers 
                                <select class="swal2-select" id="heure_dispo" disabled style="display: flex; margin-top: -2rem;
                        margin-left: 3.7rem; width: 23.4rem;">
                                ${await this.list_heure_dispo()}
                                </select> </p>`,
                            focusConfirm: false,
                            preConfirm: () => {
                            return [
                                document.getElementById('date1').value,
                                document.getElementById('duree1').value,
                                document.getElementById('date2').value,
                                document.getElementById('duree2').value,
                                document.getElementById('motif').value,
                                document.getElementById('heure_dispo').value
                            ]
                            }
                        }).then(async (result) =>{
                            if(result.isConfirmed){
                            const response = await DemandeAudienceAutoriteController.supprimer({id:this.audience.id})
                            if(response.message){
                                swal("Audience supprimée", `${response.message}`, "success");
                                // setInterval( () => {
                                //   window.location.reload()
                                // }, 1000)
                            }
                            else {
                                swal("Erreur", "Votre audience n'a pas été supprimée", "error");
                            }
                            // setInterval( () => {
                            //   window.location.reload()
                            // }, 1000)
                            }
                        }).catch((err) => {
                            console.log(err)
                        }) 
                    }
                    else if(status == 'Non validé') {
                        const form = await Swal.fire({
                            title: 'Modifier Audience',
                            showDenyButton: true,
                            showCancelButton: true,
                            confirmButtonText: 'Modifier',
                            denyButtonText: `Supprimer`,
                            cancelButtonText: 'Annuler',
                            html:
                            `<p align="left" style="margin-left: 1rem;">De <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input" disabled > <input type=time value="${this.audience.heure_debut}" id="duree1" class="swal2-input" disabled > </p>` +
                            `<p align="left" style="margin-left: 1.8rem;" disabled >à <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input" disabled > <input type=time value="${this.audience.heure_fin}" id="duree2" class="swal2-input" disabled ></p>` +
                            `<p align="left" style="margin:3.5rem 0px 0px 0rem;" >Motif<textarea id="motif" class="swal2-textarea"  placeholder="Saisissez votre motif" style="display: flex;">${this.audience.motif}</textarea></p>
                            <p align="left" style="margin:3.5rem 0px 0px 0rem;"> Vers 
                                <select class="swal2-select" id="heure_dispo" style="display: flex; margin-top: -2rem;
                            margin-left: 3.7rem; width: 23.4rem;">
                                ${await this.list_heure_dispo()}
                                </select> </p>`,
                            focusConfirm: false,
                            preConfirm: () => {
                                return [
                                    document.getElementById('date1').value,
                                    document.getElementById('duree1').value,
                                    document.getElementById('date2').value,
                                    document.getElementById('duree2').value,
                                    document.getElementById('motif').value,
                                    document.getElementById('heure_dispo').value
                                ]
                            }
                        }).then(async (result) =>{
                            if(result.isConfirmed){
                                this.audience.id_audience = this.audience.id
                                this.audience.motif = result.value[4]
                                this.audience.id_date_heure_disponible = result.value[5].split('-')[0]
                                this.audience.id_date_heure_disponible_autorite = result.value[5].split('-')[1]
                                this.audience.id_dm_aud_autorite_date_heure_dispo =  clickInfo.event.extendedProps.id_dm_aud_autorite_date_heure_dispo

                          
                                const response = await DemandeAudienceAutoriteController.modifier(this.audience)
                                if(response.message){
                                    swal("Audience enregistrée", `${response.message}`, "success");
                                    setInterval( () => {
                                    window.location.reload()
                                    }, 1000)
                                }
                                else {
                                    swal("Audience non enregistrée", "Votre audience n'a pas été enregistrée", "error");
                                }
                            }
                            else if(result.isDenied){ 
                            // const response = await DemandeAudienceAutoriteController.supprimer({id:this.audience.id})
                                Swal.fire({
                                    title: 'Supprimer votre audience',
                                    text: "Voulez vous vraiment supprimer votre audience?",
                                    icon: 'warning',
                                    showCancelButton: true,
                                    confirmButtonColor: '#3085d6',
                                    cancelButtonColor: '#d33',
                                    cancelButtonText: 'Annuler',
                                    confirmButtonText: 'Supprimer!'
                                }).then(async (result) => {
                                    const response = await DemandeAudienceAutoriteController.supprimer({id:this.audience.id})
                                    if(response.message){
                                        swal("Audience supprimée", `${response.message}`, "success");
                                    // setInterval( () => {
                                    //   window.location.reload()
                                    // }, 1000)
                                    }
                                    else {
                                        swal("Erreur", "Votre audience n'a pas été supprimée", "error");
                                    }
                                    // setInterval( () => {
                                    //   window.location.reload()
                                    // }, 1000)
                                }) 
                            }
                        }).catch((err) => {
                            console.log(err)
                        }) 
                    }
                }
                else{
                    const { value: formValues } = await Swal.fire({
                        title: 'Ajouter une audience',
                        html:
                            `<p align="left" style="margin-left: 1rem;">De <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input disabled"> <input type=time value="${this.audience.heure_debut}" id="duree1" class="swal2-input disabled"> </p>` +
                            `<p align="left" style="margin-left: 1.8rem; disabled">à <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input disabled"> <input type=time value="${this.audience.heure_fin}" id="duree2" class="swal2-input disabled"></p>` +
                            `<p align="left" style="margin:3.5rem 0px 0px 0rem;">Motif<textarea id="motif" class="swal2-textarea" placeholder="Saisissez votre motif" style="display: flex;"></textarea></p>`,
                        showCancelButton: true,
                        // width: 600,
                        confirmButtonText: 'Ajouter',    
                        focusConfirm: false,
                        preConfirm: () => {
                            return [
                            document.getElementById('date1').value,
                            document.getElementById('duree1').value,
                            document.getElementById('date2').value,
                            document.getElementById('duree2').value,
                            document.getElementById('motif').value
                            ]
                        }
                    })

                    if (formValues) {
                        // console.log(formValues)
                        this.audience.id_autorite_sender = this.id_autorite_sender,
                        this.audience.id_autorite_receiver = this.id_autorite_receiver,
                        this.audience.date_debut = formValues[0]
                        this.audience.heure_debut = formValues[1]
                        this.audience.date_fin = formValues[2]
                        this.audience.heure_fin = formValues[3]
                        this.audience.motif = formValues[4]
                        this.audience.id_date_heure_disponible_autorite = clickInfo.event.extendedProps.id_date_heure_disponible_autorite
                        

                        console.log(this.audience)
                        const response = await DemandeAudienceAutoriteController.ajouter(this.audience)
                        // console.log(response)
                        if(response.message){
                            swal("Audience enregistrée", `${response.message}`, "success");
                            // setInterval( () => {
                            //   window.location.reload()
                            // }, 1000)
                        }
                        
                        else {
                            swal("Audience non enregistrée", "Votre audience n'a pas été enregistrée", "error");
                        }                    
                    }
                }
            },

            detailEvent(info) {
                // console.log(info.event.extendedProps)
                if(info.event.extendedProps.id_autorite_sender){
                    // console.log(info)
                    tippy(info.el, {
                    theme:'light',
                    content: `<p><strong>${info.event.title}</strong></p>
                    <p> De ${Function.date_in_string(info.event.start)} à ${Function.date_in_string(info.event.end)}</p>
                    <p>Autorité: <strong>${info.event.extendedProps.intitule_receiver}</strong></p>
                    <p><span style="background-color: ${info.event.extendedProps.color_status};" class="dot"></span>  ${info.event.extendedProps.status_audience}</p>`,
                    allowHTML: true,
                    delay:[500,0]
                    });
                } 
            },
        },

    }
</script>

<template>
    <!-- <HeaderNavbar/> -->

    <main id="main" class="main">
        <h1>Demande audience</h1>
        <NavAudiences 
            :autorite="autorite"    
        />
        <div  class='demo-app' >
            <!-- <div  class='demo-app-sidebar'> -->
            
            <div class='demo-app-main'>
            <FullCalendar
                ref="fullCalendar"
                class='demo-app-calendar'
                :options='calendarOptions'
            >
                <template v-slot:eventContent='arg'>
                <b>{{ arg.timeText }}</b>
                <i>{{ arg.event.title }}</i>
                </template>
            </FullCalendar>
            </div>
        </div>
    </main>
</template>

<style lang='css'>
    @import url('./css/style.css');
</style>