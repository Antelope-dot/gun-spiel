local knockback = 1000 

--Collision detection
--x1,y1 top left coords, w1,h1 width and height 
--flipped can be either 1 or -1, basically checks if zombie comes from left or right
function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2,flipped)
    if flipped == -1 then
        x2 = x2 - 64
    end
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end

-- Handles collisions for player, bullets and zombies
function handleCollisions(dt)
    -- Check if bullet collides with zombie
    for i,bullet in ipairs(bullets.bullets) do
        for j,zombie in ipairs(zombies.zombies) do
            if checkCollision(bullet.x,bullet.y,bullet.width,bullet.height, zombie.x,zombie.y,zombie.width,zombie.height,zombie.angle) then
                print("zombie hit")
                zombie.hp = zombie.hp - 1
                if zombie.angle == -1 then
                    zombie.x = zombie.x + knockback * dt
                else
                    zombie.x = zombie.x - knockback * dt
                end
                table.remove(bullets.bullets,i)
                if zombie.hp == 0 then
                    table.remove(zombies.zombies, j)
                end
            end
        end
    end

    --check if zombie collides with player
    for z,zombie in ipairs(zombies.zombies) do
        if checkCollision(player.x,player.y,player.width,player.height, zombie.x,zombie.y,zombie.width,zombie.height,zombie.angle) then
            print("dead")
            player.dead=true
        end
    end
end