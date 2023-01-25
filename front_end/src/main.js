import "bootstrap/dist/css/bootstrap.min.css"
import { createApp } from 'vue'
import AppBack from './AppBackOffice.vue'
import AppFront from './AppFrontOffice.vue'
import AppMiddle from './AppMiddleOffice.vue'
import App from './App.vue'

import router from './router'


// import './assets/main.css'
import './assets/vendor/bootstrap-icons/bootstrap-icons.css'
import './assets/vendor/boxicons/css/boxicons.min.css'
import './assets/vendor/quill/quill.snow.css'
import './assets/vendor/quill/quill.bubble.css'
import './assets/vendor/remixicon/remixicon.css'
import './assets/vendor/simple-datatables/style.css'



import './assets/css/style.css'
import FUNC from './func/function'
/* import the fontawesome core */
import { library } from '@fortawesome/fontawesome-svg-core'

/* import font awesome icon component */
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

/* import specific icons */
import { faUserSecret } from '@fortawesome/free-solid-svg-icons'

/* add icons to the library */
library.add(faUserSecret)

let app = null

const duree_expiration = 2
const date_expiration = new Date(new Date().getTime() + (60000 * duree_expiration))
// console.log("Date d'expiration "+date_expiration)

FUNC.session_navigateur(date_expiration)
const session = sessionStorage.getItem('session_navigateur')
if(session == null){
    window.location.reload()
}

// FUNC.setGeneratedTokenIntoSession()

app = createApp(App)
// console.log(app)
app.use(router)
app.component('font-awesome-icon', FontAwesomeIcon)
app.mount('#app')


import "./assets/vendor/apexcharts/apexcharts.min.js"
import "bootstrap/dist/js/bootstrap.js"
import "./assets/vendor/chart.js/chart.min.js"
import "./assets/vendor/echarts/echarts.min.js"
import "./assets/vendor/quill/quill.min.js"
import "./assets/vendor/simple-datatables/simple-datatables.js"
import "./assets/vendor/tinymce/tinymce.min.js"
// import "./assets/vendor/php-email-form/validate.js"

import "./assets/js/main"

