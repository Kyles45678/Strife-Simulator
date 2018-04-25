---------------------------------------------------------------------SOUND MODULE-----------------------------------------------------
--This module will control the sound effects and music for the game

local soundModuleName = {}
soundModule = soundModuleName

local sources = {} --List for sound effects

function soundModuleName.sfx(soundId, volume, pitch)	--Sounds are static (you can spam this)

	--If volume or pitch are set to nothing, they get a default of 100%
	volume = volume or 1.0
	pitch = pitch or 1.0

	local newSound = love.audio.newSource(soundId, "static")
	newSound:setVolume(volume) 
	newSound:setPitch(pitch) 

	love.audio.play(newSound)

end

function soundModuleName.music(soundId, volume, pitch, loop)	--Music is streamable (Dont spam this!!!)

	--If volume or pitch are set to nothing, they get a default of 100%
	volume = volume or 1.0
	pitch = pitch or 1.0

	local newMusic = love.audio.newSource(soundId, "static")
	newMusic:setLooping(loop)
	newMusic:setVolume(volume) 
	newMusic:setPitch(pitch) 

	newMusic:play()

	return newMusic
end

return soundModule
---------------------------------------------------------------------------------------------------------------------------------