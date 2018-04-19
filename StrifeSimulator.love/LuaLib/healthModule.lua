local healthModuleName = {}
healthModule = healthModuleName

local healthBarWidth
local playerLives
local playerX

function healthModule.load(player)

end

function healthModule.update(dt, player)
	healthBarWidth = player.health * 4
	playerLives = player.lives
end

function healthModule.display(player)
	--display a health bar above the player
	love.graphics.setColor(255, 70, 70)
	love.graphics.rectangle('fill', player.hurtBox.Position.X, player.hurtBox.Position.Y - 25, healthBarWidth, 10)
	love.graphics.setColor(255, 255, 55)
	if player.playerIndex == 1 then
		love.graphics.print("Player " .. tostring(player.playerIndex) .. " Lives: " .. tostring(playerLives), 100, 15)
	elseif player.playerIndex == 2 then
		love.graphics.print("Player " .. tostring(player.playerIndex) .. " Lives: " .. tostring(playerLives), 600, 15)
	end
end

return healthModule