function love.load()
  --baseclass to all objects
  Object = require "libs/classic"
  --Objects
  require "Objects/drawable"
  require "Objects/pala"
  require "Objects/bola"
  require "Objects/powerup"
  require "Objects/powerup-speed"
  require "Objects/powerup-wall"
  require "Objects/powerup-minimize-ball"
  require "Objects/powerup-maximize-ball"
  require "Objects/powerup-maximize-pala"
  require "Objects/powerup-minimize-pala"
  require "Objects/powerup-confusion-pala"
  require "Objects/powerup-pool"
  require "Objects/wall"
  
  --shader
  shine = require "libs/shine"
  sketch = shine.sketch()
  crt = shine.crt()
  scanline = shine.scanlines()
  glow = shine.glowsimple()
  god = shine.godsray()
  postEffect = glow:chain(scanline):chain(sketch)--:chain(god)
  --setup players
  p1 = Pala(50,love.graphics.getHeight()/2 -200/2,25,200,"w","s", Wall(0,0))
  p2 = Pala(love.graphics.getWidth()-75,love.graphics.getHeight()/2 -200/2,25,200,"up","down",Wall(love.graphics.getWidth()-40,0))
  ball = Bola(love.graphics.getWidth()/2,love.graphics.getHeight()/2,25)
  --Background
  love.graphics.setColor(2,156,24,255)
  background = love.graphics.newCanvas()
  love.graphics.setCanvas(background)
  for i=0,love.graphics.getWidth(),64 do
      love.graphics.line(i,0,i,love.graphics.getHeight())
  end
  for i=0,love.graphics.getHeight(),64 do
      love.graphics.line(0,i,love.graphics.getWidth(),i)
  end
  love.graphics.setCanvas()
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
    if p1.wall.isAlive then
      ball:checkCollision(p1.wall)
    end
    if p2.wall.isAlive then
      ball:checkCollision(p2.wall)
    end
    
    for key,powerup in pairs(powerupPool.powerups) do
      if powerup.spawned then
        
        ball:checkCollisionPowerup(powerup)
        --When the powerup is active we apply it
      end
      if(powerup.activate) then
          
          if(powerup.player == 1)then
            p1:applyPowerup(powerup)
          elseif powerup.player == 3 then
            ball:applyPowerup(powerup)
          else
            p2:applyPowerup(powerup)
          end
          powerup.activate = false
          powerup.active = true
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
  
postEffect:draw(function()
            love.graphics.setColor(255,255,255,255)
            love.graphics.draw(background)
            powerupPool:draw()
            ball:draw()
            drawScore()
            love.graphics.setColor(2,156,24,255)
            p1:draw()
            p2:draw()
          end) 


    
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