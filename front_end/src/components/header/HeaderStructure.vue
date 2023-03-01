<template>

    <header id="header" class="header fixed-top d-flex align-items-center">

      <div class="d-flex align-items-center justify-content-between">
        <RouterLink :to="{name: 'home-front'}" class="logo d-flex align-items-center" >
          <span class="d-none d-lg-block">MEF</span>
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
              <img src="../../assets/img/profile-img.jpg" alt="Profile" class="rounded-circle">
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
                  <span>Se déconnecter</span>
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
            <i class="bi bi-person"></i>
            <span>Accueil</span>
          </RouterLink>
        </li>

        <li class="nav-item" >
          <RouterLink to="/back-office/boite-a-doleance" class="nav-link collapsed" >
            <i class="bi bi-file-earmark-text"></i>
            <span>Boite à doléance</span>
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
          <RouterLink to='/back-office/calendrier-evenementiel' class="nav-link collapsed">
            <i class="bi bi-calendar3-range"></i>
            <span>Mes évènements</span>
          </RouterLink>
        </li>


      </ul>

    </aside>

    <RouterView />
    
</template>

<script>
    import { RouterLink, RouterView } from 'vue-router'
    import SpinnerHeader from '../loading/SpinnerHeader.vue'
    import ColorInfos from '../instruction/ColorInformation.vue'
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
          }
        },
        emits:[
          'structure'
        ],

        created() {
            const ses_admin = JSON.parse(sessionStorage.getItem('structure'))
            if(ses_admin != null){
                this.autorite = JSON.parse(sessionStorage.getItem('structure'))
                this.$emit('structure', this.autorite)
                // setInterval( () => {
                //   window.location.reload()
                // }, 200)
            }
            // else {
            //   this.$router.push({path: '/login'});
            // }
        },
        mounted() {
          
        },

        methods: {
            deconnection(){
                sessionStorage.removeItem('structure')
                this.$router.push({name: 'home-front'});
            }
        },   
    }
  
</script>

<style scoped>
  .sidebar-nav .nav-item .router-view-active-link  {
    color: #4154f1;
    background: #f6f9ff;
  }
</style>