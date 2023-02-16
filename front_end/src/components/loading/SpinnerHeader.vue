<template>
    
    <div v-if="sipnnerActivated === true">
        <div class="spinner-border text-secondary" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>  
    </div>
  
</template>

<script>
export default {
    props:{
        sipnnerActivated:{
            type: Boolean
        }
    }
}
</script>