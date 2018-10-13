Graph = Class {
    init = function(self)
        self.nodes = {}
    end;
}

Node = Class {
    init = function(self, id)
        self.id = id
        self.neighbours = {}
    end;
}