<template>
    <div class="card mb-3">
        <div class="card-body">
            <ul class="nav nav-tabs nav-tabs-bordered d-flex" id="borderedTabJustified" role="tablist">
                <li class="nav-item flex-fill" role="presentation">
                  <button class="nav-link w-100 active" id="home-tab" data-bs-toggle="tab" data-bs-target="#bordered-justified-home" type="button" role="tab" aria-controls="home" aria-selected="true" value="seConnecter" @click="afficher($event)">Se connecter</button>
                </li>
                <li class="nav-item flex-fill" role="presentation">
                  <button class="nav-link w-100" id="profile-tab" data-bs-toggle="tab" data-bs-target="#bordered-justified-profile" type="button" role="tab" aria-controls="profile" aria-selected="false" tabindex="-1" value="sInscrire" @click="afficher($event)">S'inscrire</button>
                </li>
            </ul>

            <div v-if="affichage === 'seConnecter'">
                <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">Connecter à votre compte</h5>
                    <p class="text-center small">Entrer votre nom d'utilisateur &amp; votre mot de passe</p>
                </div>
    
                <form 
                    @submit.prevent="login"
                    class="row g-3 needs-validation" 
                    autocomplete="off"
                    novalidate=""
                >
    
                    <div class="col-12">
                        <label for="yourUsername" class="form-label">Nom d'utilisateur</label>
                        <div class="input-group has-validation">
                        <span class="input-group-text" id="inputGroupPrepend">@</span>
                        <input type="text" name="username" class="form-control" id="yourUsername" v-model="this.nom_utilisateur" required>
                        <div class="invalid-feedback" v-if="!nom_utilisateur">Entrez votre nom d'utilisateur</div>
                        </div>
                    </div>
    
                    <div class="col-12">
                        <label for="yourPassword" class="form-label">Mot de passe</label>
                        <input type="password" name="password" class="form-control" id="yourPassword" v-model="this.mot_de_passe" required>
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

            <div v-else-if="affichage === 'sInscrire'">
                <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">Créer un compte</h5>
                    <p class="text-center small">Remplir les informations nécessaires</p>
                </div>

                <form class="row g-3 needs-validation" 
                    novalidate=""
                    @submit.prevent="register"
                >
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
                                <option selected="" value="" disabled>Choisir autorité</option>
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
</template>

<script>

    import AutoriteApi from '../../api/autorite'
    import Profil from '../../api/profil'
    export default {
        data() {
            return {
                errors:'',
                affichage: 'seConnecter',
                errors_disabled: false,
                nom_utilisateur:'',
                mot_de_passe:'',
                id:'',            
                autorite:'',
                est_administrateur: false
            }
        },
        async created() {
            this.autorites = await AutoriteApi.liste()
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
    
            afficher(event){
                this.affichage = event.target.value
            },

            warnError(){
                this.errors_disabled = true
                setTimeout(() => {
                    this.errors_disabled = false
                    this.errors = ''
                }, 4000)
    
            },
            
            async register(){
                const validForm = this.nom_utilisateur && this.mot_de_passe && this.autorite

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