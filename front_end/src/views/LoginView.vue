<script setup>
    import { RouterLink, RouterView } from 'vue-router'
    // import HelloWorld from './components/HelloWorld.vue'
</script>
<template>
    <!-- <main id="main" class="main">
        <div class="container">
            <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
                <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

                    <div class="d-flex justify-content-center py-4">
                        <a href="index.html" class="logo d-flex align-items-center w-auto">
                        <span class="d-none d-lg-block"></span>
                        </a>
                    </div>
                    <div class="card mb-3">

                        <div class="card-body">

                        <div class="pt-4 pb-2">
                            <h5 class="card-title text-center pb-0 fs-4">Login to Your Account</h5>
                            <p class="text-center small">Enter your username &amp; password to login</p>
                        </div>

                        <form class="row g-3 needs-validation" novalidate>
                        
                            <div class="col-12">
                            <label for="yourUsername" class="form-label">Username</label>
                            <div class="input-group has-validation">
                                <span class="input-group-text" id="inputGroupPrepend">@</span>
                                <input type="text" name="username" class="form-control" id="yourUsername" v-model="nom_utilisateur" required>
                                <div class="invalid-feedback">Please enter your username.</div>
                            </div>
                            </div>

                            <div class="col-12">
                            <label for="yourPassword" class="form-label">Password</label>
                            <input type="password" name="password" class="form-control" id="yourPassword" v-model="mot_de_passe" required>
                            <div class="invalid-feedback">Please enter your password!</div>
                            </div>

                            <div class="col-12">
                            <button class="btn btn-primary w-100" type="submit" @click="login">Login</button>
                            </div>
                        </form>

                        </div>
                    </div>


                    </div>
                </div>
                </div>

            </section>
        </div>
    </main> -->

    <main>
        <div class="container">

            <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
            <div class="container">
                <div class="row justify-content-center">
                <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

                    <div class="d-flex justify-content-center py-4">
                    <a href="index.html" class="logo d-flex align-items-center w-auto">
                        <!-- <img src="./assets/img/logo.png" alt=""> -->
                        <span class="d-none d-lg-block">MEF</span>
                    </a>
                    </div>

                    <div class="card mb-3">

                    <div class="card-body">

                        <div class="pt-4 pb-2">
                        <h5 class="card-title text-center pb-0 fs-4">Connecter à votre compte</h5>
                        <p class="text-center small">Entrer votre nom d'utilisateur &amp; votre mot de passe</p>
                        </div>

                        <form 
                            @submit.prevent="login"
                            class="row g-3 needs-validation" 
                            autocomplete="off"
                            novalidate="">

                        <div class="col-12">
                            <label for="yourUsername" class="form-label">Nom d'utilisateur</label>
                            <div class="input-group has-validation">
                            <span class="input-group-text" id="inputGroupPrepend">@</span>
                            <input type="text" name="username" class="form-control" id="yourUsername" v-model="nom_utilisateur" required>
                            <div class="invalid-feedback" v-if="!nom_utilisateur">Entrez votre nom d'utilisateur</div>
                            </div>
                        </div>

                        <div class="col-12">
                            <label for="yourPassword" class="form-label">Mot de passe</label>
                            <input type="password" name="password" class="form-control" id="yourPassword" v-model="mot_de_passe" required>
                            <div class="invalid-feedback">Entrez votre mot de passe</div>
                        </div>
                        <p :class="{ shake: errors_disabled }" v-if="errors" >{{errors}}</p>

                        <div class="col-12">
                            <input class="btn btn-primary w-100" value="Connecter" type="submit" @click="warnError"/>
                        </div>
                        <div class="col-12">
                            <p class="small mb-0">N'avez vous pas de compte? 
                                <RouterLink to="/inscription">Créer un compte</RouterLink>
                            </p>
                        </div>
                        </form>

                    </div>
                    </div>


                </div>
                </div>
            </div>

            </section>
    
        </div>
    </main>
</template>

<script>
import Profil from '../api/profil'
export default {
    data() {
        return {
            errors:'',
            errors_disabled:false,
            nom_utilisateur:'',
            mot_de_passe:'',
            id:''
        }
    },
    created() {
        if(sessionStorage.getItem('administrateur')){
            console.log('Efa connecte admin')
            this.$router.push({path: '/administrateur/'});
        }
        else if(sessionStorage.getItem('autorite')){
            this.$router.push({path: '/autorite/'});
        }
        else{
            this.$router.push({path: '/login'});
        }
    },
    methods: {

        warnError(){
            this.errors_disabled = true
            setTimeout(() => {
                this.errors_disabled = false
                this.errors = ''
            }, 4000)

        },
        
        async login(){
            
            const validForm = this.nom_utilisateur && this.mot_de_passe
            const invalidForm = !this.nom_utilisateur && !this.mot_de_passe
            if (invalidForm){
                this.errors = `Veuillez remplir le formulaire`;
            }
            else if(!this.nom_utilisateur){
                this.errors = `Veuillez entrer votre nom d'utilisateur`;
            }
            else if(!this.mot_de_passe){
                this.errors = `Veuillez entrer votre mot de passe`;
            }
            else if (invalidForm){
                this.errors = `Veuillez fournir le formulaire`;
            }
            else if(validForm){
                const log = {
                    nom_utilisateur: this.nom_utilisateur,
                    mot_de_passe: this.mot_de_passe
                }
                const login = await Profil.login(log)
                if(login != ''){
                    if(login.est_administrateur == 1){
                        console.log('Administrateur')
                        sessionStorage.setItem('administrateur',JSON.stringify(login))
                        this.$router.push({path: '/administrateur/'});
                    }
                    else{
                        console.log('Autorité')
                        sessionStorage.setItem('autorite',JSON.stringify(login))
                        this.$router.push({path: '/autorite'});
                    }
                }
                else{
                    this.errors = `Le compte n'existe pas`
                }
            }
        }
    },
}
</script>

<style>

.shake {
    color: firebrick;
    animation: shake 0.82s cubic-bezier(0.36, 0.07, 0.19, 0.97) both;
    transform: translate3d(0, 0, 0);
}

@keyframes shake {
    10%,
    90% {
        transform: translate3d(-1px, 0, 0);
    }

    20%,
    80% {
        transform: translate3d(2px, 0, 0);
    }

    30%,
    50%,
    70% {
        transform: translate3d(-4px, 0, 0);
    }

    40%,
    60% {
        transform: translate3d(4px, 0, 0);
    }
}

</style>