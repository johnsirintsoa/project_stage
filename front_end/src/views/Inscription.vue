<script setup>
  import { RouterLink, RouterView } from 'vue-router'
  // import HelloWorld from './components/HelloWorld.vue'
</script>
<template>
    <main>
        <div class="container">
    
          <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
            <div class="container">
              <div class="row justify-content-center">
                <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">
    
                  <div class="d-flex justify-content-center py-4">
                    <a href="index.html" class="logo d-flex align-items-center w-auto">
                      <!-- <img src="assets/img/logo.png" alt=""> -->
                      <span class="d-none d-lg-block">MEF</span>
                    </a>
                  </div><!-- End Logo -->
    
                  <div class="card mb-3">
    
                    <div class="card-body">
    
                      <div class="pt-4 pb-2">
                        <h5 class="card-title text-center pb-0 fs-4">Créer un compte</h5>
                        <p class="text-center small">Remplir les informations nécessaires</p>
                      </div>
    
                      <form class="row g-3 needs-validation" 
                        novalidate=""
                        @submit.prevent="register"
                      >
                        <!-- <div class="col-12">
                          <label for="yourName" class="form-label">Nom</label>
                          <input type="text" name="name" class="form-control" id="yourName" required="">
                          <div class="invalid-feedback">Please, enter your name!</div>
                        </div>
    
                        <div class="col-12">
                          <label for="yourEmail" class="form-label">Your Email</label>
                          <input type="email" name="email" class="form-control" id="yourEmail" required="">
                          <div class="invalid-feedback">Please enter a valid Email adddress!</div>
                        </div> -->
    
                        <div class="col-12">
                          <label for="yourUsername" class="form-label">Nom d'utilisateur</label>
                          <div class="input-group has-validation">
                            <span class="input-group-text" id="inputGroupPrepend">@</span>
                            <input type="text" name="username" class="form-control" id="yourUsername"  v-model="nom_utilisateur" required="">
                            <div class="invalid-feedback">Please choose a username.</div>
                          </div>
                        </div>
    
                        <div class="col-12">
                          <label for="yourPassword" class="form-label">Mot de passe</label>
                          <input type="password" name="password" class="form-control" id="yourPassword"  v-model="mot_de_passe" required="">
                          <div class="invalid-feedback">Please enter your password!</div>
                        </div>
    
                        <div class="col-12">
                            <label class="form-label">Autorité</label>
                            <div class="col-sm-12">

                                <select class="form-select" id="autorite" name="autorite" aria-label="Default select example" v-model="autorite" required>
                                    <option v-for="(autorite)  in autorites"  :value="autorite" > {{autorite.intitule}} ({{autorite.intitule_code}})</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-12">
                          <div class="form-check">
                            <input class="form-check-input" name="terms" type="checkbox" value="" id="acceptTerms" required="" v-model="est_administrateur">
                            <label class="form-check-label" for="acceptTerms">Administrateur</label>
                        </div>
                        </div>
                        <p :class="{ shake: errors_disabled }" v-if="errors" >{{errors}}</p>
                        <div class="col-12">
                          <button class="btn btn-primary w-100" type="submit" @click="warnError">Créer compte</button>
                        </div>
                        <div class="col-12">
                          <p class="small mb-0">Avez vous déja un compte? 
                            <RouterLink to="/login">Se connecter</RouterLink>
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

import AutoriteController from '../controllers/AutoriteController'
import ProfilApi from '../api/profil'
import Swal from 'sweetalert2';
export default{
    data(){
        return{
            errors:'',
            autorites: [] ,
            nom_utilisateur:'',
            mot_de_passe:'',
            autorite:'',
            est_administrateur: false
        }
    },
    async created() {
        this.autorites = await AutoriteController.liste()
    },

    methods: {
        warnError(){
            this.errors_disabled = true
            setTimeout(() => {
                this.errors_disabled = false
                this.errors = ''
            }, 4000)

        },
        async register(){
            const validForm = this.nom_utilisateur && this.mot_de_passe && this.autorite
            // const invalidForm = !this.nom_utilisateur || !this.mot_de_passe || !this.autorite
            // if(invalidForm){
            //     this.errors = ''
            //     this.errors = 'Veuillez remplir le formulaire'
            // }
            if(!this.nom_utilisateur){
                this.errors = ''
                this.errors = `Veuillez entrer votre nom d'utilisateur`;
            }
            else if(!this.mot_de_passe){
                this.errors = '' 
                this.errors = `Veuillez entrer votre mot de passe`;
            }
            else if (!this.autorite){
                this.errors = '' 
                this.errors = `Veuillez choisir un autorité`; 
            }

            else{
                if(this.est_administrateur == true){
                    const infos = {
                        nom_utilisateur: this.nom_utilisateur,
                        mot_de_passe: this.mot_de_passe,
                        id_autorite_enfant: this.autorite.id,
                        est_administrateur: 1
                    }
                    const response = await ProfilApi.inscription(infos)
                    Swal.fire(
                        'Inscription avec succès',
                        `${response.message}`,
                        'success'
                    )
                }
                else{
                    const infos = {
                        nom_utilisateur: this.nom_utilisateur,
                        mot_de_passe: this.mot_de_passe,
                        id_autorite_enfant: this.autorite.id,
                        est_administrateur: 0
                    }
                    const response = await ProfilApi.inscription(infos)
                    Swal.fire(
                        'Inscription avec succès',
                        `${response.message}.Veuillez vous connecter après avoir crée un compte.`,
                        'success'
                    )
                }
                console.log('Register')
            }
        }
    },

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