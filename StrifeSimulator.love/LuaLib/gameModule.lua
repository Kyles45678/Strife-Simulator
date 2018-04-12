local gameModuleName = {}
gameModule = gameModuleName

local map1Module = require("Maps.map1")
local map2Module = require("Maps.map2")
local constantsModule = require("LuaLib.constants")

local screen = constantsModule.titleScreen
local BryGuy = love.graphics.newImage('assets/backgrounds/brian.jpg')

gameModuleName.gravity = -1000
gameModuleName.maxFallVelocity = 400

function gameModule.load()
	map1.load()
	map2.load()
end

function gameModule.unload()
	map1.unload()
	map2.unload()
end

function gameModule.update(dt)
	map1.update(dt)
	map2.update(dt)

	--make sure screens are in range
	if screen < constantsModule.titleScreen then
		screen = constantsModule.titleScreen
	end

	if screen > constantsModule.map2 then
		screen = constantsModule.map2
	end

	--control which screen is being displayed

	--shift to go to instructions
	if screen == 1 and (love.keyboard.isDown('lshift') or love.keyboard.isDown('rshift')) then
		screen = 2
	end

	--enter to go to map selection
	if screen == 1 and love.keyboard.isDown('return') then
		screen = 3
	end

	--backspace to go back to title screen
	if (screen == 2 or screen == 3) and love.keyboard.isDown('backspace') then
		screen = 1
	end

	--kp1 to go to map 1
	if screen == 3 and love.keyboard.isDown('kp1') then
		screen = 4
	end

	--kp2 to go to map 2
	if screen == 3 and love.keyboard.isDown('kp2') then
		screen = 5
	end

	--for testing, delete later
	if love.keyboard.isDown('kp9') then
		screen = 1
	end
end

function gameModule.display()
	if screen == 1 then
		love.graphics.draw(BryGuy, 0, 0)
		love.graphics.print("Title Screen", 10, 10)
		gameModule.unload()
		--love.graphics.print(tostring(love.graphics.getWidth()), 0, 0)
		--love.graphics.print(tostring(love.graphics.getHeight()), 0, 20)
	elseif screen == 2 then
		love.graphics.draw(BryGuy, 0, 0)
		love.graphics.print("Instructions", 10, 10)
		gameModule.unload()
	elseif screen == 3 then
		love.graphics.draw(BryGuy, 0, 0)
		love.graphics.print("Map Selection", 10, 10)
		gameModule.unload()
	elseif screen == 4 then
		map1.load()
		map1.display()
		map2.unload()
	elseif screen == 5 then
		map2.load()
		map2.display()
		map1.unload()
	else
		love.graphics.draw(BryGuy, 0, 0)
		love.graphics.print("OOF", 10, 10)
		gameModule.unload()
	end
end

return gameModule