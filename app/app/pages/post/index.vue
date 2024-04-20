<template>
  <form @submit.prevent="newPost">
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
      <button class="post_submit btn_green">公開する</button>
    </div>
  </form>
</template>

<script>
export default {
  data: function () {
    return {
      title: "",
      content: "",
      inputTag: "",
      tags: [],
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
          // 含まれていなければ追加
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
    async newPost() {
      try {
        await this.$axios.post("/api/v1/posts", {
          post: {
            title: this.title,
            content: this.content,
            tags: this.tags,
          },
        });
        this.$router.push("/");
      } catch (e) {
        console.log(e);
      }
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
}

textarea {
  height: 50vh;
}

.post_submit_container {
  border-top: 1px solid black;
  padding: 10px;
  text-align: right;
}
</style>
