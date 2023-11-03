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
          <i class="fa" :class="article.link_fa_icon"></i>
        </div>
        <div class="link-container">
          <header class="text-header">
            <h2 class="title">
              <router-link :to="{ name: 'Article', params: article }">{{article.link_text || article.title}}</router-link>
            </h2>
          </header>
          <p>{{ publishedDate(article.created_at) || 'N/A' }}</p>
        </div>
      </article>
    </div>
  </div>
</template>

<script>
  import RegisterStoreModule from '../store/mixins/registerStoreModule'
  import Articles from '../store/modules/article'

  export default {
    inject: ['$dayJS'],
    data () {
      return {
        articles: [],
        loading: true,
        error: null
      }
    },

    mixins: [RegisterStoreModule],

    created () {
      this.registerStoreModule('articles', Articles)
    },

    mounted () {
      this.loading = true

      if (this.$store.getters.articles.length === 0) {
        this.$store.dispatch('fetchArticles').then(this.loadData)
      }
      else {
        this.loadData()
      }
    },

    methods: {
      loadData () {
        this.articles = this.$store.getters.articles
        this.loading = false
      },

      publishedDate(createdAt) {
        return this.$dayJS(createdAt).format("MMM DD, YYYY")
      }
    }
  }
</script>

<style scoped>
</style>
