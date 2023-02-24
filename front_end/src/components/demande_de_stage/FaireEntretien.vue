<!-- <script setup>
    import { RouterLink, RouterView } from 'vue-router'
</script> -->

<script>

import AutoriteController from '../../controllers/AutoriteController'
import EntretienController from '../../controllers/EntretienController'
import Swal from 'sweetalert2';
import swal from 'sweetalert';
import { RouterLink, RouterView } from 'vue-router'

export default {
    components:{
        RouterLink, RouterView
    },
    props: {
        stage:Object,
        autorite:Object
    },


    methods: {

        async places(){
            const data = await AutoriteController.place_disponible({
                id_date_heure_disponible_autorite: this.stage.id_date_heure_disponible_autorite,
                id_autorite: this.autorite.child_id
            })
            return data
        },

        async placesMap(){
            const resultMap = new Map()
            const data = await this.places()

            data.forEach(element => {
                const key = element.id_date_heure_disponible_autorite
                const value = `${element.date_disponible} à ${element.heure_debut} - ${element.heure_fin}`
                resultMap.set(key,value)
            });
            return resultMap
        },

        async ajouterEntretien(id){
            const { value: place } = await Swal.fire({
                title: 'Faire une entretien',
                input: 'select',
                inputOptions: await this.placesMap(),             
                inputPlaceholder: 'Choisissez une place disponible',
                confirmButtonText: 'Ajouter',
                cancelButtonText: 'Annuler',
                showCancelButton: true,
                inputValidator: (value) => {
                    console.log(value)
                },
            })

            if (place) {
                // Swal.fire(`You selected: ${place}`)
                const response = await EntretienController.ajouter({
                    stage: this.stage,
                    autorite: this.autorite,
                    id_date_heure_disponible_autorite: place
                }).then((result) => {
                    console.log(result)
                    if(result.data.message){
                        this.$emit('stages',)
                        swal("Entretien enregistrée", `${result.data.message}`, "success");
                    }
                }).catch((err) => {
                    console.log(err)
                });
            }
        },

        async modifierEntretien(){
            const data = await this.placesMap()
            const place = await Swal.fire({
                title: `Modifier l'entretien`,
                input: 'select',
                inputOptions: data,             
                // inputPlaceholder: 'Choisissez une place disponible',
                inputValue: data.get(this.stage.id_date_heure_disponible_autorite),
                confirmButtonText: 'Modifier',
                denyButtonText:'Supprimer',
                cancelButtonText: 'Annuler',
                showDenyButton: true,
                showCancelButton: true,
                // inputValidator: (value) => {
                //     console.log(value)
                // },
            }).then(async (result) => {
                const place = result.value
                if(result.isConfirmed){
                    const response = await EntretienController.modifier({
                        stage: this.stage,
                        autorite: this.autorite,
                        id_date_heure_disponible_autorite: place
                    }).then((result) => {
                        if(result.data.message){
                            swal("Entretien modifié", `${result.data.message}`, "success");
                        }
                    }).catch((err) => {
                        console.log(err)
                    });
                }else if(result.isDenied){
                    Swal.fire({
                        title: 'Reporter un entretien',
                        text: "Cette entretien sera considérée comme stage non validé",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        cancelButtonText: 'Annuler',
                        confirmButtonText: 'Supprimer!'
                    }).then(async (result) => {

                        if (result.isConfirmed) {
                            const response = await EntretienController.supprimer({
                                stage: this.stage,
                                autorite: this.autorite,
                            }).then((result) => {
                                if(result.data.message){
                                    swal("Entretien Supprimé", `${result.data.message}`, "success");
                                }
                            }).catch((err) => {
                                console.log(err)
                            });
                        }
                    }).catch((err) => {
                        console.log(err)
                    })
                }
            }).catch((err) => {
                console.log(err)
            });
        },

    }
}

</script>

<template>


    <button type="button" v-if="stage.demande_status === 'Validé'" @click="modifierEntretien(stage.id)" class="btn btn-warning"> 
        <i class="ri-edit-2-line"></i>
    </button>

    <button type="button" v-else-if="stage.demande_status === 'Non validé'" @click="ajouterEntretien(stage.id)" class="btn btn-success"> 
        <i class="bi bi-check-circle"></i>
    </button>

    <button type="button" v-if="stage.demande_status === 'Reporté'" @click="modifierEntretien(stage.id)" class="btn btn-warning"> 
        <i class="ri-edit-2-line"></i>
    </button>

    <RouterView />
</template>