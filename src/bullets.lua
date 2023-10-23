Bullets = class('Bullets')

function Bullets:initialize()
    self.bullets = {}
end

function Bullets:update(dt)
    for i, bullet in ipairs(self.bullets) do
        bullet:update(dt)
        --check if bullet is out of bounds
        if bullet.x > windowWidth or bullet.x < 0 or bullet.y > windowHeight or bullet.y < 0 then
            print("bullet destroyed!")
            table.remove(self.bullets, i)
        end
    end
end

function Bullets:render()
    for i, bullet in ipairs(self.bullets) do
        bullet:render()
    end
end

function Bullets:addBullet(bullet)
    table.insert(self.bullets, bullet)
end