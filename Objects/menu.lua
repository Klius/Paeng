Menu = Drawable:extend()

function Menu:new()
  self.selectedOption = 1
  self.options = {
                  new = 1,
                  options = 2
                }
  self.timeToMove = 0
  self.delay = 0.2
  self.newGame = MenuOption(love.graphics.getWidth()/2-75,love.graphics.getHeight()/2,"New Geim",true, true)
  self.option = MenuOption(love.graphics.getWidth()/2-75,love.graphics.getHeight()/2+50,"Options",false, false)
  self.arrow = MenuDrawable(self.newGame.x-40, self.newGame.y, 32, 32, "assets/fletxa.png", 23)
end

function Menu:draw()
    love.graphics.setColor(2,156,24,255)
    love.graphics.setFont(bigFont)
    love.graphics.print("PÖNG", love.graphics.getWidth()/2-150, 50)
    self.newGame:draw()
    self.option:draw()
    self.arrow:draw()
end
function Menu:update(dt)
  self.arrow:update(dt)
  self.timeToMove = self.timeToMove - dt

  if love.keyboard.isDown("return") then
    if self.selectedOption == self.options.new then
      currentState = states.game
    end
  elseif love.keyboard.isDown("up") and self.timeToMove <= 0 then
    self.selectedOption = self.selectedOption + 1
    self.timeToMove = self.delay
    audioManager:PlayChime()
  elseif love.keyboard.isDown("down") and self.timeToMove <= 0 then
    self.selectedOption = self.selectedOption - 1
    self.timeToMove = self.delay
    audioManager:PlayChime()
  end
  
  if self.selectedOption < 1 then
    self.selectedOption = 2
  elseif self.selectedOption > 2 then
    self.selectedOption = 1
  end
  
  if self.selectedOption == self.options.new then
    self.newGame.selected = true
    self.option.selected = false
    self.arrow:changeVerticalPos(self.newGame.y)
  elseif self.selectedOption == self.options.options then
    self.newGame.selected = false 
    self.option.selected = true
    self.arrow:changeVerticalPos(self.option.y)
  end
  
end