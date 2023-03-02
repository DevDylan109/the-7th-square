Module = {}

local game = nil
local board = nil
local COMPUTER = ' C '
local HUMAN = ' H '

function Module.initialize(gameInstance)
  game = gameInstance
  board = gameInstance.board
end


function Module.bla()
  print('bla')
end


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
    if not game.validateMove(square, squareArray[i], HUMAN) then
      table.remove(squareArray, i)
    end
  end

  return squareArray
end


local function getRandomSquare(squareArray)
  local randomIndex = math.random(1, #squareArray)
  local randomSquare = squareArray[randomIndex]
  return randomSquare
end


function Module.makeMoveAsHuman()
  local allSquares = game.getAllPlayerSquares(HUMAN)
  local moveFrom = getRandomSquare(allSquares)
  local validSquares = getSquaresAroundBot(moveFrom)
  local moveTo = getRandomSquare(validSquares)
  game.makeMove(moveFrom, moveTo, HUMAN)
end


return Module