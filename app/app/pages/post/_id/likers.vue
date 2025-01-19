<template>
  <div class="content_wrapper1">
    <h1>いいねしたユーザー一覧が表示される</h1>
    <div class="user_list_container">
      <div v-for="user in userList" :key="user.id" class="user_box flex">
        <div class="user_box_left">
          <img
            :src="user.icon_url ? user.icon_url : '/user_default.png'"
            alt="写真"
            class="circle"
          />
        </div>
        <div class="user_box_right">
          <p class="user_name">@{{ user.name }}</p>
          <p>{{ user.profile_text }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    userList: [];
  },
  async asyncData({ params, $axios }) {
    const id = params.id;
    const response = await $axios.get(
      `${process.env.baseUrl}/api/v1/users/${id}/likers`
    );
    console.log(response.data);
    return {
      userList: response.data,
    };
  },
  methods() {},
};
</script>

<style>
.content_wrapper1 {
  width: 70%;
  margin: 15px auto;
  background-color: #fff;
  min-height: 50vh;
  padding: 10px;
}

.content_wrapper1 > h1 {
  font-size: 1.8rem;
}

.user_list_container {
  margin: 15px;
}

.user_box {
  border-bottom: 1px solid black;
  padding: 10px;
}

.user_box_right {
  margin-left: 10px;
}

.flex {
  display: flex;
}
</style>
