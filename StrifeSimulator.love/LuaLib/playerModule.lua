
local plyModuleName = {}			--The local name of the module (to be used in here only!)
playerModule = plyModuleName	--The actual name of the module

local animModule = require("LuaLib.animationModule")
local helpModule = require("LuaLib.helperModule")
local environmentModule = require("LuaLib.environmentModule")
local map1Mod = require('Maps.map1')
local map2Mod = require('Maps.map2')
local gameModule = require('LuaLib.gameModule')

plyModuleName.Player = {}

function plyModuleName.Player:new(name, upKey, downKey, leftKey, rightKey, attackKey, startX, startY, playerIndex)	
	local player = {}

	--Constants
	player.Name = name
	player.CanCollide = true

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

	player.attackBox = environmentModule.FlatPlatform:new("Part", "line")
	player.attackBox.Size.X = 20  
	player.attackBox.Size.Y = 14  
	player.attackBox.Position.X = 0                             
	player.attackBox.Position.Y = 0

	player.gaurdBox = environmentModule.FlatPlatform:new("Part", "line")
	player.gaurdBox.Size.X = 3  
	player.gaurdBox.Size.Y = 14 
	player.gaurdBox.Position.X = 0                             
	player.gaurdBox.Position.Y = 0

	--Variables
	player.Position = {
		X = startX;
		Y = startY;
		-- X = love.graphics.getWidth() / 2;
		-- Y = love.graphics.getHeight() * (3/4);
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
	player.sprinting = false
	player.grounded = true

	local allPlats = nil

	function player.update(dt)

		local dt1 = math.min(dt, 0.07)
		local frame = dt1 * 30

		if not player.attacking and not player.charging then
			if player.grounded then
				if love.keyboard.isDown(attackKey) then
					if player.state ~= "crouch" then
						player.attacking = false
						player.charging = true
					else
						player.attacking = true
						player.charging = false
					end
				elseif love.keyboard.isDown(upKey) then
					player.state = "jump"
					player.Velocity.Y = player.jumpHeight
				elseif love.keyboard.isDown(downKey) then
					player.state = "crouch"

				elseif love.keyboard.isDown(rightKey) then
					player.state = "walk"
					player.facingDirection = "right"
					player.Velocity.X = player.Velocity.X + player.walkSpeed * dt
				elseif love.keyboard.isDown(leftKey) then
					player.state = "walk"
					player.facingDirection = "left"
					player.Velocity.X = player.Velocity.X - player.walkSpeed * dt
				else
					player.state = "idle"
				end
			else
				if love.keyboard.isDown(attackKey) then
					player.attacking = true
					player.charging = false

				elseif love.keyboard.isDown(downKey) then
					player.attacking = true
					player.charging = false
					player.facingDirection = "down"

				end
			end
		end

		if player.attacking or player.charging then
			if player.grounded then
				if player.state ~= "crouch" then 
					local checkTime 
					if playerIndex == 1 then
						checkTime = helpModule.Helper.variableDelayChange(0.2)
					else
						checkTime = helpModule.Helper.variableDelayChange1(0.2)
					end
					if player.charging then
						if checkTime then
							player.attacking = true
							player.charging = false
						end
					elseif player.attacking then
						if checkTime then
							player.attacking = false
							player.charging = false
						end
					end
				else
					local checkTime 
					if playerIndex == 1 then
						checkTime = helpModule.Helper.variableDelayChange(0.2)
					else
						checkTime = helpModule.Helper.variableDelayChange1(0.2)
					end
					if player.attacking or player.charging then
						if checkTime then
							player.attacking = false
							player.charging = false
						end
					end
				end
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

		if player.Velocity.Y == 0 then
			player.grounded = true
		elseif player.Velocity.Y ~= 0 then 
			player.grounded = false                                  
			
		end

		--Collision Detection
		local t1 = map1Mod.getPlatforms()
		local t2 = map2Mod.getPlatforms()
		allPlats = {}

		for i = 1, #t1 do
			table.insert(allPlats, t1[i])
		end
		for i = 1, #t2 do
			table.insert(allPlats, t2[i])
		end

		for i = 1, #allPlats do
			local v = allPlats[i]

			local check = environmentModule.CheckCollision(player.floorHitbox.Position.X, player.floorHitbox.Position.Y, player.floorHitbox.Size.X, player.floorHitbox.Size.Y, v.Position.X, v.Position.Y, v.Size.X, v.Size.Y)
			
			if v.CanCollide then
				if player.Velocity.Y >= 0 then
					if check then
						player.ground = v.Position.Y
						break
					else
						player.ground = player.baseGround
					end
				end
			end
		end

		--Hitboxes
		player.floorHitbox.Position.X = player.Position.X + 16                       
		player.floorHitbox.Position.Y = player.Position.Y 

		player.hurtBox.Position.X = player.Position.X + 16  
		player.hurtBox.Position.Y = player.Position.Y - 64

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

		if player.state == "crouch" or player.state == "jump" then
			if player.facingDirection == "right" then
				player.currentImg = player.playerImages.playerRight.Low

				if player.grounded then
					if player.attacking then
						player.currentImg = player.playerImages.playerRight.LowStab
					end
				else
					if player.attacking then
						player.currentImg = player.playerImages.playerRight.StabDown
					end
				end
				
			elseif player.facingDirection == "left" then
				player.currentImg = player.playerImages.playerLeft.Low
				
				if player.grounded then
					if player.attacking then
						player.currentImg = player.playerImages.playerLeft.LowStab
					end
				else
					if player.attacking then
						player.currentImg = player.playerImages.playerLeft.StabDown
					end
				end
			end
		elseif player.state == "walk" then
			if player.facingDirection == "right" then
				if not player.attacking then
					player.currentImg = player.playerImages.playerRight.Idle
					player.playerImages.playerRight.Walk.update(dt)
				end

				changeAttackAnim(player.facingDirection)
			elseif player.facingDirection == "left" then
				if not player.attacking then
					player.currentImg = player.playerImages.playerLeft.Idle
					player.playerImages.playerLeft.Walk.update(dt)
				end

				changeAttackAnim(player.facingDirection)
			end
		elseif player.state == "idle" then
			if player.facingDirection == "right" then
				player.currentImg = player.playerImages.playerRight.Idle
				changeAttackAnim(player.facingDirection)
			elseif player.facingDirection == "left" then
				player.currentImg = player.playerImages.playerLeft.Idle
				changeAttackAnim(player.facingDirection)
			end
		end
		
	end

	function player.display()
		player.floorHitbox.display()
		player.hurtBox.display()
		player.attackBox.display()
		player.gaurdBox.display()

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
	end

	return player
end

return playerModule	--Returns all these functions and variables to the program it is being required