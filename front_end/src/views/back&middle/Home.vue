
<template>
    <HeaderNavbar
        @structure="getStructure"
    />
    
    <main id="main">
        <section class="section">
            <div class="row">
                <div class="col-lg-12">
                  <AccueilComponent
                    :menu="menu"
                    :styleColLg6="styleColLg6"
                    :styleInfosMenu="styleInfosMenu"
                    :styleImage="styleImage"
                  />
                </div>
            </div>
        </section>
      </main>

    <FooterComponent 
        :styleFooter="styleFooter"
        :styleFooterP="styleFooterP"
    />
</template>

<script>
    import HeaderNavbar from '../../components/header/HeaderStructure.vue'
    import FooterComponent from '../../components/footer/FooterComponent.vue'
    import AccueilComponent from '../../components/accueil/AccueilComponent.vue'

    import doleanceImg from '@/assets/img/doleance.png'
    import stageImg from '@/assets/img/entretien_back.png'
    import audienceImg from '@/assets/img/audience_back.png'
    import calendrierImg from '@/assets/img/calendrier_back.png'


    export default{
        components:{
            HeaderNavbar,
            FooterComponent,
            AccueilComponent
        },

        data() {
            return {
                menu:[
                    { 
                        id:1,
                        linkPath:'/back-office/boite-a-doleance',
                        imageWidth: '500px',
                        image: doleanceImg,
                        // image:require("@/assets/img/doleance.png"),
                        titre:'Boite à doléance',
                        contenu:'Votre visite de courtoisie vous a-t-elle plu? Vous pouvez nous en dire plus si le coeur vous en dit.'
                    },
                    { 
                        id:2,
                        linkPath:'/back-office/demande-stage',
                        imageWidth: '500px',
                        image: stageImg,
                        // image:require("@/assets/img/stage.png"),
                        titre:'Demande de stage',
                        contenu:`Vous verrez ici tous les demandes de stages. Vous pouvez filtrer, valider, reporter une demande de stage et s'entretenir avec le stagiaire souhaité.`
                    },
                    { 
                        id:3,
                        linkPath:'/back-office/demande-audience',
                        imageWidth: '500px',
                        image: audienceImg,
                        // image:require("@/assets/img/audience.png"),
                        titre:`Demande d'audience`,
                        contenu:`Souhaitez-vous vous entretenir avec nos autorités? Vous pouvez posez votre demande selon leurs dates et heures de disponibilités.`
                    },
                    { 
                        id:4,
                        linkPath:'/back-office/calendrier-evenementiel',
                        imageWidth: '500px',
                        image: calendrierImg,
                        // image:require("@/assets/img/audience.png"),
                        titre:'Mes évènements',
                        contenu:`Un interface requis pour chaque autorité. Ici, vous pouvez gérer vos évenements en cours et vos disponibilités selon vos occupations au sein de l'organisation.`
                    }
                ]
            }
        },

        computed:{
            styleColLg6(){
                return {
                    position: 'relative',
                    width: '500px',
                    height: '300px',
                    display: 'flex'  
                }
            },
            styleInfosMenu(){
                return {
                    // textAlign:'left',
                    position: 'absolute',
                    // left:'0px',
                    // textAlignLast: 'left',
                    top: '70%',
                    left: '50%',
                    transform: 'translate(-50%, -50%)',
                    width: '400px',
                    height: '200px',
                    // backgroundColor: '#ccc',
                    // display: 'flex',
                    // justifyContent: 'center',
                    // alignItems: 'left',
                }
            },
            styleImage(){
                return {
                    position: 'absolute',
                    top: '70%',
                    left: '70%',
                    transform: 'translate(-50%, -50%)',
                    width: '300px',
                    height: '200px',
                    // backgroundColor: '#ccc',
                    display: 'flex',
                    justifyContent: 'center',
                    alignItems: 'center'
                }
            },
            styleFooter(){
                return {
                    position: 'fixed',
                    bottom: '0',
                    width: '100%'
                }
            },
            styleFooterP(){
                return {
                    marginLeft: '21em'
                }
            },

        },

        methods: {

            getStructure(value){
                console.log(value)
            }
            
        },
    }
</script>

<style lang='css'>
    @import url('./css/style.css');
</style>
