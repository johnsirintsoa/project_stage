<script setup>
    import AnonymusForm from '../../components/boite_a_doleance/FormulaireAnonyme.vue'
    import NonAnonymusForm from '../../components/boite_a_doleance/FormulaireNonAnonyme.vue'
</script>

<template>
    <div class="type-doleance" style="padding-top: 10px">
        <label><input type="radio" v-model="currentForm" value="AnonymusForm" /> Anonyme</label>
        <label><input type="radio" v-model="currentForm" value="NonAnonymusForm" style="margin-left: 20px;"/> Non anonyme</label>
    </div>
    
    <KeepAlive>
        <component :is="currentForm"></component>
    </KeepAlive>    
</template>

<script>
    export default {
        components:{
            AnonymusForm,
            NonAnonymusForm
        },
        data() {
            return {
                currentForm: 'NonAnonymusForm'
            }
        },
    }
</script>

<style>
    input [type=radio]{
        padding-left: 2px ;
    }
</style>