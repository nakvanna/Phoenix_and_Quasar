<template>
  <q-page class="q-pa-md">
    <ToolBar>
      <template v-slot:title>
        អ្នកប្រើប្រាស់
      </template>
    </ToolBar>
    <div class="q-pa-md">
      <q-table
        title="USERS"
        :rows="rdUser.state.table.data.record"
        :columns="rdUser.state.table.columns"
        row-key="name"
      >
        <template v-slot:body-cell-profile="props">
          <q-td :props="props" auto-width>
            <q-avatar size="72px">
              <img :src="props.value">
            </q-avatar>
          </q-td>
        </template>
      </q-table>
    </div>
  </q-page>
</template>

<script lang="ts">
import {defineComponent, reactive} from "vue";
import {readUser} from "pages/user/store/user.store";
import ToolBar from "components/ToolBar.vue";

export default defineComponent( {
  name: "User",
  components: {ToolBar},
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
