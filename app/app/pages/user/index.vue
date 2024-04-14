<template>
  <div class="wrapper flex_center">
    <div class="wrapper_left">
      <div class="profile_box">
        <img
          :src="user.icon_url ? user.icon_url : '/user_default.png'"
          alt="写真"
          class="circle"
        />
        <p class="user_name">@{{ user.name }}</p>
        <div class="count_box">
          <div class="post_count_box">
            <p>{{ user.posts_count }}</p>
            <p>投稿</p>
          </div>
          <div class="like_count_box">
            <p>{{ user.received_likes_count }}</p>
            <p>いいね</p>
          </div>
        </div>
        <p>{{ user.profile_text }}</p>
        <button class="btn_edit">
          <nuxt-link to="/user/profile-edit">
            プロフィールを編集する
          </nuxt-link>
        </button>
      </div>
    </div>
    <div class="wrapper_right1">
      <div class="flex2">
        <button
          @click="isPost = true"
          class="btn_post"
          :class="{ btn_post_active: isPost, btn_post_inactive: !isPost }"
        >
          記事
        </button>
        <button
          @click="isPost = false"
          class="btn_post"
          :class="{ btn_post_active: !isPost, btn_post_inactive: isPost }"
        >
          いいね
        </button>
      </div>
      <MyPost v-if="isPost" />
      <MyLike v-else />
    </div>
  </div>
</template>

<script>
import MyPost from "./my-post.vue";
import MyLike from "./my-like.vue";

export default {
  middleware: "check-auth",
  components: {
    MyPost,
    MyLike,
  },
  data() {
    return {
      isPost: true,
      localError: null,
    };
  },
  computed: {
    user() {
      return this.$store.state.user.user;
    },
  },
  asyncData({ store }) {
    return store.dispatch("user/fetchUser");
  },
};
</script>

<style>
.flex {
  display: flex;
}

.flex_center {
  display: flex;
  justify-content: center;
}

.flex2 {
  margin-bottom: 10px;
}

.wrapper_left {
  width: 30%;
  margin-right: 30px;
}

.wrapper_right1 {
  width: 50%;
  padding: 10px;
}

.profile_box {
  background-color: #fff;
  padding: 10px;
  text-align: center;
  border-radius: 10px;
}

.profile_box > .circle {
  margin: 0 auto;
  width: 80px;
  height: 80px;
  line-height: 80px;
}

.count_box {
  border-top: 1px solid #000;
  margin-top: 20px;
  padding-top: 10px;
  display: flex;
  justify-content: center;
}

.user_name {
  font-size: 1.3rem;
  font-weight: bold;
  margin: 10px 0;
}

.post_count_box {
  margin-right: 30px;
  font-weight: bold;
  font-size: 1.1rem;
}

.like_count_box {
  font-weight: bold;
  font-size: 1.1rem;
}

.btn_edit {
  border: none;
  padding: 10px 15px;
  border-radius: 10px;
  background-color: #d9d9d9;
  margin-bottom: 10px;
}

.btn_post {
  padding: 2px 15px;
  border-radius: 20px;
  border: none;
  font-size: 1.1rem;
  margin-right: 8px;
}

.btn_post_active {
  background-color: #55c500;
  color: #fff;
}

.btn_post_inactive {
  background-color: #fff;
  color: #000;
}
</style>
