
<script>
    import AutoriteController from '../../controllers/AutoriteController'
    export default{
        props: {
            date_debut: String,
            date_fin: String,
            type_evenement: String,
            status: String,
            autorite: Object
        },
        emits: [
            'update:date_debut',
            'update:date_fin',
            'update:type_evenement',
            'update:status',
            'update:autorite'
        ],
        methods: {
            async rechercher(){
                this.arg = {
                    date_debut: this.date_debut,
                    date_fin: this.date_fin,
                    type_evenement: this.type_evenement,
                    status: this.status,
                    autorite:this.autorite
                }
                const data = await AutoriteController.filtre_calendrier(this.arg)
                this.$emit("dataRechercher", data);
            }
        },
    }
</script>

<template>

    <div class="row mb-1">

        <div class="col-md-2">
            <input
                type="date"
                :value="date_debut"
                @input="$emit('update:date_debut', $event.target.value)"
            />   
        </div>

        <div class="col-md-2">
            <input
                type="date"
                :value="date_fin"
                @input="$emit('update:date_fin', $event.target.value)"
            />  
        </div>

        
        <div class="col-md-3">
            <select class="form-select"  :value="type_evenement" @input="$emit('update:type_evenement', $event.target.value)" aria-label="Default select example" required="">
                <option selected disabled value="">Type</option>
                <option value="Entretien" > Entretien</option>
                <option value="Public" > Public</option>
                <option value="Autorité" > Autorité</option>

            </select> 
        </div>        
 
        <div class="col-md-3">
            <select class="form-select" :value="status" @input="$emit('update:status', $event.target.value)" aria-label="Default select example" required="">
                <option selected disabled value="">Status</option>
                <option value="0" > Non validé</option>
                <option value="1" > Validé</option>
                <option value="2" > Reporté</option>
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