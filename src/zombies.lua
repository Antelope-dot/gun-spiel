Zombies = class('zombie')

-- Zombie position either left or right of screen
local zombPos = {
    0,
    -- TODO:This should be window width but for somereason calling variable dosnt work
    920
}

function Zombies:initialize()
    self.zombies = {}
end

function Zombies:update(dt)
    for i, zombie in ipairs(self.zombies) do
        zombie:update(dt)
    end
end

function Zombies:render()
    for i, zombie in ipairs(self.zombies) do
        zombie:render()
    end
end

function Zombies:addZombie(zombie)
    table.insert(self.zombies, zombie)
end

function Zombies:spawnZombie()
    -- Fill this
    zomX = zombPos[math.random(2)]
    if zomX == 0 then
        zomAngle = 1
    else
        zomAngle = -1
    end
    print(zomAngle)
    zomb = Zombie:new(zomX, windowHeight/2, zomAngle)
    table.insert(self.zombies, zomb)
end