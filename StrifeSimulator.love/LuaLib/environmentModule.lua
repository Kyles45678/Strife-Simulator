---------------------------------------------------------------------ENVIRONMENT MODULE-----------------------------------------------------
--This module will create platforms and parts for maps.

local envirModuleName = {}			--The local name of the module (to be used in here only!)
environmentModule = envirModuleName	--The actual name of the module
envirModuleName.FlatPlatform = {}
envirModuleName.Particle = {}

local particleList = {}

function envirModuleName.CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function envirModuleName.FlatPlatform:new(name, fill, redCol, greenCol, blueCol)	
	local object = {}

	object.Name = name
	object.Fill = fill
	object.CanCollide = true
	object.ZIndex = 1
	object.Visibile = false
	object.Type = "Platform"

	object.Position = {
		X = 0;
		Y = 0;
	}

	object.Size = {
		X = 50;
		Y = 50;
	}

	object.Color = {
		Red = redCol or 255;
		Green = greenCol or 255;
		Blue = blueCol or 255;
	}

	function object.display()
		love.graphics.setColor(object.Color.Red, object.Color.Green, object.Color.Blue)
		love.graphics.rectangle(object.Fill, object.Position.X, object.Position.Y, object.Size.X, object.Size.Y)
		object.Visibile = true
	end

	return object
end

function envirModuleName.Particle:new(name, fill, redCol, greenCol, blueCol, origin, lifetime, gravity, xVelo, yVelo, xSize, ySize)
	yVelo = -math.abs(yVelo)

	local object = {}
	object.Name = name
	object.Fill = fill
	object.ZIndex = 1
	object.Type = "Particle"

	object.Lifetime = 0
	object.LifetimeLimit = Lifetime 	--Put in frames

	object.Position = {
		X = origin[1] or 0;
		Y = origin[2] or 0;
	}

	object.Size = {
		X = xSize or 2;
		Y = ySize or 2;
	}

	object.Color = {
		Red = redCol or 255;
		Green = greenCol or 255;
		Blue = blueCol or 255;
	}

	player.Velocity.Y = yVelo

	function object.update(dt)
		local dt1 = math.min(dt, 0.07)
		local frame = dt1 * 30

		--X axis
		object.Velocity.X = object.Velocity.X + xVelo * dt1
		object.Position.X = object.Position.X + object.Velocity.X * frame

		--Y axis
		object.Position.Y = object.Position.Y + object.Velocity.Y * dt1                
		object.Velocity.Y = object.Velocity.Y - gravity * dt1 
	end

	function object.display()
		love.graphics.setColor(object.Color.Red, object.Color.Green, object.Color.Blue)
		love.graphics.rectangle(object.Fill, object.Position.X, object.Position.Y, object.Size.X, object.Size.Y)
	end

	table.insert(particleList, object)

	return object
end

function createPoof(amount, name, fill, redCol, greenCol, blueCol, origin, lifetime, gravity, xVeloRange, yVeloRange, xSizeRange, ySizeRange)

	for i = 1, amount do
		if xVeloRange and yVeloRange and xSizeRange and ySizeRange then
			envirModuleName.Particle:new(name, fill, redCol, greenCol, blueCol, origin, lifetime, gravity, math.random(), math.random(), math.random(), math.random())
		end
	end
end

function envirModuleName.update(dt)
	for i = 1, #particleList do
		local particlePart = particleList[i]
		particlePart.Lifetime = particlePart.Lifetime + 1

		if particlePart.Lifetime >= particlePart.LifetimeLimit then
			table.remove(particleList, i)
		else
			particlePart.update(dt)
		end
	end
end

function envirModuleName.display()
	for i = 1, #particleList do
		local particlePart = particleList[i]
		particlePart.display()
	end
end

return environmentModule	--Returns all these functions and variables to the program it is being required
-------------------------------------------------------------------------------------------------------------------------------------