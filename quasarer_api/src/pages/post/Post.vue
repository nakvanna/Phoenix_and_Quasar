<template>
  <q-page class="q-ma-md">
    <q-card class="q-pt-md">
      <q-card-section>
        <q-form
          @submit=""
          @reset=""
        >
          <q-input
            label="Title"
            lazy-rules
            :rules="[ val => val && val.length > 0 || 'Please type something']"
          />
          <q-input
            label="Content"
            type="textarea"
            lazy-rules
            :rules="[ val => val && val.length > 0 || 'Please type something']"
          />
          <q-btn type="submit" rounded color="teal-5" class="full-width">Create</q-btn>
        </q-form>
      </q-card-section>
    </q-card>
  </q-page>
</template>

<script lang="ts">
import {defineComponent} from "vue";

export default defineComponent({
  name: "Post"
})
</script>

<style scoped>

</style>
