module(..., package.seeall)

Base = require('actors/base')
Wall = Base:extends()

function Wall:__init(x, y, w, h)
    self.super.__init(self, x, y, w, h)
    self.name = 'Wall'
end

function Wall:draw()
    g.setColor(50, 50, 50)
    love.graphics.rectangle('fill', self.x-self.w/2, self.y-self.h/2, self.w, self. h)
end

function Wall:collision(other, dx, dy)

end

function Wall:endCollision(other)

end

return Wall
