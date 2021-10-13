<template>
  <GlobalDialog v-model="state.newPost.showDialog">
    <template v-slot:appbar-title>
      បង្ហោះអត្តបទ
    </template>
    <template v-slot:content>
      <TestingComponent v-model="state.newPost.testing"/>
      <q-card class="q-pt-md">
        <q-card-section>
          <q-form @submit="crPost.md.post.create()" @reset="crPost.md.post.clear()">
            <q-select
              v-model="crPost.state.post.input.status"
              :options="state.newPost.statusPost.options"
              label="Standard"
              :rules="[ val => val && val.length > 0 || 'Please type something']"
            />
            <q-input
              v-model="crPost.state.post.input.title"
              label="Title"
              lazy-rules
              :rules="[ val => val && val.length > 0 || 'Please type something']"
            />
            <EditorComponent v-model="crPost.state.post.input.content"/>
            <div class="q-py-sm">
              <q-uploader
                accept=".jpg, image/*"
                :factory="md.factoryFn"
                multiple
                class="full-width"
              >
                <template v-slot:list="scope">
                  <q-list separator>
                    <q-item v-for="file in scope.files" :key="file.name">
                      <q-item-section>
                        <q-item-label class="full-width ellipsis">
                          {{ file.name }}
                        </q-item-label>

                        <q-item-label caption>
                          Status: {{ file.__status }}
                        </q-item-label>

                        <q-item-label caption>
                          {{ file.__sizeLabel }} / {{ file.__progressLabel }}
                        </q-item-label>
                      </q-item-section>

                      <q-item-section
                        v-if="file.__img"
                        thumbnail
                        class="gt-xs"
                      >
                        <img :src="file.__img.src">
                      </q-item-section>

                      <q-item-section top side>
                        <q-btn
                          class="gt-xs"
                          size="12px"
                          flat
                          dense
                          round
                          icon="delete"
                          @click="scope.removeFile(file)"
                        />
                      </q-item-section>
                    </q-item>
                  </q-list>
                </template>
              </q-uploader>
            </div>
            <q-btn type="submit" rounded color="teal-5" class="full-width">Create</q-btn>
          </q-form>
        </q-card-section>
      </q-card>
    </template>
  </GlobalDialog>
</template>

<script lang="ts">
import {computed, defineComponent, reactive} from "vue";
import GlobalDialog from "components/GlobalDialog.vue";
import {createPost} from "pages/post/store/post.store";
import {useMutation} from "@vue/apollo-composable";
import {fileUploadGraphql} from "pages/upload/file-upload.graphql";
import axios from "axios";
import {crudMessage, SERVER_URL, UPLOAD_URL} from "src/helpers/utils";
import EditorComponent from "components/EditorComponent.vue";
import TestingComponent from "components/TestingComponent.vue";

export default defineComponent({
  name: "NewPost",
  components: {TestingComponent, EditorComponent, GlobalDialog},
  props: {
    value: {
      type: Boolean,
      default: false
    }
  },
  setup: (props, ctx) => {
    const crPost = createPost()
    const state = reactive({
      newPost: {
        showDialog: computed({
          get: () => props.value,
          set: (value) => ctx.emit('input', value)
        }),
        testing: "Haha",
        statusPost: {
          options: [
            'only-me', 'public', 'friend'
          ]
        }
      },

    })
    const md = {
      factoryFn: (files: [File]) => {
        const formData = new FormData()
        formData.append('file', files[0])
        axios.post(UPLOAD_URL, formData).then(res => {
          crPost.state.post.input.mediaPosts.push({
            fileType: 'image',
            fileUrl: res.data.url,
          })
        })
      }
    }
    return {
      state,
      md,
      crPost
    }
  }
})
</script>

<style scoped>

</style>
