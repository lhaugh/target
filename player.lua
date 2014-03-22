local Class = require "hump.class"

local Player = Class {}

function Player:init(map, x, y, z)
    self.map = map
    self.x, self.y, self.z = x, y, z
    self.a = 0

    self.momentumX = 0
    self.momentumY = 0
    self.momentumZ = 0

    self.controllerSpeed = 100
    self.state = 0
    self.momentumX = 0
    self.momentumY = 0
    self.momentumZ = 0
    self.forwardAngle = 0
    self.speed = 0
    self.aButtonLast = false
     
    local joysticks = love.joystick.getJoysticks()
    self.joystick = joysticks[1]
    
    print("init")
end

function Player:update(dt)
    --self.y = self.y + 32 * dt
    self.z = math.max(self.z - 32 * dt, 0)

    --self.a = self.a + math.pi * 2 * dt * 0.05

	--self.momentumX = axisX * dt * self.speed
	--self.momentumY = axisY * dt * self.speed
	
	if self.joystick then
        local axisX = self.joystick:getAxis(1)
        local axisY = self.joystick:getAxis(2)
        local aButton = self.joystick:isDown(11)

    	if(self.state == 0) then --top of slope
    		
    		self.momentumX = axisX * dt * self.controllerSpeed
    		self.momentumY = axisY * dt * self.controllerSpeed
    		--allow partial movement in air?
    		
    		if (self.y < -100) then
    			print("entered slope")
    			self.state = 1
    		end
    		--state = 1
    	elseif (self.state == 1) then --slope
    		self.momentumY = self.momentumY - 1 --slope in and out
    		
    		if (self.y < -500) then
    			print("entered flick")
    			
    			self.state = 2
    		end
    	elseif (self.state == 2) then --flick
    		self.momentumZ = self.momentumZ + (20 * dt)
    		
    		if (self.y < -600) then
    			print("lanuched")
    			self.state = 3
    		end
    	elseif (self.state == 3) then --launched
    		self.momentumZ = self.momentumZ - (3 * dt)
    		
    		--[[for i = 1,20 do
    			if(self.joystick:isDown(i)) then
    				print(i .. " is down")
    			end
    		end]]
    		
    		if(self.z < 0) then
    			print("fall out")
    			self.state = 99
    		end
    		
    		if(aButton) then
    			self.state = 4
    			self.speed = Abs(self.momentumX) + Abs(self.momentumY) + Abs(self.momentumZ)
    			print("opened, " .. self.speed)
    		end
    	elseif (self.state == 4) then --glide
    		
    		self.momentumZ = self.momentumZ - (0.5 * dt)
    		
    		
    		
    		if(aButton and not self.aButtonLast) then
    			print("closed")
    			self.state = 5
    		end
    		
    	elseif (self.state == 5) then --drop
    		self.momentumZ = self.momentumZ - (3 * dt)
    		
    		
    	end
	end


	self.momentumX = self.momentumX * 0.99
	self.momentumY = self.momentumY * 0.99
	
	self.x = self.x + self.momentumX
	self.y = self.y + self.momentumY
	self.z = self.z + self.momentumZ
	
	self.aButtonLast = aButton
	
	--print("state: " .. self.state .. ", position: " .. self.x  .. " " .. self.y .. " " .. self.z )
end

function Abs(number)
	if(number > 0) then
		return number
	else
		return -number
	end
end

function Player:draw()
    local x, y, scale = self.map:transform(self.x, self.y, self.z)

    love.graphics.setBlendMode("alpha")
    love.graphics.setColor(255, 255, 0)
    love.graphics.circle("fill", x, y, 32 * scale, 32)
end

return Player
