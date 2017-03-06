--! file: shape.lua
Drawable = Object:extend()

function Drawable:new(x, y)
    self.x = x
    self.y = y
    self.speed = 300
end