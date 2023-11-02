const moment = require('moment-timezone')
// moment.tz.setDefault("Indian/Antananarivo")

const formatDate = (arg) => {
    return moment.tz(arg,"Indian/Antananarivo").format("YYYY-MM-DD")
}

const formatDateTime = (arg) => {
    return moment.tz(arg,"Indian/Antananarivo").format("YYYY-MM-DDThh:mm:ss")
}



const firstAndLastOfDate = () =>{
    // console.log("current month first date");
    const currentFirstdate = moment.utc(moment()).tz("Indian/Antananarivo").format("YYYY-MM-DD");
    const firstDateSecondMonth = moment(currentFirstdate).subtract(-2, 'months').format("YYYY-MM-DD")

    const currentTime = moment().tz("Indian/Antananarivo").format("HH:mm:ss")
    // console.log(currentFirstdate)
    // console.log(firstDateSecondMonth)
    // console.log(currentTime)
    return {
        date1: currentFirstdate,
        date2: firstDateSecondMonth,
        currentTime
    }
    // const currentFirstdate = moment.tz(new Date(),"Indian/Antananarivo").format('YYYY-MM-DD HH:MM:SS');
    // const firstDateSecondMonth = moment(currentFirstdate).subtract(-2, 'months').format('YYYY-MM-DD HH:MM:SS');
    // console.log(currentFirstdate);

    // console.log("first date of 2nd month:")
    // console.log(firstDateSecondMonth)

} 


module.exports = {
    formatDate,
    firstAndLastOfDate,
    formatDateTime
}