love.filesystem.setRequirePath( love.filesystem.getRequirePath()..";lib/?.lua;lib/;")

-- OBJECTS
local graph = {}
local mouse = {}

function love.load()
    HC = require "lib.hardoncollider"
    Util = require "lib.util"
    Class = require "lib.class"
    constants = require ("constants")
    require ("class.graph")

    local minNodes = 5 -- test variable
    graph = Graph(love.math.random(minNodes, 16), false)
    graph:addXRandomEdges(love.math.random(minNodes, graph.nodeCount))

    mouse = HC.circle(0,0, constants.MOUSE_RADIUS)

    -- Util.t.print(graph)
end

function love.update(dt)
    mouse:moveTo(love.mouse.getPosition())
    graph:update(dt)

    for shape, delta in pairs(HC.collisions(mouse)) do
        shape.node:hover()
        -- if shape.type == "OBJECT" and shape.properties["collide_projectiles"] then
        --     if not ent.dirty then
        --         ent:hitObject(shape.owner, vector(-1*delta.x, -1*delta.y), shape._polygon.centroid) --bit yolo but eh we good ok
        --         table.insert(markedForDeletion, id)
        --         ent.dirty = true
        --     end
        -- elseif shape.type == "PLAYER" then
        --     if not ent.dirty and ent.owner ~= shape.owner and not ent.hitbox.collided_with[shape.owner] then
        --         local hitPlayer = world["players"][shape.owner]
        --         if hitPlayer then
        --             hitPlayer:hitByProjectile(ent.owner, ent)
        --         end
        --         ent:hitObject(shape.owner, vector(-1*delta.x, -1*delta.y), hitPlayer.position)
        --         table.insert(markedForDeletion, id)
        --         ent.dirty = true
        --     end
        -- end
    end

end

function love.draw()
    if debug then
        love.graphics.setColor(1,1,0)
        mouse:draw('fill')
    end
    Util.l.resetColour()
    graph:draw()
end

function love.keyreleased(key)
    if key == "space" then
        love.event.quit("restart")
    elseif key == "f1" then
        debug = not debug
    end
end