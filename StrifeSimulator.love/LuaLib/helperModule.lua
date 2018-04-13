local helpModuleName = {}
helperModule = helpModuleName

helpModuleName.Helper = {}


helpModuleName.Helper.variableDelayChange = function(timeGoal, timeCounter)
	timeCounter.count = timeCounter.count + 1
	local flag = false

	if timeCounter.count / love.timer.getFPS() >= timeGoal then
		timeCounter.count = 0
		flag = true
	end

	return flag
end


function helperModule.load()
	love.window.setFullscreen(true, "desktop")
end

return helperModule