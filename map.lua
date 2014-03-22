local Class = require "hump.class"

local Map = Class {
    WATER_TILE = love.graphics.newImage("images/water-tile.png"),
    VIEWING_ANGLE = math.pi / 4,
}

Map.WATER_TILE:setFilter("nearest", "nearest")

function Map:init()
    self.objects = {}
end

function Map:update(dt)
    for object in pairs(self.objects) do
        object:update(dt)
    end
end

function Map:draw()
    for y=-1,1 do 
        for x=-1,1 do
            local x, y, scale = self:transform(x * 512, y * 512, 0)

            love.graphics.setBlendMode("alpha")
            love.graphics.setColor(255, 255, 255, 255)
            love.graphics.draw(self.WATER_TILE, x, y, 0, scale, scale, 256, 256)
        end
    end

    for object in pairs(self.objects) do
        object:draw()
    end
end

function Map:add(object)
    self.objects[object] = object
end

function Map:remove(object)
    self.objects[object] = nil
end

function Map:transform(x, y, z)
    local dx, dy, dz = x - CAMERA.x, y - CAMERA.y, z - CAMERA.z
    
    local scale = 1 / (dz * 0.01 * math.tan(self.VIEWING_ANGLE))

    return CAMERA.x + dx * scale, CAMERA.y + dy * scale, scale, dz < 0
end

return Map
