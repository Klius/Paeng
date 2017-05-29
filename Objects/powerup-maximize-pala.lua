PowerupMaximizePala = Powerup:extend()

function PowerupMaximizePala:new(x, y, width, height, sprite)
    PowerupMaximizePala.super.new(self, x, y, width, height, sprite, 5, 5)
    self.applies = "same"
    self.player = 0 
    self.type = "maxi"
    self.newSize = 300
    self.defaultSize = 200
end