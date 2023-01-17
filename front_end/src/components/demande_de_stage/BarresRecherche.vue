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
            prenom: String,
            domaine: String,
            autorite: Object
        },
        emits: [
            'update:date1',
            'update:date2',
            'update:nom',
            'update:prenom',
            'update:domaine',
            'update:autorite'
        ],
        async created() {
            this.domaines = await DomaineApi.allDomaine()
        },
        methods: {
            async rechercher(e){
                const ses = JSON.parse(sessionStorage.getItem('administrateur'))
                // this.autorite = ses
                const filtre = {
                    date1: this.date1,
                    date2: this.date2,
                    nom: this.nom,
                    prenom: this.prenom,
                    id_domaine: this.domaine,
                    id_autorite_enfant: this.autorite.id_autorite_enfant
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
                :value="date1"
                @input="$emit('update:date1', $event.target.value)"
            />   
        </div>

        <div class="col-md-2">
            <input
                type="date"
                :value="date2"
                @input="$emit('update:date2', $event.target.value)"
            />  
        </div>

        
        <div class="col-md-3">
            <input
                placeholder="Votre nom"
                type="text"
                :value="nom"
                @input="$emit('update:nom', $event.target.value)"
            />   
        </div>


        <div class="col-md-3">
            <input
                placeholder="Votre prénom"
                type="text"
                :value="prenom"
                @input="$emit('update:prenom', $event.target.value)"
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


