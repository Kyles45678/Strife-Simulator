local gameModuleName = {}
gameModule = gameModuleName

local map1Module = require("Maps.map1")
local map2Module = require("Maps.map2")

local screen = 1

function gameModule.load()
	map1.load()
	map2.load()
end

function gameModule.update(dt)
	map1.update(dt)
	map2.update(dt)
	if love.keyboard.isDown('kp1') then
		screen = 2
	end

	if love.keyboard.isDown('kp2') then
		screen = 3
	end
end

function gameModule.display()
	if screen == 1 then
		love.graphics.print("WE OUT HERE")
	end

	if screen == 2 then
		map1.display()
	end

	if screen == 3 then
		map2.display()
	end

	if screen < 1 or screen > 3 then
		love.graphics.print("OOF")
	end
end

return gameModule