<template>
  <div>
    <div v-if="loading">
      Loading...
    </div>

    <div v-if="error">
      {{ error }}
    </div>

    <div v-for="article in articles">
      <article>
        <div class="image-container pull-left">
          <i class="fa" :class="article.linkIcon"></i>
        </div>
        <div class="link-container">
          <header class="text-header">
            <h2 class="title">
              <router-link :to="{ name: 'Article', params: article }">{{article.linkText || article.title}}</router-link>
            </h2>
          </header>
          <p>{{ article.createdAt || 'N/A' }}</p>
        </div>
      </article>
    </div>
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

        fetch(apiEndpoint, {cache: "no-cache"}).then((response) => {
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
