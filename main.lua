love.filesystem.setRequirePath( love.filesystem.getRequirePath()..";lib/?.lua;")

local graph = {}

function love.load()
    Util = require "lib.util"
    Class = require "lib.class"
    require ("class.graph")

    graph = Graph()
    print("we're alive!")
    Util.t.print(graph)
end

function love.update(dt)
    
end

function love.draw()
    love.graphics.print("hello!", 0, 0)
end