<script setup>
    import ModfierAnonyme from './DoleanceModifierAnonyme.vue'
    import ModifierNonAnonyme from './DoleanceModifierNonAnonyme.vue'
</script>

<script>
    export default{
        props:{
            doleance:Object
        },
        // component:{
        //     ModfierAnonyme,
        //     ModifierNonAnonyme
        // },
        // emit:['update:showPopup'],
        // methods: {
        //     setShowPopup(event){
        //         this.$emit('update:showPopup', event.target.value)
        //     }
        // },
        // created() {
        //     if(this.doleance.type_doleance === 'Anonyme'){
        //         this.currentDoleance = 'ModfierAnonyme'
        //     }
        //     else if (this.doleance.type_doleance === 'Non anonyme'){
        //         this.currentDoleance = 'ModifierNonAnonyme'
        //     }
        // },
        // watch:{
        //     currentDoleance(value){
        //         this.currentDoleance = value
        //     }
        // }
    }
</script>

<template>
    <!-- 
        Anonyme:
            * doleance type anonyme
            * titre,messnom, prenom, cin,
     -->
    <div v-if="doleance.type_doleance === 'Anonyme'">
        <ModfierAnonyme
            :doleance="doleance"
        />
    </div>
    <div v-else-if="doleance.type_doleance === 'Non anonyme'">
        <ModifierNonAnonyme/>
    </div>
</template>



