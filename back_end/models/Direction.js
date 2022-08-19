const mongoose = require('mongoose')

const direction_schema = mongoose.Schema({
    direction_nickname:{
        type: String,
        required:true
    },
    intitule_direction:{
        type: String,
        required: true
    }
})
module.exports = mongoose.model('directions',direction_schema)