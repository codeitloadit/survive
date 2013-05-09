module(..., package.seeall)

Base = require('actors/base')
BulletManager = require('actors/bulletmanager')

Player = Base:extends()

function Player:__init()
    self.super.__init(self, SW/2-20, SH/2-20, 40, 40)
    self.name = 'Player'

    self.bulletmanager = BulletManager:new()
    self.sparks = {}

    self.hitbox = {x=self.x, y=self.y, w=10, h=10}

    self.crosshair = {x=self.x, y=self.y, w=20, h=20}

    self.angle = -1
    self.speed = 7
end

function Player:update(dt)

    -- Player input.
    if love.mouse.isDown('l') then
        self.bulletmanager:fire(self.x, self.y, util.getAngle(self, self.crosshair))
    end

    self.angle = -1
    -- if keyDown('w') and keyDown('s') then self.angle = -1 
    -- elseif keyDown('a') and keyDown('d') then self.angle = -1
    -- else
    if keyDown('w') and keyDown('d') then self.angle = 315 
    elseif keyDown('w') and keyDown('a') then self.angle = 225
    elseif keyDown('s') and keyDown('d') then self.angle = 45
    elseif keyDown('s') and keyDown('a') then self.angle = 135
    elseif keyDown('w') then self.angle = 270
    elseif keyDown('s') then self.angle = 90
    elseif keyDown('a') then self.angle = 180
    elseif keyDown('d') then self.angle = 0
    end

    -- Update postion.
    if self.angle >= 0 then
        local ox = math.cos(math.rad(self.angle)) * self.speed
        local oy = math.sin(math.rad(self.angle)) * self.speed

        -- Limit movement to screen.
        if self.x + ox < self.w/2 then ox = self.w/2 - self.x end
        if self.x + ox > SW-self.w/2 then ox = SW-self.w/2 - self.x end
        if self.y + oy < self.h/2 then oy = self.h/2 - self.y end
        if self.y + oy > SH-self.h/2 then oy = SH-self.h/2 - self.y end

        self.x = self.x + ox
        self.y = self.y + oy
    end

    -- Update crosshair.
    self.crosshair.x = love.mouse.getX()
    self.crosshair.y = love.mouse.getY()

    self.bulletmanager:update(dt)

    for i, spark in ipairs(self.sparks) do
        if not spark.alive then
            table.remove(self.sparks, i)
        end
    end
    for _, spark in pairs(self.sparks) do
        spark:update(dt)
    end
end

function Player:draw()
    g.setColor(240, 102, 240)
    love.graphics.rectangle('line', self.crosshair.x-self.crosshair.w/2, self.crosshair.y-self.crosshair.h/2, self.crosshair.w, self.crosshair. h)

    g.setColor(15, 128, 240)
    love.graphics.rectangle('line', self.x-self.w/2, self.y-self.h/2, self.w, self. h)

    self.bulletmanager:draw()
    for _, spark in pairs(self.sparks) do
        spark:draw()
    end
end

function Player:collision(other, dx, dy)
    if other.name == 'Enemy' then
        if other.w < self.w then
            other.speed = math.max(other.speed*.94, 1)

            other.w = other.w - 2
            self.w = self.w + .2
            other.h = other.h - 2
            self.h = self.h + .2
        else
            other.w = other.w + 1
            self.w = self.w - .5
            other.h = other.h + 1
            self.h = self.h - .5
        end

        if other.w <= 0 then
            other.life = 0
        end
    end

end

function Player:endCollision(other)

end

return Player
