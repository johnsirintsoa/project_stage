<template>

    <header id="header" class="header fixed-top d-flex align-items-center">

      <div class="d-flex align-items-center justify-content-between">
        <RouterLink :to="{name: 'home-front'}" class="logo d-flex align-items-center" >
          <img src="/Icon-RohiAudience-png.png" alt="">
          <span class="d-none d-lg-block">RohiAudience</span>
        </RouterLink>
          
        <SpinnerHeader
          :sipnnerActivated="sipnnerActivated"
        />
      </div>

      <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">

          <li class="nav-item d-block d-lg-none">
            <a class="nav-link nav-icon search-bar-toggle " href="#">
              <i class="bi bi-search"></i>
            </a>
          </li>

          <li class="nav-item dropdown pe-3">

            <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
              <!-- <img src="../../assets/img/profile-img.jpg" alt="Profile" class="rounded-circle"> -->
              <div class="icon">
                <!-- <i class="ri-user-6-fill"></i> -->
                <i style="font-size: 28px;" class="bx bx-user-circle"></i>
                
                <!-- <div class="label">ri-user-6-fill</div> -->
              </div>
              <span class="d-none d-md-block dropdown-toggle ps-2">{{autorite.sigle}}</span>
            </a>

            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
              <li class="dropdown-header">
                <h6>{{autorite.sigle}}</h6>
                <span>{{autorite.child_libelle}}</span>
              </li>
              
              <li>
                <a class="dropdown-item d-flex align-items-center" @click="deconnection()">
                  <i class="bi bi-box-arrow-right"></i>
                  <span class="se-deconnecter">Se déconnecter</span>
                </a>
              </li>

            </ul>
          </li>
          
        </ul>
      </nav>

    </header>

    <aside id="sidebar" class="sidebar">

      <ul class="sidebar-nav" id="sidebar-nav">
        <li class="nav-heading">Pages</li>

        <li class="nav-item">
          <RouterLink to="/back-office/" class="nav-link collapsed">
            <i class="bi bi-house"></i>
            <span>Accueil</span>
          </RouterLink>
        </li>

        <li class="nav-item">
          <RouterLink to="/back-office/tableau-bord" class="nav-link collapsed">
            <i class="bi bi-grid"></i>
            <span>Tableau de bord</span>
          </RouterLink>
        </li>

        <li class="nav-item" >
          <RouterLink to="/back-office/boite-a-doleance" class="nav-link collapsed" >
            <i class="bi bi-file-earmark-text"></i>
            <span>Boîte à doléance</span>
          </RouterLink>
        </li>

        <li class="nav-item">
          <RouterLink to="/back-office/demande-stage"  class="nav-link collapsed">
            <i class="bi bi-envelope"></i>
            <span>Demande de stage</span>
          </RouterLink>
        </li>

        <li class="nav-item">
          <RouterLink to='/back-office/demande-audience' class="nav-link collapsed">
            <i class="bi bi-people"></i><span>Demande d'audience</span>
          </RouterLink>
        </li>

        <li class="nav-item">
          <RouterLink to='/back-office/calendrier-evenementiel' class="nav-link collapsed" >
            <i class="bi bi-calendar3-range"></i>
            <span>Mon calendrier</span>
          </RouterLink>
        </li>


        <div v-if="isMyCalendarClicked">
          <div class="switch-panel">
            <label class="switch">
              <input type="checkbox" @click="toggleCheckbox" >
              <div class="slider round"></div>
            </label>
            
            <div class="textCheckBox" v-if="checkbox">
              <!-- <p>Événements en cours</p> -->
              <p>Afficher tous les évènements</p>
  
            </div>
            <div class="textCheckBox" v-else>
              <p>Afficher les évènements en cours</p>
              <!-- <p>Tous les évènements</p> -->
  
            </div>
          </div>
        </div>





      </ul>

    </aside>

    <RouterView />
    
</template>

<script>
    import { RouterLink, RouterView } from 'vue-router'
    import SpinnerHeader from '../loading/SpinnerHeader.vue'
    import ColorInfos from '../instruction/ColorInformation.vue'
    import autoriteApi from '../../api/autorite'
    export default {
        components:{
          RouterLink,
          RouterView,
          SpinnerHeader,
          ColorInfos
        },
        props:{
          sipnnerActivated:{
            type:Boolean
          },
        },
        data() {
          return {
            autorite:'',
            isMyCalendarClicked:false,
            checkbox:true
          }
        },
        emits:[
          'structure',
          'setCheckbox'
        ],

        async created() {
          // await autoriteApi.hello({})
          if(this.$route.name === 'back-office-calendrier-evenementiel'){
            this.isMyCalendarClicked = true
          }

          const ses_admin = JSON.parse(localStorage.getItem('autorite'))
          // const ses_admin = JSON.parse(sessionStorage.getItem('structure'))
          if(ses_admin != null){
              // this.autorite = JSON.parse(sessionStorage.getItem('structure'))
              this.autorite = ses_admin.db
              this.$emit('structure', this.autorite)
              // setInterval( () => {
              //   window.location.reload()
              // }, 200)
          }
          else {
            this.$router.push({path: '/login'});
          }
        },


        methods: {
            deconnection(){
                // sessionStorage.removeItem('structure')
                localStorage.removeItem('autorite')
                this.$router.push({name: 'home-front'});
            },

            toggleCheckbox() {
              this.checkbox = !this.checkbox
              this.$emit('setCheckbox', this.checkbox)
            }
        },   
    }
  
</script>

<style scoped>
  .sidebar-nav .nav-item .router-view-active-link  {
    color: #4154f1;
    background: #f6f9ff;
  }
  .se-deconnecter{
    cursor: pointer;
  }
  .textCheckBox{
    font-family: "Open Sans", sans-serif;
    color: #012970;
    font-size: 15px;
    font-weight: 600;
    margin-left: 24%;
    margin-top: -15%;
  }
  .switch-panel{
    position: relative;
    top: 250px;
    margin-left: 8%;
  }
  .switch {
    position: relative;
    /* top: 100px; */
    display: inline-block;
    width: 50px;
    height: 24px;
  }

  .switch input {
    display: none;
  }

  /* .slider {
    position: absolute;
    cursor: pointer;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #ccc;
    -webkit-transition: 0.4s;
    transition: 0.4s;
  } */
  .slider {
    position: absolute;
    cursor: pointer;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: #012970;
    -webkit-transition: 0.4s;
    transition: 0.4s;
  }

  /* .slider:before {
    position: absolute;
    content: "";
    height: 16px;
    width: 16px;
    left: 4px;
    bottom: 4px;
    background-color: white;
    -webkit-transition: 0.4s;
    transition: 0.4s;
  } */
  .slider:before {
    position: absolute;
    content: "";
    height: 16px;
    width: 16px;
    right: 4px;
    bottom: 4px;
    background-color: white;
    -webkit-transition: 0.4s;
    transition: 0.4s;
  }

  input:checked + .slider {
    background-color: #ccc;
  }

  input:focus + .slider {
    box-shadow: 0 0 1px #ccc;
  }

  input:checked + .slider:before {
    -webkit-transform: translateX(-26px);
    -ms-transform: translateX(-26px);
    transform: translateX(-26px);
  }

  .slider.round {
    border-radius: 34px;
  }

  .slider.round:before {
    border-radius: 50%;
  }
</style>