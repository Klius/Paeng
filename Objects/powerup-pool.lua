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
  self.rng = love.math.newRandomGenerator( )
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
  local chance = self.rng:random(0,100)
  if  chance > 60 and chance < 70 then
    powerup = PowerupMaximizePala( self.rng:random(self.spawnPoint["minX"],self.spawnPoint["maxX"]), self.rng:random(self.spawnPoint["minY"],self.spawnPoint["maxY"]),
                                  50, 50, "assets/powerup-maxi-pala.png")
--    powerup = PowerupSpeed( self.rng:random(self.spawnPoint["minX"],self.spawnPoint["maxX"]), self.rng:random(self.spawnPoint["minY"],self.spawnPoint["maxY"]),
--                                  50, 50, "assets/powerup-dummy.png")
  elseif chance > 20 and chance < 60 then --
    powerup = PowerupMinimizeBall( self.rng:random(self.spawnPoint["minX"],self.spawnPoint["maxX"]), self.rng:random(self.spawnPoint["minY"],self.spawnPoint["maxY"]),
                                  50, 50, "assets/powerup-mini-ball.png")
  elseif chance > 0  and chance < 20 then --
    powerup = PowerupMaximizeBall( self.rng:random(self.spawnPoint["minX"],self.spawnPoint["maxX"]), self.rng:random(self.spawnPoint["minY"],self.spawnPoint["maxY"]),
                                  50, 50, "assets/powerup-maxi-ball.png")
  end
  table.insert(self.powerups,powerup)
end

function PowerupPool:draw()
  for key,powerup in pairs(self.powerups) do
    if powerup.spawned then
      powerup:draw()
    end
  end
end