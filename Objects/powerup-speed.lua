PowerupSpeed = Powerup:extend()

function PowerupSpeed:new(x, y, width, height, sprite)
    PowerupSpeed.super.new(self, x, y, width, height, sprite, 5, 5, 4)
    self.applies = "same"
    self.player = 0 
    self.type = "speed"
    self.isGood = true
    self.newSpeed = 600
    self.defaultSpeed = 400
end