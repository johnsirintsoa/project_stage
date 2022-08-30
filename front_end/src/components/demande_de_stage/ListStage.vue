<script setup>
import { RouterLink, RouterView } from 'vue-router'

</script>
<template>
    <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="">Demandes de stages</a></li>
          <li class="breadcrumb-item active">Liste</li>

        </ol>
    </nav>
<div class="card">
    <div class="card-body">
        <h5 class="card-title">Demandes de stages</h5>

        <!-- Table with hoverable rows -->
        <table class="table table-hover">
        <thead>
            <tr>
            <th scope="col">#</th>
            <th scope="col">Nom et prénom</th>
            <th scope="col">Domaine</th>
            <th scope="col">Durée</th>
            <th scope="col">Status</th>
            <th scope="col">Action</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="stage in stages">
            <th scope="row">{{stage['id']}}</th>
            <td>{{stage['fullName']}}</td>
            <td>{{stage['nom_domaine']}}</td>
            <td>{{stage['duree']}}</td>
            <td>
                <span class="badge bg-success" v-if="stage['demande_status'] == 'valide'">{{stage['demande_status']}}</span>
                <span class="badge bg-warning text-dark" v-else >{{stage['demande_status']}}</span>
            </td>
            <td>
                <RouterLink :to="{name: 'back-demande-stage-detail',params:{id_demande_stage:stage['id']}}">
                    <button type="button" class="btn btn-info">
                        <i class="bi bi-info-circle"></i>
                    </button>
                </RouterLink>
                <!-- <button type="button" class="btn btn-warning" v-if="stage['demande_status'] == 'valide'">
                    <i class="bi bi-exclamation-triangle"></i>
                </button> -->
                <!-- <button type="button" class="btn btn-success" v-else>
                    <i class="bi bi-check-circle"></i>
                </button> -->
            </td>
            </tr>
            <!-- <tr>
            <th scope="row">1</th>
            <td>Brandon Jacob</td>
            <td>Designer</td>
            <td>28</td>
            <td><span class="badge bg-warning text-dark">en attente</span></td>
            <td>
                <RouterLink to="/administrateur/demande-stage/1">
                    <button type="button" class="btn btn-info">
                        <i class="bi bi-info-circle"></i>
                    </button>
                </RouterLink>
                <button type="button" class="btn btn-success">
                    <i class="bi bi-check-circle"></i>
                </button>
            </td>
            </tr> -->

        </tbody>
        </table>
        <!-- End Table with hoverable rows -->

    </div>
    <RouterView />
</div>
</template>

<script>
import DemandeStageAPI from '../../api/demande_stage';
export default {
  data() {
    return {
      stages: []
    }
  },
  async created(){
    this.stages = await DemandeStageAPI.all_status()
  },
}
</script>