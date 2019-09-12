const Article = {
  state: {
    articles: [],
  },

  mutations: {
    setArticles (state, payload) {
      state.articles = payload
    },

    addArticle (state, payload) {
      if (state.articles.filter((article) => article.slug == payload.slug).length ==  0) {
        state.articles.push(payload)
      }
    }
  },

  getters: {
    article (state) { (slug) => {
      return state.articles.find(article => article.slug === slug)
    }},

    articles (state) {
      return state.articles
    }

  },

  actions: {
    fetchArticles (state) {
      return new Promise((resolve, reject) => {
        fetch("/api/v1/articles.json", {cache: "no-cache"}).then((response) => {
          if(!response.ok) {
            throw Error(response.statusText)
          }
          return response.json()
        }).then((data) => {
          state.commit('setArticles', data)
          resolve()
        }).catch((error) => {
          console.error(error)
          reject(error)
        })
      })
    },

    fetchArticle (state, { slug }) {
      return new Promise((resolve, reject) => {
        fetch(`/api/v1/articles/${slug}.json`).then((response) => {
          if(!response.ok) {
             throw Error(response.statusText)
          }

          return response.json()
        }).then((data) => {
          resolve(data)
        }).catch((error) => {
          console.error(error)
          reject(error)
        })
      })
    }
  }
}

export default Article
