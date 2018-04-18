local healthModuleName = {}
healthModule = healthModuleName

local healthBarWidth

function healthModule.load()

end

function healthModule.update(dt, player)
	healthBarWidth = player.health * 4
end

function healthModule.display(player)
	--display a health bar above the player
	love.graphics.setColor(255, 70, 70)
	love.graphics.rectangle('fill', player.hurtBox.Position.X, player.hurtBox.Position.Y - 25, healthBarWidth, 10)
end

return healthModule