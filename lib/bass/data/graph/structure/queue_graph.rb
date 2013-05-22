module Bass::GraphBase

  # Graph structure for queue of edges implementation.
  module QueueGraph
    include Bass::GraphBase

    private

    # (see GraphBase#new_node)
    # @return [QueueNode]
    def new_node(label)
      Node::QueueNode.new(label)
    end

  end

end