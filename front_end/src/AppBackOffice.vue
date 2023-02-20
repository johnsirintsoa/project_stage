<script setup>
import { RouterLink, RouterView } from 'vue-router'
// import HelloWorld from './components/HelloWorld.vue'
import dm_autorite_controller from './controllers/BackOffice/DemandeAudienceAutoriteController'
</script>
<template>

    <!-- ======= Header ======= -->
    <header id="header" class="header fixed-top d-flex align-items-center">

      <div class="d-flex align-items-center justify-content-between">
        <a href="#" class="logo d-flex align-items-center">
          <!-- <img src="./assets/img/logo.png" alt=""> -->
          <span class="d-none d-lg-block">MEF</span>
        </a>
        <i class="bi bi-list toggle-sidebar-btn"></i>
      </div>
      <!-- End Logo -->

      <!-- <div class="search-bar">
        <form class="search-form d-flex align-items-center" method="POST" action="#">
          <input type="text" name="query" placeholder="Search" title="Enter search keyword">
          <button type="submit" title="Search"><i class="bi bi-search"></i></button>
        </form>
      </div> -->
      <!-- End Search Bar -->

      <nav class="header-nav ms-auto">
        <ul class="d-flex align-items-center">

          <li class="nav-item d-block d-lg-none">
            <a class="nav-link nav-icon search-bar-toggle " href="#">
              <i class="bi bi-search"></i>
            </a>
          </li><!-- End Search Icon-->


          <li class="nav-item dropdown pe-3">

            <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
              <img src="./assets/img/profile-img.jpg" alt="Profile" class="rounded-circle">
              <span class="d-none d-md-block dropdown-toggle ps-2">{{autorite.intitule_code}}</span>
            </a><!-- End Profile Iamge Icon -->

            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
              <li class="dropdown-header">
                <h6>{{autorite.intitule_code}}</h6>
                <span>{{autorite.intitule}}</span>
              </li>
              <li>
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
              </li>

              <li>
                <a class="dropdown-item d-flex align-items-center" @click="deconnection()">
                  <i class="bi bi-box-arrow-right"></i>
                  <span>Sign Out</span>
                </a>
              </li>

            </ul><!-- End Profile Dropdown Items -->
          </li><!-- End Profile Nav -->

        </ul>
      </nav><!-- End Icons Navigation -->

    </header><!-- End Header -->

    <!-- ======= Sidebar ======= -->
    <aside id="sidebar" class="sidebar">

      <ul class="sidebar-nav" id="sidebar-nav">

        <li class="nav-heading">Pages</li>

        <li class="nav-item">
          <RouterLink to="/administrateur/" :class="{ disabled: active }">
          <a class="nav-link collapsed">
            <i class="bi bi-person"></i>
            <span>Accueil</span>
          </a>
          </RouterLink>
        </li><!-- End Profile Page Nav -->

        <li class="nav-item" >
          <RouterLink to="/administrateur/boite-a-doleance" :class="{ disabled: active }">
          <a class="nav-link collapsed" >
            <i class="bi bi-question-circle"></i>
            <span>Doléance</span>
          </a>
          </RouterLink>
        </li><!-- End F.A.Q Page Nav -->

        <li class="nav-item">
          <RouterLink to="/administrateur/demande-stage" :class="{ disabled: active }">
          <a class="nav-link collapsed" href="">
            <i class="bi bi-envelope"></i>
            <span>Stage</span>
          </a>
          </RouterLink>
        </li><!-- End Contact Page Nav -->

        <li class="nav-item">
          <RouterLink to="/administrateur/demande-emploi" :class="{ disabled: active }" >
          <a class="nav-link collapsed" href="">
            <i class="bi bi-card-list"></i>
            <span>Emploi</span>
          </a>
          </RouterLink>
        </li><!-- End Register Page Nav -->

        <li class="nav-item">
          <RouterLink to='/administrateur/demande-audience/autorite' :class="{ disabled: active }">
            <a class="nav-link collapsed" href="">
            <i class="bi bi-calendar-plus"></i><span>Faire une audience</span>
            </a>
          </RouterLink>
        </li>
        <li class="nav-item">
          <RouterLink to='/administrateur/demande-audience/mes-audiences' :class="{ disabled: active }">
            <a class="nav-link collapsed" href="">
            <i class="bi bi-calendar3-range"></i><span>Mes audiences</span>
            </a>
          </RouterLink>
        </li>
        <li class="nav-item">
          <RouterLink to='/administrateur/demande-audience/audience-valider' :class="{ disabled: active }">
            <a class="nav-link collapsed" href="">
            <i class="bi bi-calendar-check"></i><span>Audience validées</span>
            </a>
          </RouterLink>
        </li>
        <li class="nav-item">
          <RouterLink to='/administrateur/demande-audience/audience-reporter' :class="{ disabled: active }">
            <a class="nav-link collapsed" href="">
            <i class="bi bi-calendar-x"></i><span>Audience reportées</span>
            </a>
          </RouterLink>
        </li>


      </ul>

    </aside><!-- End Sidebar-->
    
    <RouterView />
    
</template>

<script>
export default {
  data() {
    return {
      active: false,
      autorite:''
    }
  },
  
  async created() {
    if(sessionStorage.getItem('administrateur')){
      // redirect vers la page d'accueil
      this.$router.push({path: '/administrateur/'});
      this.autorite = JSON.parse(sessionStorage.getItem('administrateur')).autorite_enfant
    }else{
      // redirect vers la page de login
      this.$router.push({path: '/administrateur/login'});
      this.active = true
    }

  },
  methods: {
    getSessionId(){
      return JSON.parse(sessionStorage.getItem('administrateur')).autorite_enfant.id
    },

    deconnection(){
      sessionStorage.removeItem('administrateur')
      window.location.reload()
      this.$router.push({path: '/'});
    }
  },
}
</script>
<style>
.disabled {
    opacity: 0.5;
    pointer-events: none;
}

.dot {
  /* background-color: v-bind(notifColor); */
  height: 10px;
  width: 10px;
  border-radius: 50%;
  display: inline-block;
}

</style>