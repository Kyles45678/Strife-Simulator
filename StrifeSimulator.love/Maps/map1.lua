local map1Module = {}
map1 = map1Module

local environmentModule = require("LuaLib.environmentModule")

local map1

function map1Module.load()
	love.graphics.print("egg")
	map1 = environmentModule.FlatPlatform:new("Map1", "fill")
	map1.canCollide = true 
end

function map1Module.update(dt)

end

function map1Module.display()
	
end

return map1