
<script setup>
import FormDoleance from '../../components/boite_a_doleance/FormDoleance.vue';
import MyDoleances from '../../components/boite_a_doleance/MyDoleances.vue';
</script>
<template>
    <main id="main" class="main">
        <div class="demande-audience">
            <h1>Boite à doléance</h1>
            
            <section class="section">
                <div class="row">
                    <div class="col-lg-7">
                        <FormDoleance/>
                    </div>
                    <div class="col-lg-5">
                        <MyDoleances/>
                    </div>
                </div>
            </section>
        </div>
    </main>
</template>