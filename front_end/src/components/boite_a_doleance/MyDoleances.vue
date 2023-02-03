<script setup>
    import ModifierDoleance from './ModifierDoleance.vue'
</script>

<template>
    <table class="table table-hover">
        <thead>
          <tr>
            <th scope="col"></th>
            <th scope="col">Titre</th>
            <th scope="col">Type</th>
            <th scope="col">Autorité</th>
            <th scope="col">Action</th>
          </tr>
        </thead>
        <tbody>
            <tr v-for="doleance in doleances" :key="doleance">
                <th scope="row">{{doleance.id}}</th>
                <td>{{doleance.titre}}</td>
                <td>{{doleance.type_doleance}}</td>
                <td>{{doleance.sigle}}</td>
                <td>
                    <button type="button" class="btn btn-warning" @click="modifier(doleance)"><i class="ri-edit-2-line"></i></button>
                    <button type="button" class="btn btn-danger" @click="supprimer(doleance)"><i class="ri-delete-bin-6-fill"></i></button>
                </td>
            </tr>
        </tbody>
    </table> 

    <teleport to=".popupToShow">
        <div v-if="showPopup" class="popupShow">
            <p  @click="togglePopup"><i class="ri-close-line" style="font-size: 35px;position: fixed; margin-left: 88%;"></i></p>
            <div class="card-body">
                <h2 class="card-title">Modifier votre doléance</h2>
                <ModifierDoleance
                    v-model:doleance="doleanceObj"
                />
            </div>
        </div>
    </teleport>
    
</template>
<script>
import DoleanceAPI from '../../api/doleance';
import swal from 'sweetalert'
import Swal from 'sweetalert2'
export default {
    data(){
        return {
            showPopup: false,
            doleances: [],
            directions: [],
        };
    },
    async created() {
        const session = JSON.parse(sessionStorage.getItem('session_navigateur')).value
        const arg = {
            session_navigateur : 'session877.7483667099051',
            // session_navigateur : session,
        }
        this.doleances = await DoleanceAPI.liste_public(arg)
    },
    methods:{
        async modifier(value){
            this.togglePopup()
            this.doleanceObj = value
        },
        togglePopup(value){
            this.showPopup = !this.showPopup
            // console.log(value)
        },

        async supprimer(value){
            Swal.fire({
                title: 'Supprimer doléance',
                text: "Voulez vous vraiment supprimer votre doléance?",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                cancelButtonText: 'Annuler',
                confirmButtonText: 'Supprimer!'
            }).then(async (result) => {
                const response = await DoleanceAPI.supprimer(value.id)
                if(response.message){
                    Swal.fire('Doléance supprimée',`${response.message}`,'success')
                }
                // 
            }).catch((err) => {
                Swal.fire('error',`Vous avez une error`,'error')
                console.log(err)
            });
        },



    }
}
</script>