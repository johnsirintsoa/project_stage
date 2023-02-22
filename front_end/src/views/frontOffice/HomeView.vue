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
                  >
                    <vueper-slide 
                      v-for="(slide, i) in menu"
                      :key="slide.id"
                      :title="slide.titre"
                      :content="slide.contenu"
                      :style="'background-color: ' + ['#f6f9ff', '#f6f9ff'][i % 2]"
                      :duration="4000"
                      >
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
  import 'vueperslides/dist/vueperslides.css'
  export default {
    components: { VueperSlides, VueperSlide },
    data() {
      return {
        // styleCard:{},
        slides: [
          {
            title: 'Slide #1',
            content: 'Slide 1 content.'
          },
          {
            title: 'Slide #2',
            content: 'Slide 2 content.'
          }
        ],
        menu:[
          { 
            id:1,
            icons:'',
            titre:'Boite à doléance',
            enTete:'Higfkgjflgnfgfglkfflbf;glfgfgfgfgkljfgjfhgkfhgflghfgkfgxfdjkfjglkfjgfgjflgfjghfgfgflggdfoproejdgkjfgjdgjdgfog',
            contenu:'fgkfjgkfjgfkgjfglkjfgfg'
          },
          { 
            id:2,
            icons:'',
            titre:'Demande de stage',
            enTete:'Higfkgjflgnfgfglkfflbf;glfgfgfgfgkljfgjfhgkfhgflghfgkfgxfdjkfjglkfjgfgjflgfjghfgfgflggdfoproejdgkjfgjdgjdgfog',
            contenu:'fgkfjgkfjgfkgjfglkjfgfg'
          },
          { 
            id:3,
            icons:'',
            titre:'Demande audience',
            enTete:'Higfkgjflgnfgfglkfflbf;glfgfgfgfgkljfgjfhgkfhgflghfgkfgxfdjkfjglkfjgfgjflgfjghfgfgflggdfoproejdgkjfgjdgjdgfog',
            contenu:'fgkfjgkfjgfkgjfglkjfgfg'
          }
        ]
      }
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

</style>