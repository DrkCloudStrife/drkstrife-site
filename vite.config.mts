import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import vue from '@vitejs/plugin-vue'
import path from 'path'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    vue(),
  ],
  resolve: {
    alias: {
      '@sharedComponents': path.resolve(__dirname, './app/javascript/src/components'),
      '@storeModules': path.resolve(__dirname, './app/javascript/src/stores/modules'),
      '@storeMixins': path.resolve(__dirname, './app/javascript/src/stores/mixins'),
      '@': path.resolve(__dirname, './app/javascript/src'),
    }
  },
})
