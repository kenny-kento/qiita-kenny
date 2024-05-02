<template>
  <header>
    <div class="contents">
      <div class="header_left">
        <flashMessage />
        <nuxt-link to="/">
          <p class="btn_qiita">Kenny</p>
        </nuxt-link>
      </div>
      <div class="header_right">
        <ul>
          <li>
            <input
              type="search"
              class="content_search"
              placeholder="記事を検索"
              v-model="keyword"
              @keyup.enter="searchArticles"
            />
          </li>
          <li>
            <v-menu offset-y>
              <template v-slot:activator="{ on }">
                <div v-on="on">
                  <img
                    :src="user.icon_url ? user.icon_url : '/user_default.png'"
                    alt="写真"
                    class="circle"
                  />
                </div>
              </template>
              <v-list>
                <v-list-item v-if="this.$auth.loggedIn">
                  <v-list-item-title>
                    <nuxt-link to="/user">マイページ</nuxt-link>
                  </v-list-item-title>
                </v-list-item>
                <v-list-item v-if="this.$auth.loggedIn">
                  <v-list-item-title>
                    <b-button variant="danger" @click="logout">
                      ログアウト</b-button
                    >
                  </v-list-item-title>
                </v-list-item>
                <v-list-item v-if="!this.$auth.loggedIn">
                  <v-list-item-title>
                    <b-button variant="info" to="/login">ログイン</b-button>
                  </v-list-item-title>
                </v-list-item>
              </v-list>
            </v-menu>
          </li>
          <li v-if="this.$auth.loggedIn">
            <nuxt-link to="/post">
              <button class="post_page">投稿する</button>
            </nuxt-link>
          </li>
          <li v-if="!this.$auth.loggedIn">
            <nuxt-link to="/login">
              <button class="btn_login">ログイン</button>
            </nuxt-link>
          </li>
          <li v-if="!this.$auth.loggedIn">
            <nuxt-link to="/signup">
              <button class="btn_signup">新規登録</button>
            </nuxt-link>
          </li>
        </ul>
      </div>
    </div>
  </header>
</template>

<script>
export default {
  data: function () {
    return {
      keyword: "",
    };
  },
  async mounted() {
    await this.$store.dispatch("user/fetchUser");
  },
  computed: {
    user() {
      return this.$store.state.user.user;
    },
  },
  methods: {
    async logout() {
      await this.$auth.logout().then(() => {
        localStorage.removeItem("access-token");
        localStorage.removeItem("client");
        localStorage.removeItem("uid");
        localStorage.removeItem("token-type");
        localStorage.removeItem("authorization");

        this.$store.dispatch("user/clearUser");
        this.$router.push("/");
        this.$store.dispatch(
          "flashMessage/showMessage",
          {
            message: "ログアウトしました.",
            type: "success",
            status: true,
          },
          { root: true }
        );
      });
    },
    searchArticles() {
      this.$router.push({ path: "/search", query: { q: this.keyword } });
    },
  },
};
</script>

<style>
header {
  padding: 10px 5px;
}
.contents {
  display: flex;
  justify-content: space-between;
}

.header_right ul {
  display: flex;
  justify-content: space-between;
}

li {
  margin-left: 10px;
}

.content_search {
  height: 50px;
  width: 250px;
  border: 1px solid black;
}

.circle {
  border: 1px solid black;
  width: 50px;
  height: 50px;
  border-radius: 50%;
  text-align: center;
  line-height: 50px;
  cursor: pointer;
}

.post_page {
  height: 50px;
  width: 100px;
  border: 1px solid #000;
  text-align: center;
  padding: 10px 0 10px 0;
  background-color: #55c500;
  border-radius: 10px;
  color: #fff;
  font-weight: 500;
  font-size: 1.1rem;
}

.btn_qiita {
  box-sizing: border-box;
  display: inline-block;
  flex-shrink: 0;
  font-size: 20px;
  font-weight: 600;
  line-height: 1.8;
  min-height: 34px;
  min-width: 64px;
  opacity: 1;
  pointer-events: auto;
  text-align: center;
  user-select: none;
  vertical-align: middle;
  background-color: #67cb1b;
  color: rgb(255 255 255 / 92%);
  margin-left: 8px;
  border-radius: 8px;
  white-space: nowrap;
  transition: background-color 0.1s ease-out 0s, border-color;
  padding: 1px 16px;
}

.btn_signup {
  box-sizing: border-box;
  display: inline-block;
  flex-shrink: 0;
  font-size: 14px;
  font-weight: 600;
  line-height: 1.8;
  min-height: 34px;
  min-width: 64px;
  opacity: 1;
  pointer-events: auto;
  text-align: center;
  user-select: none;
  vertical-align: middle;
  background-color: #357a00;
  color: rgb(255 255 255 / 92%);
  margin-left: 8px;
  border-radius: 8px;
  white-space: nowrap;
  transition: background-color 0.1s ease-out 0s, border-color;
  padding: 4px 16px;
}

.btn_login {
  box-sizing: border-box;
  display: inline-block;
  flex-shrink: 0;
  font-size: 14px;
  font-weight: 600;
  line-height: 1.8;
  min-height: 34px;
  min-width: 64px;
  opacity: 1;
  pointer-events: auto;
  text-align: center;
  user-select: none;
  vertical-align: middle;
  background-color: #fff;
  color: #357a00;
  margin-left: 4px;
  border-radius: 8px;
  white-space: nowrap;
  transition: background-color 0.1s ease-out 0s, border-color;
  border: 1px solid #357a00;
  padding: 3px 15px;
}
</style>
