<template>
    <div class="col-md-12">
      <div class="form-floating mb-3">
        <input type="text" class="form-control" id="floatingName" placeholder="Titre" @input="setDoleanceAutorite(autorite)" v-model="autorite"  required>
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
              v-for="item in directions" :key="item.child_id" :value="item.child_libelle" @click="getAutorite(item)"
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
</template>

<script>

  import AutoriteApi from '../../api/autorite'

  export default{

    data() {
      return {
        marginTop: -16,
        isSearching: false,
        directions:'Aucun résultats',
        autorite:''
      }
    },

    emits:[
      'getAutoriteClicked'
    ],

    watch:{
      'autorite': function (input){
        if(input){
          this.getAutorites(input)
        }
      }
    },

    methods: {

      async setDoleanceAutorite(value){    
        this.isSearching = true
        if(value === ''){
          this.isSearching = false
        }
      },

      async getAutorite(value){
        if(this.isSearching === true){
          this.autorite = value.child_libelle
          this.$emit('getAutoriteClicked',value)
          this.isSearching = false
        }
      },

      async getAutorites(input){
        try {
          this.directions = await AutoriteApi.getStructure({path: input})
        } catch (error) {
          console.log(error)
        } 
      },
    },

  }
</script>