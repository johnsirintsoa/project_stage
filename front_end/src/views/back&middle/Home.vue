<script setup>
    import HeaderNavbar from '../../components/header/HeaderStructure.vue'
    import FooterComponent from '../../components/footer/FooterFront.vue'
</script>
    
<template>
    <HeaderNavbar
        @structure="getStructure"
    />
    
    <main id="main" class="main">
        <h1>Bienvenue Back and middle</h1>
    </main>

    <FooterComponent />
</template>

<script>
    export default{
        methods: {

            getStructure(value){
                console.log(value)
            }
            
        },
    }
</script>
    