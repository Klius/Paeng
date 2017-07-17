--! file: circle.lua
Bola = Drawable:extend()

function Bola:new(x, y, radius)
    Bola.super.new(self, x, y)
    --Config
    self.defaultSpeed = 350
    self.maxSpeed = 800
    self.incrementSpeed = 15
    --A circle doesn't have a width or height. It has a radius.
    self.radius = radius
    self.speedX = self.defaultSpeed
    self.speed = self.defaultSpeed
    self.speedY = 0
    self.colors = {
                    {255,255,255,255},{255,255,0,255},{98,150,255,255} ,
                    {0,255,0,255}, {255,0,0,255}
                  }
    self.colorLevel = 1
    self.angle = 0
    self:initSound()
    self.currentSound = 1 
end

function Bola:initSound()
  self.collisionSFX = {}
  for i=1,8,1 do
    src = love.audio.newSource("assets/sfx/ball-"..i..".ogg",static)
    table.insert(self.collisionSFX,src)
  end
end

function Bola:update(dt)
  self:updateColorLevel()
  self.x = self.x + self.speedX * dt
  self.y = self.y + self.speedY * dt
  --Check if the Ball collides with top and bottom walls
  if (self.y < 0) then
    self.y = 0
    self.speedY = self.speedY *-1
    self.collisionSFX[self:nextSound()]:play()
  elseif (self.y+self.radius > love.graphics.getHeight()) then
    
    self.y = love.graphics.getHeight() - self.radius
    self.speedY = self.speedY *-1
    self.collisionSFX[self:nextSound()]:play()
  end
  self.angle = self.angle + dt * math.pi/2
	self.angle = self.angle % (2*math.pi)
end

function Bola:updateColorLevel() 
  
  if self.speed > 400 and self.speed < 500 or self.speed > -400 and self.speed < -500 then
    self.colorLevel = 2
  elseif self.speed > 500 and self.speed < 600 or self.speed > -500 and self.speed < -600 then
    self.colorLevel = 3
  elseif self.speed > 600 and self.speed < 700 or self.speed > -600 and self.speed < -700 then
    self.colorLevel = 4
  elseif self.speed == 800 or self.speed == -800 then
    self.colorLevel = math.random(1,5)
  end 
end


function Bola:draw()
    love.graphics.setColor(
                            self.colors[self.colorLevel][1],
                            self.colors[self.colorLevel][2],
                            self.colors[self.colorLevel][3],
                            self.colors[self.colorLevel][4]
                          )
    love.graphics.setLineWidth(3)
    love.graphics.translate(self.x + self.radius/2, self.y+self.radius/2)
    love.graphics.rotate(self.angle)
    love.graphics.translate(-(self.x + self.radius/2), -(self.y+self.radius/2))
    love.graphics.circle("line", self.x, self.y,self.radius,8)
    love.graphics.setColor(255,255,255,255)
    love.graphics.origin()
    love.graphics.setLineWidth(1)
end
--[[
Reseteja la bola a l'estat inicial
]]
function Bola:reset()
  self.x = love.graphics.getWidth()/2
  self.y = love.graphics.getHeight()/2
  self.speed = self.defaultSpeed
  self.speedX = self.defaultSpeed
  self.speedY = 0
  self.colorLevel = 1
end
function Bola:setSpeed(x,y)
  self.speedX = x
  self.speed = self.speed * -1
  self.speedY = y
end

--[[
  Adds more speed to the current speed. 
]]
function Bola:moreSpeed()
  if self.speed ~= self.maxSpeed and 
    self.speed ~= -self.maxSpeed then
    if self.speed < 0 then
      self.speed = self.speed - self.incrementSpeed
    else
      self.speed = self.speed + self.incrementSpeed
    end
  end
end
-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function Bola:checkCollision(player)
  if (self.x < player.x+player.width and
         player.x < self.x+self.radius and
         self.y < player.y+player.height and
         player.y < self.y+self.radius) then
    
    local relativeIntersectY = (player.y+(player.height/2)) - (ball.y+(ball.radius/2))
    local normalizedRelativeIntersectionY = (relativeIntersectY/(player.height/2))
    local bounceAngle = normalizedRelativeIntersectionY * 60
    self:setSpeed(self.speed*-1,self.speed*-math.sin(bounceAngle))
    --This is the bounce back
    self.x = self.x + (self.speed*love.timer.getDelta())

    self:moreSpeed()
    self.collisionSFX[self:nextSound()]:play()
    --self.collisionSFX[math.random(1,7)]:play()
  end
end

function Bola:checkCollisionPowerup(powerup) 
  if (self.x < powerup.x+powerup.width and
         powerup.x < self.x+self.radius and
         self.y < powerup.y+powerup.height and
         powerup.y < self.y+self.radius and 
         powerup.active == false) then
    
    powerup.activate = true
    powerup.spawned = false
    if powerup.applies == "same" then
      if self.speedX > 0 then
        powerup.player = 1
      else 
        powerup.player = 2
      end
    elseif powerup.applies == "ball" then
        powerup.player = 3
    else
      if self.speedX > 0 then
        powerup.player = 2
      else 
        powerup.player = 1
      end
    end

  end
end

function Bola:nextSound()
  self.currentSound = self.currentSound + 1
  if self.currentSound > 8 then
    self.currentSound = 1
  end
  return self.currentSound
end

function Bola:applyPowerup(powerup)
  if powerup.type == "mini" or powerup.type == "maxi" then
    self.radius = powerup.newSize
  end
end

function Bola:deapplyPowerup(powerup)
  if powerup.type == "mini" or powerup.type == "maxi" then
    self.radius = powerup.defaultSize
  end
end