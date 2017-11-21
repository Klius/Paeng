MenuDrawable = Drawable:extend()

function MenuDrawable:new(x, y, width, height, sprite, totalFrames, durationOfFrame, orientation)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.totalFrames = totalFrames
    self.currentFrame = 0
    self.sprite = love.graphics.newImage(sprite)
    self.frames = { }
    self.durationOfFrame = durationOfFrame or 0.1
    self.freimes = self.durationOfFrame
    self.orientation = orientation or false -- if false horizontal// true vertical
    local fx = 0
    local fy = 0
    for i=0,self.totalFrames+1 do
      local frame = love.graphics.newQuad(fx, fy, self.width, self.height, self.sprite:getDimensions())
      self.frames[i]=frame
      if self.orientation then
        fy = fy+self.height
      else
        fx = fx+self.width
      end
    end
end
function MenuDrawable:draw()
  love.graphics.draw(self.sprite,self.frames[self.currentFrame], self.x, self.y)
end

function MenuDrawable:update(dt)
  self.freimes = self.freimes - dt
  if self.freimes < 0 then
    self.freimes = self.durationOfFrame
    self.currentFrame = self.currentFrame + 1
    if self.currentFrame >= self.totalFrames then self.currentFrame = 0 end
  end
end

function MenuDrawable:changeVerticalPos(newY) 
  self.y = newY
--  self.currentFrame = 24
end