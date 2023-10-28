<template>
    <button type="button" class="btn btn-success" style="margin-left: 20rem;" data-bs-toggle="modal" data-bs-target="#verticalycentered">
                  Valider
                </button>

                <div class="modal fade" id="verticalycentered" tabindex="-1" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                  <div class="modal-content">
                    <div class="modal-body">
                      <div class="card">
                        <div class="card-body">
                          <h5 class="card-title">Valider Stage</h5>

                          <!-- Vertical Form -->
                          <form class="row g-3">
                            <div class="col-12">
                              <label for="inputNanme4" class="form-label">Nom et prénom</label>
                              <input type="text" class="form-control" v-model="nom" name="nom" id="inputNanme4">
                            </div>
                            <div class="col-12">
                              <label for="inputEmail4" class="form-label">Email</label>
                              <input type="email" class="form-control" v-model="email" name="email" id="inputEmail4">
                            </div>
                            <div class="col-12">
                              <label for="inputPassword4" class="form-label">Date de l'entretien</label>
                              <input type="datetime-local" class="form-control" v-model="date_entretien" name="date_entretien" id="inputPassword4">
                            </div>
                            <div class="text-center">
                                <button type="submit" value="Send" class="btn btn-success" >Send</button>
                                <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            </div>
                          </form><!-- Vertical Form -->

                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                </div>
</template>

<script>
  
import emailjs from '@emailjs/browser'

export default {
  data() {
    return {
      nom: '',
      email: '',
      date_entretien: ''
    }
  },
  methods: {
    // sendEmail() {
    //   try {
    //     emailjs.sendForm('service_ir31b6q', 'template_84qzp1g',this.$refs.form,'RAylLdQlUWReg7ynb')

    //   } catch(error) {
    //       console.log({error})
    //   }
    //   // Reset form field
    //   this.nom = ''
    //   this.email = ''
    //   this.date_entretien = ''
    // }
    // sendEmail(){
    //     emailjs.send('service_ir31b6q', 'template_84qzp1g', {
    //         nom: this.nom,
    //         email: this.email,
    //         date_entretien: format_date(this.date_entretien)
    //     }).then(function(response) {
    //             console.log('SUCCESS!', response.status, response.text);
    //         }, function(error) {
    //             console.log('FAILED...', error);
    //         });
    // },
    format_date(date){
        var dd = String(date.getDate()).padStart(2, '0');
        var mm = String(date.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = date.getFullYear();

        today = mm + '/' + dd + '/' + yyyy;
        var time = date.toLocaleTimeString();

        return "Date: " + today + " and Time: " + time;
    }
  }
}
</script>