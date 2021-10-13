<template>
  <q-page class="q-pa-md">
    <ToolBar>
      <template v-slot:title>
        បណ្ដាញសង្គម
      </template>
    </ToolBar>
    <div>
      <div class="q-pb-md q-gutter-sm">
        <q-btn size=".7em" round color="primary" icon="add" @click="state.post.showDialog = true"/>
        <q-btn size=".7em" round color="primary" icon="edit" />
      </div>
      <q-table
        :rows="rdPost.state.table.data.record"
        :columns="rdPost.state.table.columns"
        row-key="name"
      />
    </div>
    <NewPost v-model="state.post.showDialog"/>
  </q-page>
</template>

<script lang="ts">
import {defineComponent, reactive} from "vue";
import {readPost} from "pages/post/store/post.store";
import ToolBar from "components/ToolBar.vue";
import NewPost from "pages/post/NewPost.vue";

export default defineComponent({
  name: "Post",
  components: {NewPost, ToolBar},
  setup: () => {
    const rdPost = readPost()
    const state = reactive({
      post: {
        showDialog: false
      }
    })
    const md = {}
    return {
      state,
      md,
      rdPost
    }
  }
})
</script>

<style scoped>

</style>
