Graph = Class {
    init = function(self, nodeCount, directed)
        self.nodes = {}
        self.edges = {}
        self.matrix = {} -- create an adjacency matrix for fast lookups
        self.directed = directed
        self.nodeCount = nodeCount
        self.NODES_PER_COL = math.ceil(math.sqrt(self.nodeCount))
        self.NODES_PER_ROW = math.ceil(math.sqrt(self.nodeCount))
        for i=1,self.nodeCount do
            self.matrix[i] = {}
            for j=1,self.nodeCount do
                self.matrix[i][j] = nil --nil values do not take up memory (crazy)
            end
        end

        local w = love.graphics.getWidth();
        local h = love.graphics.getHeight();
        local x = w*0.1
        local y = h*0.1

        for i = 1, self.nodeCount, 1 do
            self.nodes[i] = Node(i, x, y)

            x = x + w/self.NODES_PER_ROW
            if i % self.NODES_PER_ROW == 0 then
                y = y + h/self.NODES_PER_COL
                x = w*0.1
            end
        end
    end;
    draw = function(self)
        love.graphics.setColor(constants.COLOURS.EDGE.DEFAULT)
        for i, edge in pairs(self.edges) do
            love.graphics.line(edge.from.x, edge.from.y, edge.to.x, edge.to.y)
        end

        for i, node in pairs(self.nodes) do
            love.graphics.setColor(constants.COLOURS.NODE.BG)
            love.graphics.circle('fill', node.x, node.y, constants.NODE_RADIUS)
            love.graphics.setColor(constants.COLOURS.NODE.OUTLINE)
            love.graphics.circle('line', node.x, node.y, constants.NODE_RADIUS+1)
            love.graphics.setColor(constants.COLOURS.NODE.LABEL)
            love.graphics.draw(node.label, node.x-node.label:getWidth()/2, node.y-node.label:getHeight()/2)
        end
    end;
    addEdge = function(self, fromId, toId)
        -- may need to replace this with a more clever find function
        local from = self.nodes[fromId]
        local to = self.nodes[toId]
        self.edges[#self.edges+1] = Edge(from, to)
        self.matrix[fromId][toId] = true
        if not self.directed then
            self.matrix[toId][fromId] = true
        end
        print(fromId.." -> "..toId)
    end;
    edgeExists = function(self, from, to)
        if self.directed then
            return self.matrix[from][to]
        else 
            return self.matrix[from][to] or self.matrix[to][from]
        end
    end;
    addXRandomEdges = function(self, inCount)
        if #self.nodes <= 2 then
            print("[ERROR] Attempted to generate "..inCount.." edge(s) in graph with "..#self.nodes.." node(s).")
            return
        end
        local count = inCount
        local maximumEdges = math.ceil((#self.nodes*#self.nodes-1)/2) --half the theoretical limit (n*(n-1)). +1 to handle 1 node graph
        assert(count > 0 and count <= maximumEdges, "Random edge count must be between 0 and "..maximumEdges)
        print("Generating "..inCount.." random edges")
        while count > 0 do
            local fromId = love.math.random(#self.nodes)
            local toId = love.math.random(#self.nodes)
            if fromId ~= toId and not self:edgeExists(fromId, toId) then
                self:addEdge(fromId, toId)
                count = count - 1
            end
        end
        print("Generated "..inCount.." edges successfully!")
    end;
}

Node = Class {
    init = function(self, id, x, y)
        self.id = id
        self.x = x
        self.y = y
        self.label = love.graphics.newText(love.graphics.getFont(), id)
        self.neighbours = {}
    end;
}

Edge = Class {
    init = function(self, from, to)
        self.from = from
        self.to = to
    end;
}