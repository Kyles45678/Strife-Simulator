local gameModuleName = {}
gameModule = gameModuleName

local map1Module = require("Maps.map1")
local map2Module = require("Maps.map2")

local screen = 1

TestImage = love.graphics.newImage('assets/backgrounds/brian.jpg')

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
		love.graphics.draw(TestImage, 0, 0)
		love.graphics.print(tostring(love.graphics.getWidth()), 0, 0)
		love.graphics.print(tostring(love.graphics.getHeight()), 0, 20)
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