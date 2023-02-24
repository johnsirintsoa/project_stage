<script>
    import AutoriteApi from '../../api/autorite'
    import DoleanceAPI from '../../api/doleance';
    export default{
        props:{
            doleance:Object
        },

        emits: ['mesDoleances','closePopup'],

        data() {
          return {
            marginTop: -16,
            isSearching: false,
            autorites:'Aucun résultats',
            doleanceForm:{
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
              autorite: '',
              sigle: ''
            },
            
          }
        },

        watch:{
          'doleanceForm.autorite': function (input){
            // c
            if(input){
              this.getAutorites(input)
            }
          }
        },

        async created() {
          this.doleanceForm.id = this.doleance.id
          // this.autorites = await this.autoritesComputed
          this.doleanceForm.type_doleance = this.doleance.type_doleance   
          this.doleanceForm.titre = this.doleance.titre
          this.doleanceForm.message = this.doleance.message
          this.doleanceForm.id_autorite = this.doleance.t_structure_id
          this.doleanceForm.nom = this.doleance.nom
          this.doleanceForm.prenom = this.doleance.prenom
          this.doleanceForm.cin = this.doleance.cin
          this.doleanceForm.numero_telephone = this.doleance.numero_telephone
          this.doleanceForm.e_mail = this.doleance.addresse_electronique
          this.doleanceForm.autorite = this.doleance.child_libelle
          this.doleanceForm.sigle = this.doleance.sigle
            // this.numero_telephone = this.doleance.

        },


        methods: {
          async getAutorites(input){
            // console.log(input)
            try {
              this.autorites = await AutoriteApi.getStructure({path: input})
            } catch (error) {
              console.log(error)
            } 
          },

          async getAutorite(value){
            this.doleanceForm.autorite = value.child_libelle
            this.doleanceForm.id_autorite = value.child_id
            this.doleanceForm.sigle = value.sigle
            this.isSearching = false
          },

          async setDoleanceAutorite(value){
            
            this.isSearching = true
            if(value === ''){
              this.isSearching = false
            }
          },

          async modifier(){
              // console.log(this.doleance)
            const arg = {
              id: this.doleanceForm.id,
              titre: this.doleanceForm.titre,
              message: this.doleanceForm.message,
              id_autorite: this.doleanceForm.id_autorite,
              nom: this.doleanceForm.nom,
              prenom: this.doleanceForm.prenom,
              numero_telephone: this.doleanceForm.numero_telephone,
              cin: this.doleanceForm.cin,
              e_mail: this.doleanceForm.e_mail,
              child_libelle: this.doleanceForm.autorite,
              sigle: this.doleanceForm.sigle,
              type_doleance: this.doleanceForm.type_doleance                
            }
            console.log(arg)
            const response = await DoleanceAPI.modifier(arg)
            if(response.message){
              swal('Doléance modifiée',`${response.message}`,'success')
              const session = JSON.parse(sessionStorage.getItem('session_navigateur')).value
              const arg = {
                  // session_navigateur : 'session877.7483667099051',
                  session_navigateur : session,
              }
              this.$emit('mesDoleances', await DoleanceAPI.liste_public(arg))
              // setInterval( () => {
              //     window.location.reload()
              // }, 2000)
            }
          },
        },
    }
</script>

