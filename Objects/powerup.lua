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
    self.durationOfFrame = 0.3
    self.currentFrame = 0
    self.totalFrames = 4
    self.frames = { }
    local fx = 0
    local fy = 0
    for i=0,5 do
      local frame = love.graphics.newQuad(fx, fy, 50, 50, self.sprite:getDimensions())
      self.frames[i]=frame
      fx = fx+50
    end
end

function Powerup:draw()
  love.graphics.draw(self.sprite,self.frames[self.currentFrame], self.x, self.y)
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
    self.durationOfFrame = self.durationOfFrame - dt
    if self.durationOfFrame <= 0 then
      self.durationOfFrame = 0.3
      self.currentFrame = self.currentFrame + 1
      if self.currentFrame > self.totalFrames then self.currentFrame = 0 end
    end
    if self.durationOfSpawn < 0 and self.spawned then
      self.spawned = false
      self.dead = true
    end
  end
end