<script setup>
    import HeaderStructure from '../../components/header/HeaderStructure.vue'
    import Calendrier from '../../components/demande_audience/Calendrier.vue';
</script>

<template>
    <HeaderStructure
        @structure="getStructure"
    />
    <main id="main" class="main">
        <h1>Mes évènements</h1>
        
        <div  class='demo-app' >
            <div class='demo-app-main'>
                <Calendrier
                    :autoriteSender="autorite"
                    typeCalendrier="evenementiel"
                />

            </div>
        </div>
    </main>
</template>

<script>
    export default{
        data() {
            return {
                autorite:{}
            }
        },
        methods: {
            getStructure(value){
                this.autorite = value
            }
        },
    }
</script>