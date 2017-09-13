--! file: pala.lua
Pala = Drawable:extend()

function Pala:new(x, y, width, height,upkey,downkey,wall)
    Pala.super.new(self, x, y)
    self.width = width
    self.height = height
    self.upkey = upkey
    self.downkey = downkey
    self.score = 0
    self.wall = wall
    self.color = { 2,156,24,255} --holds the color depending on the powerup
end
--This is where it moves and is checked!
function Pala:update(dt,world)
  if love.keyboard.isDown(self.upkey) then
    self.y = self.y - self.speed * dt
  elseif love.keyboard.isDown(self.downkey) then
    self.y = self.y + self.speed * dt 
  end
  --Check that it's not out of window
  if self.y < 0 then
    self.y = 0
  end
  if self.y + self.height > love.graphics.getHeight() then
    self.y = love.graphics.getHeight() - self.height
  end
end

function Pala.draw(self)
  love.graphics.setColor( self.color)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  if self.wall.isAlive then
    self.wall:draw()
  end
end

function Pala:applyPowerup(powerup)
  if powerup.type == "speed" then
    self.speed = powerup.newSpeed
  elseif powerup.type == "maxi" or powerup.type == "mini" then
    --slight adjustmen to position
    if self.height ~= powerup.newSize and powerup.type =="mini" then
      self.y = self.y + powerup.newSize/2
    end
    self.height = powerup.newSize
  elseif powerup.type == "conf" then
    powerup.up = self.upkey
    powerup.down = self.downkey
    self.upkey = powerup.down
    self.downkey = powerup.up
    
  end
  if powerup.isGood and self.color ~= {173,51,48,255} then
    self.color = {100,150,255,255}--blue
  else
    self.color = {173,51,48,255} --red
  end
end

function Pala:deapplyPowerup(powerup)
  if powerup.type == "speed" then
    self.speed = powerup.defaultSpeed
  elseif powerup.type == "maxi" or powerup.type == "mini" then
    self.height = powerup.defaultSize
  elseif powerup.type == "conf" then
    self.upkey = powerup.up
    self.downkey = powerup.down
  end
  self.color = { 2,156,24,255}
end