import 'es6-promise/auto'

import dayjs from 'dayjs'
import dayjs_utc from 'dayjs/plugin/utc'
import Vue from 'vue'
import VueRouter from 'vue-router'
import VueMarkdown from 'vue-markdown'

dayjs.extend(dayjs_utc)
Vue.use(VueRouter)
Vue.use(VueMarkdown)

import App from './components/App.vue'
import router from './router.js'
import store from './store/index.js'

const Blog = new Vue({
  provide() {
    return {
      $dayJS: dayjs
    }
  },
  el: '#home-blog',
  store,
  router,
  render: h => h(App)
});

export default Blog
