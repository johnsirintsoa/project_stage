<script>
    import DoleanceApi from '../../api/doleance'
    export default {
        props: {
            date1: String,
            date2: String,
            type_doleance: String,
            nbr_filtre: String,
            autorite:Object
        },
        emits: [
            'update:date1',
            'update:date2',
            'update:type_doleance',
            'update:nbr_filtre',
            'update:autorite',
            'rechercherDoleance'
        ],
        watch:{
            async date1(newValue){
                const newDate1 = newValue
                const filtre = {
                    date1: newDate1,
                    date2: this.date2,
                    type_doleance: this.type_doleance,
                    nbr_filtre: this.nbr_filtre,
                    id_autorite: this.autorite.child_id
                }
                this.$emit("rechercherDoleance",await DoleanceApi.filtre(filtre))
            },
            async date2(newValue){
                const newDate2 = newValue
                const filtre = {
                    date1: this.date1,
                    date2: newDate2,
                    type_doleance: this.type_doleance,
                    nbr_filtre: this.nbr_filtre,
                    id_autorite: this.autorite.child_id
                }
                this.$emit("rechercherDoleance",await DoleanceApi.filtre(filtre))
            },
            async type_doleance(newValue){
                const filtre = {
                    date1: this.date1,
                    date2: this.date2,
                    type_doleance: newValue,
                    nbr_filtre: this.nbr_filtre,
                    id_autorite: this.autorite.child_id
                }
                this.$emit("rechercherDoleance",await DoleanceApi.filtre(filtre)) 
            },
            async nbr_filtre(newValue){
                const newNbr = newValue
                const filtre = {
                    date1: this.date1,
                    date2: this.date2,
                    type_doleance: this.type_doleance,
                    nbr_filtre: newNbr  ,
                    id_autorite: this.autorite.child_id
                }
                this.$emit("rechercherDoleance",await DoleanceApi.filtre(filtre)) 
            }

        },
        methods: {
            async rechercher(){
                const filtre = {
                    date1: this.date1,
                    date2: this.date2,
                    type_doleance: this.type_doleance,
                    nbr_filtre: this.nbr_filtre,
                    id_autorite: this.autorite.child_id
                }
                console.log(filtre)
                this.$emit("rechercherDoleance",await DoleanceApi.filtre(filtre))
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
            <select class="form-select" id="type_doleance" :value="type_doleance" @input="$emit('update:type_doleance', $event.target.value)">
                <option value="2">Tout</option>
                <option value="1">Anonyme</option>
                <option value="0">Non anonyme</option>
            </select>
        </div>
        <div class="col-md-3">
            <select class="form-select" id="domaine" :value="nbr_filtre" @input="$emit('update:nbr_filtre', $event.target.value)" >
                <option value="0" > Tout</option>
                <option value="5" > 5</option>
                <option value="10" > 10</option>
                <option value="20" > 20</option>
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