const mongoose = require('mongoose')

const doleance_schema = mongoose.Schema({
    nom:{
        type: String,
        default:''
    },
    prenom:{
        type: String,
        default:''
    },
    e_mail:{
        type: String,
        default:''
    },
    cin:{
        type: String,
        default:''
    },
    numero_telephone:{
        type: String,
        default:''
    },
    titre:{
        type: String,
        required: true,
    },
    message:{
        type: String,
        required: true,
    },
    direction:{
        type: String,
        required: true,
    },
    session_navigateur:{
        type: String,
        required: true,
    },
    date_publication:{
        type: Date,
        default:Date.now
    }
})
module.exports = mongoose.model('doleances',doleance_schema)