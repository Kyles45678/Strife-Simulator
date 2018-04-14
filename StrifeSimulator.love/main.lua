
--// Preproccesor Directives \\--

local environmentModule = require("LuaLib.environmentModule") --C:\Users\Kathy Senebouttarath\Desktop\Love 2D\StrifeSimulator.love\
local playerModule = require("LuaLib.playerModule")
local gameModule = require("LuaLib.gameModule")
local constantsModule = require("LuaLib.constants")

local platform

local player1 
local player2

function love.load()
	platform = environmentModule.FlatPlatform:new("Part", "fill", 255, 255, 255)
	platform.Size.X = love.graphics.getWidth()   
	platform.Size.Y = love.graphics.getHeight() / 4
	platform.Position.X = 0                             
	platform.Position.Y = love.graphics.getHeight() * (3/4)   

	gameModule.load()

	--helperModule.load()

	player1 = playerModule.Player:new("Andrew", constantsModule.player1up, constantsModule.player1down, constantsModule.player1left, constantsModule.player1right, constantsModule.player1attack, love.graphics.getWidth() / 2, love.graphics.getHeight() * (3/4), 1) 
	player2 = playerModule.Player:new("Biggie Smalls", constantsModule.player2up, constantsModule.player2down, constantsModule.player2left, constantsModule.player2right, constantsModule.player2attack, love.graphics.getWidth() / 2, love.graphics.getHeight() * (3/4), 2)  
end

function love.update(dt)
	gameModule.update(dt)

	--only control the players if a map is selected
	if gameModule.screen == 4 or gameModule.screen == 5 or gameModule.screen == 6 then
		player1.update(dt)
		player2.update(dt)
	end

	if(love.keyboard.isDown(constantsModule.exitKey)) then
		love.event.quit()
	end
end

function love.draw()
	platform.display()

	gameModule.display()

	--only draw the players if a map is selected
	if gameModule.screen == 4 or gameModule.screen == 5 or gameModule.screen == 6 then
		player1.display()
		player2.display()
	end
end



