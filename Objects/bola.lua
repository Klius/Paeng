--! file: circle.lua
Bola = Drawable:extend()

function Bola:new(x, y, radius)
    Bola.super.new(self, x, y)
    --A circle doesn't have a width or height. It has a radius.
    self.radius = radius
    self.speedX = 350
    self.speed = 350
    self.speedY = 0
end

function Bola:update(dt)
  self.dt = dt
  self.x = self.x + self.speedX * dt
  self.y = self.y + self.speedY * dt
  if (self.y < 0) then
    self.y = 0
    self.speedY = self.speedY *-1
  elseif (self.y+self.radius > love.graphics.getHeight()) then
    self.y = love.graphics.getHeight() - self.radius
    self.speedY = self.speedY *-1
  end
end

function Bola:draw()
    love.graphics.circle("line", self.x, self.y,self.radius)
end

function Bola:reset()
  self.x = love.graphics.getWidth()/2
  self.y = love.graphics.getHeight()/2
  self.speed = 350
  self.speedX = 350
  self.speedY = 0
  --self.diagonalSpeed = 0
  --self:changeDirection()
end
function Bola:setSpeed(x,y)
  self.speedX = x
  self.speed = self.speed * -1
  self.speedY = y
end
function Bola:moreSpeed()
  if self.speed < 0 then
    self.speed = self.speed -10
  else
    self.speed = self.speed +10
  end
  if self.speed > 700 then
    self.speed = 700
  elseif self.speed < -700 then
    self.speed = -700
  end
end