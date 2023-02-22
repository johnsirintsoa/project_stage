<script setup>
    import { RouterLink, RouterView } from 'vue-router'
    import SpinnerHeader from '../loading/SpinnerHeader.vue'
</script>
<template>

    <header id="header" class="header fixed-top d-flex align-items-center">

      <div class="d-flex align-items-center justify-content-between">
        <a href="#" class="logo d-flex align-items-center">
          <span class="d-none d-lg-block">MEF</span>
        </a>
        <SpinnerHeader
          :sipnnerActivated="sipnnerActivated"
        />
        <!-- <i class="bi bi-list toggle-sidebar-btn"></i> -->
      </div>

      <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">

          <li class="nav-item d-block d-lg-none">
            <a class="nav-link nav-icon search-bar-toggle " href="#">
              <i class="bi bi-search"></i>
            </a>
          </li><!-- End Search Icon-->


          <li class="nav-item dropdown pe-3">

            <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
              <img src="../../assets/img/profile-img.jpg" alt="Profile" class="rounded-circle">
              <span class="d-none d-md-block dropdown-toggle ps-2">{{autorite.sigle}}</span>
            </a><!-- End Profile Iamge Icon -->

            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
              <li class="dropdown-header">
                <h6>{{autorite.sigle}}</h6>
                <span>{{autorite.child_libelle}}</span>
              </li>
              <!-- <li>
                <hr class="dropdown-divider">
              </li>

              <li>
                <a class="dropdown-item d-flex align-items-center" href="users-profile.html">
                  <i class="bi bi-person"></i>
                  <span>My Profile</span>
                </a>
              </li>
              <li>
                <hr class="dropdown-divider">
              </li>

              <li>
                <a class="dropdown-item d-flex align-items-center" href="users-profile.html">
                  <i class="bi bi-gear"></i>
                  <span>Account Settings</span>
                </a>
              </li>
              <li>
                <hr class="dropdown-divider">
              </li>

              <li>
                <a class="dropdown-item d-flex align-items-center" href="pages-faq.html">
                  <i class="bi bi-question-circle"></i>
                  <span>Need Help?</span>
                </a>
              </li>
              <li>
                <hr class="dropdown-divider">
              </li> -->

              <li>
                <a class="dropdown-item d-flex align-items-center" @click="deconnection()">
                  <i class="bi bi-box-arrow-right"></i>
                  <span>Se déconnecter</span>
                </a>
              </li>

            </ul><!-- End Profile Dropdown Items -->
          </li><!-- End Profile Nav -->

        </ul>
      </nav><!-- End Icons Navigation -->

    </header>

    <aside id="sidebar" class="sidebar">

      <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-heading">Pages</li>

        <li class="nav-item">
          <RouterLink to="/back-office/" >
          <a class="nav-link collapsed">
            <i class="bi bi-person"></i>
            <span>Accueil</span>
          </a>
          </RouterLink>
        </li><!-- End Profile Page Nav -->

        <li class="nav-item" >
          <RouterLink to="/back-office/boite-a-doleance" >
            <a class="nav-link collapsed" >
              <i class="bi bi-file-earmark-text"></i>
              <span>Boite à doléance</span>
            </a>
          </RouterLink>
        </li><!-- End F.A.Q Page Nav -->

        <li class="nav-item">
          <RouterLink to="/back-office/demande-stage" >
          <a class="nav-link collapsed" href="">
            <i class="bi bi-envelope"></i>
            <span>Demande de stage</span>
          </a>
          </RouterLink>
        </li><!-- End Contact Page Nav -->

        <li class="nav-item">
          <RouterLink to='/back-office/demande-audience' >
            <a class="nav-link collapsed" href="">
            <i class="bi bi-people"></i><span>Demande d'audience</span>
            </a>
          </RouterLink>
        </li>
        <li class="nav-item">
          <RouterLink to='/back-office/calendrier-evenementiel' >
            <a class="nav-link collapsed" href="">
                <i class="bi bi-calendar3-range"></i><span>Mes évènements</span>
            </a>
          </RouterLink>
        </li>

      </ul>

    </aside>

    <RouterView />
    
</template>

<script>
    export default {

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
            }
            // else {
            //   this.$router.push({path: '/login'});
            // }
        },

        methods: {
            deconnection(){
                sessionStorage.removeItem('structure')
                this.$router.push({path: '/login'});
            }
        },   
    }
  
</script>
