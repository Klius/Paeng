Wall = Drawable:extend()

function Wall:new(x, y)
    Wall.super.new(self, x, y)
    self.width = 40
    self.height = love.graphics.getHeight()
    self.isAlive = false
end
--This is where it moves and is checked!
function Wall:update(dt)

end

function Wall.draw(self)
  if self.isAlive then
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  end
end