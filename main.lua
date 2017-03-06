function love.load()
  Object = require "classic"
  --baseclass to all objects
  require "drawable"
  --
  require "pala"
  require "bola"
  --setup players
  p1 = Pala(50,love.graphics.getHeight()/2 -200/2,25,200,"w","s")
  p2 = Pala(love.graphics.getWidth()-75,love.graphics.getHeight()/2 -200/2,25,200,"up","down")
  ball = Bola(love.graphics.getWidth()/2,love.graphics.getHeight()/2,20)
  body="none"
end

function love.update(dt)
  p1:update(dt)
  p2:update(dt)
  ball:update(dt)
  
  if checkCollision(ball,p1) then
   ball:changeDirection() 
 elseif checkCollision(ball,p2) then
   ball:changeDirection()
 end
 
end

function love.draw()
  p1:draw()
  p2:draw()
  ball:draw()
  --love.graphics.print(p1.y,100,0)
    love.graphics.print(p1.y,0,0)
    love.graphics.print(ball.y+ball.radius,300,0)
    love.graphics.print(body,0,50)

end

-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function checkCollision(ball, player)
  --top
  if ball.x < player.x+player.width and
      player.x < ball.x+ball.radius and
      ball.y < player.y+player.height/3 and
      player.y < ball.y+ball.radius then
        ball.diagonalSpeed = -350
        return true
  --middle
  elseif ball.x < player.x+player.width and
      player.x < ball.x+ball.radius and
      ball.y < player.y+player.height-player.height/3  and
      player.y < ball.y+ball.radius then
        ball.diagonalSpeed = 0
        return true
    --down
  elseif ball.x < player.x+player.width and
      player.x < ball.x+ball.radius and
      ball.y < player.y+player.height and
      player.y < ball.y+ball.radius then
        ball.diagonalSpeed = 350
        return true
  end
  
  --return ball.x < player.x+player.width and
    --     player.x < ball.x+ball.radius and
      --   ball.y < player.y+player.height and
        -- player.y < ball.y+ball.radius
end