
--// Preproccesor Directives \\--

local environmentModule = require("LuaLib.environmentModule") --C:\Users\Kathy Senebouttarath\Desktop\Love 2D\StrifeSimulator.love\
local playerModule = require("LuaLib.playerModule")
local map1Module = require("Maps.map1")

local platform
local map1

local player1 

function love.load()
	platform = environmentModule.FlatPlatform:new("Part", "fill")
	platform.Size.X = love.graphics.getWidth()   
	platform.Size.Y = love.graphics.getHeight() / 4
	platform.Position.X = 0                             
	platform.Position.Y = love.graphics.getHeight() * (3/4)   

	map1.load()

	helperModule.load()

	player1 = playerModule.Player:new("Andrew")   
end

function love.update(dt)
	player1.update(dt)
end

function love.draw()
	platform.display()

	player1.display()
end



