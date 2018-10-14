love.filesystem.setRequirePath( love.filesystem.getRequirePath()..";lib/?.lua;")

-- CONSTANTS
local NODES_COUNT = 16
local NODE_RADIUS = 15
local COLOUR_NODE_BG =          {0,0,0}
local COLOUR_NODE_OUTLINE =     {1, 0.05, 0.5}
local COLOUR_LABEL =            {1,1,1}


-- OBJECTS
local graph = {}
local NODES_PER_ROW
local NODES_PER_COL

function love.load()
    Util = require "lib.util"
    Class = require "lib.class"
    require ("class.graph")

    graph = Graph(NODES_COUNT)
    --Kinda redundant having two variables atm but : )
    NODES_PER_COL = math.ceil(math.sqrt(NODES_COUNT))
    NODES_PER_ROW = math.ceil(math.sqrt(NODES_COUNT))

    -- Util.t.print(graph)
end

function love.update(dt)
    
end

function love.draw()
    local w = love.graphics.getWidth();
    local h = love.graphics.getHeight();
    local x = w*0.1
    local y = h*0.1

    for i, v in pairs(graph.nodes) do
        local node = graph.nodes[i]
        -- print(i)
        -- local index = toNumber(i)
        -- print(index)
       
        love.graphics.setColor(COLOUR_NODE_BG)
        love.graphics.circle('fill', x, y, NODE_RADIUS)
        love.graphics.setColor(COLOUR_NODE_OUTLINE)
        love.graphics.circle('line', x, y, NODE_RADIUS+1)
        love.graphics.setColor(COLOUR_LABEL)
        love.graphics.draw(node.label, x-node.label:getWidth()/2, y-node.label:getHeight()/2)

        x = x + w/NODES_PER_ROW
        if i % NODES_PER_ROW == 0 then
            y = y + h/NODES_PER_COL
            x = w*0.1
        end
    end
end