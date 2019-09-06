import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

// modules
import Articles from './modules/article'

const store = new Vuex.Store({
  modules: {
    articles: Articles
  },
})

export default store
