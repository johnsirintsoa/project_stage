<template>
    <VueperSlides  
    class="no-shadow"
    :autoplay="true" 
    :infinite="true"
    bullets-outside :dragging-distance="50"
    fixed-height="500px"
    >
        <VueperSlide 
        :duration="4000"
        v-for="(slide, i) in menu"
        :style="'background-color: ' + ['#f6f9ff', '#f6f9ff'][i % 2]"
        >
        <template #content>
            <section class="section">

                <div class="row">
                    <div class="col-lg-6" :style="styleColLg6">
                        <div 
                            class="infos-menu"
                            :style="styleInfosMenu"
                        > 
                            <h1>{{slide.titre}}</h1>
                            <p :style="styleParagraph">
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
        
                    <div class="col-lg-6" :style="styleColLg6">
                        <div class="img-menu" :style="styleImage">
                            <img :src="slide.image" :style="{width: slide.imageWidth}" :key="i">
                        </div> 
                    </div>
                </div>

            </section>
        </template>
        </VueperSlide>
    </VueperSlides>    
</template>

<script>
    import { VueperSlides, VueperSlide } from 'vueperslides'
    import VueWriter from "vue-writer";
    import 'vueperslides/dist/vueperslides.css'
  
    export default {
        props:{
            menu:{
                type: Array,
                required: true
            },
            styleColLg6:{
                default:()=>{}
            },
            styleInfosMenu:{
                default:()=>{}
            },
            styleImage:{
                default:()=>{}
            },
            styleVueSlider:{
                default:()=>{}
            }
        },
        
        
        components: { 
            VueperSlides,
            VueperSlide,
            VueWriter
        },

        computed:{
            // styleInfosMenu(){
            //     return {
            //         // textAlign:'left',
            //         position: 'absolute',
            //         // left:'0px',
            //         // textAlignLast: 'left',
            //         top: '50%',
            //         left: '70%',
            //         transform: 'translate(-50%, -50%)',
            //         width: '500px',
            //         height: '300px',
            //         // backgroundColor: '#ccc',
            //         // display: 'flex',
            //         // justifyContent: 'center',
            //         // alignItems: 'left',
            //     }
            // },
            // styleImage(){
            //     return {
            //         position: 'absolute',
            //         top: '50%',
            //         left: '50%',
            //         transform: 'translate(-50%, -50%)',
            //         width: '300px',
            //         height: '300px',
            //         // backgroundColor: '#ccc',
            //         display: 'flex',
            //         justifyContent: 'center',
            //         alignItems: 'center'
            //     }
            // },

            styleParagraph(){
                return {
                    fontFamily: '"Source Sans Pro", sans-seri',
                    fontSize:'20px'
                }
            },
            // styleColLg6(){
            //     return {
            //         position: 'relative',
            //         width: '740px',
            //         height: '500px',
            //         display: 'flex'  
            //     }
            // }
        },
    }
</script>

<style scoped>
    .ex--center-mode {
        width: 600px;
        max-width: 100%;
        /* height: 100%; */
        /* max-height: 100%; */
        margin: auto;
    }
    /* .col-lg-6{
        position: relative;
        width: 740px;
        height: 500px;
        display: flex;
    } */
    
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