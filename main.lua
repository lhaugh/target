local Camera = require "hump.camera"

local Map = require "map"
local Object = require "object"
local Player = require "player"

function love.load()
    SCREEN = love.graphics.newCanvas(512, 512)
    CAMERA = Camera(0, 0, 1, 0, 512, 512)

    MAP = Map()
    PLAYER = Player(MAP, 0, 0, 512)

    MAP:add(PLAYER)

    for x=-3,3 do
        for y=-3,3 do
            MAP:add(Object(MAP, x * 128, y * 128, 256))
        end
    end
end

function love.update(dt)
    MAP:update(dt)
end

function love.draw()
    CAMERA.x, CAMERA.y, CAMERA.z = PLAYER.x, PLAYER.y, PLAYER.z + 64
    CAMERA.rot = PLAYER.a
    --CAMERA:lookAt(
    --    PLAYER.x,
    --    PLAYER.y)
    --CAMERA.scale = 1 / MAP:depth_scale(PLAYER.z + 1)

    SCREEN:clear(0, 0, 0)
    SCREEN:renderTo(function()
        CAMERA:attach()

        love.graphics.push()
        --love.graphics.translate(256 - CAMERA.x, 256 - CAMERA.y)
        --love.graphics.rotate(CAMERA.a)

        MAP:draw()

        love.graphics.pop()

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
