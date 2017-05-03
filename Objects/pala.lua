--! file: pala.lua
Pala = Drawable:extend()

function Pala:new(x, y, width, height,upkey,downkey)
    Pala.super.new(self, x, y)
    self.width = width
    self.height = height
    self.upkey = upkey
    self.downkey = downkey
    self.score = 0
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
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Pala:applyPowerup(powerup)
  if powerup.flags["type"] == "speed" then
    self.speed = powerup.flags["newSpeed"]
  end
end

function Pala:deapplyPowerup(powerup)
  if powerup.flags["type"] == "speed" then
    self.speed = powerup.flags["defaultSpeed"]
  end
end