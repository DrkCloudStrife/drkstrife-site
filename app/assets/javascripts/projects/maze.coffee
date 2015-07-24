#= require ./config

class Game.Maze
  initialize: (@options={})->
    console.log 'a'

# Game.viewport = document.getElementById('viewport')
#
# # initial game configurations
# Game.config.total = 0
# Game.config.wallSize = 30
# Game.config.mazeSize = 600
# Game.config.mazeStart = Array(0,0)
# Game.config.controls = Array(0,0,0,0)
# Game.config.types = Array("wall","path","player", "exit")
# Game.config.baseBackground = "#F2F2F2"
# Game.config.baseWallColor = "#666666"
# Game.config.gameWallColor = "#3C3C3C"
#
# Game.actors.player = {}
# Game.actors.player.color = "#FFCC00"
# Game.actors.player.location = Game.config.mazeStart
#
#
# # Main application
# main(opts={})->
#   mazeWalls   = opts.mazeSize / opts.wallSize
#   Game.canvas = document.createElement('canvas')
#   Game.maze   = Game.canvas.getContext('2d')
#
#   Game.canvas.id     = "maze"
#   Game.canvas.width  = opts.mazeSize
#   Game.canvas.height = opts.mazeSize
#
#   # render canvas in viewport
#   Game.viewport.appendChild(Game.canvas)
#   paintMazeBackground()
#   i = 0
#   while i < mazeWalls
#     xIndex = i * opts.wallSize
#     gameLog [
#       'xIndex:'
#       xIndex
#     ]
#     x = 0
#     while x < mazeWalls
#       yIndex = x * opts.wallSize
#       gameLog [
#         'yIndex:'
#         yIndex
#       ]
#       paintWall xIndex, yIndex
#       x++
#     i++
#
#   generateMazePath()
#
#   gameLog [
#     "The Maze is:"
#     mazeWalls + ' x ' + mazeWalls
#   ]
#
# paintWall(x, y, color, type_id=0)->
#   return console.error("x must be defined") if x is null
#   return console.error("y must be defined") if y is null
#
#   if color is null
#     gameLog "visibility not set, defaulting to true."
#     color = Game.config.gameWallColor
#
#   type = Game.config.types[type_id]
#
#   gameLog [
#     'painting ' + type +' color:'
#     color
#   ]
#
#   Game.maze.fillStyle = color
#   Game.maze.fillRect(x, y, Game.config.wallSize, Game.config.wallSize)
#   borderColor = Game.config.baseWallColor if (type == "wall")
#   borderColor = "#000000" if (type == "player")
#   borderColor = color if (type == "path")
#   Game.maze.strokeStyle = Game.config.baseWallColor
#   Game.maze.strokeRect(x, y, Game.config.wallSize, Game.config.wallSize)
