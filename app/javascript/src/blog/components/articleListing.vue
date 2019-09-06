<template>
  <div>
    <div v-if="loading">
      Loading...
    </div>

    <div v-if="error">
      {{ error }}
    </div>

    <div v-for="article in articles">
      <article :id="article.id">
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
  export default {
    data () {
      return {
        articles: [],
        loading: true,
        error: null
      }
    },

    mounted () {
      this.loading = true

      if (this.$store.getters.articles.filter((article) => article.slug !== undefined).length !== 0) {
        this.loadData()
      }
      else {
        this.$store.dispatch('fetchArticles').then(this.loadData)
      }
    },

    methods: {
      loadData () {
        this.articles = this.$store.getters.articles
        this.loading = false
      }
    }
  }
</script>

<style scoped>
</style>
