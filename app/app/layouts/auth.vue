<template>
  <div>
    <v-app>
      <Header />
      <div class="wrapper">
        <Nuxt />
      </div>
      <Footer />
    </v-app>
  </div>
</template>

<script>
import Footer from "./footer.vue";
import Header from "./auth-header.vue";

export default {
  components: {
    Footer,
    Header,
  },
};
</script>

<style>
.wrapper {
  background-color: #d9d9d9;
  padding-top: 10px;
  /* min-height: 80vh; */
}
</style>
