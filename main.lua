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
  --Fonts
  bigFont = love.graphics.newFont(100)
  debugFont = love.graphics.newFont(14)
  --math
  floor = math.floor
end

function love.update(dt)
  --Collision
  checkCollision(ball, p1)
  checkCollision(ball, p2)
  ---
  p1:update(dt)
  p2:update(dt)
  ball:update(dt)
  ----
  isGoal()
end

function love.draw()
  p1:draw()
  p2:draw()
  ball:draw()
  drawScore()
  
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
end
-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function checkCollision(ball, player)
  if (ball.x < player.x+player.width and
         player.x < ball.x+ball.radius and
         ball.y < player.y+player.height and
         player.y < ball.y+ball.radius) then
    
    local relativeIntersectY = (player.y+(player.height/2)) - (ball.y+(ball.radius/2))
    local normalizedRelativeIntersectionY = (relativeIntersectY/(player.height/2))
    local bounceAngle = normalizedRelativeIntersectionY * 60
    ball:setSpeed(ball.speed*-1,ball.speed*-math.sin(bounceAngle))
    ball:moreSpeed()
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