<script setup>
    import HeaderNavbar from '../../components/header/HeaderMiddle.vue'
// import {r RouterLink, RouterView } from 'vue-router'
</script>

<template>
    <HeaderNavbar/>
    <main id="main" class="main">
        <h1>Bienvenue </h1>
    </main><!-- End #main -->
  <!-- <main>
    <TheWelcome />
    
  </main> -->
</template>
<script>
import Profil from '../../api/profil';

export default{
    // data(){
    //     return{
    //         nom_utilisateur:'',
    //         mot_de_passe:''
    //     }
    // },
    // created(){
    //     const autorite = JSON.parse(sessionStorage.getItem('autorite'))
    //     console.log(autorite)
    //     if(autorite != null) {
    //         this.$router.push({name:'middle-demande-audience', params:{id_autorite_enfant: autorite.autorite_enfant.id}});
    //     }else{
    //         this.$router.push('/autorite/');
    //     }
    //     // this.$router.push({name:'middle-demande-audience', params:{id_autorite_enfant: 1}});
    // },
    // methods:{
    //     async login() {
    //         const login = await Profil.login_autorite(this.nom_utilisateur,this.mot_de_passe)
    //         // console.log(login)
    //         if(login.id == null){
    //             // console.log('Profil null')
    //             this.$router.push({path: '/autorite/'});
    //         }else{
    //             console.log('Profil exist')
    //             const profil = {
    //                 id_profil: login.id,
    //                 autorite_enfant:{
    //                     id: login.id_autorite_enfant,
    //                     intitule: login.intitule,
    //                     intitule_code: login.intitule_code
    //                 }
    //             }
    //             // console.log(profil)
    //             sessionStorage.setItem('autorite',JSON.stringify(profil))
                
    //         }
    //         this.id = login
    //     }
    // }
}
</script>

<style scoped>

@media (min-width: 1200px){
    #main {
        margin-left: 300px;
    }
}

#main {
    margin-top: 60;
    padding: 20px 30px;
    transition: all 0.3s;
}
    
</style>