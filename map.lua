local Class = require "hump.class"

local Map = Class {
    WATER_TILE = love.graphics.newImage("images/water-tile.png"),
}

function Map:init()
    self.objects = {}
end

function Map:update(dt)
    for object in pairs(self.objects) do
        object:update(dt)
    end
end

function Map:draw()
    love.graphics.setBlendMode("alpha")
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(self.WATER_TILE, -256, -256, 0, 1, 1)

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

return Map
