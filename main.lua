function love.load()
  --baseclass to all objects
  Object = require "libs/classic"
  --Objects
  require "Objects/drawable"
  require "Objects/pala"
  require "Objects/bola"
  require "Objects/powerup"
  require "Objects/powerup-speed"
  require "Objects/powerup-minimize-ball"
  require "Objects/powerup-maximize-ball"
  require "Objects/powerup-pool"
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
  music = love.audio.newSource("assets/sfx/loop.wav")
  music:setLooping(true)
  music:setVolume(0.5)
  music:play()
  ---Powerup test
  powerupPool = PowerupPool()
  --timing debug 
  startTime = love.timer.getTime()
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
    for key,powerup in pairs(powerupPool.powerups) do
      if powerup.spawned then
        
        ball:checkCollisionPowerup(powerup)
        --When the powerup is active we apply it
      end
      if(powerup.active) then
          
          if(powerup.player == 1)then
            p1:applyPowerup(powerup)
          elseif powerup.player == 3 then
            ball:applyPowerup(powerup)
          else
            p2:applyPowerup(powerup)
          end
        elseif(powerup.deactivate)then
          if(powerup.player == 1)then
            p1:deapplyPowerup(powerup)
          elseif powerup.player == 3 then
            ball:deapplyPowerup(powerup)
          else
            p2:deapplyPowerup(powerup)
          end
          powerup.dead = true  
        end
    end
  ---Updates
    
    p1:update(dt)
    p2:update(dt)
    ball:update(dt)
    
    powerupPool:update(dt)
    ----
    isGoal()
  end
end

function love.draw()
  drawScore()
  p1:draw()
  p2:draw()
  ball:draw()
  
  powerupPool:draw()
  --Debug
  if debug then
    love.graphics.setFont(debugFont)
    --player1
    love.graphics.print("Player 1",0,0)
    love.graphics.print("x:"..p1.x,0,15)
    love.graphics.print("y:"..p1.y,0,30)
    love.graphics.print("score:"..p1.score,0,45)
    love.graphics.print("speed:"..p1.speed,0,60)
    --player2
    love.graphics.print("Player 2",150,0)
    love.graphics.print("x:"..p2.x,150,15)
    love.graphics.print("y:"..p2.y,150,30)
    love.graphics.print("score:"..p2.score,150,45)
    love.graphics.print("speed:"..p2.speed,150,60)
    --Ball
    love.graphics.print("Ball",300,0)
    love.graphics.print("x:"..ball.x,300,15)
    love.graphics.print("y:"..ball.y,300,30)
    love.graphics.print('Speed:' .. ball.speed,300,45)
    love.graphics.print('Color:' .. ball.colorLevel,300,60)
    love.graphics.print('Size:' .. ball.radius,300,75)
    --Other
    love.graphics.print('Mem Used:'..floor(collectgarbage("count")).."KB",550,0)
    love.graphics.print('FPS:'..love.timer.getFPS( ),550,15)
    love.graphics.print('TIME:'..love.timer.getTime()- startTime ,550,30)
    for key,powerup in pairs(powerupPool.powerups) do
      if powerup.spawned then
        love.graphics.print("Duration of Spawn"..powerup.durationOfSpawn,powerup.x+15,powerup.y-15)
      end
    end
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