<template>
  <div v-if="show" class="modal1">
    <div class="modal-wrap1">
      <p>本当に削除しますか？</p>
      <button @click="$emit('confirm')" class="post_submit btn_delete">
        はい
      </button>
      <button @click="$emit('cancel')" class="post_submit">いいえ</button>
    </div>
  </div>
</template>

<script>
export default {
  props: ["show"],
};
</script>

<style>
.modal1 {
  position: fixed;
  top: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
}
.modal-wrap1 {
  background-color: #fff;
  width: 50%;
  padding: 20px;
  border-radius: 10px;
  text-align: center;
}
</style>
