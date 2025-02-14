<template>
  <div>
    <ConfirmModal
      :show="showModal"
      @confirm="deletePost(id)"
      @cancel="cancel"
    />

    <form @submit.prevent="editPost(id)">
      <div class="content_wrapper">
        <ul>
          <li>
            <input type="text" placeholder="記事タイトル" v-model="title" />
          </li>
          <li>
            <input
              type="text"
              placeholder="タグを入力してください。カンマ(,)区切りで入力できます。"
              v-model="inputTag"
              @change="addTags"
            />
          </li>
          <li>
            <textarea
              placeholder="知識をMarkdown記法で書いて共有しよう"
              v-model="content"
            ></textarea>
          </li>
        </ul>
      </div>
      <div class="post_submit_container">
        <ul>
          <li>
            <button
              class="post_submit btn_delete"
              @click.prevent="showConfirmModal"
            >
              削除する
            </button>
          </li>
          <li>
            <button class="post_submit btn_green">公開する</button>
          </li>
        </ul>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      title: "",
      content: "",
      tags: [],
      inputTag: "",
      showModal: false,
    };
  },
  async asyncData({ params, $axios, redirect }) {
    const id = params.id;
    const response = await $axios.get(
      `${process.env.baseUrl}/api/v1/posts/${id}`
    );
    if (!response.data.is_current_user_post_owner) {
      return redirect(`/post/${id}`);
    }
    return {
      id: response.data.id,
      title: response.data.title,
      content: response.data.content,
      inputTag: response.data.tags.map((tag) => tag.tag_name).join(", "),
    };
  },
  methods: {
    addTags() {
      // カンマでタグを分割し、空白を削除して新しいタグの配列を生成する
      const newTags = this.inputTag
        .split(",")
        .map((tag) => tag.trim())
        .filter((tag) => tag.length > 0);

      // Setを使用して、効率的に重複を避けながら既存タグと新規タグを比較する
      const currentTagsSet = new Set(this.tags);
      const newTagsSet = new Set(newTags);

      // 新規タグで現在のタグセットを更新する
      newTags.forEach((tag) => {
        // 新規タグが既存のセットに含まれるかチェック
        if (!currentTagsSet.has(tag)) {
          currentTagsSet.add(tag);
        }
      });

      this.tags.forEach((tag) => {
        // 現在のタグが新規タグセットに含まれていない場合は削除
        if (!newTagsSet.has(tag)) {
          currentTagsSet.delete(tag);
        }
      });

      // `this.tags`を更新したタグ配列で置き換える
      this.tags = Array.from(currentTagsSet);
    },
    async editPost(id) {
      try {
        await this.$axios.put(`/api/v1/posts/${id}`, {
          post: {
            title: this.title,
            content: this.content,
            tags: this.tags,
          },
        });
        this.$router.push(`/post/${id}`);
        this.$store.dispatch("flashMessage/showMessage", {
          message: "記事を更新しました",
          type: "success",
          status: true,
        });
      } catch (e) {
        console.log(e);
      }
    },
    showConfirmModal() {
      this.showModal = true;
    },
    async deletePost(id) {
      try {
        await this.$axios.delete(`/api/v1/posts/${id}`);
        this.$router.push("/");
      } catch (e) {
        console.log(e);
      }

      this.showModal = false;
    },
    cancel() {
      this.showModal = false;
    },
  },
};
</script>

<style>
.content_wrapper {
  width: 97%;
  margin: 0 auto;
}

li > input,
textarea {
  width: 100%;
  margin-bottom: 15px;
  background-color: #fff;
  border: 1px solid black;
}

textarea {
  height: 50vh;
}

.post_submit_container {
  border-top: 1px solid black;
  padding: 10px;
}

.post_submit_container ul {
  display: flex;
  justify-content: flex-end;
}

.btn_delete {
  background-color: red;
  color: white;
}
</style>
