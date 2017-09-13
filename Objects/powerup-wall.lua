PowerupWall = Powerup:extend()

function PowerupWall:new(x, y, width, height)
    self.sprite =  "assets/powerup-wall.png"
    self.applies = "same"
    self.player = 0 
    self.type = "wall"
    self.totalFrames = 8
    PowerupWall.super.new(self, x, y, width, height, self.sprite, 5, 5,self.totalFrames)
end