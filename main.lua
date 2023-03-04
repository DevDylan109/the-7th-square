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


local function button(text, fn)
  return {
    text = text,
    fn = fn,

    now = false,
    last = false
  }
end


function love.load()
  game.initBoard()
  bot.initialize(game)

  _G.menuClosed = false;
  _G.buttons = {}
  _G.font = love.graphics.newFont(32)

  _G.playBtn = button('Play',
    function()
      print('start game')
      _G.menuClosed = true
    end
  )

  _G.optionsBtn = button('Options',
    function()
      print('Open Options')
    end
  )

  _G.exitBtn = button('Exit game',
    function()
      print('Close Window')
      love.window.close()
    end
  )

  _G.highscoreBtn = button('Highscores',
  function ()
    print('Show highscores')
  end
  )
  buttons[1] = playBtn
  buttons[2] = optionsBtn
  buttons[3] = exitBtn
  buttons[4] = highscoreBtn

  _G.ww = love.graphics.getWidth()
  _G.wh = love.graphics.getHeight()
  _G.button_width = ww * (1 / 3)
  _G.button_height = 60

  _G.sfx = love.audio.newSource('sounds/metronome.mp3', 'static')
  _G.blueTile = love.graphics.newImage('maps/Single Blocks/Blue.png')
  _G.lightTile = love.graphics.newImage('maps/Single Blocks/LightBlue.png')
  _G.board = game.board

  _G.DebugMsg = ''
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

  if love.keyboard.isDown("escape") then
    menuClosed = false
  end

  if menuClosed then
    if mouse_x >= 192 and mouse_x <= 192 + 576 and mouse_y >= 64 and mouse_y <= 64 + 576 then
      DebugMsg = 'cursor is within board'
    else
      DebugMsg = ''
    end

    counter = counter + 1
    if counter % 180 == 0 then
      bot.makeMoveAsBot()
      love.audio.play(sfx)
    end
    --game.printBoard()
  end
end

function love.draw()
  if not menuClosed then
    local margin = 16
    local total_height = button_height + margin * #buttons
    local position_y = 0

    for _, btn in ipairs(buttons) do
      btn.last = btn.now

      local btn_x = (ww * 0.5) - (button_width * 0.5)
      local btn_y = (wh * 0.5) - (button_height)
          - (total_height * 0.5)
          + position_y

      local color = { 235 / 255, 225 / 255, 215 / 255 }

      local hovered = mouse_x > btn_x and mouse_x < btn_x + button_width and
          mouse_y > btn_y and mouse_y < btn_y + button_height

      if hovered then
        color = { 245 / 255, 235 / 255, 225 / 255 }
      end

      btn.now = love.mouse.isDown(1)
      if btn.now and not btn.last and hovered then
        btn.fn()
      end

      love.graphics.setColor(unpack(color))
      love.graphics.rectangle("fill",
        (ww * 0.5) - (button_width * 0.5),
        (wh * 0.5) - (button_height)
        - (total_height * 0.5)
        + position_y,
        button_width,
        button_height
      )

      love.graphics.setColor(0, 0, 0, 1)

      local textW = font:getWidth(btn.text)
      local textH = font:getHeight(btn.text)

      love.graphics.print(
        btn.text,
        font,
        (ww * 0.5) - textW * 0.5,
        btn_y + textH * 0.4
      )

      position_y = position_y + (button_height + margin)
    end
  end


  if menuClosed then
    love.graphics.setColor(245 / 255, 235 / 255, 225 / 255)
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
          else
            HoveringTiles = false
          end
        end
      end
    end
  end

  love.graphics.print("position: X " .. mouse_x .. ' Y ' .. mouse_y)
  love.graphics.print(DebugMsg, 0, 20)
end
