--Handles zombie spawning 
ZombieSpawner = class('ZombieSpawner')

function ZombieSpawner:initialize()
    self.spawnTimer = 2
    self.zombiesSpawned = 0
end

function ZombieSpawner:update(dt)
    self.spawnTimer = self.spawnTimer - dt

    if self.spawnTimer <= 0 then
        zombies:spawnZombie()
        self.zombiesSpawned = self.zombiesSpawned + 1
        if self.zombiesSpawned < 10 then
            self.spawnTimer = 2
        else
            self.spawnTimer = 0.5
        end
    end
end