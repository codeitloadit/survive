module(..., package.seeall)
Class = require('lib/30log')
Enemy = require('actors/enemy')
Wall = require('actors/wall')

EnemyManager = Class()

function EnemyManager:__init()
    self.name = 'EnemyManager'
    self.enemies = {}
    self.walls = {
        Wall:new(SW/2, -50, SW*2, 100),
        Wall:new(SW/2, SH+50, SW*2, 100),
        Wall:new(-50, SH/2, 100, SH*2),
        Wall:new(SW+50, SH/2, 100, SH*2)
    }
    for _, wall in pairs(self.walls) do
        bump.add(wall)
    end

    self.age = 0
end

function EnemyManager:spawn(x, y, w, h, angle, speed)
    -- Sloppy for now...
    x = x or math.random(100, SW-100)
    y = y or math.random(100, SH-100)
    testCoords = {x = x, y = y}
    while util.getDistance(testCoords, player) < 200 do
        x = math.random(100, SW-100)
        y = math.random(100, SH-100)
        testCoords = {x = x, y = y}
    end

    local angle = angle or math.random(0, 360)
    local speed = speed or math.random(1, 3)
    self.enemies[#self.enemies+1] = Enemy:new(x, y, w, h, angle, speed)
    bump.add(self.enemies[#self.enemies])
end

function EnemyManager:update(dt)
    self.age = self.age + 1
    if self.age%300 == 0 then
        self:spawn()
    end

    for i, enemy in ipairs(self.enemies) do
        if enemy.life <= 0 then
            if (enemy.w >= 2) then
                self:spawn(enemy.x, enemy.y, enemy.w/2, enemy.h/2)
                self:spawn(enemy.x, enemy.y, enemy.w/2, enemy.h/2)
                self:spawn(enemy.x, enemy.y, enemy.w/2, enemy.h/2)
                self:spawn(enemy.x, enemy.y, enemy.w/2, enemy.h/2)
            end
            bump.remove(enemy)
            table.remove(self.enemies, i)
        end
    end

    for _, enemy in pairs(self.enemies) do
        enemy:update(dt)
    end
end

function EnemyManager:draw()
    for _, enemy in pairs(self.enemies) do
        enemy:draw()
    end
    for _, wall in pairs(self.walls) do
        wall:draw()
    end
end

return EnemyManager
