
local animModuleName = {}			--The local name of the module (to be used in here only!)
animationModule = animModuleName

animModuleName.Animation = {}

function animModuleName.Animation:new(image, width, height, duration)
    local animation = {}
    animation.spriteSheet = image;
    animation.quads = {};
 
    for y = 0, image:getHeight() - height, height do
        for x = 0, image:getWidth() - width, width do
            table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
        end
    end
 
    animation.duration = duration or 1
    animation.currentTime = 0

    function animation.update(dt)
    	animation.currentTime = animation.currentTime + dt
	    if animation.currentTime >= animation.duration then
	        animation.currentTime = animation.currentTime - animation.duration
	    end
    end

    function animation.draw(posX, posY)
    	local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
    	love.graphics.setColor(255, 255, 255)
   		love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], posX, posY, 0, 1, 1, 0, 64)
   		 --texture, quad, x, y, r, sx, sy, ox, oy, kx, ky 
    end
 
    return animation
end




return animationModule