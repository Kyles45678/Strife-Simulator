
local plyModuleName = {}			--The local name of the module (to be used in here only!)
playerModule = plyModuleName	--The actual name of the module

local animModule = require("LuaLib.animationModule")
local helpModule = require("LuaLib.helperModule")

plyModuleName.Player = {}

function plyModuleName.Player:new(name)	
	local player = {}

	--Constants
	player.Name = name
	player.CanCollide = "true"

	--Variables
	player.Position = {
		X = love.graphics.getWidth() / 2;
		Y = love.graphics.getHeight() * (3/4);
	}

	player.Velocity = {
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
	player.jumpHeight = -300   
	player.gravity = -500       

	player.state = "idle"
	player.facingDirection = "left"
	player.attacking = false
	player.charging = false
	player.sprinting = false

	function player.update(dt)

		--Inputs
		if love.keyboard.isDown('e') and not player.attacking and not player.charging then
			player.charging = true
		end

		if player.attacking or player.charging then
			local checkTime = helpModule.Helper.variableDelayChange(0.2)
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
		end

		if not love.keyboard.isDown('s') and not love.keyboard.isDown('w') then
			if love.keyboard.isDown('d') then
				player.facingDirection = "right"
				if not player.attacking or not player.charging then
					player.state = "walk"
					player.Velocity.X = player.Velocity.X + player.walkSpeed * dt
				else
					player.state = "idle"
				end
			elseif love.keyboard.isDown('a') then
				player.facingDirection = "left"
				if not player.attacking or not player.charging then
					player.state = "walk"
					player.Velocity.X = player.Velocity.X - player.walkSpeed * dt
				else
					player.state = "idle"
				end
			elseif not love.keyboard.isDown('a') and not love.keyboard.isDown('d') then
				player.state = "idle"
			end
		elseif love.keyboard.isDown('s') and not love.keyboard.isDown('w') then
			player.state = "crouch"
		elseif not love.keyboard.isDown('s') and love.keyboard.isDown('w') then
			if player.Velocity.Y == 0 then
				player.Velocity.Y = player.jumpHeight
			end
		end

		if player.facingDirection == "right" then
			if player.state == "crouch" then
				if not player.attacking then
					player.currentImg = player.playerImages.playerRight.Low
				else
					player.currentImg = player.playerImages.playerRight.LowStab
				end
			else
				if player.charging then
					player.currentImg = player.playerImages.playerRight.Charge
				elseif player.attacking then
					player.currentImg = player.playerImages.playerRight.Stab
				else
					player.currentImg = player.playerImages.playerRight.Idle
				end
			end
		elseif player.facingDirection == "left" then
			if player.state == "crouch" then
				if not player.attacking then
					player.currentImg = player.playerImages.playerLeft.Low
				else
					player.currentImg = player.playerImages.playerLeft.LowStab
				end
			else
				if player.charging then
					player.currentImg = player.playerImages.playerLeft.Charge
				elseif player.attacking then
					player.currentImg = player.playerImages.playerLeft.Stab
				else
					player.currentImg = player.playerImages.playerLeft.Idle
				end
			end
		end

		--Physics

		local dt1 = math.min(dt, 0.07)

		frame = dt1 * 30
		player.Position.X = player.Position.X + player.Velocity.X * frame
		player.Velocity.X = player.Velocity.X * (1 - math.sin(dt * player.friction, 1))

		if player.Position.X >= (love.graphics.getWidth() - player.currentImg:getWidth()) then
			player.Position.X = love.graphics.getWidth() - player.currentImg:getWidth()
			player.Velocity.X = 0
		elseif player.Position.X <= 0 then 
			player.Position.X = 0
			player.Velocity.X = 0
		end 

		if player.Velocity.Y ~= 0 then                                   
			player.Position.Y = player.Position.Y + player.Velocity.Y * dt                
			player.Velocity.Y = player.Velocity.Y - player.gravity * dt 
		end
        if player.Position.Y > player.ground then    
			player.Velocity.Y = 0       
	    	player.Position.Y = player.ground    
		end

		--Anims

		if player.state == "walk" then
			if player.facingDirection == "left" then
				player.currentImg = player.playerImages.playerLeft.Idle
				player.playerImages.playerLeft.Walk.update(dt)
			elseif player.facingDirection == "right" then
				player.currentImg = player.playerImages.playerRight.Idle
				player.playerImages.playerRight.Walk.update(dt)
			end
		end
	end

	function player.display()
		love.graphics.setColor(255, 0, 0)
		love.graphics.rectangle("fill", player.Position.X, player.Position.Y, 2, 2)

		if player.state == "walk" then
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