M = {}


M.board = {}
local rows = 7
local cols = 7;
--local HUMAN = ' H '

local function HUMAN()
  return {
    image = love.graphics.newImage('maps/Single Blocks/Blue.png'),
    player = ' H '
  }
end

-- local COMPUTER = ' C '
local function COMPUTER()
  return {
    image = love.graphics.newImage('maps/Single Blocks/Red.png'),
    player = ' C '
  }
end

-- local EMPTY = ' - '
local function EMPTY()
  return {
    image = love.graphics.newImage('maps/Board/Border.png'),
    player = ' - '
  }
end

square = {
  row = 0,
  col = 0,
}

function square:new(o)
  o = o or {} -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self
  return o
end

local function createBoard()
  for i = 1, rows do
    M.board[i] = {}
    for j = 1, cols do
      M.board[i][j] = EMPTY()
    end
  end
end


local function setDefaultSetup()
  M.board[7][1] = HUMAN()
  M.board[7][2] = HUMAN()
  M.board[6][1] = HUMAN()
  M.board[6][2] = HUMAN()
  M.board[1][6] = COMPUTER()
  M.board[1][7] = COMPUTER()
  M.board[2][6] = COMPUTER()
  M.board[2][7] = COMPUTER()
end

function M.initBoard()
  createBoard()
  setDefaultSetup()
end

local function clearBoard()
  createBoard()
  setDefaultSetup()
end


function M.printBoard()
  print('   1  2  3  4  5  6  7')
  local count = 0;
  for i = 1, rows do
    count = count + 1;
    io.write(count .. ' ')
    for j = 1, cols do
      io.write(M.board[i][j].player)
    end
    print('')
  end
end

function M.isOutOfBounds(square)
  local row = square.row
  local col = square.col

  if row > 7 or col > 7 or row < 1 or col < 1 then
    return true
  else
    return false
  end
end

local function isOccupied(square)
  if M.board[square.row][square.col].player == EMPTY().player then
    return false
  else
    return true
  end
end


local function isFromEnemy(square, player)
  local enemy = nil
  if player == HUMAN().player then
    enemy = COMPUTER().player
  else
    enemy = HUMAN().player
  end

  if M.board[square.row][square.col].player == enemy then
    return true
  else
    return false
  end
end


local function WithinRange(prev, next, range)
  local rangeX = math.abs(prev.row - next.row)
  local rangeY = math.abs(prev.col - next.col)
  if rangeX <= range and rangeY <= range then
    return true;
  else
    return false
  end
end


local function isRestrictedCoordinate(prev, next)
  local r = prev.row
  local c = prev.col
  local restrictedSquares = {}
  restrictedSquares[1] = square:new({ row = r - 2, col = c - 1 })
  restrictedSquares[2] = square:new({ row = r - 2, col = c + 1 })
  restrictedSquares[3] = square:new({ row = r - 1, col = c + 2 })
  restrictedSquares[4] = square:new({ row = r + 1, col = c + 2 })
  restrictedSquares[5] = square:new({ row = r + 2, col = c + 1 })
  restrictedSquares[6] = square:new({ row = r + 2, col = c - 1 })
  restrictedSquares[7] = square:new({ row = r + 1, col = c - 2 })
  restrictedSquares[8] = square:new({ row = r - 1, col = c - 2 })

  for _, value in ipairs(restrictedSquares) do
    if value.row == next.row and value.col == next.col then
      return true
    end
  end

  return false
end


function M.validateMove(prevSquare, nextSquare, currentPlayer)
  if M.isOutOfBounds(nextSquare) then
    -- print('Square is out of bounds')
    return false
  end

  if isOccupied(nextSquare) then
    -- print('Square is occupied')
    return false
  end

  if not isOccupied(prevSquare) then
    -- print('can not make move from empty square')
    return false
  end

  if isFromEnemy(prevSquare, currentPlayer) then
    -- print('prev Square is from enemy')
    return false
  end

  if not WithinRange(prevSquare, nextSquare, 2) then
    -- print('the new Square is outside of allowed range')
    return false
  end

  if isRestrictedCoordinate(prevSquare, nextSquare) then
    -- print('coordinate is restricted')
    return false
  end

  return true
end

local function isMoveTwoSteps(prevSquare, nextSquare)
  local directionX = math.abs(prevSquare.row - nextSquare.row)
  local directionY = math.abs(prevSquare.col - nextSquare.col)

  local isXTwoSteps = directionX == 2 and directionY == 0
  local isYTwoSteps = directionY == 2 and directionX == 0
  local isDiagonalTwoSteps = directionX == 2 and directionY == 2 and directionX == directionY

  if isXTwoSteps or isYTwoSteps or isDiagonalTwoSteps then
    return true
  else
    return false
  end
end


local function jumpToCoord(prevSquare, nextSquare, player)
  local playerimg = nil
  if player == HUMAN().player then
    playerimg = HUMAN().image
  else
    playerimg = COMPUTER().image
  end
  M.board[prevSquare.row][prevSquare.col].player = EMPTY().player
  M.board[prevSquare.row][prevSquare.col].image = EMPTY().image
  M.board[nextSquare.row][nextSquare.col].player = player
  M.board[nextSquare.row][nextSquare.col].image = playerimg
