<template>
    <form class="row g-3" @submit.prevent="ajouter" autocomplete="off">
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
                  required  
                  minlength="12"
                  maxlength="12"
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
              required  
              minlength="10"
              maxlength="10"
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
            <select class="form-select" id="floatingSelect" aria-label="Autorité" v-model="autorite" required>
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
</template>

<script>
    export default {
        data() {
            return {
                titre:'',
                nom:'',
                prenom:'',
                cin:'',
                e_mail:'',
                message:'',
                numero_telephone:'',
                
            }
        },
    }
</script>