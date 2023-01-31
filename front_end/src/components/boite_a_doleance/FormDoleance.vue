<template>
    <div class="type-doleance" style="padding-top: 10px">
        <label><input type="radio" v-model="currentForm" value="AnonymusForm" /> Anonyme</label>
        <label><input type="radio" v-model="currentForm" value="NonAnonymusForm" style="margin-left: 20px;"/> Non anonyme</label>
    </div>
    
    <div v-if="currentForm === 'AnonymusForm'">
        <form class="row g-3" @submit.prevent="ajouter" autocomplete="off">
            <div class="col-md-12">
              <div class="form-floating">
                <input type="text" class="form-control" id="floatingName" placeholder="Titre" v-model="doleance.titre" required>
                <label for="floatingName">Titre</label>
              </div>
            </div>
            <div class="col-12">
              <div class="form-floating">
                <textarea required class="form-control" placeholder="Message" id="floatingTextarea" style="height: 100px;"
                
                v-model="doleance.message"></textarea>
                <label for="floatingTextarea">Message</label>
              </div>
            </div>
            <div class="col-md-12">
              <div class="form-floating mb-3">
                <select class="form-select" id="floatingSelect" aria-label="Autorité" v-model="doleance.autorite" required>
                  <option selected="" value="">Choisir autorité</option>
                  <option v-for="a in directions" :value="a.id" > {{a.intitule}}</option>
                </select>
                <label for="floatingSelect">Autorité</label>
              </div>
            </div>
            <div class="text-center">
              <button type="submit" class="btn btn-primary">Ajouter</button>
              <button type="reset" class="btn btn-secondary" @click="reset">Annuler</button>
            </div>
        </form>
    </div>
    
    <div v-else-if="currentForm === 'NonAnonymusForm'">
        <form class="row g-3" @submit.prevent="ajouter" autocomplete="off">
            <div class="col-md-12">
                <div class="form-floating">
                  <input type="text" class="form-control" id="floatingName" placeholder="Titre" v-model="doleance.titre" required>
                  <label for="floatingName">Titre</label>
                </div>
            </div>
            <div class="col-md-4">
              <div class="form-floating">
                <input type="text" class="form-control" id="floatingName" placeholder="Votre nom" v-model="doleance.nom" required>
                <label for="floatingName">Votre nom</label>
              </div>
            </div>
            <div class="col-md-4">
                <div class="form-floating">
                  <input type="text" class="form-control" id="floatingName" placeholder="Votre prénom" v-model="doleance.prenom" required>
                  <label for="floatingName">Votre prénom</label>
                </div>
              </div>
            <div class="col-md-4">
                <div class="form-floating">
                    <input 
                      type="text" 
                      class="form-control" 
                      id="floatingName" 
                      placeholder="Carte d'Itentité National" 
                      v-model="doleance.cin" 
                      required  
                      minlength="12"
                      maxlength="12"
                    >
                    <label for="floatingName">CIN</label>
                </div>
            </div>
            <div class="col-md-6">
              <div class="form-floating">
                <input type="email" class="form-control" id="floatingEmail" placeholder="Votre mail" v-model="doleance.e_mail" required>
                <label for="floatingEmail">Votre mail</label>
              </div>
            </div>
            <div class="col-md-6">
              <div class="form-floating">
                <input 
                  type="tel" 
                  class="form-control" 
                  id="floatingPassword" 
                  placeholder="Numéro téléphone" 
                  v-model="doleance.numero_telephone" 
                  pattern="[0-9]{3}[0-9]{2}[0-9]{3}[0-9]{2}" 
                  required  
                  minlength="10"
                  maxlength="10"
                >
                <label for="floatingPassword">Numéro téléphone</label>
              </div>
            </div>
            <div class="col-12">
              <div class="form-floating">
                <textarea required class="form-control" placeholder="Message" id="floatingTextarea" style="height: 100px;" v-model="doleance.message" ></textarea>
                <label for="floatingTextarea">Message</label>
              </div>
            </div>
            <div class="col-md-12">
              <div class="form-floating mb-3">
                <select class="form-select" id="floatingSelect" aria-label="Autorité" v-model="doleance.autorite" required>
                  <option selected="" value="">Choisir autorité</option>
                  <option v-for="a in directions" :value="a.id" > {{a.intitule}}</option>
                </select>
                <label for="floatingSelect">Autorité</label>
              </div>
            </div>
            <div class="text-center">
              <button type="submit" class="btn btn-primary">Ajouter</button>
              <button type="reset" class="btn btn-secondary" @click="reset">Annuler</button>
            </div>
        </form> 
    </div>

</template>

<script>
    import AutoriteApi from '../../api/autorite'
    import swal from 'sweetalert'
    import DoleanceApi from '../../api/doleance'
    export default {
        data() {
            return {
                currentForm: 'AnonymusForm',
                directions:'',
                doleance:{
                    autorite:'',
                    titre:'',
                    message:''
                }
            }
        },
        computed:{
            async autoritesComputed(){
                return await AutoriteApi.liste()
            }
        },
        
        methods: {
            async setAutorites(){
                this.directions = await this.autoritesComputed
            },

            async ajouter() {
                if(this.currentForm === 'AnonymusForm'){
                    const data = await DoleanceApi.ajouter_anonyme(this.doleance)
                    if(data.message){
                        swal('Doléance ajoutée',`${data.message}`,'success')
                    }
                }
                else if(this.currentForm === 'NonAnonymusForm'){
                    const data = await DoleanceApi.ajouter_non_anonyme(this.doleance)
                    if(data.message){
                        swal('Doléance ajoutée',`${data.message}`,'success')
                    }
                }
            },

            reset(){
                this.doleance.titre = ''
                this.doleance.message = ''
                this.doleance.autorite = ''
                this.doleance.nom = ''                                
                this.doleance.prenom = ''                                
                this.doleance.cin = ''                            
                this.doleance.e_mail = ''
                this.doleance.numero_telephone = '' 
                this.doleance.message = ''  
                this.doleance.autorite = ''                         
            }
        },

        async created() {
            this.setAutorites()
            this.doleance.session_navigateur = JSON.parse(sessionStorage.getItem('session_navigateur')).value
        },
    }
</script>

<style>
    input [type=radio]{
        padding-left: 2px ;
    }
</style>