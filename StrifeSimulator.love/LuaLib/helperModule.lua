local helpModuleName = {}
helperModule = helpModuleName

helpModuleName.Helper = {}

local timeCounter = 0

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

function helperModule.load()
	love.window.setFullscreen(true, "desktop")
end

return helperModule