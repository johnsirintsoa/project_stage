<script >
    export default {
        props:{
            autorite: Object
        },
    }
</script>

<template>
    <div class="pagetitle">
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="">Demande audience</a></li>
                <li class="breadcrumb-item"><a href="">{{autorite.intitule_code}}</a></li>
                <li class="breadcrumb-item active">Calendrier évènementiel</li>
            </ol>
            
        </nav> 
    </div>
   
</template>
