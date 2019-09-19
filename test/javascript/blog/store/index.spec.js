import assert from 'assert'
import store from '../../../../app/javascript/src/blog/store/index.js'
import Article from '../../../../app/javascript/src/blog/store/modules/article.js'

describe('Store', () => {
  describe('presence', () => {
    it('should be defined', () => {
      assert.ok(store)
    })
  })

  describe('modules', () => {
    describe('articles', () => {
      var moduleName = 'articles'

      it('should not be registered to store', () => {
        assert.ok(typeof store.state[moduleName] == 'undefined')
      })

      it('should register to store', () => {
        store.registerModule(moduleName, Article)
        assert.ok(store.state[moduleName])
      })
    })
  })
})
