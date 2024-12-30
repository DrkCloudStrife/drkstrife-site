import 'es6-promise/auto'

import dayjs from 'dayjs'
import dayjs_utc from 'dayjs/plugin/utc'
import { createApp } from 'vue'
import App from './components/App.vue'
import router from './router.js'
import store from './store/index.js'

const Blog = createApp(App)

dayjs.extend(dayjs_utc)

Blog.use(router)
Blog.use(store)
Blog.provide('$dayJS', dayjs)
Blog.mount('#home-blog')

export default Blog
