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
      <vue-markdown class="container" :source='markdownLocal'></vue-markdown>
    </article>
  </div>
</template>

<script>
  import VueMarkdown from 'vue-markdown'
  const apiPath = "/api/v1/articles/";

  export default {
    props: {
      id: Number,
      slug: String,
      title: String,
      markdown: String,
      createdAt: Date
    },

    data () {
      return {
        idLocal: this.id,
        slugLocal: this.slug,
        titleLocal: this.title,
        markdownLocal: this.markdown,
        createdAtLocal: this.createdAt
      }
    },

    mounted () {
      if (typeof this.title === "undefined") {
        this.fetchData()
      }
    },

    methods: {
      fetchData () {
        fetch(`${apiPath + this.slug}.json`).then((response) => {
          if(!response.ok) {
             throw Error(response.statusText)
          }

          return response.json()
        }).then((data) => {
          for(var item of Object.keys(data)) {
            this[`${item}Local`] = data[item]
          }
        }).catch((error) => {
          console.log(error)
        })
      },

    },

    components: {
      VueMarkdown
    }

  }
</script>

<style scoped>
</style>
