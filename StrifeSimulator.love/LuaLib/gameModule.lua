local gameModuleName = {}
gameModule = gameModuleName

local map1Module = require("Maps.map1")
local map2Module = require("Maps.map2")
local map3Module = require("Maps.map3")
local constantsModule = require("LuaLib.constants")

--images
local TitleScreen = love.graphics.newImage('assets/backgrounds/titleScreen.png')
local Instructions = love.graphics.newImage('assets/backgrounds/instructions.png')
local MapSelection = love.graphics.newImage('assets/backgrounds/mapSelection.png')
local Map1Icon = love.graphics.newImage('Maps/Icons/map1Icon.png')
local Map2Icon = love.graphics.newImage('Maps/Icons/map2Icon.png')
local Map3Icon = love.graphics.newImage('Maps/Icons/map3Icon.png')
local BryGuy = love.graphics.newImage('assets/backgrounds/brian.jpg')
local cursor = love.graphics.newImage('assets/cursors/crosshair.png')

--variables
local screen = constantsModule.titleScreen
gameModuleName.gravity = -1000
gameModuleName.maxFallVelocity = 400
gameModuleName.pressed = false

--turn off mouse visibility
love.mouse.setVisible(false)

function gameModule.load()
	map1.load()
	map2.load()
	map3.load()

	--title screen rectangles
	InstructionsRect = environmentModule.FlatPlatform:new("InstructionsRect", "line", 255, 255, 255)
	InstructionsRect.Size.X = 298
	InstructionsRect.Size.Y = 50
	InstructionsRect.Position.X = 20
	InstructionsRect.Position.Y = 396

	MapSelectRect = environmentModule.FlatPlatform:new("MapSelectRect", "line", 255, 255, 255)
	MapSelectRect.Size.X = 225
	MapSelectRect.Size.Y = 50
	MapSelectRect.Position.X = 500
	MapSelectRect.Position.Y = 396

	--back button rectangle
	BackRect = environmentModule.FlatPlatform:new("BackRect", "line", 255, 255, 255)
	BackRect.Size.X = 85
	BackRect.Size.Y = 40
	BackRect.Position.X = 705
	BackRect.Position.Y = 14

	--map icons
	Map1Rect = environmentModule.FlatPlatform:new("Map1Rect", "line", 34, 177, 76)
	Map1Rect.Size.X = 162
	Map1Rect.Size.Y = 122
	Map1Rect.Position.X = 159
	Map1Rect.Position.Y = 199

	Map2Rect = environmentModule.FlatPlatform:new("Map2Rect", "line", 34, 177, 76)
	Map2Rect.Size.X = 162
	Map2Rect.Size.Y = 122
	Map2Rect.Position.X = 479
	Map2Rect.Position.Y = 199

	Map3Rect = environmentModule.FlatPlatform:new("Map3Rect", "line", 34, 177, 76)
	Map3Rect.Size.X = 162
	Map3Rect.Size.Y = 122
	Map3Rect.Position.X = 159
	Map3Rect.Position.Y = 369
end

function gameModule.unload()
	map1.unload()
	map2.unload()
	map3.unload()
end

--[[
function gameModule.intersects(object)
	local check = false
	local mouseX = love.mouse.getX() - cursor:getWidth() / 2
	local mouseY = love.mouse.getY() - cursor:getHeight() / 2
	local objectLeftX = object.Position.X
	local objectRightX = object.Position.X + object.Size.X
	local objectTopY = object.Position.Y
	local objectBotY = object.Position.Y + object.Size.Y

	if(mouseX >= objectLeftX and mouseX <= objectRightX and mouseY >= objectTopY and mouseY <= objectBotY) then
		check = true
	end

	return check
end--]]

--check for intersection, returns true if the two objects are intersecting, false if not
function gameModule.intersects(object)
	return love.mouse.getX() - cursor:getWidth() / 2 >= object.Position.X and
		   love.mouse.getX() - cursor:getWidth() / 2 <= object.Position.X + object.Size.X and
		   love.mouse.getY() - cursor:getHeight() / 2 >= object.Position.Y and
		   love.mouse.getY() - cursor:getHeight() / 2 <= object.Position.Y + object.Size.Y
