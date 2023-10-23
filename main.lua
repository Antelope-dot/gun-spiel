--OOP
class = require 'libs/middleclass'

--animation
anim8 = require 'libs/anim8'

require 'src/collider'
require 'src/shader'

require 'src/player'
require 'src/bullets'
require 'src/bullet'

require 'src/zombie_spawner'
require 'src/zombies'
require 'src/zombie'


windowHeight, windowWidth = 560, 920
background = love.graphics.newImage("assets/background.png")

function love.load()
    --Screen settings
    love.window.setMode(windowWidth, windowHeight, {
        resizable = false
    })

    shader = Shader:new()
    shader.background:send("windowHeight", windowHeight)

    ---Makes random number random NOT USED...yet
    math.randomseed(os.time())
    --make the art look less blurry
    love.graphics.setDefaultFilter('nearest', 'nearest')

    player = Player:new(windowWidth/2,windowHeight/2)
    bullets = Bullets:new()
    zombies = Zombies:new()
    zombieSpawner = ZombieSpawner:new()
end

function love.update(dt)
    if player.dead == false then
        player:update(dt)
        bullets:update(dt)
        zombies:update(dt)
        zombieSpawner:update(dt)
        --handles collisions
        handleCollisions(dt)
    end
end

function love.draw()

    love.graphics.setShader(shader.background)
    love.graphics.draw(background,0,0)
    love.graphics.setShader()

    if player.dead == false then
        player:render()
        bullets:render()
        zombies:render()
        love.graphics.print("Zombies Spawned: " .. zombieSpawner.zombiesSpawned,windowWidth/2 - 50, windowHeight- 50)
    else
        love.graphics.print("You have died and managed to survive " .. zombieSpawner.zombiesSpawned .." ghosts",windowWidth/2  - 175, 100,0,1.4,1.4)
    end

end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
       love.event.quit()
    elseif key == "space" then
        player:handleJump()
    end
end