love.filesystem.setRequirePath( love.filesystem.getRequirePath()..";lib/?.lua;")

-- OBJECTS
local graph = {}

function love.load()
    Util = require "lib.util"
    Class = require "lib.class"
    constants = require ("constants")
    require ("class.graph")
    
    local minNodes = 5 -- test variable
    graph = Graph(love.math.random(minNodes, 16), false)
    graph:addXRandomEdges(love.math.random(minNodes, graph.nodeCount))

    -- Util.t.print(graph)
end

function love.update(dt)
    
end

function love.draw()
    graph:draw()
end

function love.keyreleased(key)
    if key == "space" then
        love.event.quit("restart")
    end
end