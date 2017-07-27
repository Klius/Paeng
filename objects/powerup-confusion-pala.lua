PowerupConfusionPala = Powerup:extend()

function PowerupConfusionPala:new(x, y, width, height)
    self.sprite =  "assets/powerup-confusion.png"
    self.applies = "other"
    self.player = 0 
    self.type = "conf"
    self.newSize = 300
    self.defaultSize = 200
    PowerupConfusionPala.super.new(self, x, y, width, height, self.sprite, 5, 5)
end