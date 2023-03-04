Mod = {}

local game = nil
local board = nil
-- local COMPUTER = ' C '
local function COMPUTER()
  return {
    player = ' C '
  }
end
-- local HUMAN = ' H '
local function HUMAN()
  return {
    player = ' H '
  }
end

function Mod.initialize(gameInstance)
  game = gameInstance
  board = gameInstance.board
end

function Mod.bla()
  print('bla')
end

local function manhattanDist(X1, Y1, X2, Y2)
  local dist = math.abs(X2 - X1) + math.abs(Y2 - Y1)
  return dist;
end

--table.remove is volgensmij erg langzaam. Vooral bij grote arrays.
local function removeOutliers(array)
  for i = #array, 1, -1 do
    if game.isOutOfBounds(array[i]) then
      table.remove(array, i)
    end
  end
end


local function getSquaresAroundBot(square)
  local squareArray = game.getSquaresAroundSquare(square, 2)
  removeOutliers(squareArray)
  for i = #squareArray, 1, -1 do
    if not game.validateMove(square, squareArray[i], COMPUTER().player) then
      table.remove(squareArray, i)
    end
  end

  return squareArray
end


local function calculateShortestDistance()
  local allBotSquares = game.getAllPlayerSquares(COMPUTER().player)
  local allHumanSquares = game.getAllPlayerSquares(HUMAN().player)
  local shortestDistance = 999
  local bestBotSquare = nil
  local dist = 0;

  for i, v in ipairs(allBotSquares) do
    for j, val in ipairs(allHumanSquares) do
      dist = manhattanDist(v.col, v.row, val.col, val.row)
      if dist < shortestDistance then
        if #getSquaresAroundBot(v) > 0 then
          shortestDistance = dist
          bestBotSquare = v
        end
      end
    end
  end

  return bestBotSquare
end


local function getRandomSquare(squareArray)
  local randomIndex = math.random(1, #squareArray)
  local randomSquare = squareArray[randomIndex]
  return randomSquare
end


function Mod.makeMoveAsBot()
  local gameOver = game.isGameOver(COMPUTER().player)
  --local gameOver = false
  if not gameOver then
    local moveFrom = calculateShortestDistance()
    local validSquares = getSquaresAroundBot(moveFrom)
    local moveTo = getRandomSquare(validSquares)
    game.makeMove(moveFrom, moveTo, COMPUTER().player)
  end
end

return Mod
