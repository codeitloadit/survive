module(..., package.seeall)

Base = require('actors/base')
Spark = require('actors/spark')
Bullet = Base:extends()

function Bullet:__init(x, y, angle, speed)
    self.super.__init(self, x, y, 5, 5)
    self.name = 'Bullet'

    self.angle = angle
    self.speed = speed
    self.alive = true
    self.age = 0
end

function Bullet:update(dt)
    self.age = self.age + 1

    -- Update postion.
    if self.angle >= 0 then
        local ox = math.cos(math.rad(self.angle)) * self.speed
        local oy = math.sin(math.rad(self.angle)) * self.speed

        self.x = self.x + ox
        self.y = self.y + oy
    end
end

function Bullet:draw()
    g.setColor(240, 240, 240)
    love.graphics.rectangle('line', self.x-self.w/2, self.y-self.h/2, self.w, self. h)
end

function Bullet:collision(other, dx, dy)
    if other.name == 'Enemy' then
        if other.w > player.w and other.life > 0 then
            other.life = other.life - 1
        end
        if other.w <= player.w then
            other.w = other.w - 1
            other.h = other.h - 1
        end
    end
    if other.name ~= 'Player' then
        self.alive = false

        -- Super Shitty!
        local count = 0
        while count < 4 do
            count = count + 1
            if dy ~= 0 then
                if dy < 0 then
                    angle = math.random(270-90, 270+90)
                end
                if dy > 0 then
                    angle = math.random(90-90, 90+90)
                end
            elseif dx ~= 0 then
                if dx < 0 then
                    angle = math.random(180-90, 180+90)
                end
                if dx > 0 then
                    angle = math.random(0-90, 0+90)
                end
            end
            if angle < 0 then angle = angle + 360 end

            player.sparks[#player.sparks+1] = Spark:new(self.x, self.y, angle)
        end
    end

end

function Bullet:endCollision(other)
end

return Bullet
