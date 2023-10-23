Bullet = class('Bullet')

local bulletImage = love.graphics.newImage("assets/sprites/guns_gameassets/PNG/small_bullet_rotated.png")

function Bullet:initialize(x,y,angle)
    self.y = y + math.sin(angle) * 30 --calculates so that bullets leaves from end of barrel
    self.x = x + math.cos(angle) * 30 --calculates so that bullets leaves from end of barrel
    self.height = 13
    self.width = 13
    self.angle = angle
    self.image = bulletImage
end

function Bullet:update(dt)
    self.x = self.x + 10 * dt * math.cos(self.angle) * 23
    self.y = self.y + 10 * dt * math.sin(self.angle) * 23
end

function Bullet:render()
    love.graphics.draw(self.image, self.x, self.y, self.angle, .2)
end

function Bullet:debug()
   print("bullet info: x: " .. self.x .. " y: " .. self.y) 
end