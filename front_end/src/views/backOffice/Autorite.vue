<script setup>
    import { RouterLink, RouterView } from 'vue-router'
    // import HelloWorld from './components/HelloWorld.vue'
</script>
<template>
    <main id="main-audience" class="main-audience">
        <div class="autorite-enfant">
            <ul>
                <li v-for="autorite in autorites">
                    <!-- <RouterLink to="/demande-audience/autorite">{{autorite.intitule}}</RouterLink> -->
                    <RouterLink :to="{ name: 'back-demande-audience-id-autorite-enfant', params: { id_autorite_enfant: autorite.id }}">{{autorite.intitule}}</RouterLink>
                </li>
            </ul>
        </div>
    </main>
    <!-- < RouterView/> -->
</template>
<script>
    import AutoriteAPI from '../../api/autorite';
    export default {
        data(){
            return{
                autorites: '',
            }
        },
        async created() {
          const profil = JSON.parse(sessionStorage.getItem('administrateur'));
          console.log(profil)
          this.autorites = await AutoriteAPI.autorite_enfant_autorite(profil.autorite_enfant.id)
          console.log(this.autorites)
        },
        methods:{
            // async autorites_enfants(id_autorite_enfant){
            //     return await AutoriteAPI.autorite_enfant_autorite(id_autorite_enfant)
            // }
        }
    }
</script>
<style lang='css'>
#main-audience{
    margin-top: 60px;
    margin-left: 300px;
    padding: 20px 30px;
    transition: all 0.3s;
}
@media (min-width: 1200px) {

  #main,
  #footer {
    margin-left: 300px;
  }
}
h2 {
  margin: 0;
  font-size: 16px;
}

ul {
  margin: 0;
  padding: 0 0 0 1.5em;
}

li {
  margin: 1.5em 0;
  padding: 0;
}

b { /* used for event dates/times */
  margin-right: 3px;
}

.demo-app {
  display: flex;
  min-height: 100%;
  font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  font-size: 14px;
}

.demo-app-sidebar {
  width: 300px;
  line-height: 1.5;
  background: #eaf9ff;
  border-right: 1px solid #d3e2e8;
}

.demo-app-sidebar-section {
  padding: 2em;
}

.demo-app-main {
  flex-grow: 1;
  padding: 3em;
  z-index: 1;
}

.fc { /* the calendar root */
  /* max-width: 1100px; */
  margin: 0 auto;
}
footer{
  background:#ccc;
  position:fixed;
  bottom:0;
  width:100%;
  padding-top:50px;
  height:50px;
  z-index: 2;
}
#button-add-event {
  float: right;
  margin-top: -3%;
  margin-right: 10px;
}

/* Popup */
.button {
border: none;
color: #FFF;
background: #42b983;
appearance: none;
font: inherit;
font-size: 1.8rem;
padding: .5em 1em;
border-radius: .3em;
cursor: pointer;
}

.modal {
position: absolute;
position: fixed;
top: 0;
right: 0;
bottom: 0;
left: 0;
margin: auto;
text-align: center;
width: fit-content;
height: fit-content;
max-width: 22em;
padding: 2rem;
border-radius: 1rem;
box-shadow: 0 5px 5px rgba(0, 0, 0, 0.2);
background: #FFF;
z-index: 9999;
transform: none;
}
.modal h1 {
margin: 0 0 1rem;
}


/* ---------------------------------- */
.fade-enter-active,
.fade-leave-active {
transition: opacity .4s linear;
}

.fade-enter,
.fade-leave-to {
opacity: 0;
}

.pop-enter-active,
.pop-leave-active {
transition: transform 0.4s cubic-bezier(0.5, 0, 0.5, 1), opacity 0.4s linear;
}

.pop-enter,
.pop-leave-to {
opacity: 0;
transform: scale(0.3) translateY(-50%);
}

</style>