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
    <div v-if="data.length" class="search_result">
      <div
        v-for="(i, index) in data"
        :key="index"
        class="serch_result_content flex"
      >
        <div class="content_left">
          <p class="circle">写真</p>
        </div>
        <div class="content_right">
          <p class="post_user_name">@{{ i.user.name }}</p>
          <time class="post_date">{{ i.formatted_created_at }}</time>
          <nuxt-link :to="`/post/${i.id}`">
            <h3
              class="post_title"
              v-html="highlightKeyword(i.title, keyword)"
            ></h3>
          </nuxt-link>
          <p><font-awesome-icon :icon="['fas', 'tag']" />タグ</p>
          <p>いいね数</p>
        </div>
      </div>
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
        "http://localhost:3001/api/v1/posts/search",
        {
          params: {
            keyword: keyword,
          },
        }
      );
      return {
        data: response.data,
        keyword: keyword,
      };
    } catch (error) {
      console.error("APIリクエストでエラーが発生しました:", error);
      return { data: [] };
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
  },
  data() {
    return {
      data: [],
      keyword: "",
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
