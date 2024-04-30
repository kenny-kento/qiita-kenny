<template>
  <v-dialog v-model="dialogLocal" width="500">
    <v-card>
      <v-card-title class="text-h5 lighten-2">
        ログインして続ける
      </v-card-title>
      <v-card-text> メールアドレスでログイン・新規登録 </v-card-text>
      <v-layout column align-center>
        <v-btn
          class="btn_auth_box"
          @click="$router.push('/login')"
          style="background-color: white"
          >メールアドレスでログイン</v-btn
        >
        <v-btn
          class="btn_auth_box"
          @click="$router.push('/signup')"
          style="background-color: white"
          >メールアドレスで新規登録</v-btn
        >
      </v-layout>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    dialog: Boolean,
  },
  computed: {
    dialogLocal: {
      get() {
        return this.dialog;
      },
      set(value) {
        this.$emit("update:dialog", value);
      },
    },
  },
};
</script>

<style>
.btn_auth_box {
  width: 90%;
  margin-bottom: 15px;
  border: 1px solid black !important;
}
</style>
