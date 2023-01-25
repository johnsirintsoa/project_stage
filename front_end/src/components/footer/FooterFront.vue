<template>
    <footer id="footer" class="footer">
        <p>Copyright &copy;{{year}}</p>
    </footer>    
</template>
<script>
    export default{
        computed:{
            year(){
                return new Date().getFullYear()
            }
        }
    }

</script>
<style>
    #footer {
        margin-left: 6px !important;
    }
    footer p{
        text-align: center;
    }
</style>