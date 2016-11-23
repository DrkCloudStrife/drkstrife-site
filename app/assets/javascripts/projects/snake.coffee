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
  snakeLength: 4
  snakeCells: []
  userScore: 0
  direction: 'right'
  isMoving: false

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

    @$canvas.attr('tabindex',0)
    @$canvas.on('keydown', @_toggleMovement)

    @$canvas.attr('contentEditable', true)
    @$canvas[0].contentEditable = true

    @startGame()

  # Builds the board and game assets
  startGame: ()->
    @_buildSnake()
    @_createPill()
    @draw()

  draw: ()->
    @_drawBoard()
    @_drawSnake()
    @_drawPill()

  # Builds a canvas where our snake game will live
  _buildCanvas: ()->
    @$canvas  = $('<canvas>')
    canvas   = @$canvas[0]
    @context = canvas.getContext('2d')

    canvas.width = @boardWidth
    canvas.height = @boardHeight

    @$el.html(canvas)

  # Builds the snake in memory so we can keep track of it in the canvas
  _buildSnake: ()->
    i = @snakeLength - 1
    while i >= 0
      @snakeCells.push({ x: i, y: 0 })
      i--

  # Creates the pill, or food for the snake to eat in memory so we can keep
  # track of it when drawing on canvas
  _createPill: ()->
    @pill =
      x: Math.round(Math.random() * (@boardWidth - @cellWidth) / @cellWidth)
      y: Math.round(Math.random() * (@boardHeight - @cellWidth) / @cellWidth)

  #### Canvas Drawings ####

  # Draws the game board to the canvas
  _drawBoard: ()->
    @context.fillStyle = @boardBackground
    @context.fillRect(0, 0, @boardWidth, @boardHeight)
    @context.strokeStyle = @boardBorder
    @context.strokeRect(0, 0, @boardWidth, @boardHeight)

  # Draws the snake to the canvas
  _drawSnake: ()->
    i = @snakeCells.length - 1
    while i >= 0
      cell = @snakeCells[i]
      @_drawCell(cell.x, cell.y)
      i--

  _drawPill: ()->
    if @snakeCells.indexOf(@pill) isnt -1
      @_createPill()
      return @_drawPill()

    @_drawCell(@pill.x, @pill.y, @pillColor, @pillBorder)

  # Draws a square on the board
  _drawCell: (x, y, color=@snakeColor, border=@snakeBorder)->
    posX = x * @cellWidth
    posY = y * @cellWidth

    @context.fillStyle = color
    @context.fillRect(posX, posY, @cellWidth, @cellWidth)
    @context.strokeStyle = border
    @context.strokeRect(posX, posY, @cellWidth, @cellWidth)

  #### End of drawings ####

  # Game Controls
  # TODO: if snake direction is changing, we should also queue the upcoming
  # movement to ensure the 180 degree takes effect if for some reason the
  # game fails to update the snake movement in time prior to the second
  # keystroke. i.e. If snake is going down, and user wants snake to go upward
  # instead, they would have to press left or right and up. If l/r is still
  # pending, we have to queue up and vice versa to ensure the 180 turn works
  # without causing collision.
  _toggleMovement: (e)=>
    e.preventDefault

    key = parseInt(e.keyCode)
    return false if @isMoving

    # Here we check which arrow key the user pressed and check that the snake
    # is not going the opposite direction so it doesn't collide with itself
    # causing an instant game over.
    newDirection = switch
      when key is 37 and @direction isnt 'right' then 'left' # left key is pressed
      when key is 39 and @direction isnt 'left' then 'right' # right key is pressed
      when key is 38 and @direction isnt 'down' then 'up'    # up key is pressed
      when key is 40 and @direction isnt 'up' then 'down'    # down key is pressed
      when key is 27 or key is 9 then @$canvas.blur(); false
      else false

    if typeof newDirection isnt 'undefined' and newDirection isnt @direction and newDirection isnt false
      @direction = newDirection
      @isMoving  = true
      # @update()

    return false # used to prevent page scrolling

  moveSnake: ()->
    snakeHeadXPosition = @snakeCells[0].x
    snakeHeadYPosition = @snakeCells[0].y

    switch @direction
      when 'right' then snakeHeadXPosition++
      when 'left' then snakeHeadXPosition--
      when 'up' then snakeHeadYPosition--
      when 'down' then snakeHeadYPosition++

    newPosition = {
      x: snakeHeadXPosition
      y: snakeHeadYPosition
    }

    if newPosition.x is @pill.x and newPosition.y is @pill.y
      @_createPill()
    else
      @snakeCells.pop()

    @snakeCells.unshift(newPosition)

    @isMoving = false if @isMoving is true
