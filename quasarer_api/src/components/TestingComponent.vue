<template>
  <div>HELLO THE {{state.model}}</div>
</template>

<script lang="ts">
import {computed, defineComponent, reactive} from "vue";

export default defineComponent({
  name: "TestingComponent",
  props: {
    value: {
      type: String,
      default: "World"
    }
  },
  setup: (props, ctx) => {
    const state = reactive({
      model: computed({
        get: () => props.value,
        set: (val) => ctx.emit('input', val)
      })
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
