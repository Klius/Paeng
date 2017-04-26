--! file: shape.lua
Drawable = Object:extend()

function Drawable:new(x, y)
    self.x = x
    self.y = y
    self.speed = 400
end


function Drawable.draw(self)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end