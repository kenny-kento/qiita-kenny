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
      <div v-for="(i, index) in posts" :key="index" class="content_box flex">
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
          <template v-if="i.tags.length">
            <p>
              <span v-for="(t, index) in i.tags" :key="index">
                <font-awesome-icon :icon="['fas', 'tag']" />
                <nuxt-link :to="`/tag/${t.id}`">{{ t.tag_name }}</nuxt-link>
              </span>
            </p>
          </template>
          <template v-else>
            <p><font-awesome-icon :icon="['fas', 'tag']" />タグなし</p>
          </template>
          <p>
            <font-awesome-icon :icon="['fas', 'heart']" />{{ i.likes_count }}
          </p>
        </div>
      </div>
      <v-pagination
        v-model="currentPage"
        :length="totalPages"
        @input="changePage"
      ></v-pagination>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      currentPage: 1,
      totalPages: 0,
      total_count: 0,
      tag: [],
      posts: [],
    };
  },
  async asyncData({ params, $axios }) {
    console.log(params);
    const id = params.tagid;
    console.log(id);
    const response = await $axios.get(
      `${process.env.baseUrl}/api/v1/posts/${id}/list_posts_by_tag`
    );
    console.log(response);
    return {
      posts: response.data.posts,
      tag: response.data.tag[0],
      total_count: response.data.total_count,
      totalPages: response.data.total_pages,
    };
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
