<script>
    import swal from 'sweetalert';
    import Swal from 'sweetalert2';
    import AutoriteController from '../../controllers/AutoriteController'
    import evenementController from '../../controllers/EvenementController'

    export default{
        props:{
            evenement:Object,
            autorite: Object
        },
        methods: {
            detailEvenement(event){
                if(event.type_evenement ==='Public'){
                    Swal.fire({
                        title: `Détail ${event.type_evenement}`,
                        icon: 'info',
                        html: 
                            `<p> Nom: ${event.nom}</p>
                            <p> Prénom: ${event.prenom}</p>
                            <p> CIN: ${event.cin}</p>
                            <p> Tél: ${event.numero_telephone}</p>
                            <p> Mail: ${event.addresse_electronique}</p>
                            <p> Motif: ${event.motif}</p>`,
                    })
                }  
                else if (event.type_evenement ==='Autorité'){
                    Swal.fire({
                        title: `Détail ${event.type_evenement}`,
                        icon: 'info',
                        html: `<p> Intitulé: ${event.intitule_sender} (${event.intitule_code_sender})</p>
                            <p> Mail: ${event.intitule_sender_addresse_electronique}</p>
                            <p> Motif: ${event.motif}</p>`,
                    })                    
                } 
                else if (event.type_evenement ==='Entretien'){
                    Swal.fire({
                        title: `Détail ${event.type_evenement}`,
                        icon: 'info',
                        html: `<p> Nom: ${event.nom}</p>
                            <p> Prénom: ${event.prenom}</p>
                            <p>Motif: ${event.motif}</p>
                            <p> CIN: ${event.cin}</p>
                            <p> Tél: ${event.numero_telephone}</p>
                            <p> Mail: ${event.numero_telephone}</p>`,
                    })                    
                } 
            },
            async places(){
                const data = await AutoriteController.place_disponible({
                    id_date_heure_disponible_autorite: this.evenement.id_date_heure_disponible_autorite,
                    id_autorite: this.autorite.id_autorite_enfant
                })
                return data
            },

            async placesMap(){
                const resultMap = new Map()
                const data = await this.places()

                data.forEach(element => {
                    const key = `${element.id_date_heure_disponible_autorite},${element.date_disponible},${element.heure_debut},${element.heure_fin}`
                    // const key = [
                    //     element.id_date_heure_disponible_autorite,
                    //     element.date_disponible,
                    //     element.heure_debut,
                    //     element.heure_fin
                    // ]
                    const value = `${element.date_disponible} ${element.heure_debut}-${element.heure_fin}`
                    resultMap.set(key,value)
                });
                return resultMap
            },

            async ajouterEvenement(event){
                const data = await this.placesMap()
                const key_evenement = `${event.id_date_heure_disponible_autorite},${event.date_debut},${event.heure_debut},${event.heure_fin}`
                // console.log(this.evenement)
                const { value: place } = await Swal.fire({
                    title: 'Ajouter évènement',
                    input: 'select',
                    inputOptions: await this.placesMap(),             
                    inputValue: data.get(key_evenement),
                    confirmButtonText: 'Valider',
                    cancelButtonText: 'Annuler',
                    showCancelButton: true,
                    // inputValidator: (value) => {
                    //     // console.log(value)
                    //     if(!value){
                    //         return 'Vous deve!'
                    //     }
                    // },
                })
                if (place) {
                    // Swal.fire(`You selected: ${place}`)
                    console.log(place)
                    const places_split = place.split(',')
                    const date_split = places_split[1]
                    const hd = places_split[2]
                    const hf = places_split[3]
                    const arg = {
                        id_date_heure_disponible_autorite: places_split[0],
                        id_evenement: event.id,
                        type_evenement: event.type_evenement,
                        date_debut: date_split,
                        date_fin: date_split,
                        heure_debut: hd,
                        heure_fin: hf,
                        autorite: this.autorite,
                        sender:{
                            nom: event.nom,
                            prenom: event.prenom,
                            addresse_electronique: event.addresse_electronique,
                        },
                        evenement:{
                            autorite_sender:{
                                intitule: event.intitule_code_sender,
                                intitule_code: event.intitule_sender,
                                addresse_electronique: event.intitule_sender_addresse_electronique,
                            }
                        }
                    }
                    const data = await evenementController.valider(arg).then((result) => {
                        if(result.data){
                            swal("Entretien enregistrée", `${result.data.db.message}`, "success");
                        }
                    }).catch((err) => {
                        console.log(err)
                    });
                }
            },
            async modifierEvenement(event){
                const data = await this.placesMap()
                const key_evenement = `${event.id_date_heure_disponible_autorite},${event.date_debut},${event.heure_debut},${event.heure_fin}`
                if(event.status === 'Validé' || event.status === 'Reporté'){
                    const { value: place } = await Swal.fire({
                        title: 'Modifier évènement',
                        input: 'select',
                        inputOptions: await this.placesMap(),             
                        // inputPlaceholder: 'Choisissez une place disponible',
                        inputValue: data.get(key_evenement),
                        confirmButtonText: 'Valider',
                        cancelButtonText: 'Annuler',
                        showCancelButton: true,
                        inputValidator: (value) => {
                            const value_data = data.get(value)
                            console.log(value_data)
                        },
                    })
                    if (place) {
                    // Swal.fire(`You selected: ${place}`)
                        const places_split = place.split(',')
                        const date_split = places_split[1]
                        const hd = places_split[2]
                        const hf = places_split[3]
                        const arg = {
                            id_date_heure_disponible_autorite: places_split[0],
                            id_evenement: event.id,
                            type_evenement: event.type_evenement,
                            date_debut: date_split,
                            date_fin: date_split,
                            heure_debut: hd,
                            heure_fin: hf,
                            autorite: this.autorite,
                            sender:{
                                nom: event.nom,
                                prenom: event.prenom,
                                addresse_electronique: event.addresse_electronique,
                            },
                            evenement:{
                                autorite_sender:{
                                    intitule: event.intitule_code_sender,
                                    intitule_code: event.intitule_sender,
                                    addresse_electronique: event.intitule_sender_addresse_electronique,
                                }
                            }
                        }

                        const data = await evenementController.revalider(arg).then((result) => {
                            if(result.data){
                                swal("Evènement modifié ", `${result.data.message}`, "success");
                            }
                        }).catch((err) => {
                            console.log(err)
                        });
                    }
                }
            }
        },
    }
</script>

<template>
    <button type="button" v-if="evenement.status === 'Non validé' " @click="ajouterEvenement(evenement)" class="btn btn-success"> 
        <i class="bi bi-check-circle"></i>
    </button>

    <button type="button" v-else @click="modifierEvenement(evenement)" class="btn btn-warning"> 
        <i class="ri-edit-2-line"></i>
    </button> 
    
    <button type="button"  @click="detailEvenement(evenement)" class="btn btn-info"> 
        <i class="bi bi-info-circle"></i>
    </button>
</template>