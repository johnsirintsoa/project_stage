<template>        
    <div class="row mb-3">
        <!-- <label class="col-sm-1 col-form-label">Autorité:</label> -->
        <div class="col-sm-12  ">
          <select class="form-select" v-model="autorite" >
            <option selected="" value="" disabled>Choisir autorité</option>
            <option v-for="a in autorites" :key="a.id" :value="a" >
                {{a.intitule}}
            </option>
          </select>
        </div>
      </div>
</template>

<script>
    import AutoriteApi from '../../api/autorite'
    import { actual_events_public } from '../../controllers/FrontOffice/DemandeAudience'
    
    export default {
        // props: {
        //     interfaceUtilisateur:{
        //         type:String,
        //         required: true
        //     }
        // },
        data() {
            return {
                autorite: '',
                autorites:[]
            }
        },
        methods: {
            async listAutorites(){
                return await AutoriteApi.liste()
            },
            // Liste des disponibiltes a afficher
            // async actualEvents(autorite){
            //     // console.log(autorite)
            //     if(this.interfaceUtilisateur === 'Public'){
            //         this.$emit('events', await actual_events_public(autorite.id))   
            //     }
            // }
        },

        watch:{
            autorite: async function (aut) {
                console.log()
                // actualEvents(value)
                
                this.$emit('events', await actual_events_public(aut.id))
                this.$emit('autorite', aut)

                // if(this.interfaceUtilisateur === 'Public'){
                    
                // }
            }
        },

        async created() {
            this.autorites = await this.listAutorites()
        },
    }
</script>