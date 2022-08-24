import "bootstrap/dist/css/bootstrap.min.css"
import { createApp } from 'vue'
import AppBack from './AppBackOffice.vue'
import AppFront from './AppFrontOffice.vue'

import router from './router'


// import './assets/main.css'
import './assets/vendor/bootstrap-icons/bootstrap-icons.css'
import './assets/vendor/boxicons/css/boxicons.min.css'
import './assets/vendor/quill/quill.snow.css'
import './assets/vendor/quill/quill.bubble.css'
import './assets/vendor/remixicon/remixicon.css'
import './assets/vendor/simple-datatables/style.css'

import '@fortawesome/fontawesome-free/js/all'


import './assets/css/style.css'
import FUNC from './func/function'

let app = null
// sessionStorage.setItem('administrateur','138749183943')

// console.log(window.location.href.includes('administrateur'))
if(window.location.href.includes('administrateur')){
    app = createApp(AppBack)
    // if(Profil.login_admin('haha','huhu')){
    //     console.log('Connecter et login true')
    //     // redirection page d'accueil
    //     // router.push({name: 'back-home'})
    //     window.location.href = '/administrateur/'
    //     // router.push({path: '/administrateur/'})
    //     // console.log(window.location.href)
    // }else{
    //     console.log('diso login')
    //     // redirection page login
    //     // router.push({name: 'loginAdmin'})
    //     window.location.href = '/administrateur/login'
    //     // router.push({name:'loginAdmin'})
    //     // console.log(window.location.href)

    // }
}else{
    // expiration du session navigateur
    // start
    const duree_expiration = 1
    const date_expiration = new Date(new Date().getTime() + (60000 * duree_expiration))
    FUNC.session_navigateur(date_expiration)
    // end
    app = createApp(AppFront)
}
// console.log(app)
app.use(router)
app.mount('#app')
// app.mount('#app')



import "./assets/vendor/apexcharts/apexcharts.min.js"
import "bootstrap/dist/js/bootstrap.js"
import "./assets/vendor/chart.js/chart.min.js"
import "./assets/vendor/echarts/echarts.min.js"
import "./assets/vendor/quill/quill.min.js"
import "./assets/vendor/simple-datatables/simple-datatables.js"
import "./assets/vendor/tinymce/tinymce.min.js"
import "./assets/vendor/php-email-form/validate.js"

import './assets/js/main.js'

