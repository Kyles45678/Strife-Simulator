
local envirModuleName = {}			--The local name of the module (to be used in here only!)
environmentModule = envirModuleName	--The actual name of the module

envirModuleName.FlatPlatform = {}

function envirModuleName.CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function envirModuleName.FlatPlatform:new(name, fill)	
	local object = {}

	object.Name = name
	object.Fill = fill
	object.CanCollide = true
	object.ZIndex = 1

	object.Position = {
		X = 0;
		Y = 0;
	}

	object.Size = {
		X = 50;
		Y = 50;
	}

	object.Color = {
		Red = 255;
		Green = 255;
		Blue = 255;
	}

	function object.display()
		love.graphics.setColor(object.Color.Red, object.Color.Green, object.Color.Blue)
		love.graphics.rectangle(object.Fill, object.Position.X, object.Position.Y, object.Size.X, object.Size.Y)
	end

	return object
end

return environmentModule	--Returns all these functions and variables to the program it is being required