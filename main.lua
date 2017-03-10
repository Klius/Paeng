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
end

function love.update(dt)
  --Collision
checkCollision(ball, p1)
checkCollision(ball, p2)
  ---
  p1:update(dt)
  p2:update(dt)
  ball:update(dt)
end

function love.draw()
  p1:draw()
  p2:draw()
  ball:draw()
  --Debug
  love.graphics.print("Player",0,0)
  love.graphics.print("x:"..p1.x,0,15)
  love.graphics.print("y:"..p1.y,0,30)
  love.graphics.print("Ball",300,0)
  love.graphics.print("x:"..ball.x,300,15)
  love.graphics.print("y:"..ball.y,300,30)
  love.graphics.print('Speed:' .. ball.speed,300,45)
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
