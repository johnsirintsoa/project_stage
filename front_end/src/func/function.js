export default class Function{
    // nombre aleatoire
    static random_number(min, max) {
        return Math.random() * (max - min) + min;
    }

// set sessionStorage
    static session_navigateur(date_expiration) {
        const key='session_navigateur'
        let stringValue = sessionStorage.getItem(key)
        // console.log(date_expiration)  
        if(sessionStorage.getItem(key) !== null) {
            let value = JSON.parse(stringValue)        
            let expirationDate = new Date(value.expirationDate) 
            // console.log(expirationDate+' session_expired') 
            if(expirationDate < new Date()){
                sessionStorage.removeItem(key)
            }
        }else{
            let newValue = { value: "session".concat(Function.random_number(0,1000)),expirationDate: date_expiration.toISOString() }  
            sessionStorage.setItem(key, JSON.stringify(newValue))
        }

        // let stringValue = sessionStorage.getItem(key)    
        // if (stringValue !== null) {      
        //     let value = JSON.parse(stringValue)        
        //     let expirationDate = new Date(value.expirationDate)        
        //     if (expirationDate > new Date()) {          
        //         return value.value        
        //     } else {          
        //         window.sessionStorage.removeItem(key)        
        //     }    
        // }    return null
    }// add into session

    static sessionSet(key, value, expirationInMin = 10) {  
        let expirationDate = new Date(new Date().getTime() + (60000 * expirationInMin))    
        let newValue = {    value: value,    expirationDate: expirationDate.toISOString()  }  
        window.sessionStorage.setItem(key, JSON.stringify(newValue))
    }
    
}