<template>
  <div v-if="doleanceForm.type_doleance === 'Anonyme'">
    <div class="type-doleance">
        <label><input type="radio" v-model="doleanceForm.type_doleance" value="Anonyme" checked/> Anonyme</label>
        <label><input type="radio" v-model="doleanceForm.type_doleance" value="Non anonyme" style="margin-left: 20px;"/> Non anonyme</label>
    </div> 

    <div class="type-doleance">
        <form class="row g-3" @submit.prevent="modifier" autocomplete="off">
            <div class="col-md-12">
                <div class="form-floating">
                  <input type="text" class="form-control" id="floatingName" placeholder="Titre" v-model="doleanceForm.titre" required>
                  <label for="floatingName">Titre</label>
                </div>
            </div>

            <div class="col-12">
              <div class="form-floating">
                <textarea required class="form-control" placeholder="Message" id="floatingTextarea" style="height: 100px;" v-model="doleanceForm.message" ></textarea>
                <label for="floatingTextarea">Message</label>
              </div>
            </div>
    
            <div class="col-md-12">
              <div class="form-floating mb-3">
                <input type="text" class="form-control" id="floatingName" placeholder="Titre" @input="setDoleanceAutorite(doleanceForm.autorite)" v-model="doleanceForm.autorite"  required>
                <label for="floatingSelect">Autorité</label>
              </div>
            </div>  

            <div class="col-md-12" 
              v-if="isSearching"
              :style="{ marginTop: marginTop + 'px' }"
            >

              <div class="card">
                <div class="card-body">
                  <div class="list-group">
                    
                    <a href="#" class="list-group-item list-group-item-action"
                      v-for="item in autorites" :key="item.id_autorite" :value="item.intitule"  @click="getAutorite(item)"
                    >
                      <div class="d-flex w-100 justify-content-between">
                        <h5 class="mb-1">{{item.child_libelle}}</h5>
                      </div>
                      <p class="mb-1">{{item.path}}</p>
                      <small class="text-muted">{{item.sigle}}</small>
                    </a>

                    
                  </div>
                </div>
              </div>

            </div>
    
            <div class="text-center">
              <button type="submit" class="btn btn-warning">Modifier</button>
              <button type="reset" class="btn btn-secondary" @click="reset">Annuler</button>
            </div>
        </form> 
    </div>

  </div>

  <div v-else-if="doleanceForm.type_doleance === 'Non anonyme'">
      <div class="type-doleance">
          <label><input type="radio" v-model="doleanceForm.type_doleance" value="Anonyme"/> Anonyme</label>
          <label><input type="radio" v-model="doleanceForm.type_doleance" value="Non anonyme" style="margin-left: 20px;" checked/> Non anonyme</label>
      </div> 

      <form class="row g-3" @submit.prevent="modifier" autocomplete="off">
          <div class="col-md-12">
              <div class="form-floating">
                <input type="text" class="form-control" id="floatingName" placeholder="Titre" v-model="doleanceForm.titre" required>
                <label for="floatingName">Titre</label>
              </div>
          </div>

          <div class="col-md-4">
            <div class="form-floating">
              <input type="text" class="form-control" id="floatingName" placeholder="Votre nom" v-model="doleanceForm.nom" required>
              <label for="floatingName">Votre nom</label>
            </div>
          </div>

          <div class="col-md-4">
              <div class="form-floating">
                <input type="text" class="form-control" id="floatingName" placeholder="Votre prénom" v-model="doleanceForm.prenom" required>
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
                    v-model="doleanceForm.cin"   
                    minlength="12"
                    maxlength="12"
                  >
                  <label for="floatingName">CIN</label>
              </div>
          </div>

          <div class="col-md-6">
            <div class="form-floating">
              <input type="email" class="form-control" id="floatingEmail" placeholder="Votre mail" v-model="doleanceForm.e_mail" required>
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
                v-model="doleanceForm.numero_telephone" 
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
              <textarea required class="form-control" placeholder="Message" id="floatingTextarea" style="height: 100px;" v-model="doleanceForm.message" ></textarea>
              <label for="floatingTextarea">Message</label>
            </div>
          </div>

          <div class="col-md-12">
            <div class="form-floating mb-3">
              <input type="text" class="form-control" id="floatingName" placeholder="Titre" @input="setDoleanceAutorite(doleanceForm.autorite)" v-model="doleanceForm.autorite"  required>
              <label for="floatingSelect">Autorité</label>
            </div>
          </div>  

          <div class="col-md-12" 
            v-if="isSearching"
            :style="{ marginTop: marginTop + 'px' }"
          >

            <div class="card">
              <div class="card-body">
                <div class="list-group">
                  
                  <a href="#" class="list-group-item list-group-item-action"
                    v-for="item in autorites" :key="item.id_autorite" :value="item.intitule"  @click="getAutorite(item)"
                  >
                    <div class="d-flex w-100 justify-content-between">
                      <h5 class="mb-1">{{item.child_libelle}}</h5>
                    </div>
                    <p class="mb-1">{{item.path}}</p>
                    <small class="text-muted">{{item.sigle}}</small>
                  </a>

                  
                </div>
              </div>
            </div>

          </div>

          <div class="text-center">
            <button type="submit" class="btn btn-warning">Modifier</button>
            <button type="reset" class="btn btn-secondary" @click="reset">Annuler</button>
          </div>
      </form> 
  </div>
</template>



