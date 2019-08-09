<template>
  <div id="home-blog">
   <ArticleListing />
  </div>
</template>

<script>
import ArticleListing from './components/articleListing';
import Article from './components/article';

// TODO: Move to a config
const apiHost = ""

export default {
  data: () => {
    return {
      articles: []
    }
  },
  mounted: () => {
    fetch()
  },
  components: {
    ArticleListing,
  },
}
</script>

<style scoped>
</style>
