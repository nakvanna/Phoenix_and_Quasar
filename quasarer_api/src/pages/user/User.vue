<template>
  <q-page>
    <div class="q-pa-md">
      <q-table
        title="Treats"
        :rows="rdUser.state.table.data.record"
        :columns="rdUser.state.table.columns"
        row-key="name"
      />
    </div>
  </q-page>
</template>

<script lang="ts">
import {defineComponent, reactive} from "vue";
import {readUser} from "pages/user/store/user.store";

export default defineComponent( {
  name: "User",
  setup: () => {
    const rdUser = readUser()
    const state = reactive({

    })
    const md = {}

    return {
      state, md, rdUser
    }
  }
})
</script>

<style scoped>

</style>
