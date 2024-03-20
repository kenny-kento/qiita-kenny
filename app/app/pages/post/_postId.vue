<template>
  <div class="post_content_wrapper">
    <div class="wrapper_left">
      <ul>
        <li>
          <div class="circle">
            <font-awesome-icon
              :icon="['far', 'heart']"
              class="font-awesome-size"
            />
          </div>
        </li>
        <li>
          <div class="fab-box">
            <nuxt-link
              :to="`/post/${data.id}/edit`"
              v-if="data.is_current_user_post_owner"
            >
              <font-awesome-icon
                :icon="['fas', 'pen-to-square']"
                class="font-awesome-size"
              />
            </nuxt-link>
          </div>
        </li>
      </ul>
    </div>

    <div class="wrapper_right">
      <div class="author_box">
        <p class="circle"></p>
        <div class="content_right">
          <p>@kenny</p>
          <p>
            更新日:{{ data.formatted_updated_at }} 投稿日:{{
              data.formatted_created_at
            }}
          </p>
        </div>
      </div>
      <h1>{{ data.title }}</h1>
      <span>タグ1</span>
      <div
        class="markdown markdown_wrapper"
        v-html="$md.render(data.content)"
      ></div>
    </div>
  </div>
</template>

<script>
export default {
  async asyncData({ params, $axios }) {
    const id = params.postId;
    const response = await $axios.get(
      `${process.env.baseUrl}/api/v1/posts/${id}`
    );
    return {
      data: response.data,
    };
  },
};
</script>

<style lang="scss" scoped>
.post_content_wrapper {
  width: 80%;
  margin: 0 auto;
  margin-top: 10px;
  height: auto;
  min-height: 70vh;
  display: flex;
  justify-content: center;
}

.post_content_wrapper > h1 {
  font-weight: bold;
  font-size: 1.5rem;
  margin: 20px 0;
}

.wrapper_right {
  background-color: #ffffff;
  padding: 10px 25px;
}

.author_box {
  display: flex;
}

.content_right {
  margin-left: 20px;
}

.markdown_wrapper {
  border-top: 1px solid black;
  margin: 20px 0;
  padding: 10px 5px;
}

.wrapper_left {
  margin: 10px 30px;
}

.wrapper_left li {
  margin-bottom: 15px;
}

.font-awesome-size {
  font-size: 1.3rem;
}

.fab-box {
  width: 50px;
  height: 50px;
  text-align: center;
  line-height: 50px;
  font-size: 1.5rem;
}
</style>
