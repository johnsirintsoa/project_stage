<script>
    import DomaineApi from '../../api/domaine';
    import emailjs from 'emailjs-com';
    import StageController from '../../controllers/StageController'

    export default {
        data() {
            return {
                domaines:''
            }
        },
        props: {
            date1: String,
            date2: String,
            nom: String,
            etablissement: String,
            domaine: String,
            autorite: Object
        },
        emits: [
            'update:date1',
            'update:date2',
            'update:nom',
            'update:etablissement',
            'update:domaine',
            'update:autorite',
            'rechercherStages'
        ],
        async created() {
            this.domaines = await DomaineApi.allDomaine()
        },

        watch:{
            async date1(newValue){
                const newDate1 = newValue
                const filtre = {
                    date1: newDate1,
                    date2: this.date2,
                    nom: this.nom,
                    etablissement: this.etablissement,
                    id_domaine: this.domaine,
                    id_autorite: this.autorite.child_id
                }
                this.$emit("rechercherStages",await StageController.filtre(filtre))
            },
            async date2(newValue){
                const newDate2 = newValue
                const filtre = {
                    date1: this.date1,
                    date2: newDate2,
                    nom: this.nom,
                    etablissement: this.etablissement,
                    id_domaine: this.domaine,
                    id_autorite: this.autorite.child_id
                }
                this.$emit("rechercherStages",await StageController.filtre(filtre))
            },
            async nom(newValue){
                const newNom = newValue
                const filtre = {
                    date1: this.date1,
                    date2: this.date2,
                    nom: newNom,
                    etablissement: this.etablissement,
                    id_domaine: this.domaine,
                    id_autorite: this.autorite.child_id
                }
                this.$emit("rechercherStages",await StageController.filtre(filtre))
            },
            async etablissement(newValue){
                const newEtablissement = newValue
                const filtre = {
                    date1: this.date1,
                    date2: this.date2,
                    nom: this.nom,
                    etablissement: newEtablissement,
                    id_domaine: this.domaine,
                    id_autorite: this.autorite.child_id
                }
                this.$emit("rechercherStages",await StageController.filtre(filtre))
            },
            async domaine(newValue){
                const newDomaine = newValue
                // console.log(this.autorite)
                const filtre = {
                    date1: this.date1,
                    date2: this.date2,
                    nom: this.nom,
                    etablissement: this.etablissement,
                    id_domaine: newDomaine,
                    id_autorite: this.autorite.child_id
                }
                this.$emit("rechercherStages",await StageController.filtre(filtre))
            }

        },

        methods: {
            async rechercher(e){
                const ses = JSON.parse(sessionStorage.getItem('structure'))
                // this.autorite = ses
                const filtre = {
                    date1: this.date1,
                    date2: this.date2,
                    nom: this.nom,
                    etablissement: this.etablissement,
                    id_domaine: this.domaine,
                    id_autorite: ses.child_id
                }
                // this.stages = await StageController.filtre(filtre) 
                this.$emit("rechercherStages",await StageController.filtre(filtre))
            }
        },
        
    }
    
</script>

<template>

    <div class="row mb-3">

        <div class="col-md-2">
            <input
                type="date"
                class="form-control"
                :value="date1"
                @input="$emit('update:date1', $event.target.value)"
            />   
        </div>

        <div class="col-md-2">
            <input
                type="date"
                class="form-control"
                :value="date2"
                @input="$emit('update:date2', $event.target.value)"
            />  
        </div>

        
        <div class="col-md-2">
            <input
                class="form-control"
                placeholder="Nom ou prénom" 
                type="text"
                :value="nom"
                @input="$emit('update:nom', $event.target.value)"
            />   
        </div>


        <div class="col-md-2">
            <input
                class="form-control"
                placeholder="Etablissement"
                type="text"
                :value="etablissement"
                @input="$emit('update:etablissement', $event.target.value)"
            /> 
        </div>
        
 
        <div class="col-md-2">
            <select class="form-select" id="domaine" name="domaine" :value="domaine" @input="$emit('update:domaine', $event.target.value)" aria-label="Default select example" required="">
                <option selected disabled value="">Domaine</option>
                <option v-for="d in domaines"  :value="d.id" > {{d.nom_domaine}}</option>
            </select>
        </div>

        <div class="col-md-2">
            <button 
                type="button"
                class="btn btn-primary" 
                @click="rechercher" 
                style="background-color: #012970;"  
            >
                Rechercher
            </button>
        </div>

    </div>
      
</template>