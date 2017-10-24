MusicManager = Object:extend()

function MusicManager:new()
  self.backgroundMusic = love.audio.newSource("assets/sfx/aqua-loop.wav")
  self.backgroundMusic:setLooping(true)
  self.backgroundMusic:setVolume(0.5)
  self.chime = love.audio.newSource("assets/sfx/chime.wav")
  self.chime:setVolume(1)
  self.menuMusic = love.audio.newSource("assets/sfx/menu.wav")
  self.menuMusic:setLooping(true)
  self.menuMusic:setVolume(0.5)
  self.currentMusic = self.backgroundMusic
end

function MusicManager:PlayMusic()
    if(currentState == states.menu and self.currentMusic ~= self.menuMusic) then
      self.currentMusic:stop()
      self.currentMusic = self.menuMusic
      self.currentMusic:play()
    elseif (currentState == states.game and self.currentMusic ~= self.backgroundMusic) then
      self.currentMusic:stop()
      self.currentMusic = self.backgroundMusic
      self.currentMusic:play()
    end
end

function MusicManager:PlayChime()
  self.chime:stop()
  self.chime:play()
end