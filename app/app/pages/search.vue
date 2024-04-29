<template>
  <div class="search_content_wrapper">
    <div class="search_target">
      <p class="keyword">
        {{
          keyword
            ? `「${keyword}」の検索結果`
            : "キーワードが指定されておりません"
        }}
      </p>
    </div>
    <div v-if="posts.length" class="search_result">
      <div
        v-for="post in posts"
        :key="post.id"
        class="serch_result_content flex"
      >
        <div class="content_left">
          <img
            :src="post.user.icon_url ? post.user.icon_url : '/user_default.png'"
            alt="写真"
            class="circle"
          />
        </div>
        <div class="content_right">
          <p class="post_user_name">@{{ post.user.name }}</p>
          <time class="post_date">{{ post.formatted_created_at }}</time>
          <nuxt-link :to="`/post/${post.id}`">
            <h3
              class="post_title"
              v-html="highlightKeyword(post.title, keyword)"
            ></h3>
          </nuxt-link>
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
          <p>
            <font-awesome-icon :icon="['fas', 'heart']" />{{ post.likes_count }}
          </p>
        </div>
      </div>
      <v-pagination
        v-model="currentPage"
        :length="totalPages"
        @input="changePage"
      ></v-pagination>
    </div>
    <div v-else class="search_result">
      <p>検索キーワードを含む記事がヒットしませんでした</p>
    </div>
  </div>
</template>

<script>
export default {
  async asyncData({ $axios, query }) {
    const keyword = query.q;
    try {
      const response = await $axios.get(
        `${process.env.baseUrl}/api/v1/posts/search`,
        {
          params: {
            keyword: keyword,
          },
        }
      );
      return {
        posts: response.data.posts,
        keyword: keyword,
        totalPages: response.data.total_pages,
      };
    } catch (error) {
      console.error("APIリクエストでエラーが発生しました:", error);
      return { posts: [] };
    }
  },
  watchQuery: ["q"],
  methods: {
    highlightKeyword(title, keyword) {
      if (!keyword.trim()) {
        return title;
      }
      // RegExp.escape関数がないため、正規表現で使用される特殊文字をエスケープします。
      const escapedKeyword = keyword.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
      const regex = new RegExp(`(${escapedKeyword})`, "gi");
      return title.replace(regex, '<span class="highlight">$1</span>');
    },
    async changePage() {
      const response = await this.$axios.get(
        `${process.env.baseUrl}/api/v1/posts/search`,
        {
          params: {
            keyword: this.keyword,
            page: this.currentPage,
          },
        }
      );
      this.posts = response.data.posts;
      this.totalPages = response.data.total_pages;
    },
  },
  data() {
    return {
      posts: [],
      keyword: "",
      currentPage: 1,
      totalPages: 0,
    };
  },
};
</script>

<style>
.search_content_wrapper {
  width: 70%;
  margin: 0 auto;
}

.search_target {
  margin: 25px 0;
  padding: 10px;
  background-color: #ffffff;
  border-radius: 10px;
  display: flex;
  align-items: center;
  line-height: 1.5;
}

.search_target > .keyword {
  font-size: 1.2rem;
}

.search_result {
  background-color: #ffffff;
  border-radius: 10px;
  padding: 15px 0;
  margin-bottom: 20px;
}

.serch_result_content {
  border-top: 1px solid black;
  padding: 5px;
}

.highlight {
  background-color: yellow;
  font-weight: bold;
}
</style>
