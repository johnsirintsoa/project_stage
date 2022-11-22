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

          <li class="nav-item dropdown">

            <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
              <i class="bi bi-bell"></i>
              <span class="badge bg-primary badge-number">{{notifications.length}}</span>
            </a><!-- End Notification Icon -->

            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
              <li class="dropdown-header">
                Vous avez {{notifications.length}} audiences
                <RouterLink to="/administrateur/demande-audience/mes-audiences" >
                  <span class="badge rounded-pill bg-primary p-2 ms-2">Voir tout</span>
                </RouterLink>
              </li>
              <li>
                <hr class="dropdown-divider">
              </li>
              
              <RouterLink to="/administrateur/demande-audience/mes-audiences" >
              <li v-for="notification in notifications" :key="notifications.id" class="notification-item">
                <i v-if="notification.type_audience === 'Public' "><span style="background-color: #331999" class="dot"></span></i>
                <i v-else-if="notification.type_audience === 'Autorité'" ><span style="background-color: #f10586" class="dot"></span></i>
                <!-- <i><span :style="{ 'background-color': styleObject.color}" class="dot"></span></i> -->
                <div>
                  <h4>{{notification.title}}</h4>
                  <p>{{notification.type_audience}}</p>
                  <p>{{notification.start}}</p>
                </div>
              </li>
              </RouterLink>

              <li><hr class="dropdown-divider"></li>
            </ul><!-- End Notification Dropdown Items -->

          </li><!-- End Notification Nav -->


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
      notifications: '',
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


    //Notifications
    const id_autorite = JSON.parse(sessionStorage.getItem('administrateur')).autorite_enfant.id
    // this.notifications = await dm_autorite_controller.notifications(id_autorite)
    // console.log(this.notifications)
  },
  methods: {
    getSessionId(){
      return JSON.parse(sessionStorage.getItem('administrateur')).autorite_enfant.id
    },

    deconnection(){
      sessionStorage.removeItem('administrateur')
      window.location.reload()
      this.$router.push({path: '/administrateur/login'});
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
<!-- <style scoped>
header {
  line-height: 1.5;
  max-height: 100vh;
}

.logo {
  display: block;
  margin: 0 auto 2rem;
}

nav {
  width: 100%;
  font-size: 12px;
  text-align: center;
  margin-top: 2rem;
}

nav a.router-link-exact-active {
  color: var(--color-text);
}

nav a.router-link-exact-active:hover {
  background-color: transparent;
}

nav a {
  display: inline-block;
  padding: 0 1rem;
  border-left: 1px solid var(--color-border);
}

nav a:first-of-type {
  border: 0;
}

@media (min-width: 1024px) {
  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  .logo {
    margin: 0 2rem 0 0;
  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }

  nav {
    text-align: left;
    margin-left: -1rem;
    font-size: 1rem;

    padding: 1rem 0;
    margin-top: 1rem;
  }
}
</style> -->
