AnnouncerText = Drawable:extend()

function AnnouncerText:new(x, y, string,speed)
  self.counter = 0
  self.nextWord = 0.5
  self.string = string
  self.x = x
  self.y = y
  self.alpha = 0
  self.speed = speed
end
function AnnouncerText:draw()
  love.graphics.setColor(240, 255, 0,self.alpha)
  love.graphics.print(self.string,self.x,self.y)
  love.graphics.setColor(255,255,255,255)
end
function AnnouncerText:update(dt)
  self.alpha = self.alpha + (dt * (255 / self.speed)) -- so it takes X seconds to remove all the alpha
	if self.alpha > 255 then self.alpha = 255 end
end
