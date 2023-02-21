<script setup>
    import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
    <main>
        <div class="container">
            <div class="screen">
                <div class="screen__content">
                    
                    <form class="login"
                        @submit.prevent="login"
                        autocomplete="off"
                    >
                        <!-- <h6>Accéder à mon compte</h6> -->
                        <div class="login__field">
                            <i class="login__icon bi bi-person-fill"></i>
                            <input type="text" class="login__input" placeholder="Nom d'utilisateur" v-model="nom_utilisateur" required> 
                        </div>			
                        <div class="login__field">
                            <i class="login__icon bi bi-lock-fill"></i>
                            <input type="password" class="login__input" placeholder="Mot de passe" v-model="mot_de_passe" required>
                        </div>
                        <p :class="{ shake: errors_disabled }" v-if="errors" >{{errors}}</p>
                        <button class="button login__submit" @click="warnError">
                            <span class="button__text">Se connecter</span>
                            <i class="button__icon bi bi-chevron-right"></i>
                        </button>			
                    </form>
                    <div class="social-login">
                        <!-- <h3>log </h3> -->
                        <div class="social-icons">
                            
                            <RouterLink to="/"><a href="#" class="social-login__icon fab ri-logout-box-line"></a></RouterLink>
                            
                            <!-- <a href="#" class="social-login__icon fab fa-facebook"></a>
                            <a href="#" class="social-login__icon fab fa-twitter"></a> -->
                        </div>
                    </div>
                </div>
                <div class="screen__background">
                    <span class="screen__background__shape screen__background__shape4"></span>
                    <span class="screen__background__shape screen__background__shape3"></span>		
                    <span class="screen__background__shape screen__background__shape2"></span>
                    <span class="screen__background__shape screen__background__shape1"></span>
                </div>		
            </div>
        </div>
    </main>
</template>

<script>

    import AutoriteApi from '../api/autorite'
    import Profil from '../api/profil'
    export default {
        data() {
            return {
                sipnnerActivated: false,
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
                    this.sipnnerActivated = true
                    const login = await AutoriteApi.login(log)

                    // if(login != '') {
                    //     sessionStorage.setItem('structure',JSON.stringify(login))
                    //     this.$router.push({path: '/back-office/'});
                    // }
					if(login.message){
						this.errors = login.message
					}
                    else{
						sessionStorage.setItem('structure',JSON.stringify(login))
						this.$router.replace(this.$route.query.redirect || '/back-office/');
										// setInterval( () => {
				// 	window.location.reload()
				// }, 1)
                        // this.$router.push({path: '/back-office/'});

                    }
                }
				
            }
        },
    }
</script>

<style scoped>
body {
	background: linear-gradient(90deg, #f6f9ff, #4154f1) !important;		
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

* {
	box-sizing: border-box;
	/* margin: 0;
	padding: 0;	 */
	font-family: Raleway, sans-serif;
}



.container {
	display: flex;
	align-items: center;
	justify-content: center;
	min-height: 100vh;
    
}

.screen {		
	background: linear-gradient(90deg, #c1d2f6, #f6f9ff);		
	position: relative;	
	height: 600px;
	width: 360px;	
	box-shadow: 0px 0px 24px rgba(82, 63, 105, 0.2);
    

}

.screen__content {
	z-index: 1;
	position: relative;	
	height: 100%;
}

.screen__background {		
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	z-index: 0;
	-webkit-clip-path: inset(0 0 0 0);
	clip-path: inset(0 0 0 0);	
}

.screen__background__shape {
	transform: rotate(45deg);
	position: absolute;
}

.screen__background__shape1 {
	height: 520px;
	width: 520px;
	background: #FFF;	
	top: -50px;
	right: 120px;	
	border-radius: 0 72px 0 0;
}

.screen__background__shape2 {
	height: 220px;
	width: 220px;
	background: #cadaf0;	
	top: -172px;
	right: 0;	
	border-radius: 32px;
}

.screen__background__shape3 {
	height: 540px;
	width: 190px;
	background: linear-gradient(270deg,  #bed1ec, #dae5fc);
	top: -24px;
	right: 0;	
	border-radius: 32px;
}

.screen__background__shape4 {
	height: 400px;
	width: 200px;
	background: #b6cdee;	
	top: 420px;
	right: 50px;	
	border-radius: 60px;
}

.login {
	width: 320px;
	padding: 30px;
	padding-top: 156px;
}

.login__field {
	padding: 20px 0px;	
	position: relative;	
}

.login__icon {
	position: absolute;
	top: 30px;
	color: #606879;
}

.login__input {
	border: none;
	border-bottom: 2px solid #c1d2f6;
	background: none;
	padding: 10px;
	padding-left: 24px;
	font-weight: 700;
	width: 75%;
	transition: .2s;
}

.login__input:active,
.login__input:focus,
.login__input:hover {
	outline: none;
	border-bottom-color: #dbe3f5;
}

.login__submit {
	background: #fff;
	font-size: 14px;
	margin-top: 30px;
	padding: 16px 20px;
	border-radius: 26px;
	border: 1px solid #c1d2f6;
	text-transform: uppercase;
	font-weight: 700;
	display: flex;
	align-items: center;
	width: 100%;
	color: #606879;
	box-shadow: 0px 2px 2px #737987;
	cursor: pointer;
	transition: .2s;
}

.login__submit:active,
.login__submit:focus,
.login__submit:hover {
	border-color: #8a8f9a;
	outline: none;
}

.button__icon {
	font-size: 24px;
	margin-left: auto;
	color: #7875B5;
}

.social-login {	
		position: absolute;
		height: 140px;
		width: 160px;
		text-align: center;
		bottom: 0px;
		right: 0px;
		color: #fff;
	}

	.social-icons {
		display: flex;
		align-items: center;
		justify-content: center;
        font-size: 40px;
	}

	.social-login__icon {
		padding: 20px 10px;
		color: #fff;
		text-decoration: none;	
		text-shadow: 0px 0px 8px #7875B5;
	}

	.social-login__icon:hover {
		transform: scale(1.5);	
	}

</style>
