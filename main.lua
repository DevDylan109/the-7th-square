package.path = package.path .. 'C:\\LuaProjects\\boardgame\\?.lua'

_G.love = require('love')
_G.sti = require('libraries/sti')
_G.gameMap = sti('maps/blockymap.lua')
_G.game = require('boardgame')
_G.bot = require('bot')

local function square()
  return {
    row = 0,
    col = 0
  }
end

function love.load()
  game.initBoard()
  _G.blueTile = love.graphics.newImage('maps/Single Blocks/Blue.png')
  _G.lightTile = love.graphics.newImage('maps/Single Blocks/LightBlue.png')
  _G.board = game.board
  bot.initialize(game)

  _G.Testmessage = ''
  _G.Selected = false
  _G.oldSelection = square()
  _G.HoveringTiles = false
  _G.prevSquare = square()
  _G.nextSquare = square()

  local red = 237 / 255
  local green = 195 / 255
  local blue = 121 / 255
  love.graphics.setBackgroundColor(red, green, blue)
  _G.counter = 0;
end

function love.update(dt)
  _G.mouse_x, _G.mouse_y = love.mouse.getPosition()

  if mouse_x >= 192 and mouse_x <= 192 + 576 and mouse_y >= 64 and mouse_y <= 64 + 576 then
    Testmessage = 'cursor is within board'
  else
    Testmessage = ''
  end

  counter = counter + 1
  if counter % 180 == 0 then
    game.isGameOver()
    bot.makeMoveAsBot()
  end
  -- game.printBoard()
end

function love.draw()
  gameMap:draw()

  for i, row in ipairs(board) do
    for j, col in ipairs(row) do
      local tileX = (j * 64) + 192
      local tileY = (i * 64) + 64

      love.graphics.draw(col.image, tileX, tileY)
      if mouse_x >= tileX and mouse_x <= tileX + 64 and mouse_y >= tileY and mouse_y <= tileY + 64 then
        HoveringTiles = true
        love.graphics.print('cursor is hovering a tile', 0, 40)
        love.graphics.draw(blueTile, tileX, tileY)

        if love.mouse.isDown(1) then
          if Selected and HoveringTiles then
            if mouse_x >= oldSelection.col and mouse_x <= oldSelection.col + 64 and mouse_y >= oldSelection.row and mouse_y <= oldSelection.row + 64 then

            else
              nextSquare.col = j
              nextSquare.row = i
              game.makeMove(prevSquare, nextSquare, ' H ')
              oldSelection.col = tileX
              oldSelection.row = tileY
              Selected = false
            end
          elseif HoveringTiles then        
              prevSquare.col = 0
              prevSquare.row = 0
              nextSquare.col = 0
              nextSquare.row = 0
              prevSquare.col = j
              prevSquare.row = i
              oldSelection.col = tileX
              oldSelection.row = tileY
              Selected = true           
          end
          love.graphics.print('old square: ' .. prevSquare.col .. ',' .. prevSquare.row, 0, 60)
          love.graphics.print('new square: ' .. nextSquare.col .. ',' .. nextSquare.row, 0, 80)
        else
          HoveringTiles = false
        end
      end
    end
  end
  love.graphics.print("position: X " .. mouse_x .. ' Y ' .. mouse_y)
  love.graphics.print(Testmessage, 0, 20)
end
