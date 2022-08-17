const express = require('express')
const mongoose = require('mongoose')
const bodyParser = require('body-parser')
const cors = require('cors')
require('dotenv/config')

const app = express()
const doleance_route = require('./routes/doleance')

app.use(cors())
app.use(bodyParser.json())

// app use route
app.use('/api/doleance',doleance_route)


// connection mongoDB
mongoose.connect(process.env.DB_CONNECT,()=>{
    console.log('connect to DB')
})

// port listener
app.listen(3000)