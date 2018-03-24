
--// Preproccesor Directives \\--

local environmentModule = require("LuaLib.environmentModule") --C:\Users\Kathy Senebouttarath\Desktop\Love 2D\StrifeSimulator.love\
local playerModule = require("LuaLib.playerModule")
local gameModule = require("LuaLib.gameModule")

local platform

local player1 

function love.load()
	platform = environmentModule.FlatPlatform:new("Part", "fill")
	platform.Size.X = love.graphics.getWidth()   
	platform.Size.Y = love.graphics.getHeight() / 4
	platform.Position.X = 0                             
	platform.Position.Y = love.graphics.getHeight() * (3/4)   

	gameModule.load()

	--helperModule.load()

	player1 = playerModule.Player:new("Andrew")   
end

function love.update(dt)
	player1.update(dt)

	gameModule.update(dt)

	if(love.keyboard.isDown(constantsModule.exitKey)) then
		love.event.quit()
	end
end

function love.draw()
	platform.display()

	gameModule.display()

	player1.display()
end



