<!-- <script setup>
    import HeaderNavbar from '../../components/header/HeaderStructure.vue'
    import FooterComponent from '../../components/footer/FooterComponent.vue'
</script> -->
    
<template>
    <HeaderNavbar
        @structure="getStructure"
    />
    
    <main id="main" class="main">
        <h1>Bienvenue Back and middle</h1>
    </main>

    <FooterComponent 
        numberMarginLeft="15"
    />
</template>

<script>
    import HeaderNavbar from '../../components/header/HeaderStructure.vue'
    import FooterComponent from '../../components/footer/FooterComponent.vue'

    export default{
        components:{
            HeaderNavbar,
            FooterComponent
        },
        methods: {

            getStructure(value){
                console.log(value)
            }
            
        },
        // created() {
        //     this.count++
        //     if(this.count == 1){
                // setInterval( () => {
                //     window.location.reload()
                // }, 100)
        //         this.count = 0
        //     }

        // },
        // beforeCreate() {
        //     // setInterval( () => {
        //     //     window.location.reload()
        //     // }, 100)
        // },
    }
</script>
    