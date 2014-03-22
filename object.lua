local Class = require "hump.class"

local Object = Class {
    IMAGE = love.graphics.newImage("images/banana.png"),
}

function Object:init(map, x, y, z, a)
    self.map = map
    self.x, self.y, self.z, self.a = x, y, z, a or 0
end

function Object:update(dt)
    self.a = self.a + math.pi * 2 * 0.1 * dt
end

function Object:draw()
    local x, y, scale, visible = self.map:transform(self.x, self.y, self.z)

    if visible then
        love.graphics.setBlendMode("alpha")
        love.graphics.setColor(255, 255, 0)
        love.graphics.draw(self.IMAGE, x, y, self.a, scale, scale, 32, 32)
    end
end

return Object
