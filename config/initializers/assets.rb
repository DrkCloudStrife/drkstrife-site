# http://guides.rubyonrails.org/configuring.html#configuring-assets
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.enabled = true


Rails.application.config.assets.precompile += %w(
  font-awesome.min.css
  mobile.css
  projects/maze.js
  projects/snake.js
)
