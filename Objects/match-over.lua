MatchOver = Drawable:extend()

function MatchOver:new()
  self.messageBackground = MenuDrawable(0, love.graphics.getHeight()/2-100, 800 , 200, "assets/player-wins.png", 6, 0.1,true)
  self.announcerText = AnnouncerText(0,love.graphics.getHeight()/2-60,"Left player wins",0.5)
end
function MatchOver:draw()
  love.graphics.setColor(255,255,255,255)
  self.messageBackground:draw()
  self.announcerText:draw()
end
function MatchOver:update(dt)
  self.messageBackground:update(dt)
  self.announcerText:update(dt)
end