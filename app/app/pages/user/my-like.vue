<template>
  <div v-if="posts.length" class="mypost_wrapper">
    <div v-for="post in posts" :key="post.id" class="content_box1">
      <template v-if="post.tags.length">
        <p>
          <span v-for="t in post.tags" :key="t.id">
            <font-awesome-icon :icon="['fas', 'tag']" />
            <nuxt-link :to="`/tag/${t.id}`">{{ t.tag_name }}</nuxt-link>
          </span>
        </p>
      </template>
      <template v-else>
        <p><font-awesome-icon :icon="['fas', 'tag']" />タグなし</p>
      </template>
      <nuxt-link :to="`/post/${post.id}`">
        <h3 class="post_title">
          {{ post.title }}
        </h3>
      </nuxt-link>
      <p class="post_date">{{ post.formatted_created_at }}</p>
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
      currentPage: 1,
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
        this.posts = response.data.posts ? response.data.posts : [];
        this.totalPages = response.data.total_pages;
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
