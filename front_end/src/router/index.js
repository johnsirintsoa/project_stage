import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/frontOffice/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home-front',
      component: HomeView
    },
    {
      path: '/boite-a-doleance',
      name: 'front-boite-a-doleance',
      component: () => import('../views/frontOffice/BoiteDoleance.vue')

    },
    {
      path: '/demande-stage',
      name: 'front-demande-stage',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/frontOffice/DemandeStage.vue')
    },

    {
      path: '/demande-audience/autorite',
      name: 'front-demande-audience',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/frontOffice/Autorite.vue')
    },
    {
      path: '/demande-audience',
      name: 'front-demande-audience-autorite-enfant',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/frontOffice/DemandeAudience.vue'),
      props:true
    },

        // /** Autorite routes */
    {
      path: '/login',
      name: 'middle-login',
      component: () => import('../views/LoginView.vue')
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
  ]
})

export default router
