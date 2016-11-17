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
  snakeLength: 4
  snakeCells: []
  userScore: 0

  # game colors
  boardBackground: '#FFF'
  boardBorder: '#000'
  snakeColor: '#0B6274'
  snakeBorder: '#FFF'
  pillColor: '#D0342D'
  pillBorder: '#FFF'

  constructor: (elementID)->
    @$el = $(elementID)
    @_buildCanvas()

    @startGame()

  # Builds the board and game assets
  startGame: ()->
    @_drawBoard()
    @_createSnake()
    @_createPill()

  # Builds a canvas where our snake game will live
  _buildCanvas: ()->
    @canvas = $('<canvas>')[0]
    @context = @canvas.getContext('2d')

    @canvas.width = @boardWidth
    @canvas.height = @boardHeight

    @$el.html(@canvas)

  # Draws the board to the canvas
  _drawBoard: ()->
    @context.fillStyle = @boardBackground
    @context.fillRect(0, 0, @boardWidth, @boardHeight)
    @context.strokeStyle = @boardBorder
    @context.strokeRect(0, 0, @boardWidth, @boardHeight)

  # Creates the snake in memory so we can keep track of it in the canvas
  _createSnake: ()->
    i = @snakeLength
    while i > 0
      @snakeCells.push({ x: i, y: 0 })
      i--

  # Creates the pill, or food for the snake to eat in memory so we can keep
  # track in memory
  # TODO: Ensure pill is not within the snake
  _createPill: ()->
    @pill =
      x: Math.round(Math.random() * (@boardWidth - @cellWidth) / @cellWidth)
      y: Math.round(Math.random() * (@boardHeight - @cellWidth) / @cellWidth)
