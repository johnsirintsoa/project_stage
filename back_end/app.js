const express = require('express')
// const mongoose = require('mongoose')
const bodyParser = require('body-parser')
const cors = require('cors')
require('dotenv/config')

const app = express()
const db = require('./database')
// routes 
const doleance_route = require('./routes/doleance')
const direction_route = require('./routes/direction')
const profil_route = require('./routes/profil')
const stage_route = require('./routes/demande_stage')
const domaine_route = require('./routes/domaine')
const audience_autorite_route = require('./routes/audience_autorite')
const audience_public_route = require('./routes/audience_public')
const autorite_route = require('./routes/autorite')
const jour_ferie = require('./routes/jf')
const entretien_route = require('./routes/entretien_stage')
const audience_pas_dispo = require('./routes/audience_pas_dispo')
const notification_route = require('./routes/notification')
const nonDispo = require('./routes/NonDispo')
const evenement_route = require('./routes/evenement')
const token_route = require('./routes/token')


app.use(cors({
    Origin: ['http://127.0.0.1:5173/','http://192.168.100.160'],
    methods: ['GET','POST','DELETE','UPDATE','PUT','PATCH'],
    credentials: true
}))
// app.use((req,res,next)=>{
//     res.setHeader('Access-Control-Allow-Origin','*');
//     res.setHeader('Access-Control-Allow-Methods','GET,POST,PUT,PATCH,DELETE');
//     res.setHeader('Access-Control-Allow-Methods','Content-Type','Authorization');
//     next(); 
// })
app.use(bodyParser.json())
app.use(
    express.urlencoded({
        extended: true,
    })
);


// app use route
app.use('/api/jour_ferie',jour_ferie)
app.use('/api/doleance',doleance_route)
app.use('/api/direction',direction_route)
app.use('/api/profil',profil_route)
app.use('/api/stage',stage_route)
app.use('/api/domaine',domaine_route)
app.use('/api/audience',audience_autorite_route)
app.use('/api/audience',audience_public_route)
app.use('/api/autorite',autorite_route)
app.use('/api/entretien',entretien_route)
app.use('/api/audience',audience_pas_dispo)
app.use('/api/notification',notification_route)
app.use('/api/nonDispo',nonDispo)
app.use('/api/evenement',evenement_route)
app.use('/api/token', token_route)

// app.use('/api/notification',notification_route)


// connection mongoDB
// mongoose.connect(process.env.DB_CONNECT,()=>{
//     console.log('connect to DB')
// })

// port listener
// Hello world
app.listen(3000)