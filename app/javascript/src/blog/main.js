import Vue from 'vue'
import VueRouter from 'vue-router'

import App from './App.vue'
import router from './router.js'

Vue.use(VueRouter)

const Blog = new Vue({
  el: '#home-blog',
  router,
  render: h => h(App)
});

export default Blog
