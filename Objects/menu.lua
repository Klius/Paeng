Menu = Drawable:extend()

function Menu:new()
  self.selectedOption = 1
  self.options = {
                  new = 1,
                  options = 2
                }
  self.subMenu = {
                    --score = 1,
                    audio = 1,
                    bigBall = 2,
                    smallBall = 3,
                    bigPaddle = 4,
                    smallPaddle = 5,
                    wall = 6,
                    back = 7
                    
                  }
  self.inOptions = false
  self.timeToMove = 0
  self.delay = 0.2
  x = love.graphics.getWidth()/2-75
  self.newGame = MenuOption(x,love.graphics.getHeight()/2,"Start Match",true, true)
  self.option = MenuOption(x,love.graphics.getHeight()/2+50,"Options",true, false)
  self.arrow = MenuDrawable(self.newGame.x-40, self.newGame.y, 32, 32, "assets/fletxa.png", 23)
  self.submenuchecks = self.getMenuChecks()
end

function Menu:getMenuChecks()
  x = love.graphics.getWidth()/2-75
  checks = {
            MenuCheck("Audio",x,150,config["sound"]),
            MenuCheck("MaxiBall",x,200,config["sound"]),
            MenuCheck("MiniBall",x,250,config["sound"]),
            MenuCheck("MaxiPaddle",x,300,config["sound"]),
            MenuCheck("MiniPaddle",x,350,config["sound"]),
            MenuCheck("Wall",x,400,config["sound"]),
            MenuOption( x, 500, "Back", true, false)
            }
  return checks
end

function Menu:draw()
    if self.inOptions then
      love.graphics.setColor(2,156,24,255)
      love.graphics.setFont(bigFont)
      love.graphics.print("OPTIONS", love.graphics.getWidth()/2-220, 0)
      love.graphics.setFont(mediumFont)
      for key,option in pairs(self.submenuchecks) do 
        option:draw()
      end
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
    self.selectedOption = 7
  elseif self.selectedOption > 7 then
    self.selectedOption = 1
  end
  
  self:subMenuDeselect()
  self.submenuchecks[self.selectedOption].selected = true
  self.arrow:changeVerticalPos(self.submenuchecks[self.selectedOption].y)
  
  if self.selectedOption == self.subMenu.audio then
    
  elseif self.selectedOption == self.subMenu.audio then
    self.newGame.selected = false 
    self.option.selected = true
    self.arrow:changeVerticalPos(self.option.y)
  end
end

function Menu:subMenuDeselect()
  for key,option in pairs(self.submenuchecks) do 
    option.selected = false
  end
end
function Menu:mainMenuUpdate(dt) 
  if love.keyboard.isDown("return") and self.timeToMove <= 0 then
    if self.selectedOption == self.options.new then
      currentState = states.game
    elseif self.selectedOption == self.options.options then
      self.inOptions = true
      self.selectedOption = self.subMenu.audio
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

