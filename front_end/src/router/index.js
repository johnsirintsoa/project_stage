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
      path: '/demande-emploi',
      name: 'front-demande-emploi',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/frontOffice/DemandeEmploi.vue')
    },
    {
      path: '/demande-audience',
      name: 'front-demande-audience',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/frontOffice/DemandeAudience.vue')
    },

    /** Administrateur routes */
    {
      path: '/administrateur/login',
      name: 'loginAdmin',
      component: () => import('../views/backOffice/LoginView.vue')
    },
    {
      path: '/administrateur/',
      name: 'back-home',
      component: () => import('../views/backOffice/HomeView.vue')
    },
    {
      path: '/administrateur/boite-a-doleance',
      name: 'back-boite-a-doleance',
      component: () => import('../views/backOffice/BoiteDoleance.vue')
    },
    {
      path: '/administrateur/demande-stage',
      name: 'back-demande-stage',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/backOffice/DemandeStage.vue')
    },
    {
      path: '/administrateur/demande-emploi',
      name: 'back-demande-emploi',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/backOffice/DemandeEmploi.vue')
    },
    {
      path: '/administrateur/demande-audience',
      name: 'back-demande-audience',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/backOffice/DemandeAudience.vue')
    }
    /** Administrateur routes */
  ]
})

export default router
