<template>
    <div class="card" v-for="doleance in doleances" :key="doleance._id">
        <div class="card-body">
            <div class="d-flex w-100 justify-content-between">
                <h5 class="card-title">{{ doleance['titre'] }}</h5>
                <small class="text-muted">{{ doleance['date_publication'].substring(0,10) }}</small>
            </div>
            
            <!-- <small class="text-muted">{{ doleance['date_publication']}}</small> -->
            <h6 class="card-subtitle mb-2 text-muted">{{ doleance['direction'] }}</h6>
            {{ doleance['message']}}
        </div>
    </div>
</template>
<script>
import DoleanceAPI from '../../api/doleance';
export default {
    data(){
        return {
            doleances:[]
        };
    },
    async created() {
        this.doleances = await DoleanceAPI.getAllDoleance();
        console.log(this.doleances)
    },
}
</script>