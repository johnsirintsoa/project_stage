<template>
    <headerComponent @structure="getStructure"/> 

    <main id="main" class="main">
        <div class="tableau-bord">
            <section class="section">
                <h1>Tableau de bord</h1>
                <div class="row">
                    <nav>
                        <ol class="breadcrumb">
                          <li class="breadcrumb-item"><a href="">Tableau de bord</a></li>
                          <li class="breadcrumb-item active">dahsboard  </li>
                        </ol>
                    </nav>
                    <Chart 
                        :autorite="autorite"
                    />
                </div>
            </section>
        </div>
    </main>

    <footerComponent :styleFooterP="styleFooterP" />
</template>

<script>
    import headerComponent from '../../components/header/HeaderStructure.vue'
    import footerComponent from '../../components/footer/FooterComponent.vue'
    import Chart from '../../components/dashboard/chart.component.vue' 
    
    export default {
        components: {
            headerComponent,
            footerComponent,
            Chart
        },
        data() {
            return {
                autorite:{}
            }
        },
        methods: {
            getStructure(value){
                // console.log(value)
                this.autorite = value
            }  
        },

        computed:{
            styleFooterP(){
                return {
                    marginLeft: '21em'
                }
            }
        },
    }
</script>
<style lang='css'>
    @import url('./css/style.css');
</style>