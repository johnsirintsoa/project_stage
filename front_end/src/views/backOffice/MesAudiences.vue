<script setup>
    // MesAudiences V2
    import HeaderNavbar from '../../components/header/HeaderBack.vue'
    import NavAudiences from '../../components/NavBar/NavAudiences.vue' 
</script>


<template>
    <HeaderNavbar/>
    <main id="main" class="main">
        <h1>Mes Audiences</h1>
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

<script>
    import '@fullcalendar/core/vdom'
    import FullCalendar from '@fullcalendar/vue3'
    import dayGridPlugin from '@fullcalendar/daygrid'
    import timeGridPlugin from '@fullcalendar/timegrid'
    import interactionPlugin from '@fullcalendar/interaction'
    import listPlugin from '@fullcalendar/list'
    import timeLine from '@fullcalendar/timeline'
    import { actual_events_autorite} from '../../func/event-utils'
    import DemandeAudience from '../../api/demande_audience'
    import EntretienDemandeStage from '../../api/entretien_stage'
    import NonDispoAutoriteDate from '../../api/pas_dispo_date'
    import NonDispoAutoriteJour from '../../api/pas_dispo_jour'
    import tippy from 'tippy.js';
    import 'tippy.js/dist/tippy.css'; // optional for styling
    import 'tippy.js/themes/light.css';
    import Function from '../../func/function';
    import swal from 'sweetalert';
    import Swal from 'sweetalert2';
    import AutoriteAPI from '../../api/autorite';
    import frLocale from '@fullcalendar/core/locales/fr';
    import dm_autorite_controller from '../../controllers/BackOffice/DemandeAudienceAutoriteController'
    import dm_public_controller from '../../controllers/BackOffice/DemandeAudiencePublicController'
    
    export default{
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
                    initialEvents: this.actual_events,
                    // editable: true,
                    contentHeight: 450,
                    selectable: false,
                    droppable: true,
                    selectMirror: false,
                    dayMaxEvents: true,
                    weekends: false,
                    select: this.handleDateSelect,
                    // eventClick: this.handleEventClick,
                    // eventsSet: this.handleEvents,
                    eventDidMount: this.detailEvent,
                    eventResize: this.eventDragged,
                    eventDrop: this.eventDropped,
                    slotMinTime: '08:00:00',
                    slotMaxTime: '16:00:00'
                    /* you can update a remote database when these fire:
                    eventAdd:
                    eventChange:
                    eventRemove:
                    */
                },

                audience :{
                    autorite:'',
                    evenement:'',
                    date_debut:'',
                    date_fin: '',
                    heure_debut:'',
                    heure_fin:''
                }
            }
        },

        async created(){
            const ses = JSON.parse(sessionStorage.getItem('administrateur'))
            this.session_autorite = ses
            this.autorite = ses
            // this.autorite_sender
        },

        computed:{
            autoriteObject:{
                get(){
                    return this.audience.autorite
                },
                set(obj){
                    this.audience.autorite = {
                        id : obj.id,
                        intitule : obj.intitule,
                        intitule_code : obj.intitule_code,
                        addresse_electronique : obj.addresse_electronique,
                        mot_de_passe_mailing : obj.mot_de_passe_mailing,
                        porte: obj.porte
                    }   
                }
            },
            evenementPublic:{
                get(){
                    return this.audience.evenement
                },  
                set(obj){
                    this.evenement = ''
                    this.audience.evenement = {
                        id : obj.id,
                        motif: obj.motif,
                        nom: obj.nom,
                        prenom: obj.prenom,
                        addresse_electronique: obj.addresse_electronique,
                        id_dm_aud_public_date_heure_dispo: obj.id_event_date_heure_dispo
                    }   
                }              
            },
            evenementAutorite:{
                get(){
                    return this.audience.evenement
                },  
                set(obj){
                    this.evenement = ''
                    this.audience.evenement = {
                        id_audience : obj.id_evenement,
                        autorite_sender: {
                            id: obj.id_autorite_sender,
                            intitule: obj.intitule_autorite_sender,
                            intitule_code: obj.intitule_code_sender,
                            addresse_electronique: obj.addresse_electronique_autorite_sender
                        },
                        id_dm_aud_aut_date_heure_dispo: obj.id_event_date_heure_dispo
                    }   
                }              
            },
            evenementEntretien:{
                get(){
                    return this.audience.evenement
                },  
                set(obj){
                    this.evenement = ''
                    this.audience.evenement = {
                        id : obj.id,
                        nom: obj.nom,
                        prenom: obj.prenom,
                        addresse_electronique: obj.addresse_electronique
                        // id_entretien
                    }   
                }              
            },
        },

        methods: {

            async handleEventClick(clickInfo){
                const start_date_time = Function.format_date_time(clickInfo.event.start)
                const end_date_time = Function.format_date_time(clickInfo.event.end)                
                console.log(clickInfo.event.extendedProps)
                // Instance autorité
                this.autoriteObject = {
                    id: clickInfo.event.extendedProps.id_autorite,
                    intitule: clickInfo.event.extendedProps.intitule_autorite,
                    intitule_code: clickInfo.event.extendedProps.intitule_code_autorite,
                    addresse_electronique: clickInfo.event.extendedProps.addresse_electronique_autorite,
                    mot_de_passe_mailing: clickInfo.event.extendedProps.mot_de_passe_mailing_autorite,
                    porte: clickInfo.event.extendedProps.porte_autorite
                }
                this.audience.date_debut = start_date_time[0]
                this.audience.date_fin = end_date_time[0]
                this.audience.heure_debut = start_date_time[1]
                this.audience.heure_fin = end_date_time[1]


                const type = clickInfo.event.extendedProps.type_audience
                const action = clickInfo.event.extendedProps.status_audience
                if(type === 'Public' ){
                    this.evenementPublic = {
                        id : clickInfo.event.extendedProps.id_evenement,
                        motif: clickInfo.event.extendedProps.motif,
                        nom: clickInfo.event.extendedProps.nom,
                        prenom: clickInfo.event.extendedProps.prenom,
                        addresse_electronique: clickInfo.event.extendedProps.addresse_electronique_sender_externe,
                        id_event_date_heure_dispo:clickInfo.event.id
                    }
                    if(action === 'Non validé'){
                        const { value: formValues } = await Swal.fire({
                            title: 'Validation',
                            showCancelButton: true,
                            confirmButtonText: 'Valider',
                            html:
                            `<p>Date début: <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"></p>` +
                            `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                            `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.heure_debut}" id="duree1" class="swal2-input"></p>`+
                            `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.heure_fin}" id="duree2" class="swal2-input"></p>`,
                            focusConfirm: false,
                            preConfirm: () => {
                                return[
                                    document.getElementById('date1').value,
                                    document.getElementById('date2').value,
                                    document.getElementById('duree1').value,
                                    document.getElementById('duree2').value
                                ]
                            }
                        })
                        if (formValues) {
                            this.audience.date_debut = formValues[0]
                            this.audience.date_fin = formValues[1]
                            this.audience.heure_debut = formValues[2]
                            this.audience.heure_fin = formValues[3]

                            const response = await dm_public_controller.valider(this.audience)
                            if(response.data){
                                Swal.fire('Succès',`${response.message}`,'success')
                                // setInterval( () => {
                                //   window.location.reload()
                                // }, 1000)
                            }
                            else{
                                Swal.fire('Error',`${response.message}`,'error')
                            }
                        }
                    }
                    else if (action === 'Validé'){
                        const form = await Swal.fire({
                            title: 'A reporter',
                            showDenyButton: true,
                            showCancelButton: true,
                            confirmButtonText: 'Maintenant',
                            
                            denyButtonText:'Plus tard',
                            html:
                                `<p>Date début: <input type=Date value="${this.audience.date_debut}"  id="date1" class="swal2-input"></p>` +
                                `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                                `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.heure_debut}" id="duree1" class="swal2-input"></p>`+
                                `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.heure_fin}" id="duree2" class="swal2-input"></p>`,
                            focusConfirm: false,
                            preConfirm: () => {
                                return[
                                    document.getElementById('date1').value,
                                    document.getElementById('date2').value,
                                    document.getElementById('duree1').value,
                                    document.getElementById('duree2').value
                                ]
                            } 
                        }).then(async (result) => {
                            // console.log(result)

                            // console.log(result)
                            if(result.isConfirmed){
                                this.audience.date_debut = result.value[0]
                                this.audience.date_fin = result.value[1] 
                                this.audience.heure_debut = result.value[2]
                                this.audience.heure_fin = result.value[3] 
                                console.log(result)     
                                await dm_public_controller.reporter_maintenant(this.audience)
                                    Swal.fire('Succès','Vous avez reportée avec succès','success')
                                // setInterval( () => {
                                //     window.location.reload()
                                // }, 1000)
                            }
                            else if(result.isDenied){           
                                const data = await dm_public_controller.reporter_plus_tard(this.audience)
                                Swal.fire('Audience reporter plus tard', `${data.message}`, 'success')
                                // setInterval( () => {
                                // window.location.reload()
                                // }, 1000)
                            }
                        }).catch((err) => {
                            console.log(err)
                        });
                    }
                    else if(action === 'Reporté'){
                        const { value: formValues } = await Swal.fire({
                            title: 'Revalider',
                            showCancelButton: true,
                            confirmButtonText: 'Valider',
                            html:
                            `<p>Date début: <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"></p>` +
                            `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                            `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.heure_debut}" id="duree1" class="swal2-input"></p>`+
                            `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.heure_fin}" id="duree2" class="swal2-input"></p>`,
                            focusConfirm: false,
                            preConfirm: () => {
                                return[
                                    document.getElementById('date1').value,
                                    document.getElementById('date2').value,
                                    document.getElementById('duree1').value,
                                    document.getElementById('duree2').value
                                ]
                            }
                        })
                        if (formValues) {
                            this.audience.date_debut = formValues[0]
                            this.audience.date_fin = formValues[1]
                            this.audience.heure_debut = formValues[2]
                            this.audience.heure_fin = formValues[3]
                            const response = await dm_public_controller.revalider(this.audience)
                            if(response.message){
                                Swal.fire('Succès',`${response.message}`,'success')
                            }
                            else{
                                Swal.fire('Error',`${response.message}`,'error')
                            }
                        }
                    }
                }
                else if(type === 'Autorité'){
                    this.evenementAutorite = {
                        id_evenement : clickInfo.event.extendedProps.id_evenement,
                        id_autorite_sender: clickInfo.event.extendedProps.id_autorite_sender,
                        intitule_autorite_sender: clickInfo.event.extendedProps.intitule_autorite_sender,
                        intitule_code_sender: clickInfo.event.extendedProps.intitule_code_sender,
                        addresse_electronique_autorite_sender: clickInfo.event.extendedProps.addresse_electronique_autorite_sender,
                        date_debut: clickInfo.event.extendedProps.date_debut,
                        date_fin: clickInfo.event.extendedProps.date_fin,
                        heure_debut: clickInfo.event.extendedProps.heure_debut,
                        heure_fin: clickInfo.event.extendedProps.heure_fin,
                        id_event_date_heure_dispo:clickInfo.event.id
                    }
                    if(action === 'Non validé'){
                        const { value: formValues } = await Swal.fire({
                            title: 'Validation',
                            showCancelButton: true,
                            confirmButtonText: 'Valider',
                            html:
                            `<p>Date début: <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"></p>` +
                            `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                            `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.heure_debut}" id="duree1" class="swal2-input"></p>`+
                            `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.heure_fin}" id="duree2" class="swal2-input"></p>`,
                            focusConfirm: false,
                            preConfirm: () => {
                                return[
                                    document.getElementById('date1').value,
                                    document.getElementById('date2').value,
                                    document.getElementById('duree1').value,
                                    document.getElementById('duree2').value
                                ]
                            }
                        })
                        if (formValues) {
                            this.audience.date_debut = formValues[0]
                            this.audience.date_fin = formValues[1]
                            this.audience.heure_debut = formValues[2]
                            this.audience.heure_fin = formValues[3]

                            // console.log(this)
                            const response = await dm_autorite_controller.valider(this.audience)
                            if(response.data){
                                Swal.fire('Succès',`${response.message}`,'success')
                                // setInterval( () => {
                                //   window.location.reload()
                                // }, 1000)
                            }
                            else{
                                Swal.fire('Error',`${response.message}`,'error')
                            }
                        }
                    }
                    else if (action === 'Validé'){
                        const form = await Swal.fire({
                            title: 'A reporter',
                            showDenyButton: true,
                            showCancelButton: true,
                            confirmButtonText: 'Maintenant',
                            
                            denyButtonText:'Plus tard',
                            html:
                                `<p>Date début: <input type=Date value="${this.audience.date_debut}"  id="date1" class="swal2-input"></p>` +
                                `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                                `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.heure_debut}" id="duree1" class="swal2-input"></p>`+
                                `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.heure_fin}" id="duree2" class="swal2-input"></p>`,
                            focusConfirm: false,
                            preConfirm: () => {
                                return[
                                    document.getElementById('date1').value,
                                    document.getElementById('date2').value,
                                    document.getElementById('duree1').value,
                                    document.getElementById('duree2').value
                                ]
                            } 
                        }).then(async (result) => {
                            // console.log(result)

                            // console.log(result)
                            if(result.isConfirmed){
                                this.audience.date_debut = result.value[0]
                                this.audience.date_fin = result.value[1] 
                                this.audience.heure_debut = result.value[2]
                                this.audience.heure_fin = result.value[3] 
                                console.log(result)     
                                await dm_autorite_controller.reporter_maintenant(this.audience)
                                    Swal.fire('Succès','Vous avez reportée avec succès','success')
                                // setInterval( () => {
                                //     window.location.reload()
                                // }, 1000)
                            }
                            else if(result.isDenied){           
                                const data = await dm_autorite_controller.reporter_plus_tard(this.audience)
                                Swal.fire('Audience reporter plus tard', `${data.message}`, 'success')
                                // setInterval( () => {
                                // window.location.reload()
                                // }, 1000)
                            }
                        }).catch((err) => {
                            console.log(err)
                        });
                    }
                    else if(action === 'Reporté'){
                        const { value: formValues } = await Swal.fire({
                            title: 'Revalider',
                            showCancelButton: true,
                            confirmButtonText: 'Valider',
                            html:
                            `<p>Date début: <input type=Date value="${this.audience.date_debut}" id="date1" class="swal2-input"></p>` +
                            `<p style="margin-left:25px;" >Date fin: <input type=Date value="${this.audience.date_fin}" id="date2" class="swal2-input"></p>` +
                            `<p style="margin-right:49px;">Durée début: <input type=time value="${this.audience.heure_debut}" id="duree1" class="swal2-input"></p>`+
                            `<p style="margin-right:25px;">Durée fin: <input type=time value="${this.audience.heure_fin}" id="duree2" class="swal2-input"></p>`,
                            focusConfirm: false,
                            preConfirm: () => {
                                return[
                                    document.getElementById('date1').value,
                                    document.getElementById('date2').value,
                                    document.getElementById('duree1').value,
                                    document.getElementById('duree2').value
                                ]
                            }
                        })
                        if (formValues) {
                            this.audience.date_debut = formValues[0]
                            this.audience.date_fin = formValues[1]
                            this.audience.heure_debut = formValues[2]
                            this.audience.heure_fin = formValues[3]
                            const response = await dm_autorite_controller.revalider(this.audience)
                            if(response.message){
                                Swal.fire('Succès',`${response.message}`,'success')
                            }
                            else{
                                Swal.fire('Error',`${response.message}`,'error')
                            }
                        }
                    }
                }
                else if(type === 'Entretien'){
                    this.evenementEntretien = {
                        id: clickInfo.event.extendedProps.id_evenement,
                        nom: clickInfo.event.extendedProps.nom,
                        prenom: clickInfo.event.extendedProps.prenom,
                        addresse_electronique: clickInfo.event.extendedProps.addresse_electronique_sender_externe,
                        date_debut: clickInfo.event.extendedProps.date_debut,
                        date_fin: clickInfo.event.extendedProps.date_fin,
                        heure_debut: clickInfo.event.extendedProps.heure_debut,
                        heure_fin: clickInfo.event.extendedProps.heure_fin,
                    }
                }

            },


            async eventDropped(event){
                const start_date_time = Function.format_date_time(event.event.start)
                const end_date_time = Function.format_date_time(event.event.end)
                // console.log(event.event.extendedProps)
                this.autoriteObject = {
                    id: event.event.extendedProps.id_autorite,
                    intitule: event.event.extendedProps.intitule_autorite,
                    intitule_code: event.event.extendedProps.intitule_code_autorite,
                    addresse_electronique: event.event.extendedProps.addresse_electronique_autorite,
                    mot_de_passe_mailing: event.event.extendedProps.mot_de_passe_mailing_autorite,
                    porte: event.event.extendedProps.porte_autorite
                }
                this.audience.date_debut = start_date_time[0]
                this.audience.date_fin = end_date_time[0]
                this.audience.heure_debut = start_date_time[1]
                this.audience.heure_fin = end_date_time[1]

                const type = event.event.extendedProps.type_audience
                const action = event.event.extendedProps.status_audience

                if(type === 'Public'){
                    this.evenementPublic = {
                        id : event.event.extendedProps.id_evenement,
                        motif: event.event.extendedProps.motif,
                        nom: event.event.extendedProps.nom,
                        prenom: event.event.extendedProps.prenom,
                        addresse_electronique: event.event.extendedProps.addresse_electronique_sender_externe,
                        id_event_date_heure_dispo:event.event.id
                    }
                    const response = await dm_public_controller.valider(this.audience)
                }
                else if(type === 'Autorité'){
                    this.evenementAutorite = {
                        id_evenement : event.event.extendedProps.id_evenement,
                        id_autorite_sender: event.event.extendedProps.id_autorite_sender,
                        intitule_autorite_sender: event.event.extendedProps.intitule_autorite_sender,
                        intitule_code_sender: event.event.extendedProps.intitule_code_sender,
                        addresse_electronique_autorite_sender: event.event.extendedProps.addresse_electronique_autorite_sender,
                        date_debut: event.event.extendedProps.date_debut,
                        date_fin: event.event.extendedProps.date_fin,
                        heure_debut: event.event.extendedProps.heure_debut,
                        heure_fin: event.event.extendedProps.heure_fin,
                        id_event_date_heure_dispo:event.event.id
                    }
                    const response = await dm_autorite_controller.valider(this.audience)
                }
            },

            async eventDragged(event){
                const start_date_time = Function.format_date_time(event.event.start)
                const end_date_time = Function.format_date_time(event.event.end)
                // console.log(event.event.extendedProps)
                this.autoriteObject = {
                    id: event.event.extendedProps.id_autorite,
                    intitule: event.event.extendedProps.intitule_autorite,
                    intitule_code: event.event.extendedProps.intitule_code_autorite,
                    addresse_electronique: event.event.extendedProps.addresse_electronique_autorite,
                    mot_de_passe_mailing: event.event.extendedProps.mot_de_passe_mailing_autorite,
                    porte: event.event.extendedProps.porte_autorite
                }
                this.audience.date_debut = start_date_time[0]
                this.audience.date_fin = end_date_time[0]
                this.audience.heure_debut = start_date_time[1]
                this.audience.heure_fin = end_date_time[1]

                const type = event.event.extendedProps.type_audience
                const action = event.event.extendedProps.status_audience

                if(type === 'Public'){
                    this.evenementPublic = {
                        id : event.event.extendedProps.id_evenement,
                        motif: event.event.extendedProps.motif,
                        nom: event.event.extendedProps.nom,
                        prenom: event.event.extendedProps.prenom,
                        addresse_electronique: event.event.extendedProps.addresse_electronique_sender_externe,
                        id_event_date_heure_dispo:event.event.id
                    }
                    const response = await dm_public_controller.valider(this.audience)
                }
                else if(type === 'Autorité'){
                    this.evenementAutorite = {
                        id_evenement : event.event.extendedProps.id_evenement,
                        id_autorite_sender: event.event.extendedProps.id_autorite_sender,
                        intitule_autorite_sender: event.event.extendedProps.intitule_autorite_sender,
                        intitule_code_sender: event.event.extendedProps.intitule_code_sender,
                        addresse_electronique_autorite_sender: event.event.extendedProps.addresse_electronique_autorite_sender,
                        date_debut: event.event.extendedProps.date_debut,
                        date_fin: event.event.extendedProps.date_fin,
                        heure_debut: event.event.extendedProps.heure_debut,
                        heure_fin: event.event.extendedProps.heure_fin,
                        id_event_date_heure_dispo:event.event.id
                    }
                    const response = await dm_autorite_controller.valider(this.audience)
                }
            },
            
            async actual_events(){
                console.log(await actual_events_autorite(this.session_autorite))
                return await actual_events_autorite(this.session_autorite)  
            },

            detailEvent(info) {
                if(info.event.extendedProps.type_audience == 'Public'){
                    tippy(info.el, {
                        theme:'light',
                        content: `
                        <p><strong>${info.event.extendedProps.motif}</strong></p>
                        <p>De ${Function.date_in_string(info.event.start)} à ${Function.date_in_string(info.event.end)}</p>
                        <p>Nom: ${info.event.extendedProps.nom}</p>
                        <p>Prénom: ${info.event.extendedProps.prenom}</p>
                        <p>CIN: ${info.event.extendedProps.cin}</p>  
                        <p>Numéro téléphone: ${info.event.extendedProps.numero_telephone}</p>  
                        <p>mail: ${info.event.extendedProps.addresse_electronique_sender_externe}</p>  
                        <p><span style="background-color: ${info.event.extendedProps.color_status};" class="dot"></span>  ${info.event.extendedProps.status_audience}</p>`,
                        allowHTML: true,
                        delay: [500,0]
                    });              
                }
                else if(info.event.extendedProps.type_audience == 'Autorité'){
                    tippy(info.el, {
                    theme:'light',
                    content: `<p><strong>${info.event.extendedProps.motif}</strong></p>
                    <p> De ${Function.date_in_string(info.event.start)} à ${Function.date_in_string(info.event.end)}</p>
                    <p>Venant de la <strong>${info.event.extendedProps.intitule_autorite_sender} (${info.event.extendedProps.intitule_code_sender})</strong></p>
                    <p> <span style="background-color: ${info.event.extendedProps.color_status};" class="dot"></span>  ${info.event.extendedProps.status_audience}</p>`,
                    allowHTML: true,
                    delay: [500,0]

                    })
                }
                else if(info.event.extendedProps.type_audience == 'Entretien'){
                    tippy(info.el, {
                    theme:'light',
                    content: `<p><strong>${info.event.extendedProps.motif}</strong></p>
                    <p> De ${Function.date_in_string(info.event.start)} à ${Function.date_in_string(info.event.end)}</p>
                    <p>Nom: ${info.event.extendedProps.nom}</p>
                    <p>Prénom: ${info.event.extendedProps.prenom}</p>
                    <p>CIN: ${info.event.extendedProps.cin}</p>  
                    <p>Numéro téléphone: ${info.event.extendedProps.numero_telephone}</p>  
                    <p>mail: ${info.event.extendedProps.addresse_electronique_sender_externe}</p>  
                    <p><span style="background-color: ${info.event.extendedProps.color_status};" class="dot"></span>  ${info.event.extendedProps.status_audience}</p>`,
                    allowHTML: true,
                    delay: [500,0]

                    })
                }
            },
        },

    }

</script>


<style lang='css'>
    @import url('./css/style.css');
</style>