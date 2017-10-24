Menu = Drawable:extend()

function Menu:new()
  self.selectedOption = 1
  self.options = {
                  new = 1,
                  options = 2
                }
  self.subMenu = {
                    score = 1,
                    audio = 2,
                    bigBall = 3,
                    smallBall = 4,
                    bigPaddle =5,
                    smallPaddle = 6,
                    wall = 7,
                    back = 8
                    
                  }
  self.inOptions = false
  self.timeToMove = 0
  self.delay = 0.2
  self.newGame = MenuOption(love.graphics.getWidth()/2-75,love.graphics.getHeight()/2,"New Geim",true, true)
  self.option = MenuOption(love.graphics.getWidth()/2-75,love.graphics.getHeight()/2+50,"Options",false, false)
  self.arrow = MenuDrawable(self.newGame.x-40, self.newGame.y, 32, 32, "assets/fletxa.png", 23)
  self.menuchecktest = MenuCheck()
end

function Menu:draw()
    if self.inOptions then
      love.graphics.setColor(2,156,24,255)
      love.graphics.setFont(bigFont)
      love.graphics.print("OPTIONS", love.graphics.getWidth()/2-220, 0)
      love.graphics.setFont(mediumFont)
      self.menuchecktest:draw()
      self.arrow:draw()
    else
      love.graphics.setColor(2,156,24,255)
      love.graphics.setFont(bigFont)
      love.graphics.print("PÖNG", love.graphics.getWidth()/2-150, 50)
      self.newGame:draw()
      self.option:draw()
      self.arrow:draw()
    end
     love.graphics.print(self.selectedOption,0,0)
end
function Menu:update(dt)
  self.arrow:update(dt)
  self.timeToMove = self.timeToMove - dt

  if self.inOptions then
    self:subMenuUpdate(dt)
  else
    self:mainMenuUpdate(dt)
  end
end

function Menu:subMenuUpdate(dt)
  if love.keyboard.isDown("return") and self.timeToMove <= 0 then
    if self.selectedOption == self.subMenu.back then
      self.inOptions = false
      self.selectedOption = 2
    end
    self.timeToMove = self.delay
  elseif love.keyboard.isDown("up") and self.timeToMove <= 0 then
    self.selectedOption = self.selectedOption - 1
    self.timeToMove = self.delay
    audioManager:PlayChime()
  elseif love.keyboard.isDown("down") and self.timeToMove <= 0 then
    self.selectedOption = self.selectedOption + 1
    self.timeToMove = self.delay
    audioManager:PlayChime()
  end
  if self.selectedOption < 1 then
    self.selectedOption = 8
  elseif self.selectedOption > 8 then
    self.selectedOption = 1
  end
end
function Menu:mainMenuUpdate(dt) 
  if love.keyboard.isDown("return") and self.timeToMove <= 0 then
    if self.selectedOption == self.options.new then
      currentState = states.game
    elseif self.selectedOption == self.options.options then
      self.inOptions = true
      self.selectedOption = self.subMenu.score
    end
    self.timeToMove = self.delay
  elseif love.keyboard.isDown("up") and self.timeToMove <= 0 then
    self.selectedOption = self.selectedOption - 1
    self.timeToMove = self.delay
    audioManager:PlayChime()
  elseif love.keyboard.isDown("down") and self.timeToMove <= 0 then
    self.selectedOption = self.selectedOption + 1
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