module(..., package.seeall)

Base = require('actors/base')
Enemy = Base:extends()

function Enemy:__init(x, y, w, h, angle, speed)
    self.super.__init(self, x, y, w or 128, h or 128)
    self.name = 'Enemy'

    self.angle = angle
    self.speed = speed
    self.life = self.w/4
    self.age = 0
end

function Enemy:update(dt)
    self.age = self.age + 1

    -- Update postion.
    if self.angle >= 0 then
        local ox = math.cos(math.rad(self.angle)) * self.speed
        local oy = math.sin(math.rad(self.angle)) * self.speed

        self.x = self.x + ox
        self.y = self.y + oy
    end

    if self.w <= 0 then
        self.life = 0
    end
end

function Enemy:draw()
    if self.w > player.w then
        g.setColor(240, 102, 102)
    else
        g.setColor(102, 240, 102)
    end
    love.graphics.rectangle('line', self.x-self.w/2, self.y-self.h/2, self.w, self. h)
end

function Enemy:collision(other, dx, dy)
    if other.name == 'Wall' then
        if dy ~= 0 then
            self.angle = 360 - self.angle
        elseif dx ~= 0 then
            self.angle = 540 - self.angle
        end

        if self.angle > 360 then
            self.angle = self.angle - 360
        elseif self.angle < 0 then
            self.angle = self.angle + 360
        end
    end

    -- Absorb other enemy.
    if other.name == 'Enemy' and other.age >= 30 then
        smaller = self
        larger = other
        if other.w <= self.w then
            smaller = other
            larger = self
        end

        smaller.speed = math.max(smaller.speed*.94, 1)
        smaller.w = smaller.w - 1
        larger.w = larger.w + .2
        smaller.h = smaller.h - 1
        larger.h = larger.h + .2
    end

end

function Enemy:endCollision(other)
    if other.name == 'Enemy' then
        self.life = self.w/4
    end
end

return Enemy
