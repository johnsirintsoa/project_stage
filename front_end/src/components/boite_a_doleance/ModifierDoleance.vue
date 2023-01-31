<script setup>
    import ModfierAnonyme from './DoleanceModifierAnonyme.vue'
    import ModifierNonAnonyme from './DoleanceModifierNonAnonyme.vue'
</script>

<script>
    import AutoriteApi from '../../api/autorite'
    import DoleanceAPI from '../../api/doleance';
    export default{
        props:{
            doleance:Object
        },
        data() {
            return {
                id: '',
                type_doleance:'',
                id_autorite: '',
                titre: '',
                message: '',
                nom: '',
                prenom: '',
                cin: '',
                numero_telephone: '',
                e_mail: '',

                autorites:''
            }
        },
        computed:{
            async autoritesComputed(){
                return await AutoriteApi.liste()
            }
        },
        async setAutorites(){
            this.autorites = await this.autoritesComputed
        },
 
        async created() {
            this.id = this.doleance.id
            this.autorites = await this.autoritesComputed
            this.type_doleance = this.doleance.type_doleance   
            this.titre = this.doleance.titre
            this.message = this.doleance.message
            this.id_autorite = this.doleance.id_autorite
            this.nom = this.doleance.nom
            this.prenom = this.doleance.prenom
            this.cin = this.doleance.cin
            this.numero_telephone = this.doleance.numero_telephone
            this.e_mail = this.doleance.addresse_electronique
            // this.numero_telephone = this.doleance.

        },


        methods: {
            async modifier(){
                // console.log(this.doleance)
                const arg = {
                    id: this.id,
                    titre: this.titre,
                    message: this.message,
                    id_autorite: this.id_autorite,
                    nom: this.nom,
                    prenom: this.prenom,
                    cin: this.cin,
                    e_mail: this.e_mail

                }
                console.log(arg)
                const response = await DoleanceAPI.modifier(arg)
                if(response.message){
                  swal('Doléance modifiée',`${response.message}`,'success')
                  // setInterval( () => {
                  //     window.location.reload()
                  // }, 2000)
                }
            },
        },
    }
</script>

<template>
  <div v-if="type_doleance === 'Anonyme'">
    <div class="type-doleance">
        <label><input type="radio" v-model="type_doleance" value="Anonyme" checked/> Anonyme</label>
        <label><input type="radio" v-model="type_doleance" value="Non anonyme" style="margin-left: 20px;"/> Non anonyme</label>
    </div> 

    <div class="type-doleance">
        <form class="row g-3" @submit.prevent="modifier" autocomplete="off">
            <div class="col-md-12">
                <div class="form-floating">
                  <input type="text" class="form-control" id="floatingName" placeholder="Titre" v-model="titre" required>
                  <label for="floatingName">Titre</label>
                </div>
            </div>

            <div class="col-12">
              <div class="form-floating">
                <textarea required class="form-control" placeholder="Message" id="floatingTextarea" style="height: 100px;" v-model="message" ></textarea>
                <label for="floatingTextarea">Message</label>
              </div>
            </div>
    
            <div class="col-md-12">
              <div class="form-floating mb-3">
                <select class="form-select" id="floatingSelect" aria-label="Autorité" v-model="id_autorite" required>
                  <option selected="" :value="doleance.id_autorite">{{doleance.intitule}}</option>
                  <option v-for="a in autorites" :value="a.id" > {{a.intitule}}</option>
                </select>
                <label for="floatingSelect">Autorité</label>
              </div>
            </div>
    
            <div class="text-center">
              <button type="submit" class="btn btn-warning">Modifier</button>
              <button type="reset" class="btn btn-secondary" @click="reset">Annuler</button>
            </div>
        </form> 
    </div>

  </div>

  <div v-else-if="type_doleance === 'Non anonyme'">
      <div class="type-doleance">
          <label><input type="radio" v-model="type_doleance" value="Anonyme"/> Anonyme</label>
          <label><input type="radio" v-model="type_doleance" value="Non anonyme" style="margin-left: 20px;" checked/> Non anonyme</label>
      </div> 

      <form class="row g-3" @submit.prevent="modifier" autocomplete="off">
          <div class="col-md-12">
              <div class="form-floating">
                <input type="text" class="form-control" id="floatingName" placeholder="Titre" v-model="titre" required>
                <label for="floatingName">Titre</label>
              </div>
          </div>

          <div class="col-md-4">
            <div class="form-floating">
              <input type="text" class="form-control" id="floatingName" placeholder="Votre nom" v-model="nom" required>
              <label for="floatingName">Votre nom</label>
            </div>
          </div>

          <div class="col-md-4">
              <div class="form-floating">
                <input type="text" class="form-control" id="floatingName" placeholder="Votre prénom" v-model="prenom" required>
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
                    v-model="cin"   
                    minlength="12"
                    maxlength="12"
                    required
                  >
                  <label for="floatingName">CIN</label>
              </div>
          </div>

          <div class="col-md-6">
            <div class="form-floating">
              <input type="email" class="form-control" id="floatingEmail" placeholder="Votre mail" v-model="e_mail" required>
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
                v-model="numero_telephone" 
                pattern="[0-9]{3}[0-9]{2}[0-9]{3}[0-9]{2}"   
                minlength="10"
                maxlength="10"
                required
              >
              <label for="floatingPassword">Numéro téléphone</label>
            </div>
          </div>

          <div class="col-12">
            <div class="form-floating">
              <textarea required class="form-control" placeholder="Message" id="floatingTextarea" style="height: 100px;" v-model="message" ></textarea>
              <label for="floatingTextarea">Message</label>
            </div>
          </div>

          <div class="col-md-12">
            <div class="form-floating mb-3">
              <select class="form-select" id="floatingSelect" aria-label="Autorité" v-model="id_autorite" required>
                <option selected="" :value="doleance.id_intitul">{{doleance.intitule}}</option>
                <option v-for="a in autorites" :value="a.id" > {{a.intitule}}</option>
              </select>
              <label for="floatingSelect">Autorité</label>
            </div>
          </div>

          <div class="text-center">
            <button type="submit" class="btn btn-warning">Modifier</button>
            <button type="reset" class="btn btn-secondary" @click="reset">Annuler</button>
          </div>
      </form> 
  </div>
</template>



