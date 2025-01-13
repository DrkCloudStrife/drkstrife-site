<template>
  <div>
    <section>
      <router-link :to="{ name: 'Home' }">
        <i class="fa fa-caret-left"></i> Go Back
      </router-link>
    </section>

    <article class="article-container">
      <div v-if="loading">
        Loading...
      </div>
      <header v-if="!loading" class="text-header">
        <h2 class="title">{{ titleLocal }}</h2>
      </header>
      <div v-if="!loading" class="container">
        <div v-if="banner_urlLocal" class="header-image">
          <img :src="banner_urlLocal" :alt="imageAlt()"/>
        </div>

        <vue-markdown v-if="bodyLocal" :source="bodyLocal" />
      </div>
    </article>
  </div>
</template>

<script>
  import VueMarkdown from "vue-markdown-render";
  import RegisterStoreModule from '../store/mixins/registerStoreModule.js'
  import Articles from '../store/modules/article.js'

  export default {
    props: {
      id: Number,
      slug: String,
      title: String,
      body: String,
      banner_url: String,
      created_at: String
    },

    data () {
      return {
        banner_urlLocal: this.banner_url,
        bodyLocal: this.body,
        created_atLocal: this.created_at,
        idLocal: parseInt(this.id),
        loading: true,
        slugLocal: this.slug,
        titleLocal: this.title,
      }
    },

    mixins: [RegisterStoreModule],

    created () {
      this.registerStoreModule('articles', Articles)
    },

    mounted() {
      this.loading = true
      if (typeof this.title === "undefined") {
        this.$store.dispatch('fetchArticle', { slug: this.slug }).then(this.updateLocalData)
      }
      this.loading = false
    },

    methods: {

      updateLocalData (data) {
        for(var item of Object.keys(data)) {
          this[`${item}Local`] = data[item]
        }
      },

      imageAlt () {
        return `Image of ${this.titleLocal}`
      }

    },

    components: {
      VueMarkdown
    }

  }
</script>

<style scoped>
</style>
