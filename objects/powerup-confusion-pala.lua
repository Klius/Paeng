PowerupConfusionPala = Powerup:extend()

function PowerupConfusionPala:new(x, y, width, height)
    self.sprite =  "assets/powerup-confusion.png"
    self.applies = "other"
    self.player = 0 
    self.type = "conf"
    self.isGood = false
    self.up = "w"
    self.down = "s"
    PowerupConfusionPala.super.new(self, x, y, width, height, self.sprite, 5, 5)
end