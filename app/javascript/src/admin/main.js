import 'es6-promise/auto'

import dayjs from 'dayjs'
import dayjs_utc from 'dayjs/plugin/utc'
import { createApp } from 'vue'
import App from '@sharedComponents/App.vue'
import router from './router.js'

let AdminDashboard

// Init app
document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('admin-dashboard')

  if (element != null && !AdminDashboard) {
    dayjs.extend(dayjs_utc)

    AdminDashboard = createApp(App, { appId: 'admin-dashboard-app' })
    AdminDashboard.use(router)
    //AdminDashboard.use(store)
    AdminDashboard.provide('$dayJS', dayjs)
    router.replace('/admin').then(() => {
      AdminDashboard.mount(element);
    });
  }
})

// Clear cache
document.addEventListener("turbolinks:before-cache", () => {
  if (AdminDashboard) {
    AdminDashboard.unmount();
    AdminDashboard = null;
  }
})

// Unload app
document.addEventListener('turbolinks:before-visit', () => {
  if (AdminDashboard) {
    AdminDashboard.unmount()
    AdminDashboard = null
  }
})

export default AdminDashboard
