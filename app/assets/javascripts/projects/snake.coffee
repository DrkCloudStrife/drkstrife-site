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

  # canvas dimensions (px)
  boardWidth: 600
  boardHeight: 400
  cellWidth: 10

  # default settings
  # snakeCellWidth: 10 # - might not need if we use cellWidth properly
  # snakeCellHeight: 10
  snakeLength: 5
  snakeCells: []
  userScore: 0

  # game colors
  boardBackground: '#FFF'
  boardBorder: '#000'
  snakeColor: '#0B6274'
  snakeBorder: '#FFF'

  constructor: (elementID)->
    @$el = $(elementID)
    @_buildCanvas()

    # TODO: Move these to start game
    # @drawBoard()
    # @createSnake()
    # @drawSnake()
    #
    @startGame()

  # Will also work as reset
  startGame: ()->
    @_drawBoard()

  _buildCanvas: ()->
    @canvas = $('<canvas>')[0]
    @context = @canvas.getContext('2d')

    @canvas.width = @boardWidth
    @canvas.height = @boardHeight

    @$el.html(@canvas)

  _drawBoard: ()->
    @context.fillStyle = @boardBackground
    @context.fillRect(0, 0, @boardWidth, @boardHeight)
    @context.strokeStyle = @boardBorder
    @context.strokeRect(0, 0, @boardWidth, @boardHeight)
