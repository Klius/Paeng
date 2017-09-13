PowerupMinimizePala = Powerup:extend()

function PowerupMinimizePala:new(x, y, width, height)
    self.sprite = "assets/powerup-mini-pala.png"
    self.applies = "other"
    self.player = 0 
    self.type = "mini"
    self.newSize = 100
    self.defaultSize = 200
    PowerupMinimizePala.super.new(self, x, y, width, height, self.sprite, 5, 5, 4)
end