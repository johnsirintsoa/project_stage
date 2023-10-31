const moment = require('moment-timezone')
// moment.tz.setDefault("Indian/Antananarivo")

const formatDate = (arg) => {
    return moment.tz(arg,"Indian/Antananarivo").format("YYYY-MM-DD")
}


module.exports = {
    formatDate
}