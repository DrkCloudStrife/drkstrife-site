<template>
  <div>
    <div v-if="loading">
      Loading...
    </div>

    <div v-if="error">
      {{ error }}
    </div>

    <ul v-for="article in articles">
      <router-link :to="{ name: 'Article', params: article }">{{article.title}}</router-link>
    </ul>
  </div>
</template>

<script>
  const apiEndpoint = "/api/v1/articles.json";

  export default {
    data () {
      return {
        articles: [],
        loading: true,
        error: null
      }
    },

    mounted () {
      this.fetchData()
    },

    methods: {
      fetchData () {
        this.loading = true

        fetch(apiEndpoint).then((response) => {
          if(!response.ok) {
            throw Error(response.statusText)
          }
          return response.json()
        }).then((data) => {
          this.loading = false
          this.articles = data
        }).catch((error) => {
          console.log(error)
        })
      }
    }
  }
</script>

<style scoped>
</style>
