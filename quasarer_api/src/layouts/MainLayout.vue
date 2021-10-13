<template>
  <q-layout view="lHh Lpr lFf">
    <MainDrawer />
    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script lang="ts">

import {computed, defineComponent, reactive} from 'vue'
import {useQuasar} from 'quasar'
import {LOGIN_INFO_KEY} from "src/helpers/utils";
import MainDrawer from "layouts/MainDrawer.vue";
export default defineComponent({
  name: 'MainLayout',

  components: {MainDrawer},

  setup (_props, _ctx) {
    const $q = useQuasar()

    const state = reactive({
      leftDrawerOpen: true,
      listMenu: [
        {
          icon: 'mdi-home',
          color: 'red',
          name: 'ទំព័រដើម',
          caption: 'Home page',
          to: '/'
        },{
          icon: 'mdi-account-multiple',
          color: 'pink',
          name: 'អ្នកប្រើប្រាស់',
          caption: 'User page',
          to: '/user'
        },{
          icon: 'mdi-bootstrap',
          color: 'purple',
          name: 'បង្ហោះអត្តបទ',
          caption: 'Post page',
          to: '/post'
        },
      ],
    })

    const methods = {

    }
    return {
      state,
      methods
    }
  }
})
</script>
