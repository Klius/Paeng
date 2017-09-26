MenuOption = Drawable:extend()

function MenuOption:new(x, y, text, enabled,selected)
    self.x = x
    self.y = y
    self.text = text
    self.enabled = enabled
    self.selected = selected
end
function MenuOption:draw()
    love.graphics.setFont(mediumFont)
    if (self.selected) then
      love.graphics.setColor(255,255,255,255)
    else 
      love.graphics.setColor(2,156,24,255)
    end
    love.graphics.print(self.text,self.x,self.y)
    love.graphics.setColor(255,255,255,255)
end