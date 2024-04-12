<template>
  <div v-if="posts.length" class="mypost_wrapper">
    <div v-for="(i, index) in posts" :key="index" class="content_box1">
      <p><font-awesome-icon :icon="['fas', 'tag']" />タグ</p>
      <nuxt-link :to="`/post/${i.id}`">
        <h3 class="post_title">
          {{ i.title }}
        </h3>
      </nuxt-link>
      <p class="post_date">{{ i.formatted_created_at }}</p>
    </div>
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
    };
  },
  mounted() {
    this.fetchData();
  },
  methods: {
    async fetchData() {
      try {
        const response = await this.$axios.get("api/v1/posts/liked_posts");
        this.posts = response.data;
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
