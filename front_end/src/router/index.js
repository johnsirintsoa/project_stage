import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/boite-a-doleance',
      name: 'boite-a-doleance',
      component: () => import('../views/BoiteDoleance.vue')
    },
    {
      path: '/demande-stage',
      name: 'demande-stage',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/DemandeStage.vue')
    },
    {
      path: '/demande-emploi',
      name: 'demande-emploi',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/DemandeEmploi.vue')
    },
    {
      path: '/demande-audience',
      name: 'demande-audience',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/DemandeAudience.vue')
    }
  ]
})

export default router
