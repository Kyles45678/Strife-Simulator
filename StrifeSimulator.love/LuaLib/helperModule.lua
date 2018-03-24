local helpModuleName = {}
helperModule = helpModuleName

helpModuleName.Helper = {}

local timeCounter = 0
local timeCounter1 = 0

helpModuleName.Helper.thread = function(x)
	coroutine.resume(coroutine.create(x))
end

helpModuleName.Helper.variableDelayChange = function(x)
	timeCounter = timeCounter + 1
	local flag = false

	if timeCounter / love.timer.getFPS() >= x then
		timeCounter = 0
		flag = true
	end

	return flag
	--love.graphics.print(tostring(love.timer.getFPS()))
end

helpModuleName.Helper.variableDelayChange1 = function(x)
	timeCounter1 = timeCounter1 + 1
	local flag = false

	if timeCounter1 / love.timer.getFPS() >= x then
		timeCounter1 = 0
		flag = true
	end

	return flag
	--love.graphics.print(tostring(love.timer.getFPS()))
end

function helperModule.load()
	love.window.setFullscreen(true, "desktop")
end

return helperModule