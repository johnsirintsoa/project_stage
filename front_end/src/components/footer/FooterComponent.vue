<template>
    <footer 
        class="footer" 
        :style="{
            'margin-left': numberMarginLeft + 'em'
        }"    
    >
        <p> Copyright &copy;DRH {{year}}</p>
    </footer>    
</template>

<script>
    export default{
        props:['numberMarginLeft'],
        computed:{
            year(){
                return new Date().getFullYear()
            }
        }
    }

</script>

<style>
    /* #footer {
        margin-left: 6px !important;
    }
    footer p{
        text-align: center;
    } */
</style>