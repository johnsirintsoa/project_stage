<template>
    <footer 
        class="footer" 
        :style="styleFooter"    
    >
        <p :style="styleFooterP"> Copyright &copy;DRH {{year}}</p>
    </footer>    
</template>

<script>
    export default{
        props:{
            styleFooter:{
                default:()=>{}
            },
            styleFooterP:{
                default:()=>{}
            }
        },
        computed:{
            year(){
                return new Date().getFullYear()
            },
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