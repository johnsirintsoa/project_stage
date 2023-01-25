<script setup>
    import ModifierDoleance from './ModifierDoleance.vue'
</script>

<template>
    <!-- <table class="table table-hover">
        <tbody>
            

            <tr v-for="(doleance,i) in doleances" :key="doleance._id">
                <td>
                    {{doleance['titre']}}
                    
                </td>
                <td><small class="text-muted">{{ doleance['direction'] }}</small></td>
                <td>
                    <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#exampleModal2" @click="getIndexDoleance(i)"><i class="bi bi-exclamation-triangle"></i></button>
                    <button type="button" class="btn btn-danger" @click=removeTodo(doleance,i)><i class="bi bi-exclamation-octagon"></i></button>
                </td>
                <div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                    <div class="modal-content">
                        <form class="row g-3 needs-validation" >
                        <div class="modal-body">
                            <div class="card mb-3">

                                <div class="card-body">

                                    <div class="pt-4 pb-2">
                                        <h5 class="card-title text-center pb-0 fs-4">Modifier votre doléance</h5>
                                    </div>

                                        <div class="col-12">
                                            <label for="validationCustom01" class="form-label">Nom</label>
                                            <input type="text" class="form-control" id="validationCustom01" v-model="nom">

                                        </div>

                                        <div class="col-12">
                                        <label for="validationCustom02" class="form-label">Prénom</label>
                                            <input type="text" class="form-control" id="validationCustom02" v-model="prenom" name="prenom" >

                                        </div>

                                        <div class="col-12">
                                        <label for="validationCustom02" class="form-label">CIN</label>
                                            <input type="number" class="form-control" id="validationCustom02" v-model="cin" name="CIN">

                                        </div>

                                        <div class="col-12">
                                        <label for="validationCustom02" class="form-label">Numéro de téléphone</label>
                                            <input type="number" class="form-control" id="validationCustom02" v-model="numero_telephone" name="numero" >
                                            <div class="invalid-feedback">
                                                Entrez un votre numéro de téléphone
                                            </div>
                                        </div>

                                        <div class="col-12">
                                        <label for="validationCustomUsername" class="form-label">Votre adresse e-mail</label>
                                        <div class="input-group has-validation">
                                            <span class="input-group-text" id="inputGroupPrepend">@</span>
                                            <input type="text" class="form-control" id="validationCustomUsername" aria-describedby="inputGroupPrepend" v-model="e_mail" name="mail" >
                                        </div>
                                        </div>

                                        <div class="col-12">
                                            <label for="validationCustom03" class="form-label">Titre</label>
                                            <input type="text" class="form-control" id="validationCustom03" v-model="titre" name="titre" required>
                                        </div>

                                        <div class="col-12">
                                            <label for="validationCustom03" class="form-label">Message</label>
                                            <textarea class="form-control" style="height: 100px" v-model="message" name="message" required></textarea>
                                        </div>

                                        <div class="col-12">
                                            <label for="validationCustom04" class="form-label">Direction</label>
                                            <select class="form-select" v-model="doleance.direction" aria-label="Default select example" required>
                                                <option selected disabled value="">Choose...</option>
                                                <option v-for="direction in directions" :key="direction._id"> {{direction['direction_nickname']}}</option>

                                            </select>
                                        </div>
                                    

                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" >Close</button>
                        <button class="btn btn-primary" type="submit" @click="updateDoleance(doleance._id)">Modifier</button>
                        </div>
                        </form>
                    </div>
                    </div>
                </div>
            </tr>
        </tbody>
    </table> -->
  
    <table class="table table-hover">
        <thead>
          <tr>
            <th scope="col"></th>
            <th scope="col">Titre</th>
            <th scope="col">Type</th>
            <th scope="col">Autorité</th>
            <th scope="col">Action</th>
          </tr>
        </thead>
        <tbody>
            <tr v-for="doleance in doleances" :key="doleance">
                <th scope="row">{{doleance.id}}</th>
                <td>{{doleance.titre}}</td>
                <td>{{doleance.type_doleance}}</td>
                <td>{{doleance.intitule_code}}</td>
                <td>
                    <button type="button" class="btn btn-warning" @click="modifier(doleance)"><i class="ri-edit-2-line"></i></button>
                    <button type="button" class="btn btn-danger" @click="detail(doleance)"><i class="ri-delete-bin-6-fill"></i></button>
                </td>
            </tr>
        </tbody>
    </table> 

    <teleport to=".doleance-popup">
        <div v-if="showPopup" class="popupDoleance">
            <p  @click="togglePopup"><i class="ri-close-line" style="font-size: 35px;position: fixed; margin-left: 88%;"></i></p>
            <div class="card-body">
                <h2 class="card-title">Modifier votre doléance</h2>
                <ModifierDoleance
                    v-model:doleance="doleanceObj"
                />
            </div>
            <!-- <button class="btn btn-secondary" @click="togglePopup">Annuler</button> -->
        </div>
    </teleport>
</template>
<script>
import DoleanceAPI from '../../api/doleance';
export default {
    props:{
        autorite:Object
    },
    data(){
        return {
            // doleanceMofifierForm: null,
            showPopup:false,
            doleances:[],
            directions:[],
            nom: "",
            prenom: "",
            e_mail: "",
            cin: "",
            numero_telephone:"",
            titre: "",
            message: "",
            direction: ""
        };
    },
    async created() {
        const session = JSON.parse(sessionStorage.getItem('session_navigateur')).value
        const arg = {
            session_navigateur : 'session948.1640243568852',
            // session_navigateur : session,

        }
        this.doleances = await DoleanceAPI.liste_public(arg);
        // console.log(this.doleances)
    },
    methods:{
        async modifier(value){
            this.togglePopup()
            this.doleanceObj = value
        },
        togglePopup(value){
            this.showPopup = !this.showPopup
            // console.log(value)
        },
        getDataPopup(value){
            this.showPopup = value
        },
        async delete(value){
            console.log('A supprimer')
            console.log(value)
        },

        async removeTodo(doleance, i) {
            await DoleanceAPI.deleteDoleance(doleance._id)
            this.doleances.splice(i, 1);
        },
        async getIndexDoleance(i){
            this.nom = this.doleances[i].nom,
            this.prenom = this.doleances[i].prenom,
            this.e_mail = this.doleances[i].e_mail,
            this.cin = this.doleances[i].cin,
            this.numero_telephone = this.doleances[i].numero_telephone,
            this.titre = this.doleances[i].titre,
            this.message = this.doleances[i].message,
            this.direction = this.doleances[i].direction
        },
        async updateDoleance(doleance_id){
            const doleance ={
                nom : this.nom,
                prenom : this.prenom,
                e_mail : this.e_mail,
                cin : this.cin,
                numero_telephone : this.numero_telephone,
                titre : this.titre,
                message : this.message,
                direction : this.direction
            }
            await DoleanceAPI.updateDoleance(doleance_id,doleance)
            this.nom ="",
            this.prenom ="",
            this.e_mail ="",
            this.cin ="",
            this.numero_telephone =""
            this.titre ="",
            this.message ="",
            this.direction =""
        }
    }
}
</script>