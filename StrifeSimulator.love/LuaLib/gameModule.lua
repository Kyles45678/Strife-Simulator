local gameModuleName = {}
gameModule = gameModuleName

local map1Module = require("Maps.map1")
local map2Module = require("Maps.map2")

local screen = 1

function gameModule.load()
	map1.load()
	map2.load()
end

function gameModule.update(dt)
	
end

function gameModule.draw()
	
end

return gameModule