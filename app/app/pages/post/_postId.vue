<template>
  <div class="post_content_wrapper">
    <FlashMessage />
    <!-- NOTE: 子コンポーネントからthis.dialogの更新通知を受け取るため -->
    <AuthModal :dialog.sync="dialog" />
    <div class="wrapper_left">
      <ul>
        <li>
          <button @click="handleLike" class="like-button">
            <div v-if="is_liked" class="circle">
              <font-awesome-icon
                :icon="['fas', 'heart']"
                class="font-awesome-size liked_post"
              />
            </div>
            <div v-else class="circle">
              <font-awesome-icon
                :icon="['far', 'heart']"
                class="font-awesome-size"
              />
            </div>
          </button>
        </li>
        <li>
          <div class="fab-box">
            <nuxt-link
              :to="`/post/${post.id}/edit`"
              v-if="post.is_current_user_post_owner"
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
            更新日:{{ post.formatted_updated_at }} 投稿日:{{
              post.formatted_created_at
            }}
          </p>
        </div>
      </div>
      <h1>{{ post.title }}</h1>
      <template v-if="post.tags.length">
        <p>
          <span v-for="t in post.tags" :key="t.id">
            <font-awesome-icon :icon="['fas', 'tag']" />
            {{ t.tag_name + "," }}
          </span>
        </p>
      </template>
      <template v-else>
        <p><font-awesome-icon :icon="['fas', 'tag']" />タグなし</p>
      </template>
      <div
        class="markdown markdown_wrapper"
        v-html="$md.render(post.content)"
      ></div>
    </div>
  </div>
</template>

<script>
import FlashMessage from "~/components/FlashMessage.vue";

export default {
  data() {
    return {
      post: [],
      is_liked: false,
      dialog: false,
    };
  },
  async asyncData({ params, $axios }) {
    const id = params.postId;
    const response = await $axios.get(
      `${process.env.baseUrl}/api/v1/posts/${id}`
    );
    return {
      post: response.data,
      is_liked: response.data.is_liked,
    };
  },
  methods: {
    handleLike() {
      if (!this.$auth.loggedIn) {
        this.dialog = true;
      } else {
        if (this.is_liked) {
          this.removeLike(this.post.id);
        } else {
          this.addLike();
        }
      }
    },
    //TODO:未ログイン状態でいいねを押すとログインがポップアップで求められるように調整が必要。
    async addLike() {
      try {
        await this.$axios.post("/api/v1/likes", {
          like: {
            post_id: this.post.id,
          },
        });
        this.is_liked = true;
      } catch (e) {
        console.log(e);
      }
    },
    async removeLike(id) {
      try {
        await this.$axios.delete(`/api/v1/likes/${id}`);
        this.is_liked = false;
      } catch (e) {
        console.log(e);
      }
    },
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

.liked_post {
  color: red;
}

.fab-box {
  width: 50px;
  height: 50px;
  text-align: center;
  line-height: 50px;
  font-size: 1.5rem;
}
</style>
