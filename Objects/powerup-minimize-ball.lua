PowerupMinimizeBall = Powerup:extend()

function PowerupMinimizeBall:new(x, y, width, height, sprite)
    PowerupMinimizeBall.super.new(self, x, y, width, height, sprite, 5, 5)
    self.applies = "ball"
    self.player = 3 
    self.type = "mini"
    self.newSize = 10
    self.defaultSize = 20
end