<template>
    <q-dialog
      v-model="state.globalDialog.showDialog"
      persistent
      :maximized="true"
      transition-show="slide-up"
      transition-hide="slide-down"
    >
      <q-card>
        <q-bar style="height: 55px">
          <q-btn size=".7em" v-close-popup color="negative" round flat  icon="arrow_back_ios" />
          <q-toolbar-title>
            <div class="text-primary text-bold text-center">
              <slot name="appbar-title"/>
            </div>
          </q-toolbar-title>
          <q-btn size=".7em" v-close-popup round color="negative" flat icon="cancel" class="float-right"/>
        </q-bar>
        <div class="q-pt-sm">
          <slot name="content" />
        </div>
      </q-card>
    </q-dialog>
</template>

<script lang="ts">
import {computed, defineComponent, reactive} from "vue";

export default defineComponent({
  name: "GlobalDialog",
  props: {
    value: {
      type: Boolean,
      default: false
    }
  },
  setup: (props, ctx) => {
    const state = reactive({
      globalDialog: {
        showDialog: computed({
          get: () => props.value,
          set: (value) => ctx.emit('input', value)
        })
      }
    })
    const md = {}
    return {
      state,
      md
    }
  }
})

</script>

<style scoped>

</style>
