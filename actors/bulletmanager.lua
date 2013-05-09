module(..., package.seeall)
Class = require('lib/30log')
Bullet = require('actors/bullet')

BulletManager = Class()

function BulletManager:__init()
    self.name = 'BulletManager'

    self.bullets = {}
    self.speed = 14
    self.delay = 3
end

function BulletManager:fire(x, y, angle)
    if #self.bullets == 0 or self.bullets[#self.bullets].age >= self.delay then
        self.bullets[#self.bullets+1] = Bullet:new(x, y, angle, self.speed)
        bump.add(self.bullets[#self.bullets])
    end
end

function BulletManager:update(dt)
    for i, bullet in ipairs(self.bullets) do
        if not bullet.alive then
            bump.remove(bullet)
            table.remove(self.bullets, i)
        end
    end

    for _, bullet in pairs(self.bullets) do
        bullet:update(dt)
    end
end

function BulletManager:draw()
    for _, bullet in pairs(self.bullets) do
        bullet:draw()
    end
end

return BulletManager
