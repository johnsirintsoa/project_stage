<template>
    <div class="color-infos">
        <ul v-if="colorInfosPublic">
            <li v-for="(colorInfos, index) in colorInfosPublic" :key="index">
                <span :style="{
                    backgroundColor: colorInfos.color}" class="dot"></span> 
                {{colorInfos.infos}}
            </li>
        </ul> 
    
        <ul v-else-if="colorInfosAutorité">
            <li v-for="(colorInfos, index) in colorInfosAutorité" :key="index">
                <span :style="{
                    backgroundColor: colorInfos.color}" class="dot"></span> 
                {{colorInfos.infos}}
            </li>
        </ul> 
    
        <ul v-else-if="colorInfosEvenements">
            <li v-for="(colorInfos, index) in colorInfosEvenements" :key="index">
                <span :style="{
                    backgroundColor: colorInfos.color}" class="dot"></span> 
                {{colorInfos.infos}}
            </li>
        </ul>
    </div>
</template>

<script>
export default {
    props:{
        colorInfosPublic:{
            type: Array
        },
        colorInfosAutorité:{
            type: Array
        },
        colorInfosEvenements:{
            type: Array
        }
    }
    
}
</script>

<style>
    .color-infos ul {
        width:100%;
        /* background:red; */
        /* height:20px; */
        text-align:center;
        /* margin-top: -2%; */
    }
    .color-infos li {
        display:inline-block;
        /* display:block; */
        /* float:left; */
        /* background:blue; */
        /* color:white; */
        font-size: medium;
        margin-right:5em;
    }
</style>