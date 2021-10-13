import {reactive} from "vue";

export function mainDrawerData() {
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
  const md = {
    toggleLeftDrawer: () => {
      state.leftDrawerOpen = !state.leftDrawerOpen;
      console.log(state.leftDrawerOpen)
    }
  }
  return {
    state,
    md
  }
}
