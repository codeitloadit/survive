module(..., package.seeall)
Class = require('lib/30log')

Base = Class()
function Base:__init(x, y, w, h)
    self.x, self.y, self.w, self.h = x, y, w, h
end

function Base:update(dt)
    
end

function Base:draw()
    g.setColor(15, 15, 15)
    love.graphics.rectangle('line', self.x-self.w/2, self.y-self.h/2, self.w, self. h)
end

function Base:getBBox()
    return self.x-self.w/2, self.y-self.h/2, self.w, self. h
end

function Base:collision(other, dx, dy)
	global.debugString = 'other: '..other.name..' dx: '..dx..', dy: '..dy
end

function Base:endCollision(other)
	global.debugString = ''
end

return Base