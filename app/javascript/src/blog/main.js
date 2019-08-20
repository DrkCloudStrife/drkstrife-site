import Vue from 'vue'
import VueRouter from 'vue-router'
import VueMarkdown from 'vue-markdown'

import App from './App.vue'
import router from './router.js'

Vue.use(VueRouter)
Vue.use(VueMarkdown)

const Blog = new Vue({
  el: '#home-blog',
  router,
  render: h => h(App)
});

export default Blog
