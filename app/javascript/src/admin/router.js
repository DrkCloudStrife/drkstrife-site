import { createWebHistory, createRouter } from "vue-router";
import Dashboard from './components/Dashboard.vue'

const routes = [
  {
    path: '/admin',
    name: 'Dashboard',
    component: Dashboard
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
