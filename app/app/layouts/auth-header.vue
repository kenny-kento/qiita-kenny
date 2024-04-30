<template>
  <header>
    <flashMessage />
    <nuxt-link to="/">
      <p class="header_container">Qiita</p>
    </nuxt-link>
  </header>
</template>

<script>
export default {
  data: function () {
    return {};
  },
};
</script>

<style>
header {
  padding: 10px 5px;
}
</style>
