<template>
  <q-header elevated>
    <q-toolbar class="text-bold bg-brown-5">
      <q-btn
        flat
        dense
        round
        icon="menu"
        aria-label="Menu"
        @click="mainDrawer.md.toggleLeftDrawer()"
      />
      <q-toolbar-title class="text-center text-bold">
        <slot name="title" />
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
                  <img :src="user.profile">
                </q-avatar>

                <div class="text-bold text-h5 q-mt-md q-mb-xs">
                  {{ user.name }}
                </div>
                <div class="text-subtitle1 q-mt-md q-mb-xs">
                  <q-input
                    outlined
                    dense
                    readonly
                    label="Username"
                    lazy-rules
                    :rules="[ val => val && val.length > 0 || 'Please type something']"
                    :model-value="user.username"
                  />
                  <q-input
                    outlined
                    dense
                    readonly
                    label="Email"
                    lazy-rules
                    :rules="[ val => val && val.length > 0 || 'Please type something']"
                    :model-value="user.email"
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
</template>

<script lang="ts">
import {defineComponent, reactive} from "vue";
import {mainDrawerData} from "layouts/store/main-layout.store";
import {useQuasar} from "quasar";
import {getGlobalUser} from "src/helpers/utils";

export default defineComponent({
  name: "ToolBar",
  setup: (_props, _ctx) => {
    const $q = useQuasar()
    const mainDrawer = mainDrawerData()
    const user = getGlobalUser()
    const state = reactive({})
    const methods = {
      logout: () => {
        $q.localStorage.clear()
        window.location.reload()
      },
    }
    return {
      state,
      methods,
      mainDrawer,
      user
    }
  }
})
</script>

<style scoped>

</style>
