<script setup>
    import { RouterLink, RouterView } from 'vue-router'
    // import HelloWorld from './components/HelloWorld.vue'
</script>

<template>
    <header id="header" class="header fixed-top d-flex align-items-center header-scrolled">

        <div id="navbarSupportedContent">
            <ul>
                <!-- selector -->
                <div class="hori-selector">
                    <div class="left"></div>
                    <div class="right"></div>   
                </div>
                
                <li class="accueil">
                    <RouterLink to="/">
                        <i class="bi bi-house"></i>
                        Accueil
                    </RouterLink>
                </li>
                <li class="doleance">
                    <RouterLink to="/boite-a-doleance">
                        <i class="bi bi-file-earmark-text"></i>
                        Boite à doléance
                    </RouterLink>
                </li>
                <li class="stage">
                    <RouterLink to="/demande-stage">
                        <i class="bi bi-envelope"></i>
                        Demande de stage
                    </RouterLink>
                </li>
    
                <li class="audience">
                    <RouterLink to="/demande-audience">
                        <i class="bi bi-people"></i>
                        Demande d'audience
                    </RouterLink>
                </li>
                <li class="login">
                    <RouterLink to="/login">
                        <i class="bi bi-box-arrow-in-right"></i>
                        Se connecter
                    </RouterLink>
                </li>
            </ul>
        </div>

    </header>
</template>


<style scoped>
.header {
  box-shadow: none !important;
}

ul {
    margin: 0;
    padding: 0;
    display: flex;
    list-style: none;
    align-items: center;
    font-size: 17.5px;
    /* margin-left: 34rem */
}
ul li {
    position: relative;
    padding: 1rem 1rem 1rem 7.5rem;
    align-items: center;
}


#navbarSupportedContent{
	overflow: hidden;
	position: relative;
}

#navbarSupportedContent ul{
	padding: 0px;
	margin: 0px;
}

#navbarSupportedContent ul li a i{
	margin-right: 10px;
}

#navbarSupportedContent li {
	list-style-type: none;
	float: left;
}

#navbarSupportedContent ul li a{
	color: #4154f1;
    /* text-decoration: none; */
    /* font-size: 15px; */
    /* padding: 20px 20px; */
    display: block;
    transition-duration:0.6s;
	transition-timing-function: cubic-bezier(0.68, -0.55, 0.265, 1.55);
    position: relative;
}

#navbarSupportedContent ul li a router-link-active router-link-exact-active{
	color: #06070e;
	background-color: transparent;
	transition: all 0.7s;
}

/* ul li a.router-link-active router-link-exact-active{
	color: #06070e;
	background-color: transparent;
	transition: all 0.7s;
} */

.hori-selector{
    display:inline-block;
    position:absolute;
    height: 100%;
    top: 0px;
    left: 0px;
    transition-duration: 0.6s;
    transition-timing-function: cubic-bezier(0.68, -0.55, 0.265, 1.55);
    background-color: #f6f9ff;
    border-top-left-radius: 15px;
    border-top-right-radius: 15px;
    margin-top: 10px;
}

.hori-selector .right, .hori-selector .left{
	position: absolute;
	width: 25px;
	height: 25px;
	background-color: #5161ce;
	bottom: 10px;
}
.hori-selector .right{
	right: -25px;
}
.hori-selector .left{
	left: -25px;
}
.hori-selector .right:before,
.hori-selector .left:before{
	content: '';
    position: absolute;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background-color: #5161ce;
    /* background-color: #f6f9ff; */

}
.hori-selector .right:before{
	bottom: 0;
    right: -25px;
}
.hori-selector .left:before{
	bottom: 0;
    left: -25px;
}



</style>