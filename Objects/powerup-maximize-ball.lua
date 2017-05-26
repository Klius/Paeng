PowerupMaximizeBall = Powerup:extend()

function PowerupMaximizeBall:new(x, y, width, height, sprite)
    PowerupMaximizeBall.super.new(self, x, y, width, height, sprite, 5, 5)
    self.applies = "ball"
    self.player = 3 
    self.type = "maxi"
    self.newSize = 40
    self.defaultSize = 20
end