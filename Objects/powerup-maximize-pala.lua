PowerupMaximizePala = Powerup:extend()

function PowerupMaximizePala:new(x, y, width, height)
    self.sprite =  "assets/powerup-maxi-pala.png"
    self.applies = "same"
    self.player = 0 
    self.type = "maxi"
    self.isGood = true
    self.newSize = 300
    self.defaultSize = 200
    PowerupMaximizePala.super.new(self, x, y, width, height, self.sprite, 5, 5,4)
end