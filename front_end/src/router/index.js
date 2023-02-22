import { createRouter, createWebHistory } from 'vue-router'
// import HomeView from '../views/frontOffice/HomeView.vue'
const HomeView = () => import('../views/frontOffice/HomeView.vue')
const FrontBoiteDoleance = () => import('../views/frontOffice/BoiteDoleance.vue')
const FrontDemandeStage = () =>import('../views/frontOffice/DemandeStage.vue')
const FrontDemandeAudience = () =>import('../views/frontOffice/DemandeAudience.vue')
const Login = () => import('../views/LoginView.vue')

console.log(import.meta.env.BASE_URL)
const router = createRouter({
  // mode:'hash',
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'HomeView',
      component: HomeView
    },
    {
      path: '/boite-a-doleance',
      name: 'FrontBoiteDoleance',
      component: FrontBoiteDoleance

    },
    {
      path: '/demande-stage',
      name: 'FrontDemandeStage',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: FrontDemandeStage
    },

    {
      path: '/demande-audience',
      name: 'FrontDemandeAudience',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: FrontDemandeAudience,
      props:true
    },

        // /** Autorite routes */
    {
      path: '/login',
      name: 'Login',
      component: Login
    },

    

    // Administrateur / autorité
    {
      path: '/back-office/',
      name: 'back-office',
      component: () => import('../views/back&middle/Home.vue')
    },
    {
      path: '/back-office/boite-a-doleance',
      name: 'back-office-doleance',
      component: () => import('../views/back&middle/BoiteDoleance.vue')
    },
    {
      path: '/back-office/demande-stage',
      name: 'back-office-demande-stage',
      component: () => import('../views/back&middle/DemandeStage.vue')
    },
    {
      path: '/back-office/demande-audience',
      name: 'back-office-demande-audience',
      component: () => import('../views/back&middle/DemandeAudience.vue')
    },
    {
      path: '/back-office/calendrier-evenementiel',
      name: 'back-office-calendrier-evenementiel',
      component: () => import('../views/back&middle/MesEvenements.vue')
    },
    {
      path: '/back-office/demande-stage/detail/:id_demande_stage',
      name: 'back-office-detail-demande-stage',
      component: () => import('../views/back&middle/DetailDemandeStage.vue')
    },
  ],
  mode: 'history'
})

export default router
