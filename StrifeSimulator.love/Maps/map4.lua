local map4Module = {}
map4 = map4Module

local environmentModule = require("LuaLib.environmentModule")

local ground
local background

function map4Module.getPlatforms()
	return {ground}
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
	ground = environmentModule.FlatPlatform:new("Ground", "fill", 80, 80, 80)
	ground.CanCollide = true
	ground.Size.X = love.graphics.getWidth() / 2
	ground.Size.Y = love.graphics.getHeight() / 4
	ground.Position.X = love.graphics.getWidth() / 4
	ground.Position.Y = 450
end

function map4Module.unload()
	ground.CanCollide = false
end

function map4Module.update(dt)
	
end

function map4Module.display()
	--draw background
	background.display()

	--draw ground
	ground.display()
end

return map4