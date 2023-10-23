Zombie = class('zombie')

--Temp ghost image
local ghostImage = love.graphics.newImage("assets/sprites/ghost.png")

function Zombie:initialize(x,y,angle)
    self.x = x
    self.y = y
    -- flip image if zombie is coming from right
    self.angle = angle
    self.width = 64
    self.height = 64
    self.hp = 2
end

function Zombie:update(dt)
    if player.x > self.x then
        self.x = self.x + 100 * dt
    else
        self.x = self.x - 100 * dt
    end
end

function Zombie:render()
    -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.draw(ghostImage, self.x, self.y, 0, self.angle, 1)
end