end


local function copyToCoord(prevSquare, nextSquare)
  local player = M.board[prevSquare.row][prevSquare.col].player
  local playerimg = M.board[prevSquare.row][prevSquare.col].image
  M.board[nextSquare.row][nextSquare.col].player = player
  M.board[nextSquare.row][nextSquare.col].image = playerimg
end


function M.formatInput(input)
  local x_str, y_str = input:match("(%S+)%s+(%S+)")
  local x = tonumber(x_str)
  local y = tonumber(y_str)
  return square:new({ row = x, col = y })
end

local function infectEnemy(square, player)
  local arr = M.getSquaresAroundSquare(square, 1)
  local enemy = nil
  local playerimg = nil

  if player == HUMAN().player then
    enemy = COMPUTER().player
    playerimg = HUMAN().image
  else
    enemy = HUMAN().player
    playerimg = COMPUTER().image
  end

  for i = #arr, 1, -1 do
    if M.isOutOfBounds(arr[i]) then
      table.remove(arr, i)
    end
  end

  for _, v in ipairs(arr) do
    if M.board[v.row][v.col].player == enemy then
      M.board[v.row][v.col].player = player
      M.board[v.row][v.col].image = playerimg
    end
  end
end


function M.getSquaresAroundSquare(playerSquare, radius)
  local p = playerSquare

  local array = {}
  for i = 1, 16 do
    array[i] = square:new();
  end

  --get all squares around player's Square within a radius of 2 squares
  for i = 1, radius do
    local x = 0
    if i == 2 then
      x = 8
    end
    array[1 + x].row = p.row - i
    array[1 + x].col = p.col
    array[2 + x].row = p.row + i
    array[2 + x].col = p.col
    array[3 + x].row = p.row
    array[3 + x].col = p.col - i
    array[4 + x].row = p.row
    array[4 + x].col = p.col + i
    array[5 + x].row = p.row - i
    array[5 + x].col = p.col - i
    array[6 + x].row = p.row - i
    array[6 + x].col = p.col + i
    array[7 + x].row = p.row + i
    array[7 + x].col = p.col - i
    array[8 + x].row = p.row + i
    array[8 + x].col = p.col + i
  end

  return array
end

function M.getAllPlayerSquares(player)
  local playerSquares = {}
  local index = 1;

  for i, row in ipairs(M.board) do
    for j, col in ipairs(row) do
      if col.player == player then
        playerSquares[index] = square:new({ row = i, col = j })
        index = index + 1
      end
    end
  end

  return playerSquares
end


local function isBoardFull()
  for _, row in ipairs(M.board) do
    for _, col in ipairs(row) do
      if col.player == EMPTY().player then
        return false
      end
    end
  end
  return true
end


local function isSurrounded(player)
  local playerSquares = M.getAllPlayerSquares(player)

  for _, v in ipairs(playerSquares) do
    local arr = M.getSquaresAroundSquare(v, 2)
    for i = #arr, 1, -1 do
      if M.isOutOfBounds(arr[i]) then
        arr[i] = nil
      end
    end
    for _, v3 in pairs(arr) do
      if M.validateMove(v, v3, player) then
        return false
      end
    end
  end

  print(player .. ' is surrounded')
  return true
end


local function getEnemy(player)
  if player == HUMAN().player then
    return COMPUTER().player
  else
    return HUMAN().player
  end
end


local function hasConquered(player)
  local enemy = getEnemy(player)

  for _, row in ipairs(board) do
    for _, col in ipairs(row) do
      if col.player == enemy then
        return false
      end
    end
  end
  return true;
end


local function hasWinner()
  if isBoardFull() then
    local humanSquares = 0
    local computerSquares = 0

    for _, row in ipairs(M.board) do
      for _, col in ipairs(row) do
        if col.player == HUMAN().player then
          humanSquares = humanSquares + 1
        elseif col.player == COMPUTER().player then
          computerSquares = computerSquares + 1
        end
      end
    end

    if humanSquares > 24 then
      print('you won')
      return true
    else
      print('computer won')
      return true
    end
  end
  return false
end


function M.isGameOver(player)
  local ret = false
  if hasWinner() then
    clearBoard()
    ret = true
  end

  if hasConquered(player) then
    print(player .. ' has conquered')
    clearBoard()
    ret = true
  end

  if isSurrounded(player) then
    clearBoard()
    ret = true
  end

  return ret
end

function M.makeMove(prevSquare, nextSquare, player)
  local isMoveValid = false;
  local x = os.clock()
  local isGameOver = M.isGameOver(player)
  print(string.format("elapsed time: %.4f\n", os.clock() - x))
  --local isGameOver = false;
  if not isGameOver then
    isMoveValid = M.validateMove(prevSquare, nextSquare, player)
    if isMoveValid then
      if isMoveTwoSteps(prevSquare, nextSquare) then
        jumpToCoord(prevSquare, nextSquare, player)
      else
        copyToCoord(prevSquare, nextSquare)
      end
      infectEnemy(nextSquare, player)
    end
  end
end

return M
