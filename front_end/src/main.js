import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

// import './assets/main.css'

// css template start
import './assets/vendor/bootstrap/css/bootstrap.min.css'
import './assets/vendor/bootstrap-icons/bootstrap-icons.css'
import './assets/vendor/boxicons/css/boxicons.min.css'
import './assets/vendor/quill/quill.snow.css'
import './assets/vendor/quill/quill.bubble.css'
import './assets/vendor/remixicon/remixicon.css'
import './assets/vendor/simple-datatables/style.css'

import './assets/css/style.css'
// css template end


const app = createApp(App)

app.use(router)


app.mount('#app')

// js template start

// import './assets/vendor/apexcharts/apexcharts.min.js'
import './assets/vendor/bootstrap/js/bootstrap.bundle.min.js'
// import './assets/vendor/bootstrap/js/bootstrap.min.js'
// import './assets/vendor/chart.js/chart.min.js'
// import './assets/vendor/echarts/echarts.min.js'
// import './assets/vendor/quill/quill.min.js'
// import './assets/vendor/simple-datatables/simple-datatables.js'
// import './assets/vendor/tinymce/tinymce.min.js'
// import './assets/vendor/php-email-form/validate.js'

// import './assets/js/main'
// js template end