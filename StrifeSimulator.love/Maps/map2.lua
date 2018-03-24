local map2Module = {}
map2 = map2Module

local environmentModule = require("LuaLib.environmentModule")

local ground
local background
local platform1
local platform2
local platform3

function map2Module.load()
	--set background properties
	background = environmentModule.FlatPlatform:new("Background", "fill")
	background.canCollide = false
	background.Size.X = love.graphics.getWidth()
	background.Size.Y = love.graphics.getHeight()
	background.Position.X = 0
	background.Position.Y = 0
	background.Color.Red = 240
	background.Color.Green = 100
	background.Color.Blue = 15

	--set ground properties
	ground = environmentModule.FlatPlatform:new("Ground", "fill")
	ground.Size.X = love.graphics.getWidth()
	ground.Size.Y = love.graphics.getHeight() / 4
	ground.Position.X = 0
	ground.Position.Y = 450
	ground.Color.Red = 110
	ground.Color.Green = 60
	ground.Color.Blue = 35

	--set platform1 properties
	platform1 = environmentModule.FlatPlatform:new("Platform1", "fill")
	platform1.Size.X = 200
	platform1.Size.Y = 15
	platform1.Position.X = 100
	platform1.Position.Y = 365
	platform1.Color.Red = 0
	platform1.Color.Green = 0
	platform1.Color.Blue = 0

	--set platform2 properties
	platform2 = environmentModule.FlatPlatform:new("Platform2", "fill")
	platform2.Size.X = 200
	platform2.Size.Y = 15
	platform2.Position.X = 500
	platform2.Position.Y = 195
	platform2.Color.Red = 0
	platform2.Color.Green = 0
	platform2.Color.Blue = 0

	--set platform3 properties
	platform3 = environmentModule.FlatPlatform:new("Platform3", "fill")
	platform3.Size.X = 200
	platform3.Size.Y = 15
	platform3.Position.X = 300
	platform3.Position.Y = 280
	platform3.Color.Red = 0
	platform3.Color.Green = 0
	platform3.Color.Blue = 0
end

function map2Module.update(dt)

end

function map2Module.display()
	--draw background
	love.graphics.setColor(background.Color.Red, background.Color.Green, background.Color.Blue)
	love.graphics.rectangle(background.Fill, background.Position.X, background.Position.Y, background.Size.X, background.Size.Y)

	--draw ground
	love.graphics.setColor(ground.Color.Red, ground.Color.Green, ground.Color.Blue)
	love.graphics.rectangle(ground.Fill, ground.Position.X, ground.Position.Y, ground.Size.X, ground.Size.Y)

	--draw platform1
	love.graphics.setColor(platform1.Color.Red, platform1.Color.Green, platform1.Color.Blue)
	love.graphics.rectangle(platform1.Fill, platform1.Position.X, platform1.Position.Y, platform1.Size.X, platform1.Size.Y)

	--draw platform2
	love.graphics.setColor(platform2.Color.Red, platform2.Color.Green, platform2.Color.Blue)
	love.graphics.rectangle(platform2.Fill, platform2.Position.X, platform2.Position.Y, platform2.Size.X, platform2.Size.Y)

	--draw platform3
	love.graphics.setColor(platform3.Color.Red, platform3.Color.Green, platform3.Color.Blue)
	love.graphics.rectangle(platform3.Fill, platform3.Position.X, platform3.Position.Y, platform3.Size.X, platform3.Size.Y)
end

return map2