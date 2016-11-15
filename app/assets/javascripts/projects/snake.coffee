#= require ./config

# The objective of the game is to eat pills without colliding with self or walls
#
# As snake eats pills, snake increases in size
# When snake eats pill, the game will increase snake movement speed
# When snake collides with self is game over
# When snake collides with wall is game over

class DrkStrife.games.Snake
  # speed controls
  gameSpeed: 85
  gameMaxSpeed: 35
  speedDidChange: false

  # default settings
  cellWidth: 10
  snakeLength: 5
  snakeCells: []
  userScore: 0

  backgroundColor: '#FFF'
  backgroundBorder: '#000'

  snakeColor: '#0B6274'
  snakeBorder: '#FFF'

  constructor: (options={})->
    # TODO: implement snake