end

--check for mouse click on an object, return true if mouse clicked on that object
function gameModule.clicked(object)
	local check = false

	if gameModule.intersects(object) then
		if love.mouse.isDown(1) and gameModuleName.pressed == false then
			gameModuleName.pressed = true
			check = false
		elseif love.mouse.isDown(1) == false and gameModuleName.pressed == true then
			gameModuleName.pressed = false
			check = true
		end
	end

	return check
end

function gameModule.update(dt)
	map1.update(dt)
	map2.update(dt)
	map3.update(dt)

	gameModuleName.screen = screen

	--make sure screens are in range
	if screen < constantsModule.titleScreen then
		screen = constantsModule.titleScreen
	elseif screen > constantsModule.bryGuy then
		screen = constantsModule.bryGuy
	end

	--control which screen is being displayed

	if screen == 1 then
		--click on "instructions" to go to instructions
		if gameModule.clicked(InstructionsRect) then
			screen = 2
		--click on "play game" to go to map selection
		elseif gameModule.clicked(MapSelectRect) then
			screen = 3
		end
	end

	--backspace to go back to title screen
	if (screen == 2 or screen == 3) and gameModule.clicked(BackRect) then
		screen = 1
	end

	if screen == 3 then
		--click on map 1 icon to go to map 1
		if gameModule.clicked(Map1Rect) then
			screen = 4
		--click on map 2 icon to go to map 2
		elseif gameModule.clicked(Map2Rect) then
			screen = 5
		--click on map 3 icon to go to map 3
		elseif gameModule.clicked(Map3Rect) then
			screen = 6
		end
	end

	--for testing, delete later
	if love.keyboard.isDown('kp9') then
		screen = 1
	end

	--We have the meats
	if screen == 1 and love.keyboard.isDown('9') and love.keyboard.isDown('3') and love.keyboard.isDown('0') then
		screen = 7
	elseif screen == 7 and love.keyboard.isDown('backspace') then
		screen = 1
	end
end

function gameModule.display()
	--control which screen is currently being displayed
	if screen == constantsModule.titleScreen then
		love.graphics.draw(TitleScreen, 0, 0)
		InstructionsRect.display()
		MapSelectRect.display()
		gameModule.unload()
		--love.graphics.print(tostring(love.graphics.getWidth()), 0, 0)
		--love.graphics.print(tostring(love.graphics.getHeight()), 0, 20)
	elseif screen == constantsModule.instructions then
		love.graphics.draw(Instructions, 0, 0)
		BackRect.display()
		gameModule.unload()
	elseif screen == constantsModule.mapSelection then
		love.graphics.draw(MapSelection, 0, 0)
		love.graphics.draw(Map1Icon, 160, 200)
		love.graphics.draw(Map2Icon, 480, 200)
		love.graphics.draw(Map3Icon, 160, 370)
		BackRect.display()
		gameModule.unload()
	elseif screen == constantsModule.map1 then
		map1.load()
		map1.display()
		map2.unload()
		map3.unload()
	elseif screen == constantsModule.map2 then
		map2.load()
		map2.display()
		map1.unload()
		map3.unload()
	elseif screen == constantsModule.map3 then
		map3.load()
		map3.display()
		map1.unload()
		map2.unload()
	elseif screen == constantsModule.bryGuy then
		love.graphics.draw(BryGuy, 0, 0)
		gameModule.unload()
	else
		love.graphics.draw(BryGuy, 0, 0)
		love.graphics.print("OOF", 10, 10)
		gameModule.unload()
	end

	if screen == 1 or screen == 2 or screen == 3 then
		--draw cursor to screen
		love.graphics.setColor(255, 255, 255)
		love.graphics.draw(cursor, love.mouse.getX() - cursor:getWidth() / 2, love.mouse.getY() - cursor:getHeight() / 2)
	end
end

return gameModule