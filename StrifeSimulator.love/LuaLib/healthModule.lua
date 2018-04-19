local healthModuleName = {}
healthModule = healthModuleName

local environmentModule = require("LuaLib.environmentModule")

local healthBarWidth
--local playerLives = player.lives
local playerX
healthModule.gameEnded = false

function healthModule.load(player)

end

function healthModule.damage(player, damage)
	player.health = player.health - damage
end

--[[
function healthModule.updateLives(player, health)
	if health < 1 then
		playerLives = playerLives - 1
		player.health = 8
	end
end--]]

function healthModule.update(dt, player)
	healthBarWidth = player.health * 4
	--playerLives = player.lives

	if player.health < 1 then
		player.lives = player.lives - 1
		player.health = 8
	end

	if player.lives == 0 then
		gameEnded = true
	end

	if player.lives < 0 then
		player.lives = 0
	end
end

function healthModule.display(player)
	--display a health bar above the player
	love.graphics.setColor(255, 70, 70)
	love.graphics.rectangle('fill', player.hurtBox.Position.X, player.hurtBox.Position.Y - 25, healthBarWidth, 10)

	--display player health
	love.graphics.setColor(255, 255, 55)
	if player.playerIndex == 1 then
		love.graphics.print("Player " .. tostring(player.playerIndex) .. " Lives: " .. tostring(player.lives), 100, 15)
	elseif player.playerIndex == 2 then
		love.graphics.print("Player " .. tostring(player.playerIndex) .. " Lives: " .. tostring(player.lives), 600, 15)
	end
end

return healthModule