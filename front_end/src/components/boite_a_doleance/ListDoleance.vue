<template>
    <div class="float-sm-start">
        Direction :
        <select class="form-select" v-model="filter.direction" aria-label="Default select example" required>
            <option selected disabled value="">Direction</option>
            <option v-for="direction in directions" :key="direction._id"> {{direction['direction_nickname']}}</option>
            <!-- <option value="1">One</option>
            <option value="2">Two</option>
            <option value="3">Three</option> -->
        </select>
        De <input type="date" class="form-control" v-model="filter.date_1"> à <input type="date" v-model="filter.date_2" class="form-control">
        <button type="button" class="btn btn-primary position-relative" @click="filtrer()">
            Flitrer
        </button></div><br>
<div class="float-md-start"></div><br>
<!-- <div class="float-lg-start">Float start on viewports sized LG (large) or wider</div><br>
<div class="float-xl-start">Float start on viewports sized XL (extra-large) or wider</div><br> -->

            
    
    <div class="card" v-for="doleance in doleances" :key="doleance._id">
        <div class="card-body">
            <div class="d-flex w-100 justify-content-between">
                <h5 class="card-title">{{ doleance['titre'] }}</h5>
                <small class="text-muted">{{ new String(doleance['date_publication']).substring(0,10) }}</small>
            </div>
            
            <!-- <small class="text-muted">{{ doleance['date_publication']}}</small> -->
            <h6 class="card-subtitle mb-2 text-muted">{{ doleance['direction'] }}</h6>
            {{ doleance['message']}}
        </div>
    </div>
</template>
<script>
import DoleanceAPI from '../../api/doleance';
import DirectionAPI from '../../api/direction';

export default {
    data(){
        return {
            doleances:[],
            directions:[],
            filter:{
                direction:'',
                date_1:'',
                date_2:new Date().toISOString().substring(0,10)
            }
        };
    },
    async created() {
        this.doleances = await DoleanceAPI.getAllDoleance();
        this.directions = await DirectionAPI.getAllDirection();
        console.log(this.doleances)
        // console.log(new Date().toISOString().substring(0,10))
    },
    methods:{
        async filtrer(){
            this.doleances = await DoleanceAPI.filter_doleance(this.filter.date_1,this.filter.date_2,this.filter.direction);
            // console.log(this.filter.date_1)
            // console.log(this.filter.date_2)
        }
    }
}
</script>