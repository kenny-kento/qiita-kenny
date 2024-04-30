<template>
  <div class="signup_wrapper">
    <div class="container">
      <h2>Qiitaにログイン</h2>
      <Notification :message="error" v-if="error" class="mb-4 pb-3" />
      <div class="signup_form">
        <div class="signup_form_left">
          <img src="https://placehold.jp/300x300.png" alt="" />
          <p>
            もしQiitaのアカウントを持っていない場合は<NuxtLink to="/signup"
              >新規登録</NuxtLink
            >
            から
          </p>
        </div>

        <div class="signup_form_right">
          <form @submit.prevent="login">
            <div class="form_container">
              <ul>
                <li>
                  <input
                    type="email"
                    placeholder="メールアドレス"
                    required
                    v-model="email"
                  />
                </li>
                <li>
                  <input
                    type="password"
                    placeholder="パスワード"
                    required
                    v-model="password"
                  />
                </li>
              </ul>
            </div>
            <button class="resister_button" type="submit" variant="primary">
              Qiitaにログイン
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  layout: "auth",
  data: function () {
    return {
      email: "",
      password: "",
      error: null,
    };
  },
  // ログアウト時にキャッシュが残っているためリダイレクト処理を挟んで対応中
  created() {
    if (this.$auth.loggedIn) {
      this.$router.push("/");
    }
  },
  methods: {
    async login() {
      try {
        await this.$auth.loginWith("local", {
          data: {
            password: this.password,
            email: this.email,
          },
        });
        this.$router.push("/");
        this.$store.dispatch(
          "flashMessage/showMessage",
          {
            message: "ログインしました.",
            type: "success",
            status: true,
          },
          { root: true }
        );
      } catch (error) {
        this.error = error.response.data.errors;
      }
    },
  },
};
</script>

<style></style>
