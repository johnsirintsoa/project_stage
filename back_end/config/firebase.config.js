// Import the functions you need from the SDKs you need
const  initializeApp = require('firebase/app');
const getAnalytics = require('firebase/analytics');
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyB0Ecc4wIquq94_QN_xRTybtLY3yezbAok",
  authDomain: "rohi-audience.firebaseapp.com",
  projectId: "rohi-audience",
  storageBucket: "rohi-audience.appspot.com",
  messagingSenderId: "892934879222",
  appId: "1:892934879222:web:fd751a0f8663655996f9d7",
  measurementId: "G-JCB3RFEDQ7"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
// const analytics = getAnalytics(app);
module.exports = {
    app,analytics
}