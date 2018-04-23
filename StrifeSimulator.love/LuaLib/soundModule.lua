local soundModuleName = {}
soundModule = soundModuleName

sound = love.audio.newSource("pling.wav", "static") -- the "static" tells LÖVE to load the file into memory, good for short sound effects
music = love.audio.newSource("techno.ogg") -- if "static" is omitted, LÖVE will stream the file from disk, good for longer music tracks

sound:play()
music:play()

local sources = {} --List for sound effects

function sfx(soundId, volume, pitch)	--Sounds are static (you can spam this)

	volume = volume or 1.0
	pitch = pitch or 1.0

	local function createSound()
		local newSound = love.audio.newSource(soundId, "static")
		newSound:setVolume(volume) -- 90% of ordinary volume
		newSound:setPitch(pitch) -- one octave lower
		return newSound
	end

	for _, sound in ipairs(sources) do
		if sound:isStopped() then
			love.audio.play(sound)
			return
		end
	end
	table.insert(sources, createSound())
	love.audio.play(sources[#sources])

end

function music(soundId, volume, pitch, loop)	--Music is streamable

	volume = volume or 1.0
	pitch = pitch or 1.0

	local newMusic = love.audio.newSource(soundId, "static")
	newMusic:setLooping(loop)
	newMusic:setVolume(volume) 
	newMusic:setPitch(pitch) 

	newMusic:play()
end

return soundModule