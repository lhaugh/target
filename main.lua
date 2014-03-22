local Camera = require "hump.camera"

function love.load()
    SCREEN = love.graphics.newCanvas(512, 512)
    CAMERA = Camera(0, 0, 1, 0, 512, 512)
end

function love.update(dt)
end

function love.draw()
    SCREEN:clear(255, 0, 255)
    SCREEN:renderTo(function()
        CAMERA:attach()

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
    love.graphics.draw(SCREEN, width * 0.5 / scale, height * 0.5 / scale, 0, 1, 1, 256, 256)
    love.graphics.pop()
end
