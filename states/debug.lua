module(..., package.seeall)

EnemyManager = require('actors/enemymanager')

actors = {}

actors[#actors+1] = player
bump.add(player)

enemymanager = EnemyManager:new(player)
actors[#actors+1] = enemymanager

g.setBackgroundColor(15, 15, 15)

function love.update(dt)
    for _, actor in pairs(actors) do
        actor:update(dt)
    end
    bump.collide()
end

function love.draw()
    for _, actor in pairs(actors) do
        actor:draw()
    end

    g.setColor(240, 240, 240)
    g.print('FPS: '..tostring(love.timer.getFPS()..
        '\nDebug: '..global.debugString), 0, 0)
end

function love.keypressed(key)
    if key == 'escape' then love.event.push('quit') end
    if key == 'r' then global:setGameState('debug') end
    if key == ' ' then
        enemymanager:spawn()
    end
end

function love.keyreleased(key)

end

function bump.collision(objectA, objectB, dx, dy)
    -- print(item1.name, "collision with", item2.name, "displacement vector:", dx, dy)
    objectA:collision(objectB,  dx,  dy)
    objectB:collision(objectA, -dx, -dy)
end

function bump.endCollision(objectA, objectB)
    -- print(item1.name, "stopped colliding with", item2.name)
    objectA:endCollision(objectB)
    objectB:endCollision(objectA)
end

-- function bump.getBBox(item)
--   return item.l, item.t, item.w, item.h
-- end

-- function bump.shouldCollide(item1, item2)
--   return true -- we could add certain conditions here - for example, make objects of the same group not collide
-- end