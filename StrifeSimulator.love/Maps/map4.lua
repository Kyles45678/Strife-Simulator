local map4Module = {}
map4 = map4Module

local environmentModule = require("LuaLib.environmentModule")

local ground
local background
local platform1
local platform2
local platform3
local platform4

function map4Module.getPlatforms()
	return {ground, platform1, platform2, platform3, platform4}
end

function map4Module.load()
	--set background properties
	background = environmentModule.FlatPlatform:new("Background", "fill", 0, 162, 232)
	background.CanCollide = false
	background.Size.X = love.graphics.getWidth()
	background.Size.Y = love.graphics.getHeight()
	background.Position.X = 0
	background.Position.Y = 0

	--set ground properties
	ground = environmentModule.FlatPlatform:new("Ground", "fill", 170, 20, 20)
	ground.CanCollide = true
	ground.Size.X = love.graphics.getWidth() / 2
	ground.Size.Y = love.graphics.getHeight() / 4
	ground.Position.X = love.graphics.getWidth() / 4
	ground.Position.Y = 450

	--set platform1 properties
	platform1 = environmentModule.FlatPlatform:new("Platform1", "fill", 30, 30, 30)
	platform1.CanCollide = true
	platform1.Size.X = 200
	platform1.Size.Y = 15
	platform1.Position.X = 300
	platform1.Position.Y = 365

	--set platform2 properties
	platform2 = environmentModule.FlatPlatform:new("Platform2", "fill", 30, 30, 30)
	platform2.CanCollide = true
	platform2.Size.X = 200
	platform2.Size.Y = 15
	platform2.Position.X = 300
	platform2.Position.Y = 280

	--set platform3 properties
	platform3 = environmentModule.FlatPlatform:new("Platform3", "fill", 30, 30, 30)
	platform3.CanCollide = true
	platform3.Size.X = 200
	platform3.Size.Y = 15
	platform3.Position.X = 300
	platform3.Position.Y = 280

	--set platform4 properties
	platform4 = environmentModule.FlatPlatform:new("Platform4", "fill", 30, 30, 30)
	platform4.CanCollide = true
	platform4.Size.X = 200
	platform4.Size.Y = 15
	platform4.Position.X = 300
	platform4.Position.Y = 280
end

function map4Module.unload()
	ground.CanCollide = false
	platform1.CanCollide = false
	platform2.CanCollide = false
	platform3.CanCollide = false
	platform4.CanCollide = false
end

function map4Module.update(dt)
	
end

function map4Module.display()
	--draw background
	background.display()

	--draw ground
	ground.display()

	--draw platform1
	platform1.display()

	--draw platform2
	platform2.display()

	--draw platform3
	platform3.display()

	--draw platform4
	platform4.display()
end

return map4