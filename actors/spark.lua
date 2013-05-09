module(..., package.seeall)

Base = require('actors/base')
Spark = Base:extends()

function Spark:__init(x, y, angle, speed)
    self.super.__init(self, x, y, 1, 1)
    self.name = 'Spark'

    self.angle = angle or math.random(0, 360)
    self.speed = speed or math.random(1, 4)
    self.alive = true
    self.age = 0
end

function Spark:update(dt)
    self.age = self.age + 1

    -- Update postion.
    if self.angle >= 0 then
        local ox = math.cos(math.rad(self.angle)) * self.speed
        local oy = math.sin(math.rad(self.angle)) * self.speed

        self.x = self.x + ox
        self.y = self.y + oy
    end

    if self. age >= 30 then
        self.alive = false
    end
end

function Spark:draw()
    g.setColor(240, 240, 102)
    love.graphics.rectangle('line', self.x-self.w/2, self.y-self.h/2, self.w, self. h)
end

return Spark
