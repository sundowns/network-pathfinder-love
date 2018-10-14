Graph = Class {
    init = function(self, nodeCount)
        self.nodes = {}
        for i = 1, nodeCount, 1 do
            self.nodes[i] = Node(i)
        end
    end;
}

Node = Class {
    init = function(self, id)
        self.id = id
        self.label = love.graphics.newText(love.graphics.getFont(), id)
        self.neighbours = {}
    end;
}

-- Edge = Class {
    
-- }