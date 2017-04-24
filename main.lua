function love.load()
  Object = require "libs/classic"
  --baseclass to all objects
  require "Objects/drawable"
  require "Objects/pala"
  require "Objects/bola"
  --setup players
  p1 = Pala(50,love.graphics.getHeight()/2 -200/2,25,200,"w","s")
  p2 = Pala(love.graphics.getWidth()-75,love.graphics.getHeight()/2 -200/2,25,200,"up","down")
  ball = Bola(love.graphics.getWidth()/2,love.graphics.getHeight()/2,20)
  --DEBUG
  debug = false
  pause = false
  --Fonts
  bigFont = love.graphics.newFont(100)
  debugFont = love.graphics.newFont(14)
  --math
  floor = math.floor
  math.randomseed(os.time())
  music = love.audio.newSource("assets/sfx/loop.wav")
  music:setLooping(true)
  music:setVolume(0.5)
  music:play()
end

function randompassword()
  local password = ""
  -- 33-125
  math.randomseed( os.time() )
  for i=0,16,1 do
    local number = math.floor(math.random() * (125 - 33)) + 33
    password = password .. string.char(number)
  end
  
  return password
end

function love.update(dt)
  if pause == false then
    --Collision
    ball:checkCollision(p1)
    ball:checkCollision(p2)
    ---
    p1:update(dt)
    p2:update(dt)
    ball:update(dt)
    ----
    isGoal()
  end
end

function love.draw()
  drawScore()
  p1:draw()
  p2:draw()
  ball:draw()
  
  --Debug
  if debug then
    love.graphics.setFont(debugFont)
    --player1
    love.graphics.print("Player 1",0,0)
    love.graphics.print("x:"..p1.x,0,15)
    love.graphics.print("y:"..p1.y,0,30)
    love.graphics.print("score:"..p1.score,0,45)
    --player2
    love.graphics.print("Player 2",150,0)
    love.graphics.print("x:"..p2.x,150,15)
    love.graphics.print("y:"..p2.y,150,30)
    love.graphics.print("score:"..p2.score,150,45)
    --Ball
    love.graphics.print("Ball",300,0)
    love.graphics.print("x:"..ball.x,300,15)
    love.graphics.print("y:"..ball.y,300,30)
    love.graphics.print('Speed:' .. ball.speed,300,45)
    love.graphics.print('Color:' .. ball.colorLevel,300,60)
    --Other
    love.graphics.print('Mem Used:'..floor(collectgarbage("count")).."KB",450,0)
    love.graphics.print('FPS:'..love.timer.getFPS( ),450,15)
  end
end
function love.keypressed(key)
   if key == "escape" then
      love.event.quit()
   end
   if key == "d" then
    if debug then
      debug = false
    else
      debug = true
    end
   end
   if key == "p" then
      if pause then
        pause = false
      else
        pause = true
      end
   end
end


function isGoal()
  if(ball.x+ball.radius > love.graphics.getWidth() ) then
    ball:reset()
    p1.score = p1.score+1
  elseif(ball.x<0) then
    ball:reset()
    p2.score = p2.score+1
  end
end
function drawScore()
  love.graphics.setFont(bigFont)
  love.graphics.print(p1.score, love.graphics.getWidth()/2-150, 0)
  love.graphics.print(p2.score, love.graphics.getWidth()/2+100, 0)
end