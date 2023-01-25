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
      component: () => import('../views/frontOffice/BoiteDoleance2.vue')

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
      path: '/demande-audience/autorite',
      name: 'front-demande-audience',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/frontOffice/Autorite.vue')
    },
    {
      path: '/demande-audience/autorite/:id_autorite_enfant',
      name: 'front-demande-audience-autorite-enfant',
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
      path: '/administrateur/demande-stage/detail/:id_demande_stage',
      name: 'back-detail-demande-stage',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/backOffice/DetailDemandeStage.vue')
    },
    {
      path: '/administrateur/demande-emploi',
      name: 'back-demande-emploi',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/backOffice/DemandeEmploi.vue')
    },
    // {
    //   path: '/administrateur/demande-audience',
    //   name: 'back-demande-audience',
    //   // route level code-splitting
    //   // this generates a separate chunk (About.[hash].js) for this route
    //   // which is lazy-loaded when the route is visited.
    //   component: () => import('../views/backOffice/DemandeAudience2.vue')
    // },
    {
      path: '/administrateur/demande-audience/autorite',
      name: 'back-demande-audience',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/backOffice/Autorite.vue')
    },
    {
      path: '/administrateur/demande-audience/autorite/faire-audience/:intitule_code/:id_autorite_enfant',
      name: 'back-demande-audience-faire-audience',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/backOffice/FaireAudience.vue')
    },
    {
      path: '/administrateur/demande-audience/mes-audiences',
      name: 'back-mes-audiences',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      // component: () => import('../views/backOffice/MesAudiences.vue')
      component: () => import('../views/backOffice/MesAudiences.vue')
    },
    {
      path: '/administrateur/demande-audience/audience-valider',
      name: 'back-demande-audience-valider',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/backOffice/DemandeAudienceValider.vue')
    },
    {
      path: '/administrateur/demande-audience/audience-reporter',
      name: 'back-demande-audience-reporter',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/backOffice/DemandeAudienceReporter.vue')
    },

    /** Administrateur routes */

    // /** Autorite routes */
    {
      path: '/login',
      name: 'middle-login',
      component: () => import('../views/LoginView.vue')
    },
    {
      path: '/inscription',
      name: 'middle-register',
      component: () => import('../views/Inscription.vue')
    },
    {
      path: '/autorite',
      name: 'middle-home',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/middleOffice/HomeView.vue')
    },
    {
      path: '/autorite/boite-a-doleance',
      name: 'middle-doleance',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/middleOffice/BoiteDoleance.vue')
    },
    {
      path: '/autorite/demande-stage',
      name: 'middle-demande-stage',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/middleOffice/DemandeStage.vue')
    },
    {
      path: '/autorite/demande-emploi',
      name: 'middle-demande-emploi',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/middleOffice/DemandeEmploi.vue')
    },
    {
      path: '/autorite/demande-audience/autorite',
      name: 'middle-demande-audience-autorite',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/middleOffice/Autorite.vue')
    },
    {
      path: '/autorite/demande-audience/autorite/faire-audience/:intitule_code/:id_autorite_enfant',
      name: 'middle-demande-audience-autorite-faire-audience',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/middleOffice/FaireAudience.vue')
    },
    {
      path: '/autorite/demande-audience/mes-evenements',
      name: 'middle-mes-evenements',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/middleOffice/MesAudiences.vue')
    },
    {
      path: '/autorite/demande-audience/audience-valider',
      name: 'middle-demande-audience-valider',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/middleOffice/DemandeAudienceValider.vue')
    },
    {
      path: '/autorite/demande-audience/audience-reporter',
      name: 'middle-demande-audience-reporter',
      component: () => import('../views/middleOffice/DemandeAudienceReporter.vue')
    },
    {
      path: '/autorite/evenements-calendrier',
      name: 'middle-liste-evenements',
      component: () => import('../views/middleOffice/EvenementsCalendrier.vue')
    }
  ]
})

export default router
