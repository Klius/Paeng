--! file: circle.lua
Bola = Drawable:extend()

function Bola:new(x, y, radius)
    Bola.super.new(self, x, y)
    --A circle doesn't have a width or height. It has a radius.
    self.radius = radius
    self.speed = -350 
    self.diagonalSpeed = 0
end

function Bola:update(dt)
  self.x = self.x + self.speed * dt
  self.y = self.y + self.diagonalSpeed * dt
  if(self.x+self.radius > love.graphics.getWidth() ) then
    self:reset()
  elseif(self.x<0) then
    self:reset()
  end
  if (self.y < 0) then
    self.y = 0
    self:changeDiagonalDirection()
  elseif (self.y+self.radius > love.graphics.getHeight()) then
    self.y = love.graphics.getHeight() - self.radius
    self:changeDiagonalDirection()
  end
end

function Bola:draw()
    love.graphics.circle("line", self.x, self.y, self.radius)
end

function Bola:reset()
  self.x = love.graphics.getWidth()/2
  self.y = love.graphics.getHeight()/2
  self.diagonalSpeed = 0
  self:changeDirection()
end
function Bola:changeDirection()
  self.speed = self.speed * -1
end
function Bola:changeDiagonalDirection()
  self.diagonalSpeed = self.diagonalSpeed * -1
end