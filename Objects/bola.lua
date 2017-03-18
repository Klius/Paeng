--! file: circle.lua
Bola = Drawable:extend()

function Bola:new(x, y, radius)
    Bola.super.new(self, x, y)
    --Config
    self.defaultSpeed = 350
    self.maxSpeed = 800
    self.incrementSpeed = 15
    --A circle doesn't have a width or height. It has a radius.
    self.radius = radius
    self.speedX = 350
    self.speed = self.defaultSpeed
    self.speedY = 0
    self.colors = {{255,0,0,255}, {255,255,0,255},{98,150,255,255},{0,255,0,255}}
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
    love.graphics.setColor(self.colors[4][1],self.colors[4][2],
                            self.colors[4][3],self.colors[4][4])
    love.graphics.circle("line", self.x, self.y,self.radius)
    love.graphics.setColor(255,255,255,255)
end
--[[
Reseteja la bola a l'estat inicial
]]
function Bola:reset()
  self.x = love.graphics.getWidth()/2
  self.y = love.graphics.getHeight()/2
  self.speed = self.defaultSpeed
  self.speedX = self.defaultSpeed
  self.speedY = 0
end
function Bola:setSpeed(x,y)
  self.speedX = x
  self.speed = self.speed * -1
  self.speedY = y
end

--[[
  Adds more speed to the current speed. 
]]
function Bola:moreSpeed()
  if self.speed ~= self.maxSpeed and 
    self.speed ~= -self.maxSpeed then
    if self.speed < 0 then
      self.speed = self.speed - self.incrementSpeed
    else
      self.speed = self.speed + self.incrementSpeed
    end
  end
end