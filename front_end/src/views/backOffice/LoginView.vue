<template>
    <main id="main" class="main">
        <div class="container">
            <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
                <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

                    <div class="d-flex justify-content-center py-4">
                        <a href="index.html" class="logo d-flex align-items-center w-auto">
                        <span class="d-none d-lg-block">NiceAdmin</span>
                        </a>
                    </div><!-- End Logo -->

                    <div class="card mb-3">

                        <div class="card-body">

                        <div class="pt-4 pb-2">
                            <h5 class="card-title text-center pb-0 fs-4">Login to Your Account</h5>
                            <p class="text-center small">Enter your username &amp; password to login</p>
                        </div>

                        <!-- <form @submit.prevent="login" class="row g-3 needs-validation" novalidate> -->
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

                            <!-- <div class="col-12">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="remember" value="true" id="rememberMe">
                                <label class="form-check-label" for="rememberMe">Remember me</label>
                            </div>
                            </div> -->
                            <div class="col-12">
                            <button class="btn btn-primary w-100" type="submit" @click="login">Login</button>
                            </div>
                            <!-- <div class="col-12">
                            <p class="small mb-0">Don't have account? <a href="pages-register.html">Create an account</a></p>
                            </div> -->
                        </form>

                        </div>
                    </div>

                    <!-- <div class="credits">
                        
                        Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
                    </div> -->

                    </div>
                </div>
                </div>

            </section>
        </div>
    </main>
</template>

<script>
import Profil from '../../api/profil'
export default {
    data() {
        return {
            nom_utilisateur:'',
            mot_de_passe:'',
            id:''
        }
    },
    async created(){
        // const login = await Profil.login('administrateur@gmail.com','123admi')
        // console.log(login)
    },
    methods: {
        async login() {
            const login = await Profil.login(this.nom_utilisateur,this.mot_de_passe)
            // console.log(login)
            if(login.id == null){
                // console.log('Profil null')
                this.$router.push({path: '/administrateur/login'});
            }else{
                // console.log('Profil exist')
                const profil = {
                    id_profil: login.id,
                    autorite_enfant:{
                        id: login.id_autorite_enfant,
                        intitule: login.intitule,
                        intitule_code: login.intitule_code
                    }
                }
                console.log(profil)
                sessionStorage.setItem('administrateur',JSON.stringify(profil))
                this.$router.push({path: '/administrateur/'});
            }
            this.id = login
        }
    },
}
</script>