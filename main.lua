local Camera = require "hump.camera"

local Map = require "map"
local Player = require "player"

function love.load()
    SCREEN = love.graphics.newCanvas(512, 512)
    CAMERA = Camera(0, 0, 1, 0, 512, 512)

    MAP = Map()
    PLAYER = Player(0, 0, 0)

    MAP:add(PLAYER)
end

function love.update(dt)
    MAP:update(dt)
end

function love.draw()
    CAMERA:lookAt(PLAYER.x, PLAYER.y)

    SCREEN:clear(0, 0, 0)
    SCREEN:renderTo(function()
        CAMERA:attach()

        MAP:draw()

        CAMERA:detach()
    end)

    -- choose game scale based on window size
    local width, height = love.graphics.getDimensions()
    local scale = 1

    while (scale + 1) * 512 <= math.min(width, height) do
        scale = scale + 1
    end

    -- draw game in center in screen
    love.graphics.push()
    love.graphics.scale(scale)
    love.graphics.setBlendMode("premultiplied")
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(SCREEN, width * 0.5 / scale, height * 0.5 / scale, 0, 1, 1, 256, 256)
    love.graphics.pop()
end
