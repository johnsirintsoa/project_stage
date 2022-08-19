<script setup>
// import FormDoleance from '../components/FormDoleance.vue'
import FormDoleance from '../components/boite_a_doleance/FormDoleance.vue';
import ListDoleance from '../components/boite_a_doleance/ListDoleance.vue';
import MyDoleances from '../components/boite_a_doleance/MyDoleances.vue';
// import FormDoleance from '../components/FormDoleance.vue';
</script>

<template>
    <main id="main" class="main">
        <div class="boite-a-doleance">
            <section class="section">
                <div class="row">
                    <div class="col-lg-7">
                        <FormDoleance/>
                        <ListDoleance/>
                    </div>
                    <div class="col-lg-5">
                        <MyDoleances/>
                    </div>
                </div>
            </section>
        </div>
    </main>

</template>