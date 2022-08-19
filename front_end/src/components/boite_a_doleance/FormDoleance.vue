<template>
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Faire une doléance</h5>
            <div class="d-grid gap-2 mt-">
                <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                    Exprimez-vous...
                </button>
            </div>

            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                <div class="modal-content">
                    <form class="row g-3 needs-validation" >
                    <div class="modal-body">
                        <div class="card mb-3">

                            <div class="card-body">

                                <div class="pt-4 pb-2">
                                    <h5 class="card-title text-center pb-0 fs-4">Ajouter votre doléance</h5>
                                </div>

                                
                                    <div class="col-12">
                                        <label for="validationCustom01" class="form-label">Nom</label>
                                        <input type="text" class="form-control" id="validationCustom01" v-model="doleance.nom"  name="nom">
                                        <!-- <div class="invalid-feedback">
                                            Entrez un nom
                                        </div> -->
                                    </div>

                                    <div class="col-12">
                                    <label for="validationCustom02" class="form-label">Prénom</label>
                                        <input type="text" class="form-control" id="validationCustom02" v-model="doleance.prenom" name="prenom" >
                                        <!-- <div class="invalid-feedback">
                                            Entrez un prénom
                                        </div> -->
                                    </div>

                                    <div class="col-12">
                                    <label for="validationCustom02" class="form-label">CIN</label>
                                        <input type="number" class="form-control" id="validationCustom02" v-model="doleance.cin" name="CIN">
                                        <!-- <div class="invalid-feedback">
                                            Entrez votre CIN
                                        </div> -->
                                    </div>

                                    <div class="col-12">
                                    <label for="validationCustom02" class="form-label">Numéro de téléphone</label>
                                        <input type="number" class="form-control" id="validationCustom02" v-model="doleance.numero_telephone" name="numero" >
                                        <div class="invalid-feedback">
                                            Entrez un votre numéro de téléphone
                                        </div>
                                    </div>

                                    <div class="col-12">
                                    <label for="validationCustomUsername" class="form-label">Votre adresse e-mail</label>
                                    <div class="input-group has-validation">
                                        <span class="input-group-text" id="inputGroupPrepend">@</span>
                                        <input type="text" class="form-control" id="validationCustomUsername" aria-describedby="inputGroupPrepend" v-model="doleance.e_mail" name="mail" >
                                    </div>
                                    </div>

                                    <div class="col-12">
                                        <label for="validationCustom03" class="form-label">Titre</label>
                                        <input type="text" class="form-control" id="validationCustom03" v-model="doleance.titre" name="titre" required>
                                    </div>

                                    <div class="col-12">
                                        <label for="validationCustom03" class="form-label">Message</label>
                                        <textarea class="form-control" style="height: 100px" v-model="doleance.message" name="message" required></textarea>
                                    </div>

                                    <div class="col-12">
                                    <label for="validationCustom04" class="form-label">Direction</label>
                                    <select class="form-select" v-model="doleance.direction" aria-label="Default select example" required>
                                        <option selected disabled value="">Choose...</option>
                                        <option v-for="direction in directions" :key="direction._id"> {{direction['direction_nickname']}}</option>
                                        <!-- <option value="1">One</option>
                                        <option value="2">Two</option>
                                        <option value="3">Three</option> -->
                                    </select>
                                    </div>
                                

                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button class="btn btn-primary" type="submit" @click="addDoleance">Ajouter</button>
                    </div>
                    </form>
                </div>
                </div>
            </div>

            
        </div>
    </div>
</template>

<script>
import DoleanceAPI from '../../api/doleance';
import DirectionAPI from '../../api/direction';

export default{
    data(){
        return {
            doleance:{
                nom: "",
                prenom: "",
                e_mail: "",
                cin: "",
                numero_telephone:"",
                titre: "",
                message: "",
                direction: ""
            },
            directions :[]
        }
    },
    async created() {
        this.directions = await DirectionAPI.getAllDirection();
        // console.log(this.doleance)
    },
    methods: {
        async addDoleance() {
            const doleance = {
                nom : this.doleance.nom,
                prenom : this.doleance.prenom,
                e_mail : this.doleance.e_mail,
                cin : this.doleance.cin,
                numero_telephone : this.doleance.numero_telephone,
                titre : this.doleance.titre,
                message : this.doleance.message,
                direction : this.doleance.direction,
                session_navigateur: JSON.parse(sessionStorage.getItem("session_navigateur")).value
            }
            // console.log(this.doleance)
            try {
                const response = await DoleanceAPI.addDoleance(doleance)
                // this.nom = "",
                // prenom = "",
                // e_mail = "",
                // cin = "",
                // numero_telephone = "",
                // titre = "",
                // message = "",
                // direction = ""
            } catch (error) {
                console.log(error)
            }
            
        },
        
        // async getAllDirection(){
        //     try {
        //         const response = await DirectionAPI.getAllDirection()
        //         return response
        //     } catch (error) {
        //         console.log(error)
        //     }
        // }
    }
}
</script>