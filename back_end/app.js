const express = require('express')
const mongoose = require('mongoose')
const bodyParser = require('body-parser')
const cors = require('cors')
require('dotenv/config')

const app = express()
// routes 
const doleance_route = require('./routes/doleance')
const direction_route = require('./routes/direction')
const profil_route = require('./routes/profil')
const stage_route = require('./routes/demande_stage')
const domaine_route = require('./routes/domaine')



app.use(cors())
app.use(bodyParser.json())

// app use route
app.use('/api/doleance',doleance_route)
app.use('/api/direction',direction_route)
app.use('/api/profil',profil_route)
app.use('/api/stage',stage_route)
app.use('/api/domaine',domaine_route)



// connection mongoDB
mongoose.connect(process.env.DB_CONNECT,()=>{
    console.log('connect to DB')
})

// port listener
// Hello world
app.listen(3000)