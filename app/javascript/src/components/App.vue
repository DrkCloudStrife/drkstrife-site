<template>
  <div :id="appId">
    <router-view />
  </div>
</template>

<script setup>
defineProps({
  appId: {
    type: String,
    required: true,
    default: 'default-app-layout'
  }
})
</script>

<style scoped>
</style>
