<template>
  <header>
    <div class="contents">
      <div class="header_left">
        <nuxt-link to="/">
          <p class="header_container">Qiita</p>
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
          <li>
            <nuxt-link to="/post">
              <button class="post_page">投稿する</button>
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

        this.$router.push("/");
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
</style>
