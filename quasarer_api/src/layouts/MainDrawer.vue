<template>
  <q-drawer
    v-model="data.state.leftDrawerOpen"
    bordered
  >
    <q-list>
      <q-item-label header >
        <div class="text-bold text-h5">
          បញ្ចីមីនុយ {{state.drawer}}
        </div>
      </q-item-label>
      <q-item
        :key="index"
        v-for="(item, index) in data.state.listMenu"
        clickable v-ripple
        :to="item.to"
        active
        :active-class="'bg-'+item.color+'-2'"
      >
        <q-item-section avatar>
          <q-avatar :color="item.color+'-5'" :text-color="item.color+'-2'" :icon="item.icon" />
        </q-item-section>

        <q-item-section>
          <q-item-label class="text-bold" :class="'text-'+item.color">{{ item.name }}</q-item-label>
          <q-item-label caption>{{ item.caption }}</q-item-label>
        </q-item-section>

        <q-item-section side>
          <q-icon name="mdi-chevron-right" :color="item.color+'-5'" />
        </q-item-section>
      </q-item>
    </q-list>
  </q-drawer>
</template>

<script lang="ts">
import {computed, defineComponent, reactive} from "vue";
import {mainDrawerData} from "layouts/store/main-layout.store";

export default defineComponent({
  name: "MainDrawer",
  setup: () => {
    const data = mainDrawerData()
    const state = reactive({
      drawer: computed(() => data.state.leftDrawerOpen)
    })

    return {
      state,
      data,
    }
  }
})
</script>

<style scoped>

</style>
