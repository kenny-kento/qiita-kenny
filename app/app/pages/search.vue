<template>
  <div class="search_content_wrapper">
    <div class="search_target">
      <p class="keyword">検索結果が表示される</p>
    </div>
    <div class="search_result">
      <div class="serch_result_content flex">
        <div class="content_left">
          <p class="circle">写真</p>
        </div>
        <div class="content_right">
          <p class="post_user_name">@kenny</p>
          <time class="post_date">2023年07月7日</time>
          <!-- <nuxt-link :to="/"> -->
          <h3 class="post_title">記事のタイトル</h3>
          <!-- </nuxt-link> -->
          <p><font-awesome-icon :icon="['fas', 'tag']" />タグ</p>
          <p>いいね数</p>
        </div>
      </div>
      <div class="serch_result_content flex">
        <div class="content_left">
          <p class="circle">写真</p>
        </div>
        <div class="content_right">
          <p class="post_user_name">@kenny</p>
          <time class="post_date">2023年07月7日</time>
          <!-- <nuxt-link :to="/"> -->
          <h3 class="post_title">記事のタイトル</h3>
          <!-- </nuxt-link> -->
          <p><font-awesome-icon :icon="['fas', 'tag']" />タグ</p>
          <p>いいね数</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {};
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
  /* height: 100px; */
  /* font-size: 1.2rem;*/
  line-height: 1.5;
  /* line-height: 2; */
}

.search_target > .keyword {
  /* margin: 15px 0 0 0; */
  font-size: 1.2rem;
  /* line-height: 2; */
}

.search_result {
  background-color: #ffffff;
  border-radius: 10px;
  padding: 15px 0;
}

.serch_result_content {
  /* margin-top: 15px; */
  border-top: 1px solid black;
  padding: 5px;
}
</style>
