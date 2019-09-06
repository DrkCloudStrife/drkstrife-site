import VueRouter from 'vue-router'
import Article from './components/Article';
import ArticleListing from './components/ArticleListing';

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

const router = new VueRouter({
  mode: 'history',
  routes,
  scrollBehavior (to, from, savedPosition) {
    return { x: 0, y: 0 }
  }
})

export default router
