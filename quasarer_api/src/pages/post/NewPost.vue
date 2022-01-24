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
            <q-editor v-model="crPost.state.post.input.content"
                      :dense="$q.screen.lt.md"
                      :toolbar="[
        [
          {
            label: $q.lang.editor.align,
            icon: $q.iconSet.editor.align,
            fixedLabel: true,
            list: 'only-icons',
            options: ['left', 'center', 'right', 'justify']
          },
          {
            label: $q.lang.editor.align,
            icon: $q.iconSet.editor.align,
            fixedLabel: true,
            options: ['left', 'center', 'right', 'justify']
          }
        ],
        ['bold', 'italic', 'strike', 'underline', 'subscript', 'superscript'],
        ['token', 'hr', 'link', 'custom_btn'],
        ['print', 'fullscreen'],
        [
          {
            label: $q.lang.editor.formatting,
            icon: $q.iconSet.editor.formatting,
            list: 'no-icons',
            options: [
              'p',
              'h1',
              'h2',
              'h3',
              'h4',
              'h5',
              'h6',
              'code'
            ]
          },
          {
            label: $q.lang.editor.fontSize,
            icon: $q.iconSet.editor.fontSize,
            fixedLabel: true,
            fixedIcon: true,
            list: 'no-icons',
            options: [
              'size-1',
              'size-2',
              'size-3',
              'size-4',
              'size-5',
              'size-6',
              'size-7'
            ]
          },
          {
            label: $q.lang.editor.defaultFont,
            icon: $q.iconSet.editor.font,
            fixedIcon: true,
            list: 'no-icons',
            options: [
              'default_font',
              'arial',
              'arial_black',
              'comic_sans',
              'courier_new',
              'impact',
              'lucida_grande',
              'times_new_roman',
              'verdana'
            ]
          },
          'removeFormat'
        ],
        ['quote', 'unordered', 'ordered', 'outdent', 'indent'],

        ['undo', 'redo'],
        ['viewsource']
      ]"
                      :fonts="{
        arial: 'Arial',
        arial_black: 'Arial Black',
        comic_sans: 'Comic Sans MS',
        courier_new: 'Courier New',
        impact: 'Impact',
        lucida_grande: 'Lucida Grande',
        times_new_roman: 'Times New Roman',
        verdana: 'Verdana'
      }"
            />
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
import axios from "axios";
import {UPLOAD_URL} from "src/helpers/utils";
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
