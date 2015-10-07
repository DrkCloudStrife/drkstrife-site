#= require ./config

class DrkStrife.games.Maze
  constructor: (options={})->
    @config =
      wallSize: 30
      mazeSize: 600
      baseBackground: '#F2F2F2'
      baseWallColor: '#666666'
      gameWallColor: '#3C3C3C'

    @config = DrkStrife.utils.extend(@config, options)
    @config.mazeStart = DrkStrife.utils.generateStartingZone()

    @viewport = document.getElementById('viewport')

    # building a new actor (player 1)
    @player = @Actor("Player 1",
      location: @config.mazeStart
      color:    '#FFCC00'
    )

    #launching game
    @main(@config)

  score: 0

  controls = Array(0,0,0,0)

  # keeping until I find a good use for it
  # objectTypes = ['wall', 'path', 'actor', 'exit']

  gameLog = DrkStrife.utils.GameLog

  Actor: (name, opts={})->
    name:       name
    type:       'actor'
    location:   opts.location || Array(0,0)
    color:      opts.color || 'cyan'

  main: ()->
    mazeWalls = @config.mazeSize / @config.wallSize

    @canvas = document.createElement('canvas')
    @maze   = @canvas.getContext('2d')

    @canvas.id = 'maze'
    @canvas.width = @config.mazeSize
    @canvas.height = @config.mazeSize

    # render canvas to viewport
    @viewport.appendChild(@canvas)

    @paintMazeBackground()

    i = 0
    while i < mazeWalls
      xIndex = i * @config.wallSize
      gameLog [
        'xIndex:'
        xIndex
      ]
      x = 0
      while x < mazeWalls
        yIndex = x * @config.wallSize
        gameLog [
          'yIndex:'
          yIndex
        ]
        @paintBlock xIndex, yIndex
        x++
      i++

    @generateMazePath()

    gameLog [
      "The Maze is:"
      mazeWalls + ' x ' + mazeWalls
    ]


  paintBlock: (x, y, color, type='wall')->
    return console.error 'x must be defined' if x is null
    return console.error 'y must be defined' if y is null

    if color is null
      console.log "Color not set, using default."
      color = @config.gameWallColor

    gameLog [
      'painting ' + type + ' color:'
      color
    ]

    @maze.fillStyle = color
    @maze.fillRect(x, y, @config.wallSize, @config.wallSize)
    borderColor = @config.baseWallColor if (type == "wall")
    borderColor = "#000000" if (type == "player")
    borderColor = color if (type == "path")
    @maze.strokeStyle = @config.baseWallColor
    @maze.strokeRect(x, y, @config.wallSize, @config.wallSize)

  paintMazeBackground: ()->
    gameLog "Fresh board"
    @maze.fillStyle = @config.baseBackground
    @maze.fillRect(0, 0, @config.mazeSize, @config.mazeSize)
    @maze.strokeStyle = @config.baseWallColor
    @maze.strokeRect(0, 0, @config.mazeSize, @config.mazeSize)

  generateMazePath: ()->
    # initiate player location
    gameLog [
      "Player start"
      @player.location
    ]
    @paintBlock(@player.location[0], @player.location[1], @player.color, @player.type)
