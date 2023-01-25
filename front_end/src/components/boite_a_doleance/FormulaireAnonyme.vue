<script>
  import AutoriteController from '../../controllers/AutoriteController'
  import DoleanceApi from '../../api/doleance'
  import swal from 'sweetalert';
  export default {
    data() {
      return {
        doleance:{
          titre:'',
          message:'',
          autorite:''
        },
        directions:''
      }
    },
    computed:{
      async autorites(){
        return await AutoriteController.liste()
      }
    },
    methods: {
      async ajouter(){
        const data = await DoleanceApi.ajouter_anonyme(this.doleance)
          if(data.message){
            swal('Doléance ajoutée',`${data.message}`,'success')
          }
      },
      reset(){
        this.doleance.titre = ''
        this.doleance.message = ''
        this.doleance.autorite = ''      
      }
    },
    async created() {
      this.doleance.session_navigateur = JSON.parse(sessionStorage.getItem('session_navigateur')).value
      this.directions = await this.autorites
    },
  }

</script>

<template>
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
</template>