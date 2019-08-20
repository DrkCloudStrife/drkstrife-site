import VueRouter from 'vue-router'
import Article from './components/article';
import ArticleListing from './components/articleListing';

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
  routes: routes
})

export default router
