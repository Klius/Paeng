Powerup = Drawable:extend()

function Powerup:new(x, y, width, height, sprite, duration, durationOfSpawn)
    Powerup.super.new(self, x, y)
    self.width = width
    self.height = height
    self.sprite = love.graphics.newImage(sprite)
    self.active = false
    self.deactivate = false
    self.spawned = true
    self.dead = false
    self.duration = duration
    self.durationOfSpawn = durationOfSpawn 
end

function Powerup:draw()
  love.graphics.draw(self.sprite, self.x, self.y)
end

function Powerup:update(dt)
  if (self.active) then
    self.duration = self.duration - dt
    if self.duration < 0  then
      self.active = false
      self.deactivate = true
    end
  elseif (self.spawned) then
    self.durationOfSpawn = self.durationOfSpawn - dt
    if self.durationOfSpawn < 0 and self.spawned then
      self.spawned = false
      self.dead = true
    end
  end
end