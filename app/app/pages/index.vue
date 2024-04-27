<template>
  <div class="home_wrapper">
    <div class="left">
      <p>ユーザーランキング</p>
      <div class="user_lanking">ここにリストが表示される</div>
    </div>
    <div class="right">
      <PostList
        :posts="posts"
        :totalPages="totalPages"
        :currentPage="currentPage"
        @page-changed="changePage"
      />
    </div>
  </div>
</template>

<script>
import Vue from "vue";
import $axios from "axios";

export default Vue.extend({
  data() {
    return {
      currentPage: 1,
      totalPages: 0,
      posts: [],
    };
  },
  async asyncData() {
    const response = await $axios.get(`${process.env.baseUrl}/api/v1/posts`);
    return {
      posts: response.data.posts,
      totalPages: response.data.total_pages,
    };
  },
  methods: {
    async changePage(page) {
      const response = await $axios.get(
        `${process.env.baseUrl}/api/v1/posts?page=${page}`
      );

      this.posts = response.data.posts;
      this.totalPages = response.data.total_pages;
      this.currentPage = page;
    },
  },
});
</script>

<style>
.home_wrapper {
  display: flex;
  height: auto;
  padding: 15px;
}

.left {
  flex: 1;
}

.right {
  flex: 1.5;
}

.user_lanking {
  border: 1px solid black;
  width: 80%;
  margin: 0 auto;
  height: 60vh;
  text-align: center;
}
</style>
