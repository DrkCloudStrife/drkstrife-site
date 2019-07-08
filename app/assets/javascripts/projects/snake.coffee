#= require ./config

# The objective of the game is to eat pills without colliding with self or walls
#
# As snake eats pills, snake increases in size
# When snake eats pill, the game will increase snake movement speed
# When snake collides with self is game over
# When snake collides with wall is game over

class DrkStrife.games.Snake
  # speed controls
  gameFPS: 60
  currentFPS: 0
  gameSpeed: 10
  gameMaxSpeed: 25
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
  isGameOver: false

  # game colors
  boardBackground: '#FFF'
  boardBorder: '#000'
  snakeColor: '#0B6274'
  snakeBorder: '#FFF'
  pillColor: '#D0342D'
  pillBorder: '#FFF'
  textColor: '#333'

  # Default font settings
  fontSize: 24
  fontType: 'px'
  fontFamily: 'Arial'

  constructor: (elementID)->
    @$el = $(elementID)
    @_buildCanvas()

    @$canvas.attr('tabindex',0)
    @$canvas.on('focus', @play)
    @$canvas.on('blur', @pause)
    @$canvas.on('keydown', @_toggleMovement)

    @$canvas.attr('contentEditable', true)
    @$canvas[0].contentEditable = true

  # Builds the board and game assets
  startGame: ()->
    @resetGame()
    @_buildSnake()
    @_createPill()
    @draw()

  # Starts updating game and rendering
  play: ()=>
    return if @isGameOver
    @_refreshRateIntervalId = setInterval(@loop, 1000 / @gameFPS) # 60 fps
    @_gameSpeedIntervalId   = setInterval(@update, 1000 / @gameSpeed)

  # Pauses the game from updating and rendering
  pause: ()=>
    clearInterval(@_refreshRateIntervalId) if @_refreshRateIntervalId
    clearInterval(@_gameSpeedIntervalId) if @_gameSpeedIntervalId

  # Draws into canvas what is currently happening in the game
  draw: ()->
    @_drawBoard()
    @_drawPill()
    @_drawSnake()

  # Resets the snake game to it's starting configuration
  resetGame: ()->
    @pause()
    @snakeLength = 4
    @snakeCells = []
    @userScore = 0
    @direction = 'right'
    @isMoving = false

  endGame: ()->
    @pause()
    @_drawBoard()
    # TODO: dynamically set position to center based on canvas and text
    @_drawText("Game Over", { position: [250, 190] })

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

  _drawText: (text, opts={})->
    position = opts.position || [0,0]
    color    = opts.color    || @textColor

    @context.font = "#{@fontSize}#{@fontType} #{@fontFamily}"
    @context.fillStyle = color
    @context.fillText(text, position[0], position[1])

  # Checks that the pill is not colliding with the current location of the
  # snake and then renders it, otherwise it will search for a new location
  # where to place the pill
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
      when key is 27 or key is 9
        @$canvas.blur()
        false
      else false

    if typeof newDirection isnt 'undefined' and newDirection isnt @direction and newDirection isnt false
      @direction = newDirection
      @isMoving  = true

    return false # used to prevent page scrolling

  # Logic to move the snake within the grid of the canvas
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

    @validate(newPosition)

    if newPosition.x is @pill.x and newPosition.y is @pill.y
      @_createPill()
    else
      @snakeCells.pop()

    # TODO: Add scoring
    @snakeCells.unshift(newPosition)

    @isMoving = false if @isMoving is true

  # Validations of snake position
  # Should end game if snake is out of bound
  # Should end game if snake collides with self
  validate: (nextPosition)->
    endGame = false
    nx = nextPosition.x
    ny = nextPosition.y

    # check out of bound
    endGame = true if nx <= -1 or ny <= -1
    endGame = true if nx >= (@boardWidth / @cellWidth)
    endGame = true if ny >= (@boardHeight / @cellWidth)

    # check snake collision
    i = 0
    while i < @snakeCells.length
      cells = @snakeCells[i]
      endGame = true if cells.x is nx and cells.y is ny
      i++

    # TODO: Add end game view
    if endGame
      @isGameOver = endGame
      @endGame()

  # Updates the snake position,
  update: ()=>
    @moveSnake()

  loop: ()=>
    @draw()


$ ->
  window.app = new DrkStrife.games.Snake('#viewport')
  app.startGame()
