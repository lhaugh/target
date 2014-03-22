local Class = require "hump.class"

local Player = Class {}

function Player:init(x, y, z)
    self.x, self.y, self.z = x, y, z
end

function Player:update(dt)
    self.x = self.x + 10 * dt
    self.z = self.z + 10 * dt
end

function Player:draw()
    love.graphics.setBlendMode("alpha")
    love.graphics.setColor(0, 255, 0)
    love.graphics.circle("fill", self.x, self.y, 32, 32)
end

return Player
