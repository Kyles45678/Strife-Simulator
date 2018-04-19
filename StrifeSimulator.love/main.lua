
--// Preproccesor Directives \\--

local environmentModule = require("LuaLib.environmentModule") --C:\Users\Kathy Senebouttarath\Desktop\Love 2D\StrifeSimulator.love\
local playerModule = require("LuaLib.playerModule")
local gameModule = require("LuaLib.gameModule")
local constantsModule = require("LuaLib.constants")

local player1 
local player2

function love.load() 
	gameModule.load()

	--helperModule.load()

	player1 = playerModule.Player:new("Andrew", constantsModule.player1up, constantsModule.player1down, constantsModule.player1left, constantsModule.player1right, constantsModule.player1attack, love.graphics.getWidth() * (3/8), love.graphics.getHeight() * (3/4), 1) 
	player2 = playerModule.Player:new("Biggie Smalls", constantsModule.player2up, constantsModule.player2down, constantsModule.player2left, constantsModule.player2right, constantsModule.player2attack, love.graphics.getWidth() * (5/8) - 32, love.graphics.getHeight() * (3/4), 2)  
end

function love.update(dt)
	gameModule.update(dt)

	--only control the players if a map is selected
	if gameModule.screen == 4 or gameModule.screen == 5 or gameModule.screen == 6 or gameModule.screen == 7 then
		player1.update(dt)
		player2.update(dt)
	end

	if(love.keyboard.isDown(constantsModule.exitKey)) then
		love.event.quit()
	end
end

function love.draw()
	gameModule.display()

	--only draw the players if a map is selected
	if gameModule.screen == 4 or gameModule.screen == 5 or gameModule.screen == 6 or gameModule.screen == 7 then
		player1.display()
		player2.display()
	end
end



