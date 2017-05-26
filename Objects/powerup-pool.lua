PowerupPool = Object:extend()

function PowerupPool:new() 
  self.spawnTime = 1
  self.powerupSpawnLimit = 3
  self.powerups = {}
  self.spawnPoint = {
                      ["maxX"] = 650,
                      ["minX"] = 150,
                      ["maxY"] = 100,
                      ["minY"] = love.graphics.getHeight() - 50
                    }
  self.random = math.random
end

function PowerupPool:update(dt)
  self.spawnTime = self.spawnTime - dt
  if self.spawnTime < 0 and table.getn(self.powerups) < self.powerupSpawnLimit then
    --spawn another
    self:spawnPowerup()
    self.spawnTime = 1
  end
  for key,powerup in pairs(self.powerups) do
    powerup:update(dt)
    if powerup.dead then
      --erase powerup from table
      table.remove(self.powerups,key)
    end
  end
end

function PowerupPool:spawnPowerup() 
  powerup = PowerupSpeed( self.random(self.spawnPoint["minX"],self.spawnPoint["maxX"]), self.random(self.spawnPoint["minY"],self.spawnPoint["maxY"]),
                                  50, 50, "assets/powerup-dummy.png")
  table.insert(self.powerups,powerup)
end

function PowerupPool:draw()
  for key,powerup in pairs(self.powerups) do
    if powerup.spawned then
      powerup:draw()
    end
  end
end