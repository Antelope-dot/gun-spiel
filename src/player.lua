require 'src/bullet'

Player = class('Player')
local playerGunImage = love.graphics.newImage("assets/sprites/guns_gameassets/PNG/pistol.png")

local gravity = 150
local velocityY = -100
local gunRotation = 0
local playSpriteSheet = love.graphics.newImage("assets/sprites/slime_jiggle.png")
local g = anim8.newGrid(64,64, playSpriteSheet:getWidth(), playSpriteSheet:getHeight())

function Player:initialize(x,y)
    self.x = x
    self.y = y
    self.width = 64
    self.height = 64
    self.gun = playerGunImage
    self.jumpFlag = true
    self.doubleJump = 1
    -- animations go here
    self.animations = {}
    self.animations.walkLeft = anim8.newAnimation(g('1-8',1), 0.1)
    self.animations.walkRight = anim8.newAnimation(g('1-8',2), 0.1)
    self.animations.still = anim8.newAnimation(g('1-8',3), 0.1)
    -- what animation is currently selected
    self.anim = self.animations.still

    -- So player cant rabid fire
    self.shotTimer = 1
    self.canShoot = true

    -- Check if player dead
    self.dead = false


end

function Player:update(dt)

    self.anim:update(dt)

    --basic falling physics
    if self.y < windowHeight / 2 then
        self.y = self.y + gravity * dt
    else 
        self.jumpFlag = true
        self.doubleJump = 1
    end

    -- Put keyboard presses here
    if love.keyboard.isDown("a") then
        self.x = self.x - 1
        self.anim = self.animations.walkLeft
    elseif love.keyboard.isDown("d") then
        self.x = self.x + 1
        self.anim = self.animations.walkRight
    else
        self.anim = self.animations.still
    end

    self.shotTimer = self.shotTimer - dt

    if self.shotTimer <= 0 then
        self.canShoot = true
        self.shotTimer = 1
    end
end

function Player:render()
    -- love.graphics.rectangle("fill", self.x, self.y, 50, 50)
    self.anim:draw(playSpriteSheet, self.x, self.y)
    love.graphics.draw(self.gun, self.x+25, self.y+25, gunRotation, 0.4)
end

function Player:calculateAngleForGun(x, y)
    gunRotation = math.atan2(y - (self.y + 25), x - (self.x + 25))
end

function Player:handleJump()
    if self.jumpFlag then
        self.y = self.y + velocityY --* dt
        print(self.doubleJump)
        if self.doubleJump == 0 then
            self.jumpFlag = false
        else 
            self.doubleJump = self.doubleJump - 1
        end
    end
end

function love.mousepressed(x, y, button, istouch)
    if player.canShoot then
        player:calculateAngleForGun(x,y)
        local shot = Bullet:new(player.x + 25, player.y + 25, gunRotation)
        bullets:addBullet(shot)
        player.canShoot = false
    end
end