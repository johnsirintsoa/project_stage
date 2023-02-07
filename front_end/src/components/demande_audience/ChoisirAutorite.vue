<script setup>
    import structure from '../tStructureComponent/TstructurePublic.vue';
</script>

<template>       
    <structure
        @getAutoriteClicked="getAutorite"
    /> 
</template>

<script>
    import AutoriteApi from '../../api/autorite'
    import { actual_events_public } from '../../controllers/FrontOffice/DemandeAudience'
    
    export default {
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

            async getAutorite(value){
                this.autorite = value.child_id 
            }
        },
        emits:[
            'events',
            'autorite'
        ],

        watch:{
            autorite: async function (aut) {

                this.$emit('events', await actual_events_public(aut.id))
                this.$emit('autorite', aut)

            }
        },

        async created() {
            this.autorites = await this.listAutorites()
        },
    }
</script>