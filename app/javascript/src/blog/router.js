import { createWebHistory, createRouter } from "vue-router";
import Article from './components/Article.vue';
import ArticleListing from './components/ArticleListing.vue';

const routes = [
  {
    path: '/',
    name: 'Home',
    component: ArticleListing,
  },
  {
    path: '/articles/:slug',
    name: 'Article',
    props: true,
    component: Article
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior (to, from, savedPosition) {
    return { x: 0, y: 0 }
  }
})

export default router
