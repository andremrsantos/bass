module Bass

  # Graph implementation, where a set of nodes (V) is connected by a set of
  # edges (E), where for each edge (u,v) u, v C V and (u,v) == (v,u)
  class Graph

    # @param structure [Class] the graph storing structure.
    # @see GraphBase::AdjacencyGraph
    # @see GraphBase::QueueGraph
    def initialize(structure = GraphBase::QueueGraph)
      self.class.send(:include, structure)
      super()
    end

    private

    # (see GraphBase#connect)
    def connect(from, to, weight)
      edge = new_edge(from, to, weight)
      unless has_edge?(from, to)
        get_node(from).push_edge edge
        get_node(to).push_edge edge
        true
      end
    end

    # (see GraphBase#disconnect)
    def disconnect(from, to)
      edge = new_edge(from, to)
      if has_edge?(from, to)
        get_node(from).pull_edge edge
        get_node(to).pull_edge edge
        true
      end
    end

    # (see GraphBase#new_edge)
    # @return [Edge]
    def new_edge(from, to, weight = 1.0)
      Graph::Edge.new(from, to, weight)
    end

  end

end