<template>
  <div class="home_wrapper">
    <div class="left">
      <p>ユーザーランキング</p>
      <div class="user_lanking">ここにリストが表示される</div>
    </div>
    <div class="right">
      <div v-for="(i, index) in data" :key="index" class="content_box flex">
        <div class="content_left">
          <img
            :src="i.user.icon_url ? i.user.icon_url : '/user_default.png'"
            alt="写真"
            class="circle"
          />
        </div>
        <div class="content_right">
          <p class="post_user_name">@{{ i.user.name }}</p>
          <time class="post_date">{{ i.formatted_created_at }}</time>
          <nuxt-link :to="`/post/${i.id}`">
            <h3 class="post_title">
              {{ i.title }}
            </h3>
          </nuxt-link>
          <p><font-awesome-icon :icon="['fas', 'tag']" />タグ</p>
          <p>いいね数</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Vue from "vue";
import $axios from "axios";

export default Vue.extend({
  async asyncData() {
    const response = await $axios.get(`${process.env.baseUrl}/api/v1/posts`);
    return {
      data: response.data,
    };
  },
});
</script>

<style>
.home_wrapper {
  display: flex;
  height: auto;
  padding: 15px;
}

.flex {
  display: flex;
}

.left {
  flex: 1;
}

.right {
  flex: 1;
}

.content_left {
  margin: 0 15px;
}

.content_box {
  border-radius: 10px;
  background-color: #ffffff;
  margin-bottom: 5px;
  padding: 5px 8px;
}

.user_lanking {
  border: 1px solid black;
  width: 80%;
  margin: 0 auto;
  height: 70vh;
  text-align: center;
}

.content_right p {
  margin: 0;
}

.post_date {
  color: #9b9999;
}

.post_title {
  font-size: 1.3rem;
  font-weight: 400;
}
</style>
