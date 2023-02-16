<template>
    <div v-if="sipnnerActivated" style="margin-bottom: 1em;">
        <div class="d-flex justify-content-center" >
            <!-- <Spinner/> -->
            <div class="spinner-border" role="status">
            <span class="visually-hidden">Loading...</span>
            </div>
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