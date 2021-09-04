<template>
  <q-layout view="lHh Lpr lFf">
    <q-header elevated>
      <q-toolbar class="text-bold bg-brown-5">
        <q-btn
          flat
          dense
          round
          icon="menu"
          aria-label="Menu"
          @click="methods.toggleLeftDrawer()"
        />

        <q-toolbar-title>
          ឃ្វែរសារ Application
        </q-toolbar-title>

        <div class="cursor-pointer">
          <q-avatar color="brown" icon="person" >
            <q-menu style="min-width: 350px">
              <div class="row no-wrap q-pa-md">
                <div class="column">
                  <div class="text-h6 q-mb-md">Profile</div>
                </div>

                <q-separator vertical inset class="q-mx-lg" />

                <div class="column items-center">
                  <q-avatar size="72px">
                    <img src="https://scontent.fpnh1-1.fna.fbcdn.net/v/t1.6435-9/174195216_2573943746235372_1277976070297917715_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=9twnPncznd0AX9TmKsW&_nc_ht=scontent.fpnh1-1.fna&oh=9d008109248d860747c770d3c73a19c6&oe=61578421">
                  </q-avatar>

                  <div class="text-bold text-h5 q-mt-md q-mb-xs">
                    {{ state.getUser?.['user']?.name || 'Display Name' }}
                  </div>
                  <div class="text-subtitle1 q-mt-md q-mb-xs">
                    <q-input
                      outlined
                      dense
                      readonly
                      label="Username"
                      lazy-rules
                      :rules="[ val => val && val.length > 0 || 'Please type something']"
                     :model-value="state.getUser?.['user']?.username || 'Username'"
                    />
                    <q-input
                      outlined
                      dense
                      readonly
                      label="Email"
                      lazy-rules
                      :rules="[ val => val && val.length > 0 || 'Please type something']"
                     :model-value="state.getUser?.['user']?.email || 'Email'"
                    />
                  </div>

                  <q-btn
                    outline
                    color="negative"
                    label="Logout"
                    size="sm"
                    @click="methods.logout()"
                    to="/login"
                    v-close-popup
                  />
                </div>
              </div>
            </q-menu>
          </q-avatar>
        </div>
      </q-toolbar>
    </q-header>

    <q-drawer
      v-model="state.leftDrawerOpen"
      bordered
    >
      <q-list>
        <q-item-label
          header
        >
          <div class="text-bold text-h5">
            បញ្ចីមីនុយ
          </div>
        </q-item-label>
        <q-item
          :key="index"
          v-for="(item, index) in state.listMenu"
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

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script lang="ts">

import {computed, defineComponent, reactive} from 'vue'
import {useQuasar} from 'quasar'
import {LOGIN_INFO_KEY} from "app/helpers/utils";
export default defineComponent({
  name: 'MainLayout',

  components: {},

  setup (props, ctx) {
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
      getUser: computed(() => {
        return $q.localStorage.getItem(LOGIN_INFO_KEY)
      })
    })

    const methods = {
      toggleLeftDrawer: () => {
        state.leftDrawerOpen = !state.leftDrawerOpen
      },
      logout: () => {
        $q.localStorage.clear()
        window.location.reload()
      },
    }
    return {
      state,
      methods
    }
  }
})
</script>
