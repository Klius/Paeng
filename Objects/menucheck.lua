MenuCheck = Drawable:extend()

function MenuCheck:new(label, x, y, checked, configKey, subtitle)
  self.configKey = configKey
  self.label = label
  self.checked = checked
  self.selected = false
  self.sprite = love.graphics.newImage("assets/menu-checkbox.png")
  self.x = x
  self.y = y
  self.subtitle = subtitle or ""
  self.selectedFrame = 0
  self.frames = { }
  self.totalFrames = 1
  local fx = 0
  local fy = 0
  for i=0,self.totalFrames+1 do
    local frame = love.graphics.newQuad(fx, fy, 32, 32, self.sprite:getDimensions())
    self.frames[i]=frame
    fx = fx+32
  end
end

function MenuCheck:draw()
  if (self.selected) then
    love.graphics.setColor(255,255,255,255)
  else 
    love.graphics.setColor(2,156,24,255)
  end
  love.graphics.print(self.label,self.x,self.y)
  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(self.sprite,self.frames[self.selectedFrame], self.x+200, self.y)
end

function MenuCheck:Update()
  if self.checked then
    self.selectedFrame = 0
  else
    self.selectedFrame = 1
  end
end

function MenuCheck:Check()
  if self.checked == true then
    self.checked = false
  else
    self.checked = true
  end
end

function MenuCheck:Save()
  config[self.configKey] = self.checked
end