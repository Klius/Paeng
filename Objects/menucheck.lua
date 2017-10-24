MenuCheck = Drawable:extend()

function MenuCheck:new()
  self.label = "test"
  self.checked = true
  self.sprite = love.graphics.newImage("assets/menu-checkbox.png")
  self.x = 200;
  self.y = 400;
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
  love.graphics.setColor(255,255,255,255)
  love.graphics.print(self.label,self.x,self.y)
  love.graphics.draw(self.sprite,self.frames[self.selectedFrame], self.x+100, self.y)
  love.graphics.setColor(255,255,255,255)
end

function MenuCheck:Update()
  if self.checked then
    self.selectedFrame = 0
  else
    self.selectedFrame = 1
  end
end