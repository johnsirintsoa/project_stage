import "bootstrap/dist/css/bootstrap.min.css"
import { createApp } from 'vue'
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

// expiration du session navigateur
// start
const duree_expiration = 1
const date_expiration = new Date(new Date().getTime() + (60000 * duree_expiration))
FUNC.session_navigateur(date_expiration)
// end

const app = createApp(App)

app.use(router)

app.mount('#app')



import "./assets/vendor/apexcharts/apexcharts.min.js"
import "bootstrap/dist/js/bootstrap.js"
import "./assets/vendor/chart.js/chart.min.js"
import "./assets/vendor/echarts/echarts.min.js"
import "./assets/vendor/quill/quill.min.js"
import "./assets/vendor/simple-datatables/simple-datatables.js"
import "./assets/vendor/tinymce/tinymce.min.js"
import "./assets/vendor/php-email-form/validate.js"

// import './assets/main.js'

