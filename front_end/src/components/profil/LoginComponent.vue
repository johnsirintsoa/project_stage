<template>
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

            </form>
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
            // this.autorites = await AutoriteApi.liste()
            if(sessionStorage.getItem('structure')){
                this.$router.push({path: '/back-office/'});
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
                    const login = await AutoriteApi.login(log)

                    if(login != '') {
                        sessionStorage.setItem('structure',JSON.stringify(login))
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