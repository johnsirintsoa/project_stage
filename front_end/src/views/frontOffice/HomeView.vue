<template>
    <NavBar/> 

    <main id="main">
      <section class="section">
          <div class="row">
              <div class="col-lg-12" >
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

    <FooterFront
      :styleFooter="styleFooter"
    />
</template>

<script>
  import NavBar from '../../components/header/NavBarFront.vue';
  import FooterFront from '../../components/footer/FooterComponent.vue';

  import doleanceImg from '@/assets/img/doleance.png'
  import stageImg from '@/assets/img/stage.png'
  import audienceImg from '@/assets/img/audience.png'
  import AccueilComponent from '../../components/accueil/AccueilComponent.vue'

  export default {
    components: { 
      NavBar,
      FooterFront,
      AccueilComponent
    },
    data() {
      return {
        menu:[
          { 
            id:1,
            linkPath:'/boite-a-doleance',
            imageWidth: '500px',
            image: doleanceImg,
            // image:require("@/assets/img/doleance.png"),
            titre:'Boite à doléance',
            contenu:'Votre visite de courtoisie vous a-t-elle plu? Vous pouvez nous en dire plus si le coeur vous en dit.'
          },
          { 
            id:2,
            linkPath:'/demande-stage',
            imageWidth: '500px',
            image: stageImg,
            // image:require("@/assets/img/stage.png"),
            titre:'Demande de stage',
            contenu:`Vous êtes étudiant, jeune ou adulte, cherchant un stage, le Ministère de l'Economie et des Finances vous ouvre ses portes selon la durée dont vous aurez besoin.`
          },
          { 
            id:3,
            linkPath:'/demande-audience',
            imageWidth: '500px',
            image: audienceImg,
            // image:require("@/assets/img/audience.png"),
            titre:'Demande audience',
            contenu:`Souhaitez vous entretenir avec nos autorités? Vous pouvez posez votre demande selon leurs dates et heures disponibles.`
          }
        ]
      }
    },
    computed:{
      styleColLg6(){
        return {
            position: 'relative',
            width: '740px',
            height: '500px',
            display: 'flex'  
        }
      },
      styleInfosMenu(){
          return {
              // textAlign:'left',
              position: 'absolute',
              // left:'0px',
              // textAlignLast: 'left',
              top: '50%',
              left: '70%',
              transform: 'translate(-50%, -50%)',
              width: '500px',
              height: '300px',
              // backgroundColor: '#ccc',
              // display: 'flex',
              // justifyContent: 'center',
              // alignItems: 'left',
          }
      },
      styleImage(){
          return {
              position: 'absolute',
              top: '50%',
              left: '50%',
              transform: 'translate(-50%, -50%)',
              width: '300px',
              height: '300px',
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
      }
    }
  }
</script>

<style scoped>
  #main{
    margin-left: 0em !important;
    margin-right: 0em !important;
  }
</style>