<template>
  <div>
    <div v-for="(post, index) in posts" :key="index" class="content_box flex">
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
          <h3 class="post_title">
            {{ post.title }}
          </h3>
        </nuxt-link>
        <template v-if="post.tags.length">
          <p>
            <span v-for="(t, index) in post.tags" :key="index">
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
</template>

<script>
export default {
  props: {
    posts: Array,
    totalPages: Number,
    currentPage: {
      type: Number,
      default: 1,
    },
  },
  methods: {
    changePage() {
      // 親コンポーネントへイベントを発信
      this.$emit("page-changed", this.currentPage);
    },
  },
};
</script>

<style>
.flex {
  display: flex;
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
