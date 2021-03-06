MatchOver = Drawable:extend()

function MatchOver:new()
  self.messageBackground = MenuDrawable(0, love.graphics.getHeight()/2-100, 800 , 200, "assets/player-wins.png", 6, 0.1,true)
  self.announcerText = AnnouncerText(0,love.graphics.getHeight()/2-40,"",0.5)
end
function MatchOver:draw()
  love.graphics.setColor(255,255,255,255)
  god:draw(function()self.messageBackground:draw()end)
  self.announcerText:draw()
end
function MatchOver:update(dt)
    if winner == 0 then
    self.announcerText.string=" LEFT PLAYER WINS!"
  else
    self.announcerText.string="RIGHT PLAYER WINS!"
  end
  self.messageBackground:update(dt)
  self.announcerText:update(dt)
  if love.keyboard.isDown("return") or love.keyboard.isDown("space") then
    reset(false)
  elseif love.keyboard.isDown("escape") then
    reset(true)
  end
end