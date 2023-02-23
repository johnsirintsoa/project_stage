
export default class Config{
    static domaineBackEnd (route1,route2){
        const DOMAINEBACKEND = 'http://localhost:3000/api/'
        // const DOMAINEBACKEND = 'http://192.168.100.160:3000/api/'

        return DOMAINEBACKEND.concat(route1,route2)
    }
}
