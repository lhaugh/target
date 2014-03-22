local Class = require "hump.class"

local Player = Class {}

function Player:init(map, x, y, z)
    self.map = map
    self.x, self.y, self.z = x, y, z
    self.a = 0
end

function Player:update(dt)
    self.y = self.y + 32 * dt
    self.z = math.max(self.z - 32 * dt, 0)

    --self.a = self.a + math.pi * 2 * dt * 0.05
end

function Player:draw()
    local x, y, scale = self.map:transform(self.x, self.y, self.z)

    love.graphics.setBlendMode("alpha")
    love.graphics.setColor(255, 255, 0)
    love.graphics.circle("fill", x, y, 32 * scale, 32)
end

return Player
