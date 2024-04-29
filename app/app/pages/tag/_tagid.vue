<template>
  <div class="home_wrapper">
    <div class="left">
      <div class="tag_box">
        <h1>{{ tag.tag_name }}</h1>
        <div class="tag_post_count">
          <p>{{ total_count }}</p>
          <p>記事</p>
        </div>
      </div>
      <div class="user_lanking">ユーザーランキング</div>
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
export default {
  data() {
    return {
      id: null,
      currentPage: 1,
      totalPages: 0,
      total_count: 0,
      tag: [],
      posts: [],
    };
  },
  async asyncData({ params, $axios }) {
    const id = params.tagid;
    const response = await $axios.get(
      `${process.env.baseUrl}/api/v1/posts/${id}/list_posts_by_tag`
    );
    return {
      id: id,
      posts: response.data.posts,
      tag: response.data.tag,
      total_count: response.data.total_count,
      totalPages: response.data.total_pages,
    };
  },
  methods: {
    async changePage(page) {
      const response = await this.$axios.get(
        `${process.env.baseUrl}/api/v1/posts/${this.id}/list_posts_by_tag`,
        {
          params: {
            page: page,
          },
        }
      );
      this.posts = response.data.posts;
      this.tag = response.data.tag;
      this.totalPages = response.data.total_pages;
      this.currentPage = page;
    },
  },
};
</script>

<style>
.tag_box {
  background-color: #fff;
  border-radius: 10px;
  width: 80%;
  margin: 0 auto;
  text-align: center;
  margin-bottom: 30px;
}

.tag_box > h1 {
  border-bottom: 1px solid #828282;
  font-size: 1.5rem;
  padding: 10px 0;
}

.tag_post_count {
  font-size: 1.1rem;
}
</style>
