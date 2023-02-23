<script setup>
    import NavBar from '../../components/header/NavBarFront.vue';
    import FooterBack from '../../components/footer/FooterComponent.vue';
</script>
<template>
    <NavBar/> 

    <main id="main">
        <section class="section">
            <div class="row">
              
                <!-- <div class="col-lg-12">

                    <div class="card">
                      <div class="card-body">
                        <h5 class="card-title">Default Accordion</h5>
          
                        <div class="accordion" id="accordionExample">
                          <div class="accordion-item">
                            <h2 class="accordion-header" id="headingOne">
                              <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                Accordion Item #1
                              </button>
                            </h2>
                            <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                              <div class="accordion-body">
                                <strong>This is the first item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
                              </div>
                            </div>
                          </div>
                          <div class="accordion-item">
                            <h2 class="accordion-header" id="headingTwo">
                              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                Accordion Item #2
                              </button>
                            </h2>
                            <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                              <div class="accordion-body">
                                <strong>This is the second item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
                              </div>
                            </div>
                          </div>
                          <div class="accordion-item">
                            <h2 class="accordion-header" id="headingThree">
                              <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                Accordion Item #3
                              </button>
                            </h2>
                            <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                              <div class="accordion-body">
                                <strong>This is the third item's accordion body.</strong> It is hidden by default, until the collapse plugin adds the appropriate classes that we use to style each element. These classes control the overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of this with custom CSS or overriding our default variables. It's also worth noting that just about any HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
          class="no-shadow" arrows-outside bullets-outside
                </div> -->
                <div class="col-lg-12">
                  <vueper-slides  
                    class="no-shadow"
                    :autoplay="true" 
                    :infinite="true"
                    bullets-outside :dragging-distance="50"
                  >
                    <vueper-slide 
                      :duration="4000"
                      v-for="(slide, i) in menu"
                      :style="'background-color: ' + ['#f6f9ff', '#f6f9ff'][i % 2]"
                    >
                      <template #content>
                        <section class="section">
                          <div class="row">
                           
                            <div class="col-lg-6">
                              <div 
                                class="infos-menu"
                                :style="styleInfosMenu"
                              > 
                                <h1>{{slide.titre}}</h1>
                                <p :style="styleParagraph"
                                >
                                  {{slide.contenu}}
                                </p>
                                <div class="wrap">
                                  <router-link :to="{ path: slide.linkPath }">
                                    <button  class="button">
                                      <VueWriter 
                                      :array="['Voir plus']" 
                                      :typeSpeed="50"
                                    />
  
                                    </button>
                                  </router-link>

                                </div>
                              </div>
                            </div>
                    
                            <div class="col-lg-6">
                              
                              <div class="img-menu" :style="styleImage">
                                <!-- <img 
                                  :src="`/assets/img/${slide.image}`"    
                                  style="width: 500px;"
                                > -->
                                <img 
                                src="../../assets/img/doleance.png"    
                                style="width: 500px;"
                              >
                                <!-- {{slide.image}} -->
                                <!-- {{slide.contenu}} -->
                              </div> 
                            </div>
                    
                          </div>
                        </section>
                      </template>
                    </vueper-slide>
                  </vueper-slides>
                </div>
            </div>
        </section>
    </main>

    <FooterBack/>
</template>

<script>
  import { VueperSlides, VueperSlide } from 'vueperslides'
  import VueWriter from "vue-writer";
  import 'vueperslides/dist/vueperslides.css'
  export default {
    components: { VueperSlides, VueperSlide },
    data() {
      return {
        menu:[
          { 
            id:1,
            linkPath:'/boite-a-doleance',
            image:'doleance.png',
            titre:'Boite à doléance',
            contenu:'Votre visite de courtoisie vous a-t-elle plu? Vous pouvez nous en dire plus si le coeur vous en dit.'
          },
          { 
            id:2,
            linkPath:'/demande-stage',
            image:'stage.png',
            titre:'Demande de stage',
            contenu:`Vous êtes étudiant, jeune ou adulte, cherchant un stage, le Ministère de l'Economie et des Finances vous ouvre ses portes selon la durée dont vous aurez besoin.`
          },
          { 
            id:3,
            linkPath:'/demande-audience',
            image:'audience.png',
            titre:'Demande audience',
            contenu:`Souhaitez vous entretenir avec nos autorités? Vous pouvez posez votre demande selon leurs dates et heures disponibles.`
          }
        ]
      }
    },
    computed:{
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
      styleParagraph(){
        return {
          fontFamily: '"Source Sans Pro", sans-seri',
          fontSize:'20px'
        }
      },
    },
  }
</script>

<style scoped>
  #main{
      
      /* margin-top: 0px !important; */
      margin-left: 0em !important;
      margin-right: 0em !important;
  }
  .ex--center-mode {
    width: 600px;
    max-width: 100%;
    margin: auto;
  }
  .col-lg-6{
    position: relative;
    width: 740px;
    height: 500px;
    display: flex;
    /* justify-content: center; */
  }
 
.wrap {
  height: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.button {
  min-width:200px;
  min-height: 60px;
  font-family: 'Nunito', sans-serif;
  font-size: 22px;
  text-transform: uppercase;
  letter-spacing: 1.3px;
  font-weight: 700;
  color: #f7f7f9;
  /* color: #313133; */

  /* background: #4FD1C5; */
  background: #4f7ad1;

background: linear-gradient(90deg, rgb(129, 176, 230) 0%, rgb(79, 112, 209) 100%);
  border: none;
  border-radius: 1000px;
  box-shadow: 12px 12px 24px rgba(79, 101, 209, 0.64);
  transition: all 0.3s ease-in-out 0s;
  cursor: pointer;
  outline: none;
  position: relative;
  padding: 10px;
  }

button::before {
content: '';
  border-radius: 1000px;
  min-width: calc(200px + 12px);
  min-height: calc(60px + 12px);
  /* border: 6px solid #007bff; */
  border: 6px solid #85bdf9;

  box-shadow: 0 0 60px rgba(126, 182, 247, 0.64);
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  opacity: 0;
  transition: all .3s ease-in-out 0s;
}

.button:hover, .button:focus {
  color: #f9f9fc;
  transform: translateY(-6px);
}

button:hover::before, button:focus::before {
  opacity: 1;
}

button::after {
  content: '';
  width: 30px; height: 30px;
  border-radius: 100%;
  border: 6px solid #0077ff;
  position: absolute;
  z-index: -1;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  animation: ring 1.5s infinite;
}

button:hover::after, button:focus::after {
  animation: none;
  display: none;
}

@keyframes ring {
  0% {
    width: 30px;
    height: 30px;
    opacity: 1;
  }
  100% {
    width: 300px;
    height: 300px;
    opacity: 0;
  }
}

</style>