Powerup = Drawable:extend()

function Powerup:new(x, y, width, height, sprite, flags)
    Powerup.super.new(self, x, y)
    self.width = width
    self.height = height
    self.sprite = love.graphics.newImage(sprite)
    self.flags = flags
end

function Powerup:draw()
  if (self.flags["spawned"]) then 
    love.graphics.draw(self.sprite, self.x, self.y)
  end
end

function Powerup:update(dt)
  if (self.flags["active"]) then
    if love.timer.getTime() - self.flags["startTime"] > self.flags["duration"]  then
      self.flags["active"] = false
      self.flags["dead"] = true
    end
  elseif (self.flags["spawned"]) then
    if love.timer.getTime() - self.flags["startTime"] > self.flags["durationOfSpawn"] and self.flags["spawned"] then
      self.flags["spawned"] = false
      self.flags["dead"] = true
    end
  end
end