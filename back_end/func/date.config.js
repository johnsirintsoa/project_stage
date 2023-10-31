const moment = require('moment-timezone')
// moment.tz.setDefault("Indian/Antananarivo")

const formatDate = (arg) => {
    return moment.tz(arg,"Indian/Antananarivo").format("YYYY-MM-DD")
}

const firstAndLastOfDate = () =>{
    // console.log("current month first date");
    const currentFirstdate = moment.utc(new Date()).tz("Indian/Antananarivo").format().replace('T',' ').split('+')[0];
    const firstDateSecondMonth = moment(currentFirstdate).subtract(-2, 'months').format().replace('T',' ').split('+')[0];
    // console.log(currentFirstdate)
    // console.log(firstDateSecondMonth)
    return {
        date1: currentFirstdate,
        date2: firstDateSecondMonth
    }
    // const currentFirstdate = moment.tz(new Date(),"Indian/Antananarivo").format('YYYY-MM-DD HH:MM:SS');
    // const firstDateSecondMonth = moment(currentFirstdate).subtract(-2, 'months').format('YYYY-MM-DD HH:MM:SS');
    // console.log(currentFirstdate);

    // console.log("first date of 2nd month:")
    // console.log(firstDateSecondMonth)

} 


module.exports = {
    formatDate,
    firstAndLastOfDate
}