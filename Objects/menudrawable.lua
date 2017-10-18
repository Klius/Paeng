MenuDrawable = Drawable:extend()

function MenuDrawable:new(x, y, width, height, sprite, totalFrames)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.totalFrames = totalFrames
    self.currentFrame = 0
    self.sprite = love.graphics.newImage(sprite)
    self.frames = { }
    self.durationOfFrame = 0.1
    local fx = 0
    local fy = 0
    for i=0,self.totalFrames+1 do
      local frame = love.graphics.newQuad(fx, fy, 32, 32, self.sprite:getDimensions())
      self.frames[i]=frame
      fx = fx+32
    end
end
function MenuDrawable:draw()
  love.graphics.draw(self.sprite,self.frames[self.currentFrame], self.x, self.y)
end

function MenuDrawable:update(dt)
  self.durationOfFrame = self.durationOfFrame - dt
  if self.durationOfFrame < 0 then
    self.durationOfFrame = 0.1
    self.currentFrame = self.currentFrame + 1
    if self.currentFrame > self.totalFrames then self.currentFrame = 0 end
  end
end

function MenuDrawable:changeVerticalPos(newY) 
  self.y = newY
end