function love.load()
	Player = require('actors/player')
	player = Player:new()
	bump = require('lib/bump')
	util = require("util")
    love.mouse.setVisible(false)
    g = love.graphics
    keyDown = love.keyboard.isDown
    global:addGameState('debug')
end
