<template>
  
  <form class="row g-3" @submit.prevent="modifier" autocomplete="off">
    <div class="col-md-12">
      <div class="form-floating">
        <input type="text" class="form-control" id="floatingName" placeholder="Titre" v-model="titre" required>
        <label for="floatingName">Titre</label>
      </div>
    </div>

    <div class="col-12">
      <div class="form-floating">
        <textarea required class="form-control" placeholder="Message" id="floatingTextarea" style="height: 100px;"
        
        v-model="message"></textarea>
        <label for="floatingTextarea">Message</label>
      </div>
    </div>

    <div class="col-md-12">
      <div class="form-floating mb-3">
        <select class="form-select" id="floatingSelect" aria-label="Autorité" v-model="autorite"  required>
          <option :value="doleance.id_autorite" selected >{{doleance.intitule}}</option>
          <option v-for="a in autorites" :value="a.id"  >{{a.intitule}}</option>
        </select>
        <label for="floatingSelect">Autorité</label>
      </div>
    </div>

    <div class="text-center">
      <button type="submit" class="btn btn-warning">Modifier</button>
      <button type="submit" class="btn btn-danger">Supprimer</button>
    </div>

  </form>

</template>

<script>
  import AutoriteApi from '../../api/autorite'
  import DoleanceApi from '../../api/doleance'
  import swal from 'sweetalert'
  export default{
    props:{
      doleance: Object,
    },
    data() {
      return {
        autorites:'',
        autorite:'',
        titre:'',
        message:''
      }
    },
    created(){
      this.setAutorites()
      this.titre = this.doleance.titre
      this.message = this.doleance.message
      this.autorite = this.doleance.id_autorite
    },
    computed:{
      async autoritesComputed(){
        return await AutoriteApi.liste()
      }
    },
    methods: {
      async setAutorites(){
        this.autorites = await this.autoritesComputed
      },

      // async setAutorite(value){
      //   this.autorite = value.target.value
      // },

      async modifier(){
        // console.log(this.doleance)
        const arg = {
          id: this.doleance.id,
          titre: this.titre,
          message: this.message,
          id_autorite: this.autorite
        }
        const response = await DoleanceApi.modifier_anonyme(arg)
        if(response.message){
          swal('Doléance modifiée',`${response.message}`,'success')
          setInterval( () => {
            window.location.reload()
          }, 2000)
        }
      },

    },
  }
</script>
