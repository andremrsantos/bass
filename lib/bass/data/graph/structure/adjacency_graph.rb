module Bass::GraphBase

  # Graph structure for adjacency matrix implementation
  module AdjacencyGraph
    include Bass::GraphBase

    private

    # (see GraphBase#new_node)
    # @return [AdjacencyNode]
    def new_node(label)
      Node::AdjacencyNode.new(label)
    end

  end

end