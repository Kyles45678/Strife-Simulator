
local plyModuleName = {}			--The local name of the module (to be used in here only!)
playerModule = plyModuleName	--The actual name of the module

local animModule = require("LuaLib.animationModule")
local helpModule = require("LuaLib.helperModule")
local environmentModule = require("LuaLib.environmentModule")
local map1Mod = require('Maps.map1')
local map2Mod = require('Maps.map2')
local map3Mod = require('Maps.map3')
local map4Mod = require('Maps.map4')
local gameModule = require('LuaLib.gameModule')

plyModuleName.Player = {}

local allPlayers = {}
local chek = false

function plyModuleName.Player:new(name, upKey, downKey, leftKey, rightKey, attackKey, startX, startY, playerIndex)	
	local player = {}

	--Constants
	player.Name = name
	player.CanCollide = true
	player.loaded = true

	player.floorHitbox = environmentModule.FlatPlatform:new("Part", "line")
	player.floorHitbox.Size.X = 32  
	player.floorHitbox.Size.Y = 1  
	player.floorHitbox.Position.X = 0                             
	player.floorHitbox.Position.Y = 0

	player.hurtBox = environmentModule.FlatPlatform:new("Part", "line")
	player.hurtBox.Size.X = 32  
	player.hurtBox.Size.Y = 64  
	player.hurtBox.Position.X = 0                             
	player.hurtBox.Position.Y = 0
	player.hurtBox.Type = "Wall"

	player.attackBox = environmentModule.FlatPlatform:new("Part", "line", 255, 255, 0)
	player.attackBox.Size.X = 20  
	player.attackBox.Size.Y = 14  
	player.attackBox.Position.X = 0                             
	player.attackBox.Position.Y = 0

	player.gaurdBox = environmentModule.FlatPlatform:new("Part", "line", 0, 0, 255)
	player.gaurdBox.Size.X = 6  
	player.gaurdBox.Size.Y = 32 
	player.gaurdBox.Position.X = 0                             
	player.gaurdBox.Position.Y = 0

	--Variables
	player.Position = {
		X = startX;
		Y = startY;
	}

	player.Velocity = {
		X = 0;
		Y = 0;
	}

	player.Acceleration = {
		X = 0;
		Y = 0;
	}

	player.playerImages = {

		playerRight = {
			Walk = animModule.Animation:new(love.graphics.newImage('assets/player1/right/WalkRightAnim.png'), 64, 64, 0.2);
			Idle = love.graphics.newImage('assets/player1/right/WalkRightIdle.png');
			Low = love.graphics.newImage('assets/player1/right/RightLow.png');
			LowStab = love.graphics.newImage('assets/player1/right/RightLowStab.png');
			Charge = love.graphics.newImage('assets/player1/right/RightCharge.png');
			Stab = love.graphics.newImage('assets/player1/right/RightStab.png');
			StabDown = love.graphics.newImage('assets/player1/right/RightDownStab.png');
			StabUp = love.graphics.newImage('assets/player1/right/RightStabUp.png');
			Hurt = love.graphics.newImage('assets/player1/right/RightHurt.png');
		};

		playerLeft = {
			Walk = animModule.Animation:new(love.graphics.newImage('assets/player1/left/WalkLeftAnim.png'), 64, 64, 0.2);
			Idle = love.graphics.newImage('assets/player1/left/WalkLeftIdle.png');
			Low = love.graphics.newImage('assets/player1/left/LeftLow.png');
			LowStab = love.graphics.newImage('assets/player1/left/LeftLowStab.png');
			Charge = love.graphics.newImage('assets/player1/left/LeftCharge.png');
			Stab = love.graphics.newImage('assets/player1/left/LeftStab.png');
			StabDown = love.graphics.newImage('assets/player1/left/LeftDownStab.png');
			StabUp = love.graphics.newImage('assets/player1/left/LeftStabUp.png');
			Hurt = love.graphics.newImage('assets/player1/left/LeftHurt.png');
		};
	}
	
	player.currentImg = player.playerImages.playerLeft.Idle

	player.damage = 1
	player.health = 8
	player.lives = 3
	player.personalTimer = {count = 0}

	player.walkSpeed = 18
	player.sprintSpeed = player.walkSpeed + (player.walkSpeed/2)

	player.friction = 3
	player.ground = player.Position.Y     -- This makes the character land on the plaform.
	player.baseGround = player.Position.Y
	player.jumpHeight = -450   
	player.gravity = gameModule.gravity       

	player.state = "idle"
	player.facingDirection = "left"

	player.attacking = false
	player.charging = false
	player.canAttack = true
	player.sprinting = false
	player.grounded = true

	local allPlats = nil
	table.insert(allPlayers, playerIndex, player)

	--Change Images
	local function changeAttackAnim(direction)
		if direction == "right" then
			if player.charging then
				player.currentImg = player.playerImages.playerRight.Charge
			elseif player.attacking then
				player.currentImg = player.playerImages.playerRight.Stab
			end
		elseif direction == "left" then
			if player.charging then
				player.currentImg = player.playerImages.playerLeft.Charge
			elseif player.attacking then
				player.currentImg = player.playerImages.playerLeft.Stab
			end
		end
	end

	--Main Loop
	function player.update(dt)

		if not player.loaded then return end

		local dt1 = math.min(dt, 0.07)
		local frame = dt1 * 30

		if not player.attacking then
			
			if player.grounded then
				if love.keyboard.isDown(rightKey) then
					if player.state ~= "crouch" then
						player.state = "walk"
						player.Velocity.X = player.Velocity.X + player.walkSpeed * dt
					end
					player.facingDirection = "right"
				elseif love.keyboard.isDown(leftKey) then
					if player.state ~= "crouch" then
						player.state = "walk"
						player.Velocity.X = player.Velocity.X - player.walkSpeed * dt
					end
					player.facingDirection = "left"
				end
			end

			if love.keyboard.isDown(downKey) then
				if player.grounded then
					player.state = "crouch"
				end
			end

			if love.keyboard.isDown(upKey) then
				if player.grounded then
					player.state = "jump"
					player.Velocity.Y = player.jumpHeight
				end
			end

			if not player.canAttack and not player.charging and not love.keyboard.isDown(attackKey) then
				checkTime = helpModule.Helper.variableDelayChange(0.05, player.personalTimer)
				if checkTime then
					player.canAttack = true
				end
			end

			if love.keyboard.isDown(attackKey) and player.canAttack then
				player.canAttack = false
				if player.state == "crouch" or player.state == "jump" then
					player.attacking = true
					player.charging = false
				elseif player.state == "idle" or player.state == "walk" then
					if player.grounded then
						player.attacking = true
						player.charging = true
					end
				end
			end 

			if not love.keyboard.isDown(leftKey) and not love.keyboard.isDown(rightKey) and not love.keyboard.isDown(upKey) and not love.keyboard.isDown(downKey) and not love.keyboard.isDown(attackKey) then
				if player.grounded then
					player.state = "idle"
				end
			end

			--Change Idle Images
			if player.state == "jump" or player.state == "crouch" then
				if player.facingDirection == "right" then
					player.currentImg = player.playerImages.playerRight.Low
				elseif player.facingDirection == "left" then
					player.currentImg = player.playerImages.playerLeft.Low
				end
			elseif player.state == "walk" then
				if player.facingDirection == "right" then
					player.currentImg = player.playerImages.playerRight.Idle
					player.playerImages.playerRight.Walk.update(dt)
				elseif player.facingDirection == "left" then
					player.currentImg = player.playerImages.playerLeft.Idle
					player.playerImages.playerLeft.Walk.update(dt)
				end
			elseif player.state == "idle" then
				if player.facingDirection == "right" then
					player.currentImg = player.playerImages.playerRight.Idle
				elseif player.facingDirection == "left" then
					player.currentImg = player.playerImages.playerLeft.Idle
				end
			end
		else --If player.attacking then

			--Update timers
			local checkTime 
			if player.charging then
				checkTime = helpModule.Helper.variableDelayChange(0.2, player.personalTimer)
				if checkTime then
					player.attacking = true
					player.charging = false
				end
			else
				checkTime = helpModule.Helper.variableDelayChange(0.3, player.personalTimer)
				if checkTime then
					player.attacking = false
					player.charging = false
				end
			end

			--Update Images and Hitboxes
			if player.state == "crouch" or player.state == "jump" then
				if player.facingDirection == "right" then
					player.currentImg = player.playerImages.playerRight.LowStab

					if not player.grounded then
						player.currentImg = player.playerImages.playerRight.StabDown
					end
				elseif player.facingDirection == "left" then
					player.currentImg = player.playerImages.playerLeft.LowStab

					if not player.grounded then
						player.currentImg = player.playerImages.playerLeft.StabDown
					end
				end
			elseif player.state == "walk" or player.state == "idle" then
				changeAttackAnim(player.facingDirection)
			end
		end

		--Physics
		--X axis
		player.Position.X = player.Position.X + player.Velocity.X * frame
		if player.grounded then
			player.Velocity.X = player.Velocity.X * (1 - math.sin(dt * player.friction, 1)) 
		end

		--Y axis
		player.Position.Y = player.Position.Y + player.Velocity.Y * dt                
		player.Velocity.Y = player.Velocity.Y - player.gravity * dt 

		if player.Velocity.Y >= gameModule.maxFallVelocity then
			player.Velocity.Y = gameModule.maxFallVelocity
		end

		if player.Position.Y > player.ground then    
			player.Velocity.Y = 0       
	    	player.Position.Y = player.ground    
		end

		if player.Position.Y >= player.ground then
			player.grounded = true
		else
			player.grounded = false                                  
		end

		--Collision Detection
		local t1 = map1Mod.getPlatforms()
		local t2 = map2Mod.getPlatforms()
		local t3 = map3Mod.getPlatforms()
		local t4 = map4Mod.getPlatforms()
		allPlats = {}
		for i = 1, #t1 do
			table.insert(allPlats, t1[i])
		end
		for i = 1, #t2 do
			table.insert(allPlats, t2[i])
		end
		for i = 1, #t3 do
			table.insert(allPlats, t3[i])
		end
		for i = 1, #t4 do
			table.insert(allPlats, t4[i])
		end
		for i = 1, #allPlayers do
			table.insert(allPlats, allPlayers[i].hurtBox)
		end
		for i = 1, #allPlats do

			local v = allPlats[i]

			if v.Type == "Platform" then
				local check = environmentModule.CheckCollision(player.floorHitbox.Position.X, player.floorHitbox.Position.Y, player.floorHitbox.Size.X, player.floorHitbox.Size.Y, v.Position.X, v.Position.Y, v.Size.X, v.Size.Y)
				if player.Velocity.Y >= 0 then
					if check then
						if v.CanCollide then
							player.ground = v.Position.Y
							break
						else
							player.ground = player.baseGround
						end
					else
						player.ground = player.baseGround
					end
				end
			elseif v.Type == "Wall" then
				local check = environmentModule.CheckCollision(player.hurtBox.Position.X, player.hurtBox.Position.Y, player.hurtBox.Size.X, player.hurtBox.Size.Y, v.Position.X, v.Position.Y, v.Size.X, v.Size.Y)
				chek = check
				if check then
					if player.Position.X < v.Position.X then	--Velocity to the left
						player.Position.X = v.Position.X --+ v.Size.X
						player.Velocity.X = 0
						break
					end
					if player.Position.X > (v.Position.X) then
						player.Position.X = v.Position.X
						player.Velocity.X = 0
						break
					end
				end
			end
		end

		--Hitboxes
		player.floorHitbox.Position.X = player.Position.X + 16                       
		player.floorHitbox.Position.Y = player.Position.Y 

		player.hurtBox.Position.X = player.Position.X + 16  
		player.hurtBox.Position.Y = player.Position.Y - 64

		--Gaurding
		if not player.attacking and not player.charging then
			if player.state == "crouch" or player.state == "jump" then
				player.gaurdBox.Position.Y = player.Position.Y - 32
				if player.facingDirection == "left" then
					player.gaurdBox.Position.X = player.Position.X + 16
				elseif player.facingDirection == "right" then
					player.gaurdBox.Position.X = player.Position.X + 42
				end
			elseif player.state == "walk" or player.state == "idle" then
				player.gaurdBox.Position.Y = player.Position.Y - 64
				if player.facingDirection == "left" then
					player.gaurdBox.Position.X = player.Position.X + 16
				elseif player.facingDirection == "right" then
					player.gaurdBox.Position.X = player.Position.X + 42
				end
			end
		else
			player.gaurdBox.Position.X = player.Position.X
			player.gaurdBox.Position.Y = player.Position.Y + 10000 * playerIndex
		end

		--Attacking
		if player.attacking and not player.charging then
			if player.state == "idle" or player.state == "walk" then
				player.attackBox.Position.Y = player.Position.Y - 48
				if player.facingDirection == "right" then
					player.attackBox.Position.X = player.Position.X + 44
				elseif player.facingDirection == "left" then
					player.attackBox.Position.X = player.Position.X
				end
			elseif player.state == "crouch" then
				player.attackBox.Position.Y = player.Position.Y - 28
				if player.facingDirection == "right" then
					player.attackBox.Position.X = player.Position.X + 44
				elseif player.facingDirection == "left" then
					player.attackBox.Position.X = player.Position.X
				end
			elseif player.state == "jump" then
				player.attackBox.Position.Y = player.Position.Y - 4
				player.attackBox.Position.X = player.Position.X + 22
			end
		else
			player.attackBox.Position.X = player.Position.X
			player.attackBox.Position.Y = player.Position.Y + 1000000 * (playerIndex^10)
		end

		--Hitbox Detections
		for i = 1, #allPlayers do
			local enemPly = allPlayers[i]

			local enemGaurdBox = enemPly.gaurdBox
			local enemAttackBox = enemPly.attackBox

			--Detect if the swords clank
			--[[
			if player.attacking and enemPly.attacking then
				local check = environmentModule.CheckCollision(player.attackBox.Position.X, player.attackBox.Position.Y, player.attackBox.Size.X, player.attackBox.Size.Y, enemAttackBox.Position.X, enemAttackBox.Position.Y, enemAttackBox.Size.X, enemAttackBox.Size.Y)
				if enemPly.loaded then
					if check then
						if player.facingDirection == "right" then
							player.Velocity.X = -10
						elseif player.facingDirection == "left" then
							player.Velocity.X = 10
						end
						
					end
				end
			end
			]]
			--Detect the player's sword on opponent's shield
			if player.attacking then
				local check = environmentModule.CheckCollision(player.attackBox.Position.X, player.attackBox.Position.Y, player.attackBox.Size.X, player.attackBox.Size.Y, enemGaurdBox.Position.X, enemGaurdBox.Position.Y, enemGaurdBox.Size.X, enemGaurdBox.Size.Y)
				if enemPly.loaded then
					if check then
						if player.facingDirection == "right" then
							player.Velocity.X = -8
						elseif player.facingDirection == "left" then
							player.Velocity.X = 8
						end
						break
					end
				end
			end

			--Detect the enemy's sword on player's shield
			if enemPly.attacking then
				local check = environmentModule.CheckCollision(player.gaurdBox.Position.X, player.gaurdBox.Position.Y, player.gaurdBox.Size.X, player.gaurdBox.Size.Y, enemAttackBox.Position.X, enemAttackBox.Position.Y, enemAttackBox.Size.X, enemAttackBox.Size.Y)
				if enemPly.loaded then
					if check then
						if player.facingDirection == "right" then
							player.Velocity.X = -8
						elseif player.facingDirection == "left" then
							player.Velocity.X = 8
						end
						break
					end
				end
			end
		end
	end

	function player.unload()
		player.loaded = false
		table.remove(allPlayers, playerIndex)
	end

	function player.load()
		player.loaded = true
		player.Position.X = startX
		player.Position.Y = startY
		player.Velocity.X = 0
		player.Velocity.Y = 0
		table.insert(allPlayers, playerIndex, player)
	end

	function player.display()
		if player.loaded then
			player.floorHitbox.display()
			player.hurtBox.display()
			love.graphics.print(tostring(chek), 100, 100 * playerIndex)
			love.graphics.setColor(255, 0, 0)
			love.graphics.rectangle("fill", player.Position.X, player.Position.Y, 2, 2)
			if player.state == "walk" and not player.attacking and not player.charging then
				if player.facingDirection == "left" then
					player.playerImages.playerLeft.Walk.draw(player.Position.X, player.Position.Y)
				elseif player.facingDirection == "right" then
					player.playerImages.playerRight.Walk.draw(player.Position.X, player.Position.Y)
				end
			else
				love.graphics.setColor(255, 255, 255)
				love.graphics.draw(player.currentImg, player.Position.X, player.Position.Y, 0, 1, 1, 0, 64)
			end

			player.gaurdBox.display()
			player.attackBox.display()

			love.graphics.print(name, player.Position.X, player.Position.Y - 80)
		end
	end

	return player
end

return playerModule	--Returns all these functions and variables to the program it is being required