<template>
  <q-page class="q-pa-lg">
    <ToolBar>
      <template v-slot:title>
        ទំព័រដើម
      </template>
    </ToolBar>
    <q-list :key="index" separator v-for="(item, index) in rdHomePost.state.table.data.record">
      <q-item v-ripple>
        <q-card bordered class="bg-grey-9" style="width: 100%">
          <q-card-section>
            <div class="row">
              <div class="full-width" style="font-size: 20px; font-weight: bold">
                <q-avatar class="q-pr-md" size="72px">
                  <img :src="item['user']['profile']">
                </q-avatar>
                {{ item['user']['name'] }}
              </div>
              <div class="full-width text-center float-left q-pt-sm">
                <div class="text-h6">{{ item['title'] }}</div>
              </div>
            </div>
          </q-card-section>
          <q-separator dark inset/>
          <q-card-section>
            <div v-html="item['content']"></div>
          </q-card-section>
          <q-card-section v-if="item['mediaPosts'].length">
            <div class="row q-gutter-xs">
              <div class="col">
                <q-img
                  :src="md.home.getImageFullUrl(item['mediaPosts'], 0)"
                  :ratio="1/2"
                />
              </div>
              <div class="col">
                <q-img
                  :src="md.home.getImageFullUrl(item['mediaPosts'], 1)"
                  :ratio="1/2"
                />
              </div>
            </div>

          </q-card-section>
        </q-card>
      </q-item>
    </q-list>
  </q-page>
</template>

<script lang="ts">
import {defineComponent, reactive} from "vue";
import ToolBar from "components/ToolBar.vue";
import {readHomePost} from "pages/home/store/home.store";
import {MediaPostModel} from "pages/post/model/post.model";
import {SERVER_URL} from "src/helpers/utils";

export default defineComponent({
  name: "Home",
  components: {ToolBar},
  setup: () => {
    const rdHomePost = readHomePost()
    const state = reactive({})
    const md = {
      home: {
        getImageFullUrl: (data: MediaPostModel[], index: number) => {
          return SERVER_URL + '/' + data[index].fileUrl
        }
      }
    }
    return {
      state,
      md,
      rdHomePost
    }
  }
})
</script>

<style scoped>

</style>
