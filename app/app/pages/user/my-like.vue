<template>
  <div v-if="posts.length" class="mypost_wrapper">
    <div v-for="(i, index) in posts" :key="index" class="content_box1">
      <template v-if="i.tags.length">
        <p>
          <span v-for="(t, index) in i.tags" :key="index">
            <font-awesome-icon :icon="['fas', 'tag']" />
            {{ t.tag_name }}
          </span>
        </p>
      </template>
      <template v-else>
        <p><font-awesome-icon :icon="['fas', 'tag']" />タグなし</p>
      </template>
      <nuxt-link :to="`/post/${i.id}`">
        <h3 class="post_title">
          {{ i.title }}
        </h3>
      </nuxt-link>
      <p class="post_date">{{ i.formatted_created_at }}</p>
    </div>
    <v-pagination
      v-model="currentPage"
      :length="totalPages"
      @input="fetchData"
    ></v-pagination>
  </div>
  <div v-else class="mypost_wrapper">
    <p>「いいね」をした投稿がありません</p>
  </div>
</template>

<script>
export default {
  data() {
    return {
      posts: [],
      // 現在のページ番号
      currentPage: 1,
      // 総ページ数
      totalPages: 0,
    };
  },
  mounted() {
    this.fetchData();
  },
  methods: {
    async fetchData() {
      try {
        const response = await this.$axios.get(
          `api/v1/posts/liked_posts?page=${this.currentPage}`
        );
        this.posts = response.data.posts;
        this.totalPages = response.data.total_pages;
        console.log(this.posts);
      } catch (e) {
        console.log(e);
      }
    },
  },
};
</script>

<style>
.post_date {
  text-align: right;
}

.content_box1 {
  padding: 16px;
  border-bottom: 1px solid #6e6969;
  background-color: #fff;
}

.mypost_wrapper {
  border: 1px solid #000;
  padding: 10px;
  background-color: #fff;
}
</style>
