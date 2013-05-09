module(..., package.seeall)

function getDistance(a, b)
    return math.sqrt((a.x - b.x ) * ( a.x - b.x) + (a.y - b.y) * (a.y - b.y));
end

function getAngle(object, target)
    return math.deg(math.atan2(target.y - object.y, target.x - object.x)) + 360;
end

