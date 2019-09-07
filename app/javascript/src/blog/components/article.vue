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
        <div v-if="imageLinkLocal" class="header-image">
          <img :src="require(`images/${ this.imageLinkLocal}`)" :alt="imageAlt()"/>
        </div>

        <vue-markdown :source='markdownLocal'></vue-markdown>
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
      markdown: String,
      imageLink: String,
      createdAt: String
    },

    data () {
      return {
        idLocal: this.id,
        slugLocal: this.slug,
        titleLocal: this.title,
        markdownLocal: this.markdown,
        imageLinkLocal: this.imageLink,
        createdAtLocal: this.createdAt,
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
