<script setup>
    import HeaderNavbar from '../../components/header/HeaderBack.vue'
</script>
<script>
// import { audience_reporter} from '../../func/event-utils'
import DemandeAudienceController from '../../controllers/BackOffice/DemandeAudienceAutoriteController'
import dm_public_controller from '../../controllers/BackOffice/DemandeAudiencePublicController'
import Swal from 'sweetalert2';
    export default {
        data(){
            return{
                autorite:'',
                audiences:'',
            }
        },
        async created() {
            this.audiences = await this.audiences_reportes()
        },
        methods: {

            setAutorite(){
                const ses = JSON.parse(sessionStorage.getItem('administrateur'))
                this.autorite = ses.autorite_enfant
            },
            
            async audiences_reportes(){
                this.setAutorite()
                const id = this.autorite.id
                return await DemandeAudienceController.liste_audiences_reportes(id)
            },

            async infos_audience(audience){
                if(audience.type_audience == 'Public'){
                    const form = await Swal.fire({
                        title: 'A reporter',
                        showCancelButton: true,
                        confirmButtonText: 'Valider',
                        html:
                            `<p>Date début: <input type=Date value="${audience.date_debut}" id="date1" class="swal2-input"></p>` +
                            `<p style="margin-left:25px;" >Date fin: <input type=Date value="${audience.date_fin}" id="date2" class="swal2-input"></p>` +
                            `<p style="margin-right:49px;">Durée début: <input type=time value="${audience.time_debut}" id="duree1" class="swal2-input"></p>`+
                            `<p style="margin-right:25px;">Durée fin: <input type=time value="${audience.time_fin}" id="duree2" class="swal2-input"></p>`,
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
                        if(result.isConfirmed){
                            const audience_event = {
                                autorite: audience.autorite,
                                sender: audience.sender,
                                date_debut: result.value[0],
                                date_fin: result.value[1], 
                                time_debut: result.value[2],
                                time_fin: result.value[3],
                                id_autorite_enfant: this.autorite.id,
                                motif: audience.motif,
                                id: audience.id
                            }                  
                            const response = await dm_public_controller.revalider(audience_event)
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
                        }).catch((err) => {
                            console.log(err)
                        })
                    }
                    else if(audience.type_audience == 'Autorité'){
                        const form = await Swal.fire({
                        title: 'A reporter',
                        showCancelButton: true,
                        confirmButtonText: 'Valider',
                        html:
                            `<p>Date début: <input type=Date value="${audience.date_debut}" id="date1" class="swal2-input"></p>` +
                            `<p style="margin-left:25px;" >Date fin: <input type=Date value="${audience.date_fin}" id="date2" class="swal2-input"></p>` +
                            `<p style="margin-right:49px;">Durée début: <input type=time value="${audience.time_debut}" id="duree1" class="swal2-input"></p>`+
                            `<p style="margin-right:25px;">Durée fin: <input type=time value="${audience.time_fin}" id="duree2" class="swal2-input"></p>`,
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
                        if(result.isConfirmed){
                            const audience_event = {
                                autorite:audience.autorite,
                                sender: audience.sender,
                                date_debut: result.value[0],
                                date_fin: result.value[1], 
                                time_debut: result.value[2],
                                time_fin: result.value[3],
                                id_autorite_enfant_receiver: this.autorite.id ,
                                id_autorite_enfant_sender: audience.sender.id,
                                motif: audience.motif,
                                id: audience.id
                            }                  
                            const response = await DemandeAudienceController.revalider(audience_event)
                            if(response.data){
                                Swal.fire('Succès',`${response.message}`,'success')
                                // setInterval( () => {
                                //     window.location.reload()
                                // }, 1000)
                            }
                            else{
                                Swal.fire('Error',`${response.message}`,'error')
                            }
                        }
                        }).catch((err) => {
                            console.log(err)
                        });   
                    }
                }
            
        },
    }
</script>
<template>
    <HeaderNavbar/>
    <main id="main-audience" class="main-audience">
    <div class="card">
        <div class="card-body">
        <h5 class="card-title">Demandes audiences reportées</h5>

        <!-- Table with hoverable rows -->
        <table class="table table-hover">
            <thead>
            <tr>
                <th scope="col"></th>
                <th scope="col">Motif</th>
                <th scope="col">Type audience</th>
                <th scope="col">Action</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="audience in this.audiences" :key="audience.id_audience">
                <th scope="row">{{audience.id}}</th>
                <td>{{audience.motif}}</td>
                <td>{{audience.type_audience}}</td>
                <td>
                <button type="button" @click="infos_audience(audience)" class="btn btn-info" >Infos</button>
                </td>
            </tr>
            </tbody>
        </table>
        <!-- End Table with hoverable rows -->

        </div>
    </div>
    </main>
</template>
<style lang='css'>
#main-audience{
    margin-top: 60px;
    margin-left: 300px;
}
h2 {
    margin: 0;
    font-size: 16px;
}

ul {
    margin: 0;
    padding: 0 0 0 1.5em;
}

li {
    margin: 1.5em 0;
    padding: 0;
}

b { /* used for event dates/times */
    margin-right: 3px;
}

.demo-app {
    display: flex;
    min-height: 100%;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
}

.demo-app-sidebar {
    width: 300px;
    line-height: 1.5;
    background: #eaf9ff;
    border-right: 1px solid #d3e2e8;
}

.demo-app-sidebar-section {
    padding: 2em;
}

.demo-app-main {
    flex-grow: 1;
    padding: 3em;
    z-index: 1;
}

.fc { /* the calendar root */
    /* max-width: 1100px; */
    margin: 0 auto;
}
footer{
    background:#ccc;
    position:fixed;
    bottom:0;
    width:100%;
    padding-top:50px;
    height:50px;
    z-index: 2;
}
#button-add-event {
    float: right;
    margin-top: -3%;
    margin-right: 10px;
}

/* Popup */
.button {
border: none;
color: #FFF;
background: #42b983;
appearance: none;
font: inherit;
font-size: 1.8rem;
padding: .5em 1em;
border-radius: .3em;
cursor: pointer;
}

.modal {
position: absolute;
position: fixed;
top: 0;
right: 0;
bottom: 0;
left: 0;
margin: auto;
text-align: center;
width: fit-content;
height: fit-content;
max-width: 22em;
padding: 2rem;
border-radius: 1rem;
box-shadow: 0 5px 5px rgba(0, 0, 0, 0.2);
background: #FFF;
z-index: 9999;
transform: none;
}
.modal h1 {
margin: 0 0 1rem;
}


/* ---------------------------------- */
.fade-enter-active,
.fade-leave-active {
transition: opacity .4s linear;
}

.fade-enter,
.fade-leave-to {
opacity: 0;
}

.pop-enter-active,
.pop-leave-active {
transition: transform 0.4s cubic-bezier(0.5, 0, 0.5, 1), opacity 0.4s linear;
}

.pop-enter,
.pop-leave-to {
opacity: 0;
transform: scale(0.3) translateY(-50%);
}

</style>