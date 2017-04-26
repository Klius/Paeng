--file: powerup.lua
Powerup = Drawable:extend()

function Powerup:new(x, y, )
    Powerup.super.new(self, x, y)
    self.width = 50
    self.height = 50
end