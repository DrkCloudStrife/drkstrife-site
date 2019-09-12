import assert from 'assert'

import Blog from '../../../app/javascript/src/blog/main.js'

describe('Blog', () => {
  var blog;

  beforeEach(() => {
    blog = Blog;
  });

  describe('presence', () => {
    it('should exist', () => {
      assert.ok(blog)
    });

    it('should have a store', () => {
      assert.ok(blog.$store)
    });

    it('should have a router', () => {
      assert.ok(blog.$router)
    });
  });

});
