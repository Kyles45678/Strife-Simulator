----------------------------------------------map1.lua--------------------------------------------------

--this holds the data for the first map

local map1Module = {}
map1 = map1Module

local environmentModule = require("LuaLib.environmentModule")

local ground
local background
local platform1
local platform2
local platform3
local leftWall
local rightWall

function map1Module.getPlatforms()
	return {ground, platform1, platform2, platform3, leftWall, rightWall}
end

function map1Module.load()
	--set background properties
	background = environmentModule.FlatPlatform:new("Background", "fill", 125, 200, 232)
	background.CanCollide = false
	background.Size.X = love.graphics.getWidth()
	background.Size.Y = love.graphics.getHeight()
	background.Position.X = 0
	background.Position.Y = 0

	--set ground properties
	ground = environmentModule.FlatPlatform:new("Ground", "fill", 0, 175, 0)
	ground.CanCollide = true
	ground.Size.X = love.graphics.getWidth()
	ground.Size.Y = love.graphics.getHeight() / 4
	ground.Position.X = 0
	ground.Position.Y = 450

	--set platform1 properties
	platform1 = environmentModule.FlatPlatform:new("Platform1", "fill", 60, 60, 60)
	platform1.CanCollide = true
	platform1.Size.X = 200
	platform1.Size.Y = 15
	platform1.Position.X = 100
	platform1.Position.Y = 365

	--set platform2 properties
	platform2 = environmentModule.FlatPlatform:new("Platform2", "fill", 60, 60, 60)
	platform2.CanCollide = true
	platform2.Size.X = 200
	platform2.Size.Y = 15
	platform2.Position.X = 500
	platform2.Position.Y = 365

	--set platform3 properties
	platform3 = environmentModule.FlatPlatform:new("Platform3", "fill", 60, 60, 60)
	platform3.CanCollide = true
	platform3.Size.X = 200
	platform3.Size.Y = 15
	platform3.Position.X = 300
	platform3.Position.Y = 280

	leftWall = environmentModule.FlatPlatform:new("Left Wall", "fill", 255, 255, 255)
	leftWall.CanCollide = true
	leftWall.Size.X = 30
	leftWall.Size.Y = 600
	leftWall.Position.X = -30
	leftWall.Position.Y = 0
	leftWall.Type = "Wall"

	rightWall = environmentModule.FlatPlatform:new("Right Wall", "fill", 255, 255, 255)
	rightWall.CanCollide = true
	rightWall.Size.X = 30
	rightWall.Size.Y = 600
	rightWall.Position.X = 800
	rightWall.Position.Y = 0
	rightWall.Type = "Wall"
end

function map1Module.unload()
	ground.CanCollide = false
	platform1.CanCollide = false
	platform2.CanCollide = false
	platform3.CanCollide = false
	leftWall.CanCollide = false
	rightWall.CanCollide = false
	leftWall.Type = "Platform"
	rightWall.Type = "Platform"
end

function map1Module.update(dt)

end

function map1Module.display()
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
end

return map1
-------------------------------------------------------------------------------------------------------