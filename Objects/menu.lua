Menu = Drawable:extend()

function Menu:new()
  self.selectedOption = -1
  self.options = {
                  new = 1,
                  options = 2
                }
  self.newGame = MenuOption(love.graphics.getWidth()/2-75,love.graphics.getHeight()/2,"New Geim",true, true)
  self.option = MenuOption(love.graphics.getWidth()/2-75,love.graphics.getHeight()/2+50,"Options",false, false)
end

function Menu:draw()
    love.graphics.setColor(2,156,24,255)
    love.graphics.setFont(bigFont)
    love.graphics.print("PÖNG", love.graphics.getWidth()/2-150, 50)
    self.newGame:draw()
    self.option:draw()
end
function Menu:update(dt)
  if love.keyboard.isDown("") then
    self.y = self.y - self.speed * dt
  elseif love.keyboard.isDown(self.downkey) then
    self.y = self.y + self.speed * dt 
  end
end