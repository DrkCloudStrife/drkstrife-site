<template>
  <div>
    <section>
      <router-link :to="{ name: 'Home' }">
        <i class="fa fa-caret-left"></i> Go Back
      </router-link>
    </section>

    <article class="article-container">
      <header class="text-header">
        <h2 class="title">{{ titleLocal }}</h2>
      </header>
      <div class="container">
        <div v-if="banner_urlLocal" class="header-image">
          <img :src="banner_urlLocal" :alt="imageAlt()"/>
        </div>

        <vue-markdown :source='bodyLocal'></vue-markdown>
      </div>
    </article>
  </div>
</template>

<script>
  import VueMarkdown from 'vue-markdown'
  import RegisterStoreModule from '../store/mixins/registerStoreModule'
  import Articles from '../store/modules/article'

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
        idLocal: this.id,
        slugLocal: this.slug,
        titleLocal: this.title,
        bodyLocal: this.body,
        banner_urlLocal: this.banner_url,
        created_atLocal: this.created_at,
      }
    },

    mixins: [RegisterStoreModule],

    created () {
      this.registerStoreModule('articles', Articles)
    },

    mounted () {
      if (typeof this.title === "undefined") {
        this.$store.dispatch('fetchArticle', { slug: this.slug }).then(this.updateLocalData)
      }
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
