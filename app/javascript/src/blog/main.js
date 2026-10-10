import 'es6-promise/auto'

import dayjs from 'dayjs'
import dayjs_utc from 'dayjs/plugin/utc'
import { createApp } from 'vue'
import App from '@sharedComponents/App.vue'
import router from './router.js'
import store from './store/index.js'

let Blog

// Init Blog
document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('home-blog')

  if (element != null && !Blog) {
    dayjs.extend(dayjs_utc)

    Blog = createApp(App, { appId: 'blog-app' })
    Blog.use(router)
    Blog.use(store)
    Blog.provide('$dayJS', dayjs)
    router.replace('/').then(() => {
      Blog.mount(element);
    });
  }
})

// Clear cache
document.addEventListener("turbolinks:before-cache", () => {
  if (Blog) {
    Blog.unmount();
    Blog = null;
  }
})

// Unload Blog
document.addEventListener('turbolinks:before-visit', () => {
  if (Blog) {
    Blog.unmount()
    Blog = null
  }
})

export default Blog
